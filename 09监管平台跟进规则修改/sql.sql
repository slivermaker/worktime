UPDATE DWD_R250417001_J03 SET IS_NEW_DATA = '否'; --将历史数据改为否

INSERT INTO DWD_R250417001_J03 (
    SOURCE_SYS  ,-- 来源系统
    ID  ,-- ID
    CUSTOMER_CODE ,-- 客户编码
    CUSTOMER_NAME ,-- 客户名称
	STATUS, -- 状态
    PS_USER_ID  ,-- PS账号
    EMP_NAME  ,-- 员工姓名
    ORG_NAME1 ,-- 一级组织全称
    ORG_NAME2 ,-- 二级组织全称
    ORG_NAME3 ,-- 三级组织全称
    ORG_NAME4 ,-- 四级组织全称
    ORG_NAME5 ,-- 五级组织全称
    EFFDT ,-- 离职日期
    CHECK_TIME  ,-- 检查时间
    IS_HX ,-- 是否核销
    HX_TIME ,-- 核销时间
    HX_PS_UID ,-- 核销人PS账号
    HX_NAME ,-- 核销人姓名
    RULE_CODE ,-- 规则编码
    JOB_CODE  ,-- 作业编码
    ETL_CRT_DT  ,-- 创建时间
    ETL_UPD_DT，  --  更新时间
	IS_NEW_DATA --是否最新数据

)

SELECT
    '管通汇' SOURCE_SYS  ,-- 来源系统
    CUSTOMERCODE AS ID  ,-- ID
    CUSTOMERCODE  ,-- 客户编码
    CUSTOMERNAME  ,-- 客户名称
	A.ENABLED AS STATUS, -- 状态
    B.PS_USER_ID AS PS_USER_ID  ,-- PS账号
        CASE 
        WHEN B.EMP_NAME IS NULL THEN '无跟进人'
        ELSE B.EMP_NAME
    END AS EMP_NAME, --员工姓名
    B.ORG_LEVEL1_NAME AS ORG_NAME1 ,-- 一级组织全称
    B.ORG_LEVEL2_NAME AS ORG_NAME2 ,-- 二级组织全称
    B.ORG_LEVEL3_NAME AS ORG_NAME3 ,-- 三级组织全称
    B.ORG_LEVEL4_NAME AS ORG_NAME4 ,-- 四级组织全称
    B.ORG_LEVEL5_NAME AS ORG_NAME5 ,-- 五级组织全称
    B.EFFDT EFFDT ,-- 离职日期
     MAX(A.ETL_CRT_DT)OVER(ORDER BY A.ETL_CRT_DT) AS CHECK_TIME, -- 检查时间
    '否' AS IS_HX ,-- 是否核销
    NULL AS HX_TIME ,-- 核销时间
    NULL AS HX_PS_UID ,-- 核销人PS账号
    NULL AS HX_NAME ,-- 核销人姓名
    'R250417001' AS RULE_CODE ,-- 规则编码
    'R250417001_J03' AS JOB_CODE  ,-- 作业编码
    SYSDATE AS ETL_CRT_DT  ,-- 创建时间
    SYSDATE AS ETL_UPD_DT, -- 更新时间
	'是' AS IS_NEW_DATA --是否最新数据
FROM
   ODS_GTH.ODS_T_NEW_CUSTOMER_FILE A
LEFT JOIN MDDWI.TF_DWI_EMPLOYEE B
ON A.FOLLOWUPID = B.EMPLID
WHERE ENABLED = 'Y' AND (B.HR_STATUS = 'I' OR B.EMP_NAME IS NULL) ;




---条件为客户生效且客户状态为跟进中