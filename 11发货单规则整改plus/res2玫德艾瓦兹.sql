INSERT INTO
    DWD_SALE_DLY1_TMP (
        ID,
        PERIOD,
        BIZ_DATE,
        DELIVERY_CODE,
        BIZ_LINE_NO,
        ORDER_NOS,
        ORDER_TYPE,
        ORDER_NO,
        PROJECT_NAME,
        COMPANY_SALE,
        COMPANY_SN,
        DEPT1_HIS,
        DEPT2_HIS,
        DEPT3_HIS,
        DEPT1,
        DEPT2,
        DEPT3,
        PRODUCE_COMPANY,
        PRODUCE_COMPANY_SN,
        PRODUCT_SORT1,
        PRODUCT_SORT2,
        PRODUCT_SORT3,
        FIELD,
        MAT_DESC,
        PRODUCT_FORM,
        TEXTURE,
        MAT_SURFACE,
        MAT_SORT,
        MAT_ATTR5,
        MAT_CODE,
        MAT_VARIETY,
        MAT_SPEC,
        CURRENCY,
        COUNTRY,
        CUSTOMER_CODE,
        CUSTOMER_NAME,
        CUSTOMER_NEW_NAME,
        CUSTOMER_CODE1,
        CUSTOMER_NAME1,
        CUSTOMER_NEW_NAME1,
        PROVINCE_NAME,
        CITY_NAME,
        SALESMAN_HIS,
        SALESMAN,
        SALESMAN_ID_HIS,
        SALESMAN_ID,
        MANAGER,
        LEADER,
        ISNEWCUS,
        ISNEWPROD,
        ISUPSELLPROD,
        BUSINESS_TYPE,
        STATUS,
        EXPORT_CONFIRM_FLAG,
        ISSTATUS,
        MEASUREMENT_UNIT,
        TRADE_DISCOUNT_TYPE,
        LINE_NET_WEIGHT,
        TOTAL_AMOUNT_OUTEXP,
        TOTAL_AMOUNT,
        MARKET_DISCOUNT_AMOUNT,
        TRADE_DISCOUNT_AMOUNT,
        QTY_OUT_LINE,
        TOTAL_AMOUNT_EXP,
        BEFORE_DISCOUNT_AMOUNT,
        TOTAL_QUANTITY,
        TOTAL_BOX,
        AMT_M_FACT,
        ORDER_AMOUNT,
        ATTRIBUTE12,
        AMT_M_FACT_OUTTAX,
        QTY_M_FACT,
        BOX_M_FACT,
        ETL_CRT_DT,
        ETL_UPD_DT,
        BUSINESS,
        CUSTOMER_ID,
        INCEPT_ADDRESS_ID,
        ORG_NAME,
        FULL_NAME,
        product_first_mass_prod_dt --	产品首批量产时间
,
        transfer_finance_dt --	转财务日期
,
        new_product_end_dt --	新产品结束时间
,
        FULL_NAME_SN --库存组织名称
    )

SELECT
    SYS_GUID () AS ID --UUID主键                  
,
    TRUNC (A.EXPORT_CONFIRM_DATE, 'MM') AS PERIOD --账期期间
,
    A.EXPORT_CONFIRM_DATE AS BIZ_DATE --业务日期 
,
    A.DELIVERY_CODE AS DELIVERY_CODE --发货单号
,
    B.LINE_NO AS BIZ_LINE_NO --业务单据明细行号
,
REPLACE (
        REPLACE (A.SOURCE_NO, CHR (10), ''),
            CHR (13),
            ''
    ) AS ORDER_NOS --订单编号
,
    H.ORDER_TYPE_NAME AS ORDER_TYPE --订单类型
,
    L.ORDER_NUM AS ORDER_NO --明细订单编号 
,
    A.ATTRIBUTE21 AS PROJECT_NAME --项目名称（渠道/用户/项目名称）
,
    '玫德艾瓦兹（济南）金属制品有限公司' AS COMPANY_SALE --销售公司
,
    '玫德艾瓦兹' AS COMPANY_SN --销售公司简称  
,
    '玫德艾瓦兹国内销售' AS DEPT1_HIS --历史部门
,
    G4.ORGNAME AS DEPT2_HIS --历史大区
,
    G3.ORGNAME AS DEPT3_HIS --历史科室
,
    '玫德艾瓦兹国内销售' AS DEPT1 --部门
,
    '玫德艾瓦兹国内销售(未映射)' AS DEPT2 --大区
,
    '玫德艾瓦兹国内销售(未映射)' AS DEPT3 --科室
,
REPLACE (G2.FULL_NAME, '库存组织', '') AS PRODUCE_COMPANY --生产公司
,
    '玫德艾瓦兹' PRODUCE_COMPANY_SN, --生产公司简称
    NVL (CPFL.REF07, '未归类产品') AS PRODUCT_SORT1, --产品大类
    NVL (CPFL.REF08, '未归类产品') AS PRODUCT_SORT2, --产品中类
    NVL (CPFL.REF08, '未归类产品') AS PRODUCT_SORT3 --产品小类
,
    ' ' AS FIELD --领域
,
    B.MATERIAL_DESCRIPTION AS MAT_DESC --产品名称
,
    C.FORM AS PRODUCT_FORM --产品形式
,
    C.TEXTURE AS TEXTURE --材质分类
,
    C.SURFACE_TREATMENT AS MAT_SURFACE --表面
,
    C.PRODUCT_SORT AS MAT_SORT --产品分类新
,
    K.ATTR5_NAME AS MAT_ATTR5 --属性5
,
    B.MATERIAL_CODE AS MAT_CODE --物料编号
,
    C.VARIETY AS MAT_VARIETY --品种
,
    C.SPECIFICATION AS MAT_SPEC --规格
,
    'CNY' AS CURRENCY --币种
,
    '中国' AS COUNTRY --国别
,
    D.CUSTOMER_CODE AS CUSTOMER_CODE --开单客户编号  
,
    D.CUSTOMER_NAME AS CUSTOMER_NAME --开单客户名称
,
    D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME --开单客户最新名称
,
    D1.CUSTOMER_CODE AS CUSTOMER_CODE1 --分销客户编号/最终客户
,
    D1.CUSTOMER_NAME AS CUSTOMER_NAME1 --分销客户名称/最终客户 
,
    D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1 --分销客户最新名称/最终客户最新名称 
,
    DECODE (
        D.PROVINCE_ID,
        NULL,
        D.PROVINCE_NAME,
        E.AREA_NAME
    ) AS PROVINCE_NAME --隶属省
,
    DECODE (
        D.CITY_ID,
        NULL,
        D.CITY_NAME,
        E1.AREA_NAME
    ) AS CITY_NAME --隶属市
,
    I.EMPNAME AS SALESMAN_HIS --历史业务员
,
    I.EMPNAME AS SALESMAN --业务员
,
    EMP.USERID AS SALESMAN_ID_HIS --历史业务员账号 
,
    EMP.USERID AS SALESMAN_ID --最新业务员账号
,
    ' ' AS MANAGER --主管
,
    ' ' AS LEADER --科室负责人
,
    ' ' AS ISNEWCUS --是否新客户
,
    case
        when trunc (A.export_confirm_date) >= trunc (C.splcsj)
        and trunc (C.splcsj + C.pallet_num) >= trunc (A.export_confirm_date) then '是'
        else '否'
    end ISNEWPROD --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
,
    ' ' AS ISUPSELLPROD --是否老客户新产品
,
    NULL AS BUSINESS_TYPE,
    A.STATUS AS STATUS --基础信息状态生效
,
    A.EXPORT_CONFIRM_FLAG AS EXPORT_CONFIRM_FLAG --已出库
,
    CASE
        WHEN A.STATUS = 'C'
        AND A.EXPORT_CONFIRM_FLAG = 'Y' THEN '是'
        ELSE '否'
    END AS ISSTATUS -- 是否已生效且出库  
,
    J.DICTNAME AS MEASUREMENT_UNIT --计量单位
,
    J1.DICTNAME AS TRADE_DISCOUNT_TYPE --商业折扣类型    
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.LINE_NET_WEIGHT AS LINE_NET_WEIGHT --重量                            
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT --总计金额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT --商业折扣额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.QTY_OUT_LINE AS QTY_OUT_LINE --项目差价
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT --临时：表头折前金额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY --临时：表头总数量
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * A.TOTAL_BOX AS TOTAL_BOX --临时：表头总箱数
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.AMOUNT AS AMT_M_FACT -- 销售金额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.ORDER_AMOUNT AS ORDER_AMOUNT -- 订单金额汇总
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.ATTRIBUTE12 AS ATTRIBUTE12 -- 费用金额汇总
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.AMOUNT / 1.13 * DECODE (
        G1.ORGNAME,
        '10_玫德集团2061',
        0.965,
        1
    ) AS AMT_M_FACT_OUTTAX --底表字段：无税金额
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.LOADING_QUANTITY AS QTY_M_FACT --底表字段：实发数量
,
    DECODE (
        H.BUSINESS_TYPE,
        'A',
        1,
        'B',
        -1,
        'C',
        1,
        0
    ) * B.LOADING_BOX_QTY AS BOX_M_FACT --底表字段：箱数  
,
    SYSDATE ETL_CRT_DT,
    SYSDATE ETL_UPD_DT,
    '国内' AS BUSINESS,
    A.CUSTOMER_ID,
    A.INCEPT_ADDRESS_ID,
    G1.ORGNAME,
    G2.FULL_NAME FULL_NAME,
    C.splcsj AS product_first_mass_prod_dt --	产品首批量产时间
,
    A.export_confirm_date AS transfer_finance_dt --	转财务日期   IMS 无
,
    trunc (C.splcsj + C.pallet_num) AS new_product_end_dt --	新产品结束时间    邵贤鹏提供规则
,
    G2.ORGNAME
FROM
    ODS_IMS.CRM_LG_DELIVERY_HEADER A
    LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE B ON A.DELIVERY_HEAD_ID = B.DELIVERY_HEAD_ID
    LEFT JOIN MDDIM.TD_DIM_MATERIALS C ON B.MATERIAL_CODE = C.MATERIAL_CODE
    AND C.ORG_ID = A.DELIVERY_ORG
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER D ON A.CUSTOMER_ID = D.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER D1 ON A.INVOICE_CUSTOMER_ID = D1.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_AREA E ON D.PROVINCE_ID = E.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_AREA E1 ON D.CITY_ID = E1.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE H ON A.ORDER_TYPE_ID = H.ORDER_TYPE_ID
    LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
    LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID
    AND J.DICTTYPEID = 'MEASUREMENT_UNITS'
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID
    AND J1.DICTTYPEID = 'CRM_REBATE_TYPE'
    LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID = L.ORDER_ID
    LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID = G1.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG = G2.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID = G3.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
    LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
    LEFT JOIN (
        SELECT
            LOOKUP_CODE AS ATTR5_ID,
            DESCRIPTION AS ATTR5_NAME
        FROM ODS_IMS.FND_LOOKUP_VALUES
        WHERE
            LANGUAGE = USERENV ('LANG')
            AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5'
            AND ENABLED_FLAG = 'Y'
    ) K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
    LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER
WHERE
    H.ORDER_TYPE_NAME IN (
        '内销常规订单',
        '内销调账销售订单',
        '内销调账红冲订单',
        '内销退货订单',
        '内销外协常规订单',
        '服务销售订单',
        '工具归还订单',
        '工具借出订单'
    )
    AND G1.ORGNAME IN ('42_玫德艾瓦兹421')
    and to_char (
        A.EXPORT_CONFIRM_DATE,
        'yyyymm'
    ) > '202411';

COMMIT;

-----------------------------------------------------------------

MERGE INTO DWD_SALE_DLY1_TMP A USING ODS_APD.ODS_APD_SALE_ORG_MAPP_MDAWZ B ON (
    A.CUSTOMER_NEW_NAME = B.CUSTOMER
    AND A.COMPANY_SALE = '玫德艾瓦兹（济南）金属制品有限公司'
) WHEN MATCHED THEN
UPDATE
SET
    A.SALESMAN_ID = B.SALESMAN_ID,
    A.SALESMAN = B.SALESMAN,
    A.DEPT1 = B.DEPT1,
    A.DEPT2 = B.DEPT2,
    A.DEPT3 = B.DEPT3,
    A.LEADER = B.LEADER;

COMMIT;