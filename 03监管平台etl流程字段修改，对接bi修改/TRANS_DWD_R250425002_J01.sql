UPDATE DWD_R250425002_J01 SET IS_NEW_DATA = '否';
--将历史数据改为否
INSERT INTO
    MDDWD.DWD_R250425002_J01 (
        SOURCE_SYS,
        ID,
        CUSTOMER_CODE,
        CUSTOMER_NAME,
        CREATE_STATUS_IMS,
        BG_IMS,
        BU_IMS,
        CREATED_DT_IMS,
        FOLLOWER_NAME_IMS,
        CREATE_STATUS_GTH,
        CLUE_CODE,
        BG_GTH,
        BU_GTH,
        CREATED_DT_GTH,
        CREATE_STATUS_U9,
        BG_U9,
        BU_U9,
        LEAD_NAME,
        CREATED_DT_U9,
        CREATE_STATUS_TAR,
        -- BG_TAR,
        -- BU_TAR,
        CHECK_TIME,
        IS_HX,
        HX_TIME,
        HX_PS_UID,
        HX_NAME,
        RULE_CODE,
        JOB_CODE,
        ETL_CRT_DT,
        ETL_UPD_DT,
        IS_NEW_DATA --是否最新数据
    )
WITH
    CCC AS (
        SELECT DISTINCT
            CCC.CUSTOMER_NAME,
            CCC.BRAND,
            CCC.CUSTOMER_NO,
            CCC.CREATION_DATE,
            CCC.ETL_UPD_DT,
            -- 将 EMPNAME 和 DEPARTMENT_NAME_3 合并为多行文本字段
            LISTAGG (
                CASE
                    WHEN OE.EMPNAME IS NOT NULL
                    AND DEPT.DEPARTMENT_NAME_3 IS NOT NULL THEN OE.EMPNAME || ' - ' || DEPT.DEPARTMENT_NAME_3
                    ELSE NULL
                END,
                CHR (10) -- 使用换行符分隔
            ) WITHIN GROUP (
                ORDER BY OE.EMPNAME
            ) AS EMP_DEPT_INFO -- 按员工名排序
        FROM
            ODS_IMS.CRM_CTM_CUSTOMER CCC
            LEFT JOIN (
                SELECT DISTINCT
                    CUSTOMER_ID,
                    SALESMAN
                FROM ODS_IMS.ODS_CRM_CTM_CUST_SALESMAN
                where
                    END_DATE >= sysdate
            ) CCS ON CCC.CUSTOMER_ID = CCS.CUSTOMER_ID
            LEFT JOIN ODS_IMS.OM_EMPLOYEE OE ON CCS.SALESMAN = OE.EMPID
            LEFT JOIN MDDWI.TF_DWI_EMPLOYEE EMP ON OE.EMPCODE = EMP.EMPLID
            LEFT JOIN MDDIM.DIM_DEPARTMENT_D DEPT ON EMP.UNIT_CODE = DEPT.DEPARTMENT_CODE
        WHERE
            CCC.STATUS <> 'D'
            AND CCC.CUSTOMER_CODE NOT LIKE 'DZ%'
            AND CCC.CUSTOMER_NAME IS NOT NULL
        GROUP BY
            CCC.CUSTOMER_NAME,
            CCC.BRAND,
            CCC.CUSTOMER_NO,
            CCC.CREATION_DATE,
            CCC.ETL_UPD_DT
    ),
    TNCF AS (
        SELECT DISTINCT
            TNCF.CUSTOMERNAME,
            TNCF.CLUECODE,
            TNCF.BG,
            TNCF.BU,
            TNCF.CTTIME,
            TNCF.ETL_UPD_DT
        FROM ODS_GTH.ODS_T_NEW_CUSTOMER_FILE TNCF
    ),
    CUST AS (
        SELECT
            CCT.NAME,
            -- 合并多行账套名称，按换行符分隔
            LISTAGG (BOT.NAME, CHR (10)) WITHIN GROUP (
                ORDER BY BOT.NAME
            ) AS ORG_NAME,
            DECODE (
                CC.DESCFLEXFIELD_PRIVATEDESCSEG2,
                '1',
                '建筑BG',
                '2',
                '市政BG',
                '3',
                '工业BG',
                '4',
                '电力BG',
                '5',
                '贸易',
                '6',
                '工程管理部',
                '7',
                '废料及其他',
                '8',
                '关联方',
                '9',
                '内部',
                '10',
                '对外贸易',
                '11',
                '物资服务',
                NULL
            ) AS BG,
            DECODE (
                CC.TRADECATEGORY,
                '0',
                '工业',
                '1',
                '农业',
                '2002',
                '燃气BU',
                '2003',
                '热力BU',
                '2004',
                '水务BU',
                '2005',
                '消防BU',
                '2006',
                '其他',
                '2007',
                '暖通BU',
                '2008',
                '电力BU',
                '2009',
                '工业应用BU',
                '2010',
                '暖通&燃气BU',
                '2011',
                '智能制造BU',
                '2012',
                '铸造材料BU',
                '2013',
                '水利BU',
                NULL
            ) AS BU,
            TO_DATE (
                TO_CHAR (CC.CREATEDON, 'YYYY-MM-DD'),
                'YYYY-MM-DD'
            ) AS CREATE_DT,
            CC.ETL_UPD_DT
        FROM ODS_MAIKE_U9.CBO_CUSTOMER CC
            JOIN ODS_MAIKE_U9.CBO_CUSTOMER_TRL CCT ON CCT.ID = CC.ID
            AND CCT.SYSMLFLAG = 'zh-CN'
            LEFT JOIN ODS_MAIKE_U9.BASE_ORGANIZATION_TRL BOT ON CC.ORG = BOT.ID
            AND BOT.SYSMLFLAG = 'zh-CN'
        where
            cct.name = '聊城市环能供应链有限公司'
            -- 按非聚合字段分组
        GROUP BY
            CCT.NAME,
            DECODE (
                CC.DESCFLEXFIELD_PRIVATEDESCSEG2,
                '1',
                '建筑BG',
                '2',
                '市政BG',
                '3',
                '工业BG',
                '4',
                '电力BG',
                '5',
                '贸易',
                '6',
                '工程管理部',
                '7',
                '废料及其他',
                '8',
                '关联方',
                '9',
                '内部',
                '10',
                '对外贸易',
                '11',
                '物资服务',
                NULL
            ),
            DECODE (
                CC.TRADECATEGORY,
                '0',
                '工业',
                '1',
                '农业',
                '2002',
                '燃气BU',
                '2003',
                '热力BU',
                '2004',
                '水务BU',
                '2005',
                '消防BU',
                '2006',
                '其他',
                '2007',
                '暖通BU',
                '2008',
                '电力BU',
                '2009',
                '工业应用BU',
                '2010',
                '暖通&燃气BU',
                '2011',
                '智能制造BU',
                '2012',
                '铸造材料BU',
                '2013',
                '水利BU',
                NULL
            ),
            TO_DATE (
                TO_CHAR (CC.CREATEDON, 'YYYY-MM-DD'),
                'YYYY-MM-DD'
            ),
            CC.ETL_UPD_DT
    ),
    DST AS (
        SELECT DISTINCT
            CUSTOMER_NAME,
            CUSTOMER_BG,
            CUSTOMER_BU,
            ETL_UPD_DT
        FROM ODS_APD.ODS_APD_SALES_TARGET
        WHERE
            SALE_PLATFORM_NAME = '国内销售平台'
            AND SALES_TARGET_TYPE = '挑战'
            AND YEAR = 2025
            AND IS_NEW_DATA = '是'
    ),
    MIN_TIME AS (
        SELECT MIN(ETL_UPD_DT) AS MIN_TIME
        FROM (
                SELECT DISTINCT
                    ETL_UPD_DT
                FROM CCC
                UNION ALL
                SELECT DISTINCT
                    ETL_UPD_DT
                FROM TNCF
                UNION ALL
                SELECT DISTINCT
                    ETL_UPD_DT
                FROM CUST
            )
    )
SELECT DISTINCT
    'BI' AS SOURCE_SYS,
    DSR.CUSTOMER_CODE || CUST.ORG_NAME AS ID,
    DSR.CUSTOMER_CODE AS 客户编码,
    DSR.CUSTOMER_NAME AS 客户名称,
    CASE
        WHEN CCC.CUSTOMER_NAME IS NULL THEN '未建档'
        ELSE '已建档'
    END,
    CCC.BRAND AS IMS系统BG,
    CCC.CUSTOMER_NO AS IMS系统BU,
    CCC.CREATION_DATE AS IMS客户建档时间,
    CCC.EMP_DEPT_INFO AS IMS系统跟进人,
    CASE
        WHEN TNCF.CUSTOMERNAME IS NULL THEN '未建档'
        ELSE '已建档'
    END,
    TNCF.CLUECODE AS 线索编码,
    TNCF.BG AS 管通汇系统BG,
    TNCF.BU AS 管通汇系统BU,
    TNCF.CTTIME AS 管通汇客户建档时间,
    CASE
        WHEN CUST.NAME IS NULL THEN '未建档'
        ELSE '已建档'
    END,
    CUST.BG AS U9系统BG,
    CUST.BU AS U9系统BU,
    CUST.ORG_NAME AS U9账套名,
    CUST.CREATE_DT AS U9客户建档时间,
    CASE
        WHEN DST.CUSTOMER_NAME IS NULL THEN '未建档'
        ELSE '已建档'
    END
    -- ,DST.CUSTOMER_BG AS 目标BG
    -- ,DST.CUSTOMER_BU AS 目标BU
,
    (
        SELECT MIN_TIME
        FROM MIN_TIME
        WHERE
            1 = 1
    ) AS 检查时间 -- 取各系统的最早更新时间，王泽祥，250513
,
    '否' AS IS_HX,
    NULL AS HX_TIME,
    NULL AS HX_PS_UID,
    NULL AS HX_NAME,
    'R250425002',
    'R250425002_J01',
    SYSDATE,
    SYSDATE,
    '是' AS IS_NEW_DATA --是否最新数据
FROM (
        SELECT
            LISTAGG (CUSTOMER_CODE, CHR (10)) WITHIN GROUP (
                ORDER BY CUSTOMER_CODE
            ) AS CUSTOMER_CODE,
            CUSTOMER_NAME
        FROM (
                SELECT DISTINCT
                    CUSTOMER_CODE, CUSTOMER_NAME
                FROM MDDWD.DWD_SALE_REVENUE
                where
                    SALE_PLATFORM_NAME = '国内销售平台'
                    AND TRUNC (PERIOD_DAY, 'YYYY') BETWEEN ADD_MONTHS (
                        TRUNC (SYSDATE - 1, 'YYYY'), -36
                    ) AND TRUNC  (SYSDATE - 1, 'YYYY')
            )
        GROUP BY
            CUSTOMER_NAME
    ) DSR --销售业绩表
    LEFT JOIN CCC --客户表(IMS)
    ON UPPER(DSR.CUSTOMER_NAME) = UPPER(CCC.CUSTOMER_NAME)
    LEFT JOIN TNCF --客户表(GTH)
    ON UPPER(DSR.CUSTOMER_NAME) = UPPER(TNCF.CUSTOMERNAME)
    LEFT JOIN CUST --复合客户表(U9)
    ON UPPER(DSR.CUSTOMER_NAME) = UPPER(CUST.NAME)
    LEFT JOIN DST --销售目标表
    ON UPPER(DSR.CUSTOMER_NAME) = UPPER(DST.CUSTOMER_NAME)
WHERE (
        (
            TNCF.CUSTOMERNAME IS NOT NULL
            AND TNCF.BG || TNCF.BU <> CCC.BRAND || CCC.CUSTOMER_NO
        )
        OR (
            CUST.NAME IS NOT NULL
            AND CUST.BG || CUST.BU <> CCC.BRAND || CCC.CUSTOMER_NO
        )
        -- OR (
        --     DST.CUSTOMER_NAME IS NOT NULL
        --     AND DST.CUSTOMER_BG || DST.CUSTOMER_BU <> CCC.BRAND || CCC.CUSTOMER_NO
        -- )
        OR (
            TNCF.CUSTOMERNAME IS NOT NULL
            AND CUST.NAME IS NOT NULL
            AND CUST.BG || CUST.BU <> TNCF.BG || TNCF.BU
        )
    )