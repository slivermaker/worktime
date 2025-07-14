INSERT INTO DWD_R250417001_J01 (
    SOURCE_SYS  ,-- 来源系统
    ID  ,-- ID
    CLUE_TYPE ,-- 线索类型
    CLUB_CODE ,-- 线索编码
    CLUE_NAME ,-- 线索名称
  STATUS ,--状态
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
    ETL_UPD_DT -- 更新时间
)


SELECT 
    '管通汇' SOURCE_SYS  ,-- 来源系统
    A.CLUE_ID AS ID  ,-- ID
    A.CLUE_TYPE AS  CLUE_TYPE ,-- 线索类型
    A.CLUE_ID AS CLUB_CODE ,-- 线索编码
    A.CLUE_NAME AS CLUE_NAME ,-- 线索名称
    A.STATUS AS STATUS ,--状态
    B.PS_USER_ID AS PS_USER_ID  ,-- PS账号
    B.EMP_NAME AS EMP_NAME  ,-- 员工姓名
    -- CASE 
    --     WHEN B.EMP_NAME IS NULL THEN '无跟进人'
    --     ELSE B.EMP_NAME
    -- END AS EMP_NAME,
    B.ORG_LEVEL1_NAME AS ORG_NAME1 ,-- 一级组织全称
    B.ORG_LEVEL2_NAME AS ORG_NAME2 ,-- 二级组织全称
    B.ORG_LEVEL3_NAME AS ORG_NAME3 ,-- 三级组织全称
    B.ORG_LEVEL4_NAME AS ORG_NAME4 ,-- 四级组织全称
    B.ORG_LEVEL5_NAME AS ORG_NAME5 ,-- 五级组织全称
    B.EFFDT EFFDT ,-- 离职日期
    MIN(A.ETL_CRT_DT)OVER(ORDER BY A.ETL_CRT_DT) AS CHECK_TIME  ,-- 检查时间
    '否' AS IS_HX ,-- 是否核销
    NULL AS HX_TIME ,-- 核销时间
    NULL AS HX_PS_UID ,-- 核销人PS账号
    NULL AS HX_NAME ,-- 核销人姓名
    'R250417001' AS RULE_CODE ,-- 规则编码
    'R250417001_J01' AS JOB_CODE  ,-- 作业编码
    SYSDATE AS ETL_CRT_DT  ,-- 创建时间
    SYSDATE AS ETL_UPD_DT -- 更新时间
FROM 
    (SELECT '客户线索' AS CLUE_TYPE ,CLUE_ID , CUSTOMER_NAME AS CLUE_NAME,GJCODE AS EMPLID,ETL_CRT_DT，
        CASE  
        WHEN STATUS = 1  THEN '未分发'
        WHEN STATUS  =2 AND SFJD = 'Y' THEN '已建档'
        WHEN  STATUS  =2 AND (NVL(SFJD,' ') = ' ' OR SFJD <> 'Y')  THEN '跟进'
        WHEN  STATUS  =3  THEN '暂不分发'
        WHEN  STATUS  =4  THEN '申请关闭中'
        WHEN  STATUS  =5  THEN '关闭'
        END 
        AS STATUS    FROM ODS_GTH.ODS_T_NEW_CLUE A 
            UNION ALL
            SELECT '项目线索' AS CLUE_TYPE ,CLUE_ID , PROJECT_NAME AS CLUE_NAME ,GJCODE AS EMPLID ,ETL_CRT_DT，
        CASE  
        WHEN STATUS = 1  THEN '未分发'
        WHEN STATUS  =2 AND SFJD = 'Y' THEN '已建档'
        WHEN  STATUS  =2 AND (NVL(SFJD,' ') = ' ' OR SFJD <> 'Y')  THEN '跟进'
        WHEN  STATUS  =3  THEN '暂不分发'
        WHEN  STATUS  =4  THEN '申请关闭中'
        WHEN  STATUS  =5  THEN '关闭'
        END 
        AS STATUS   FROM ODS_GTH.ODS_T_NEW_CLUE_XM ) A 
    LEFT JOIN MDDWI.TF_DWI_EMPLOYEE B --员工信息表
    ON A.EMPLID = B.EMPLID
    WHERE STATUS  NOT IN ('未分发','暂不分发') AND (B.HR_STATUS = 'I' OR B.EMP_NAME IS NULL); --改成离职或者跟进人为空 如果跟进人为空，就展示无跟进人
   