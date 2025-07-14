UPDATE DWD_R250425005_J01 SET IS_NEW_DATA = '否';
--将历史数据改为否

INSERT INTO
    MDDWD.DWD_R250425005_J01 (
        SOURCE_SYS, -- 来源系统
        ID, -- id
        CUSTOMER_CODE, -- 客户编码
        CUSTOMER_NAME, -- 客户名称
        CREATE_STATUS_IMS, -- ims是否建档
        CUSTOMER_TYPE_IMS, -- ims系统客户类型
        CREATED_DT_IMS, -- ims客户建档时间
        EMP_DEPT_INFO, -- ims系统跟进人
        CREATE_STATUS_GTH, -- 管通汇是否建档
        CLUE_CODE, -- 线索编码
        CUSTOMER_TYPE_GTH, -- 管通汇系统客户类型
        CREATED_DT_GTH, -- 管通汇客户建档时间
        CREATE_STATUS_U9, -- u9是否建档
        CUSTOMER_TYPE_U9, -- u9系统客户类型
        LEAD_NAME, -- 账套名称
        CREATED_DT_U9, -- u9客户建档时间
        -- CREATE_STATUS_TAR, -- 销售目标中是否建档
        -- CUSTOMER_TYPE_TAR, -- 目标客户类型
        CHECK_TIME, -- 检查时间
        IS_HX, -- 是否核销
        HX_TIME, -- 核销时间
        HX_PS_UID, -- 核销人ps账号
        HX_NAME, -- 核销人姓名
        RULE_CODE, -- 规则编码
        JOB_CODE, -- 作业编码
        ETL_CRT_DT, -- 创建日期
        ETL_UPD_DT, --  更新日期
        IS_NEW_DATA --是否最新数据
    )
WITH
    CCC AS (
        SELECT DISTINCT
            CCC.CUSTOMER_NAME,
            CCC.ENTERPRISE_LEGAL_PERSON AS CUSTOMER_TYPE,
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
            CCC.ENTERPRISE_LEGAL_PERSON,
            CCC.CREATION_DATE,
            CCC.ETL_UPD_DT
    ),
    TNCF AS (
        SELECT DISTINCT
            TNCF.CUSTOMERNAME,
            TNCF.CLUECODE,
            TNCF.CUSTOMERTYPENAME AS CUSTOMER_TYPE,
            TNCF.CTTIME,
            TNCF.ETL_UPD_DT
        FROM ODS_GTH.ODS_T_NEW_CUSTOMER_FILE TNCF
    ),
    CUST AS (
        SELECT
            CC.ORG,
            CCT.NAME,
            -- 合并多行账套名称，按换行符分隔
            LISTAGG (BOT.NAME, CHR (10)) WITHIN GROUP (
                ORDER BY BOT.NAME
            ) AS ORG_NAME,
            DECODE (
                CC.descflexfield_privatedescseg4,
                1,
                '安装公司',
                2,
                '关系经销商',
                3,
                '渠道经销商',
                4,
                '用户',
                ''
            ) AS CUSTOMER_TYPE,
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
            -- 按非聚合字段分组
        GROUP BY
            CC.ORG,
            CCT.NAME,
            DECODE (
                CC.descflexfield_privatedescseg4,
                1,
                '安装公司',
                2,
                '关系经销商',
                3,
                '渠道经销商',
                4,
                '用户',
                ''
            ),
            CC.CREATEDON,
            CC.ETL_UPD_DT
    ),
    DST AS (
        SELECT DISTINCT
            CUSTOMER_NAME,
            CUSTOMER_TYPE,
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
    CCC.CUSTOMER_TYPE AS IMS系统客户类型,
    CCC.CREATION_DATE AS IMS客户建档时间,
    CCC.EMP_DEPT_INFO AS IMS系统跟进人,
    CASE
        WHEN TNCF.CUSTOMERNAME IS NULL THEN '未建档'
        ELSE '已建档'
    END,
    TNCF.CLUECODE AS 线索编码,
    TNCF.CUSTOMER_TYPE AS 管通汇系统客户类型,
    TNCF.CTTIME AS 管通汇客户建档时间,
    CASE
        WHEN CUST.NAME IS NULL THEN '未建档'
        ELSE '已建档'
    END,
    CUST.CUSTOMER_TYPE AS U9系统客户类型,
    CUST.ORG_NAME AS U9账套名,
    CUST.CREATE_DT AS U9客户建档时间,
    -- CASE
    --     WHEN DST.CUSTOMER_NAME IS NULL THEN '未建档'
    --     ELSE '已建档'
    -- END,
    -- DST.CUSTOMER_TYPE AS 目标客户类型,
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
    'R250425005',
    'R250425005_J01',
    SYSDATE,
    SYSDATE,
    '是' AS IS_NEW_DATA --是否最新数据
FROM (
        SELECT *
        FROM MDDWD.DWD_SALE_REVENUE DSR
        where
            DSR.SALE_PLATFORM_NAME = '国内销售平台'
            AND TRUNC (DSR.PERIOD_DAY, 'YYYY') BETWEEN ADD_MONTHS (
                TRUNC (SYSDATE - 1, 'YYYY'),
                -36
            ) AND TRUNC  (SYSDATE - 1, 'YYYY')
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
            AND TNCF.CUSTOMER_TYPE <> CCC.CUSTOMER_TYPE
        )
        OR (
            CUST.NAME IS NOT NULL
            AND CUST.CUSTOMER_TYPE <> CCC.CUSTOMER_TYPE
        )
        OR (
            DST.CUSTOMER_NAME IS NOT NULL
            AND DST.CUSTOMER_TYPE <> CCC.CUSTOMER_TYPE
        )
        OR (
            TNCF.CUSTOMERNAME IS NOT NULL
            AND CUST.NAME IS NOT NULL
            AND CUST.CUSTOMER_TYPE <> TNCF.CUSTOMER_TYPE
        )
    )