INSERT INTO DWD_R250627001_J01 (
    SOURCE_SYS   --  来源系统【必需字段】
    ,ID   --  ID【根据粒度自定义，必需字段】
    ,CLUE_TYPE  --  线索类型 【检核作业文档登记字段】
    ,CLUE_CODE  --  线索编码 【检核作业文档登记字段】
    ,CLUE_NAME  --  线索名称 【检核作业文档登记字段】
    ,...
    ,CHECK_TIME   --  检查时间【必需字段 源系统抽取时间、如果从导入表来，取SYSDATE】
    ,IS_HX  --  是否核销 【必需字段，默认填否】
    ,HX_TIME  --  核销时间 【必需字段，默认填空】
    ,HX_PS_UID  --  核销人PS账号 【必需字段，默认填空】
    ,HX_NAME  --  核销人姓名 【必需字段，默认填空】
    ,RULE_CODE  --  规则编码 【必需字段，表名去掉DWD 和J..】
    ,JOB_CODE   --  作业编码 【必需字段，表名去掉DWD】
    ,IS_NEW_DATA  --是否最新数据【必需字段，默认填是】
    ,ETL_CRT_DT   --  创建时间 【必需字段，默认填SYSDATE】
    ,ETL_UPD_DT -- 更新时间 【必需字段，默认填SYSDATE】
)





SELECT 
    CASE CORPORATE_ENTITY_NAME_SN 
        WHEN '迈克阀门' THEN 'U9'
        ELSE 'IMS'
    END AS SOURCE_SYS   --  来源系统
    ,A.PRODUCT_CODE AS ID   --  ID
    ,A.PRODUCT_SORT1 AS  CLUE_TYPE  --  线索类型
    ,A.PRODUCT_CODE AS CLUB_CODE  --  线索编码
    ,MIN(A.ETL_CRT_DT)OVER(ORDER BY A.ETL_CRT_DT) AS CHECK_TIME   --  检查时间【如果从多表来，用开窗函数取最早日期】  
    ,'否' AS IS_HX  --  是否核销
    ,NULL AS HX_TIME  --  核销时间
    ,NULL AS HX_PS_UID  --  核销人PS账号
    ,NULL AS HX_NAME  --  核销人姓名
    ,'R250627001' AS RULE_CODE  --  规则编码
    ,'R250627001_J01' AS JOB_CODE   --  作业编码
    ,'是'  AS  IS_NEW_DATA   --是否最新数据
    ,SYSDATE AS ETL_CRT_DT   --  创建时间
    ,SYSDATE AS ETL_UPD_DT -- 更新时间

FROM
    DWD_SALE_REVENUE A
WHERE sale_platform_name ='国内销售平台' AND PRODUCT_SORT1='未归类产品'
  AND (PERIOD_DAY BETWEEN TO_DATE('2024-01-01','YYYY-MM-DD') AND TO_DATE('2025-12-31','YYYY-MM-DD'))
  
--     (SELECT ...,ETL_CRT_DT FROM ODS_GTH.ODS_T_NEW_CLUE A 
--     UNION ALL
--      SELECT ...,ETL_CRT_DT FROM ODS_GTH.ODS_T_NEW_CLUE_XM ) A  --监控表
-- LEFT JOIN MDDWI.TF_DWI_EMPLOYEE B  -- 标准表
-- ON A.EMPLID = B.EMPLID --关联条件
-- WHERE STATUS  NOT IN ('未分发','暂不分发') AND B.HR_STATUS = 'I'; --过滤条件