WITH TMP AS (
  SELECT TRUNC(PERIOD,'MM') AS PERIOD ,
         ORDER_CODE,
         PRODUCT_LINE,
         PRODUCT_SORT1,
         PRODUCT_SORT2,
         PRODUCT_SORT3,
         SUM(WEIHT_T) AS ZL
  FROM MDDWD.DWD_PRODUCT_ORDER A LEFT JOIN ODS_ERP.ODS_CNLXDZB B
  ON A.PRODUCT_LINE=B.SCX
  AND A.PRODUCT_SORT1=B.CPDL
  AND A.PRODUCT_SORT2=B.CPZL
  AND A.PRODUCT_SORT3=B.CPXL
  WHERE B.CNLX IS NULL AND PERIOD>=DATE'2025-06-1'AND A.PRODUCT_LINE='迈科管道'
         GROUP BY PERIOD,
         ORDER_CODE,
         PRODUCT_LINE,
         PRODUCT_SORT1,
         PRODUCT_SORT2,
         PRODUCT_SORT3
)
       
SELECT PERIOD,SUM(ZL) FROM TMP GROUP BY PERIOD








--生产负荷率订单
TRUNCATE TABLE DWD_PRODUCT_ORDER;
INSERT INTO DWD_PRODUCT_ORDER
(
    PERIOD
    ,ORDER_CODE
    ,PRODUCT_LINE_ALL_NAME
    ,PRODUCT_LINE
    ,MANU_DEPARTMENT
    ,FACTORY_NAME
    ,EX_IN_ORDER
    ,IS_SAVE_ORDER
    ,CUSTOMER_NAME
    ,ORG_NAME1
    ,ORG_NAME2
    ,ORG_NAME3
    ,ORG_NAME4
    ,ORG_NAME5
    ,ORG_NAME6
    ,SALESMAN_NAME
    ,SALESMAN_PS_UID
    ,PRODUCT_CODE
    ,PRODUCT_SORT1
    ,PRODUCT_SORT2
    ,PRODUCT_SORT3
    ,PRODUCT_SORT4
	,ITEM_CATE
	,ITEM_SPEC
	,ITEM_STYLE
    ,MEASUREMENT_UNIT
    ,ACTUAL_MONTH_OUTPUT_CNT
    ,WEIHT_T
    ,ETL_CRT_DT
    ,ETL_UPD_DT
)
SELECT  FACTS.PERIOD
        ,FACTS.ORDER_CODE
        ,SCXS.SCX
        ,SCXSJC.SCXJC
        ,SCXS.ZZB
        ,FACTS.FACTORY_NAME
        ,FACTS.EX_IN_ORDER
        ,FACTS.IS_SAVE_ORDER
        ,FACTS.CUSTOMER_NAME
        ,FACTS.ORG_NAME1
        ,FACTS.ORG_NAME2
        ,FACTS.ORG_NAME3
        ,FACTS.ORG_NAME4
        ,FACTS.ORG_NAME5
        ,FACTS.ORG_NAME6
        ,FACTS.SALESMAN_NAME
        ,FACTS.SALESMAN_PS_UID
        ,FACTS.PRODUCT_CODE
        ,FACTS.PRODUCT_SORT1
        ,FACTS.PRODUCT_SORT2
        ,FACTS.PRODUCT_SORT3
        ,FACTS.PRODUCT_SORT4
        ,CPFL.ITEM_CATE
        ,CPFL.ITEM_SPEC
        ,CPFL.ITEM_STYLE
        ,SCXS.JLDW
        ,NVL(SCXS.YDCN, 0) AS ACTUAL_MONTH_OUTPUT_CNT
        ,FACTS.ZL
        ,SYSDATE
        ,SYSDATE
FROM    (
    SELECT  SCX,
            ZZB,
            CQ,
            JLDW,
            YDCN,
            ROW_NUMBER() OVER(PARTITION BY SCX, ZZB, CQ ORDER BY SXRQ DESC) RN
    FROM    ODS_ERP.ODS_ERP_ERPSJWHJCB
)                                                   SCXS
LEFT JOIN   ODS_ERP.ODS_GJZBSCX                     SCXSJC
ON  SCXS.SCX = SCXSJC.SCX
LEFT JOIN
(
--IMS
    SELECT  JHQ AS PERIOD  --账期
            ,DDH AS ORDER_CODE  --订单号
            ,DECODE(
                A.CQ
                ,'玫德威海铸造厂','威海智能铸造事业部'
                ,'玫德威海','玫德威海炼铁事业部'
                ,'泰国南洋金属','泰钢管配件'
                ,'泰钢玛钢厂MTMF','泰钢管配件'
                ,'泰钢球铁厂QT','泰钢管配件'
                ,'泰钢铜厂BZ','泰钢管配件'
                ,A.CQ
            ) AS FACTORY_NAME  --厂区
            ,CASE
                WHEN IS_INTERNATIONAL_TRADE = 'Y' THEN '外销'
                WHEN IS_INTERNATIONAL_TRADE = 'N' THEN '内销'
            END AS EX_IN_ORDER  --内外销
            ,CASE
                WHEN IS_INTERNATIONAL_TRADE = 'Y' AND SUBSTR(DDH, 7, 1) IN ('A','B') THEN '是'
                ELSE '否'
            END AS IS_SAVE_ORDER  --是否储备订单
            ,A.KHM AS CUSTOMER_NAME  --客户名称
            ,DEPT.ORG_NAME1 AS ORG_NAME1  --1级组织
            ,DEPT.ORG_NAME2 AS ORG_NAME2  --2级组织
            ,DEPT.ORG_NAME3 AS ORG_NAME3  --3级组织
            ,DEPT.ORG_NAME4 AS ORG_NAME4  --4级组织
            ,DEPT.ORG_NAME5 AS ORG_NAME5  --5级组织
            ,DEPT.ORG_NAME6 AS ORG_NAME6  --6级组织
            ,A.EMPNAME AS SALESMAN_NAME  --业务员名称
            ,EMP.PS_USER_ID AS SALESMAN_PS_UID  --业务员PS账号
            ,A.ITEM_CODE AS PRODUCT_CODE  --产品编码
            ,CPFL.REF07 AS PRODUCT_SORT1  --产品大类
            ,CPFL.REF08 AS PRODUCT_SORT2  --产品中类
            ,CPFL.REF09 AS PRODUCT_SORT3  --产品小类
            ,CPFL.ATTRIBUTE19 AS PRODUCT_SORT4  --产品品类
            ,CASE WHEN A.CQ = '山东晨晖' THEN SL ELSE ZL END AS ZL  --重量
    FROM    ODS_IMS.ODS_CRM_SO_ORDER_BI     A
    LEFT JOIN   MDDWI.TF_DWI_EMPLOYEE      EMP
    ON  A.EMPCODE = EMP.EMPLID
    LEFT JOIN   MDDIM.DIM_ORG               DEPT
    ON  EMP.UNIT_CODE = DEPT.ORG_ID
    LEFT JOIN   (SELECT DISTINCT ITEM_NUMBER,REF07,REF08,REF09,ATTRIBUTE19 FROM MDDIM.TD_DIM_CPFL_INFO)     CPFL
    ON  A.ITEM_CODE = CPFL.ITEM_NUMBER
    WHERE   A.PD_CHECK_CONFIRM = 'T'
        AND A.CQ NOT LIKE '%管道%'
        AND SUBSTR(A.DDH,7,1) NOT IN ('A','B')
        AND NOT (A.CQ = '鹤壁工厂' AND SUBSTR(A.DDH,1,3)='KKK')  --鹤壁形式的剔除，可以用订单号前三位（代表形式）处理 提出人：邵贤鹏 ，王泽祥，250521
        --AND NOT (A.CQ = '迈克阀门' AND NVL(A.SCX,' ') IN ('F12','F10'))
        AND DDLX NOT IN ('内销物资销售订单','售后退货订单','内销废旧物资销售订单','内销物资销售免费订单','内销补货订单','出口采购物资','内销退货订单','售后维修订单','代管仓调拨订单')

    UNION ALL
--U9
    SELECT  SSL.REQUIREDATE AS PERIOD
            ,SO.DOCNO AS ORDER_CODE
            ,ORG.NAME AS FACTORY_NAME
            ,CASE
                WHEN SO.DOCNO LIKE '%SOMK%' THEN '内销'
                ELSE '外销'
            END AS EX_IN_ORDER
            ,CASE
                WHEN SO.DOCNO NOT LIKE '%SOMK%' AND SUBSTR(SO.DOCNO, 7, 1) IN ('A', 'B') THEN '是'
                ELSE '否'
            END AS IS_SAVE_ORDER
            ,CUST.NAME AS CUSTOMER_NAME
            ,DEPT.ORG_NAME1
            ,DEPT.ORG_NAME2
            ,DEPT.ORG_NAME3
            ,DEPT.ORG_NAME4
            ,DEPT.ORG_NAME5
            ,DEPT.ORG_NAME6
            ,EMP.EMP_NAME AS SALESMAN_NAME
            ,EMP.PS_USER_ID AS SALESMAN_PS_UID
            ,ITEM.NAME AS PRODUCT_CODE
            ,CPFL.REF07 AS PRODUCT_SORT1
            ,CPFL.REF08 AS PRODUCT_SORT2
            ,CPFL.REF09 AS PRODUCT_SORT3
            ,CPFL.ATTRIBUTE19 AS PRODUCT_SORT4
            ,CASE
                WHEN SO.DOCNO LIKE '%SOMK%' THEN SL.WEIGHT/1000
                ELSE SL.ORDERBYQTYPU/1000
            END AS ZL
    FROM    ODS_MAIKE_U9.SM_SO                      SO  --销售订单头
    LEFT JOIN   ODS_MAIKE_U9.SM_SOLINE              SL  --销售订单行
    ON      SL.SO = SO.ID
    LEFT JOIN   ODS_MAIKE_U9.SM_SOSHIPLINE          SSL  --销售订单子行
    ON      SL.ID = SSL.SOLINE
    LEFT JOIN  (SELECT DISTINCT ID,NAME FROM ODS_MAIKE_U9.BASE_ORGANIZATION_TRL where SYSMLFLAG = 'zh-CN')   ORG  --组织表
    ON      SO.ORG = ORG.ID
    LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER         ITEM  --物料表
    ON      SL.ITEMINFO_ITEMID = ITEM.ID
    LEFT JOIN   ODS_MAIKE_U9.CBO_CUSTOMER_TRL       CUST  --客户表
    ON      SO.ORDERBY_CUSTOMER = CUST.ID
        AND CUST.SYSMLFLAG = 'zh-CN'
    LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS          OPER  --业务员表
    ON      SO.SELLER = OPER.ID
    LEFT JOIN   MDDWI.TF_DWI_EMPLOYEE               EMP  --员工表
    ON      OPER.DESCFLEXFIELD_PRIVATEDESCSEG1 = EMP.EMPLID
    LEFT JOIN   MDDIM.DIM_ORG                       DEPT  --部门表
    ON      EMP.UNIT_CODE = DEPT.ORG_ID
    LEFT JOIN   (SELECT DISTINCT ITEM_NUMBER,REF07,REF08,REF09,ATTRIBUTE19 FROM MDDIM.TD_DIM_CPFL_INFO)     CPFL
    ON      CPFL.ITEM_NUMBER = CASE WHEN SUBSTR(ITEM.NAME, -3, 1) = '_' THEN SUBSTR(ITEM.NAME, 1, LENGTH(ITEM.NAME) - 3) ELSE ITEM.NAME END
    WHERE   SO.STATUS NOT IN ('4','5','6')

    UNION ALL
--统一入库查询
    SELECT  TO_DATE(BZRKB.JHQ, 'YY.MM.DD') AS PERIOD
            ,BZRKB.DDH AS ORDER_CODE
            ,MLB.CB AS FACTORY_NAME
            ,'内销' AS EX_IN_ORDER
            ,'是' AS IS_SAVE_ORDER
            ,BZRKB.KHM AS CUSTOMER_NAME
            ,NULL AS ORG_NAME1
            ,NULL AS ORG_NAME2
            ,NULL AS ORG_NAME3
            ,NULL AS ORG_NAME4
            ,NULL AS ORG_NAME5
            ,NULL AS ORG_NAME6
            ,NULL AS SALESMAN_NAME
            ,NULL AS SALESMAN_PS_UID
            ,null AS PRODUCT_CODE
            ,CPFL.REF07 AS PRODUCT_SORT1
            ,CPFL.REF08 AS PRODUCT_SORT2
            ,CPFL.REF09 AS PRODUCT_SORT3
            ,CPFL.ATTRIBUTE19 AS PRODUCT_SORT4
            ,NVL(BZRKB.JS*BZRKB.DZ, 0) / 1000 AS ZL
    FROM    ODS_JNMD.BZRKB      BZRKB
    LEFT JOIN   ODS_JNMD.MLB    MLB
    ON  BZRKB.RKDW = MLB.DW
    LEFT JOIN   (
       SELECT DISTINCT 
            ITEM_CATE
            ,ITEM_SPEC
            ,ITEM_STYLE
            ,ITEM_MAT
            ,ITEM_SURFACE_PRC
            ,max(REF07)REF07
            ,max(REF08) REF08
            ,max(REF09)REF09
            ,max(ATTRIBUTE19 )ATTRIBUTE19
        FROM MDDIM.TD_DIM_CPFL_INFO
        group by ITEM_CATE
            ,ITEM_SPEC
            ,ITEM_STYLE
            ,ITEM_MAT
            ,ITEM_SURFACE_PRC
    )     CPFL
    ON  BZRKB.PZ = CPFL.ITEM_CATE
        AND BZRKB.GG = CPFL.ITEM_SPEC
        AND BZRKB.XS = CPFL.ITEM_STYLE
        AND BZRKB.CZFL = CPFL.ITEM_MAT
        AND BZRKB.BMCL = CPFL.ITEM_SURFACE_PRC
    WHERE   KHM = '销售科内销'

    UNION ALL
--交货期查询
    SELECT  TO_DATE(BZDDB.JHQ, 'YY.MM.DD') AS PERIOD
            ,BZDDB.DDH
            ,MLB.CB AS FACTORY_NAME
            ,'内销'
            ,'是'
            ,BZDDB.KHM AS CUSTOMER_NAME
            ,NULL AS ORG_NAME1
            ,NULL AS ORG_NAME2
            ,NULL AS ORG_NAME3
            ,NULL AS ORG_NAME4
            ,NULL AS ORG_NAME5
            ,NULL AS ORG_NAME6
            ,NULL AS SALESMAN_NAME
            ,NULL AS SALESMAN_PS_UID
            ,null AS PRODUCT_CODE
            ,REF07 AS PRODUCT_SORT1
            ,REF08 AS PRODUCT_SORT2
            ,REF09 AS PRODUCT_SORT3
            ,ATTRIBUTE19 AS PRODUCT_SORT4
            ,NVL(BZDDB.DDQZ, 0) / 1000 AS ZL
    FROM    ODS_ERP.ODS_BZDDB   BZDDB
    LEFT JOIN   ODS_JNMD.MLB    MLB
    ON  BZDDB.BS = MLB.BS
    LEFT JOIN  (
        SELECT DISTINCT 
            ITEM_CATE
            ,ITEM_SPEC
            ,ITEM_STYLE
            ,ITEM_MAT
            ,ITEM_SURFACE_PRC
            ,REF07
            ,REF08
            ,REF09
            ,ATTRIBUTE19 
        FROM MDDIM.TD_DIM_CPFL_INFO
    )    CPFL
    ON BZDDB.pz = CPFL.ITEM_CATE
    AND BZDDB.gg =CPFL.ITEM_SPEC
    AND BZDDB.xs =CPFL.ITEM_STYLE
    AND BZDDB.czfl =CPFL.ITEM_MAT
    AND BZDDB.bmcl =CPFL.ITEM_SURFACE_PRC
    WHERE   BZDDB.KHM = '销售科内销'

    UNION ALL
--U9生产订单
    SELECT  MO.STARTDATE AS PERIOD
            ,MO.DOCNO
            ,CASE
                WHEN DEPT.NAME IN ('焊管一车间', '焊管二车间' ,'镀锌一车间' ,'镀锌二车间', '涂塑一线', '涂塑二线', '涂塑三线', '压槽线', '分流组', '喷漆线', '衬塑线') THEN '迈科管道焊管厂'
                ELSE ORG.NAME
            END AS FACTORY_NAME
            ,'内销' AS EX_IN_ORDER
            ,'是' AS IS_SAVE_ORDER
            ,'销售科内销' AS CUSTOMER_NAME
            ,NULL AS ORG_NAME1
            ,NULL AS ORG_NAME2
            ,NULL AS ORG_NAME3
            ,NULL AS ORG_NAME4
            ,NULL AS ORG_NAME5
            ,NULL AS ORG_NAME6
            ,NULL AS SALESMAN_NAME
            ,NULL AS SALESMAN_PS_UID
            ,ITEM.NAME AS PRODUCT_CODE
            ,CPFL.REF07 AS PRODUCT_SORT1
            ,CPFL.REF08 AS PRODUCT_SORT2
            ,CPFL.REF09 AS PRODUCT_SORT3
            ,CPFL.ATTRIBUTE19 AS PRODUCT_SORT4
            ,(NVL(MO.PRODUCTQTY, 0) * NVL(ITEM.WEIGHT, 0)) / 1000 AS ZL  --生产数量乘料品单重 by：周脉航user：王泽祥
    FROM    ODS_MAIKE_U9.ODS_MO_MO              MO
    LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER     ITEM
    ON  MO.ITEMMASTER = ITEM.ID
    LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT        PROJ
    ON  MO.PROJECT = PROJ.ID
    LEFT JOIN   (SELECT DISTINCT ID, NAME FROM ODS_MAIKE_U9.BASE_ORGANIZATION_TRL WHERE SYSMLFLAG = 'zh-CN')    ORG
    ON  MO.ORG = ORG.ID
    LEFT JOIN   (SELECT DISTINCT ID, NAME FROM ODS_MAIKE_U9.CBO_DEPARTMENT_TRL WHERE SYSMLFLAG = 'zh-CN')       DEPT
    ON  MO.DEPARTMENT = DEPT.ID
    LEFT JOIN   (SELECT DISTINCT ITEM_NUMBER,REF07,REF08,REF09,ATTRIBUTE19 FROM MDDIM.TD_DIM_CPFL_INFO)         CPFL
    ON      CPFL.ITEM_NUMBER = CASE WHEN SUBSTR(ITEM.NAME, -3, 1) = '_' THEN SUBSTR(ITEM.NAME, 1, LENGTH(ITEM.NAME) - 3) ELSE ITEM.NAME END
    WHERE   PROJ.CODE IN ('RQCB','XFCB','CSCB','XXHFCB','RQCB-3091','XFCB-3091')  --生产订单
)                                       FACTS
ON  SCXS.CQ = FACTS.FACTORY_NAME
LEFT JOIN   MDDIM.TD_DIM_CPFL_INFO      CPFL
ON  FACTS.PRODUCT_CODE = CPFL.ITEM_NUMBER

WHERE   SCXS.RN = 1
    AND SCXS.SCX NOT IN ('济南科德智能科技有限公司','临沂玫德庚辰金属材料有限公司')
    AND NVL(SCXS.ZZB,' ') <> '玫德威海炼铁事业部'
;
COMMIT;

MERGE INTO DWD_PRODUCT_ORDER A 
USING MDDIM.TD_DIM_CPFL_INFO B
ON (
    B.ITEM_NUMBER 
    = CASE 
        WHEN PRODUCT_LINE = '迈科管道' AND SUBSTR(TRIM(A.PRODUCT_CODE), -3, 1) = '_'  -- 检查倒数第三位是否下划线
        THEN SUBSTR(A.PRODUCT_CODE, 1, LENGTH(A.PRODUCT_CODE) - 3)  -- 直接移除最后三位字符
        ELSE A.PRODUCT_CODE  -- 其他情况保持原值
    END 
) 

WHEN MATCHED THEN UPDATE SET 
     PRODUCT_SORT1 = B.REF07
    ,PRODUCT_SORT2 = B.REF08
    ,PRODUCT_SORT3 = B.REF09
;


MERGE INTO DWD_PRODUCT_ORDER A
USING (
    SELECT 
      *
    FROM ods_apd.ods_apd_xinghaoyignshe B
) B
ON (
    A.PRODUCT_CODE = B.ITEM
)
WHEN MATCHED THEN
    UPDATE SET A.PRODUCT_SORT1 = B.PRO1
   ,  A.PRODUCT_SORT2 = B.PRO2
   ,  A.PRODUCT_SORT3 = B.PRO3;


MERGE INTO DWD_PRODUCT_ORDER A 
USING MDDIM.TD_DIM_CPFL_INFO B
ON (
    B.ITEM_NUMBER 
    = CASE 
        WHEN  SUBSTR(TRIM(A.PRODUCT_CODE), -3, 1) = '_'  -- 检查倒数第三位是否下划线
        THEN SUBSTR(A.PRODUCT_CODE, 1, LENGTH(A.PRODUCT_CODE) - 3)  -- 直接移除最后三位字符
        ELSE A.PRODUCT_CODE  -- 其他情况保持原值
    END 
) 

WHEN MATCHED THEN UPDATE SET 
     PRODUCT_SORT1 = B.REF07
    ,PRODUCT_SORT2 = B.REF08
    ,PRODUCT_SORT3 = B.REF09
    WHERE   PRODUCT_SORT3 IS NULL
;