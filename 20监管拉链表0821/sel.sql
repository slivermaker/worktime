WITH DWD as(
SELECT 
     CASE WHEN ORIGIN_SYSTEM = 'IMS' THEN ORDER_SHIP_ET_M WHEN ORIGIN_SYSTEM = 'MAIKE_U9' THEN TRUNC(ORDER_SHIP_DT, 'MM') END AS ORDER_SALE_FORE_HW_M
    ,ORIGIN_SYSTEM
    ,SALE_PLATFORM_NAME
    ,SALE_REGION_NAME
    ,SALE_COMPANY_NAME
    ,SALE_BG_NAME
    ,CUSTOMER_NAME_SN AS CUSTOMER_NAME
    ,customer_bg
    ,customer_bu
    ,PRODUCT_CODE
    ,product_sort1
    ,product_sort2
    ,B.ORGNAME AS CORPORATE_ENTITY_NAME_SN
    ,SALESMAN_ID
    ,SALESMAN_NAME
FROM MDDWD.DWD_SALE_ORDER A
LEFT JOIN (
    SELECT * FROM (
        SELECT 
            ORGNAME
            ,FULL_NAME
            ,ROW_NUMBER() OVER (PARTITION BY FULL_NAME ORDER BY ETL_CRT_DT) AS PM 
        FROM MDDIM.DIM_BUSINESS_ORGANIZATION_CI 
        WHERE ORG_DESC = '营销'
    ) WHERE PM = 1
) B
ON A.PRODUCE_COMPANY_NAME = B.FULL_NAME
WHERE SALE_PLATFORM_NAME = '海外销售平台'
    AND 
     CASE WHEN ORIGIN_SYSTEM = 'IMS' THEN ORDER_SHIP_ET_M WHEN ORIGIN_SYSTEM = 'MAIKE_U9' THEN TRUNC(ORDER_SHIP_DT, 'MM') END  BETWEEN TRUNC(SYSDATE,'MM') AND ADD_MONTHS(TRUNC(SYSDATE,'MM'),3)
)

SELECT DISTINCT ORDER_SALE_FORE_HW_M 预测月份,ORIGIN_SYSTEM 系统,SALE_PLATFORM_NAME 平台,PRODUCT_CODE 产品编码,product_sort1 产品大类 ,product_sort2 产品中类 FROM DWD
where product_sort1 is null or product_sort2 is null

-------------------------------------------------------------------------------------------------------------------------------------------------------------------


DECLARE 
    run_date DATE;
    yesterday DATE;
BEGIN 
    -- 设置默认值
    run_date := TRUNC(SYSDATE);  -- 默认今日
    -- run_date := TO_DATE('2025-06-10','YYYY-MM-DD'); -- 手工指定日期（取消注释使用）

    -- 计算昨日日期
    yesterday := run_date - 1;

    -- 第一步：失效变更记录（业务员变更或客户删除）
    -- 使用UPDATE语句替代MERGE，避免ON子句中引用待更新列
    UPDATE DIM_CUSTOMER_SALESMAN_HIS his
    SET his.end_date = yesterday,
        his.ETL_UPD_DT = SYSDATE
    WHERE his.end_date = TO_DATE('9999-12-31','YYYY-MM-DD')  -- 仅当前有效记录
      AND EXISTS (
          SELECT 1
          FROM (
            SELECT 
                HIS_INNER.source_sys,
                HIS_INNER.DELIVERY_ADDRESS_ID,
                CASE 
                    WHEN cur.DELIVERY_ADDRESS_ID IS NULL THEN 'DELETE'
                    WHEN his_inner.salesman_id <> cur.salesman_ID THEN 'CHANGE'
                END AS change_type
            FROM DIM_CUSTOMER_SALESMAN_HIS his_inner
            LEFT JOIN (
                SELECT DISTINCT source_sys,DELIVERY_ADDRESS_ID, salesman_ID 
                FROM mddim.dim_customer_address
            ) cur 
                ON NVL(HIS_INNER.source_sys,'@') = NVL(CUR.source_sys,'@')
                AND NVL(HIS_INNER.DELIVERY_ADDRESS_ID,'@') = NVL(CUR.DELIVERY_ADDRESS_ID,'@')
            WHERE his_inner.end_date = TO_DATE('9999-12-31','YYYY-MM-DD')
          ) changes
          WHERE changes.source_sys = his.source_sys
              AND changes.DELIVERY_ADDRESS_ID = his.DELIVERY_ADDRESS_ID
              AND changes.change_type IN ('DELETE','CHANGE')
      );

    -- 第二步：插入新增/变更记录
    INSERT INTO DIM_CUSTOMER_SALESMAN_HIS (
        source_sys
        ,delivery_address_id
        ,salesman_id
        ,salesman_name
        ,start_date
        ,end_date
        ,etl_crt_dt
    )
    SELECT DISTINCT
        cur.source_sys,
        cur.delivery_address_id,
        CUR.salesman_id,
        cur.salesman_name,
        run_date AS start_date,
        TO_DATE('9999-12-31','YYYY-MM-DD') AS end_date,
        SYSDATE AS ETL_CRT_DT
    FROM (
        SELECT DISTINCT source_sys,DELIVERY_ADDRESS_ID, salesman_ID,SALESMAN_NAME 
            FROM mddim.dim_customer_address
    )cur
    WHERE NOT EXISTS (
        SELECT 1 
        FROM DIM_CUSTOMER_SALESMAN_HIS his
        WHERE NVL(his.DELIVERY_ADDRESS_ID,'@') = NVL(cur.DELIVERY_ADDRESS_ID,'@')
          AND NVL(his.source_sys,'@') =     NVL(cur.source_sys,'@')
          AND NVL(his.salesman_id,'@') =     NVL(cur.salesman_id,'@')
          AND NVL(his.salesman_NAME,'@') =     NVL(cur.salesman_NAME,'@')
          AND his.end_date = TO_DATE('9999-12-31','YYYY-MM-DD')
    );

    -- 提交事务
    COMMIT;
END;