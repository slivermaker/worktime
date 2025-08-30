/*
    监管描述：
    作业开发人：
    作业开发日期：
*/
UPDATE DWD_R250821001_J01 SET IS_NEW_DATA = '否'; --将历史数据改为否

INSERT INTO DWD_R250821001_J01 (
    SOURCE_SYS   --  来源系统【必需字段】
    ,ID   --  ID【根据粒度自定义，必需字段】
    ,customer_code--客户编码
    ,customer_name--客户名称
    ,dz_customer_name--单证客户名称
    ,dz_customer_country--单证客户国家
    ,salaman_name--业务员
    ,saleman_psid--业务员ps
    ,CHECK_TIME   --  检查时间【必需字段,该字段必须有值 源系统抽取时间、如果从导入表来，取SYSDATE】
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
    'IMS' AS SOURCE_SYS
    ,A2.customer_name||A1.ATTRIBUTE3||A1.ATTRIBUTE9 AS ID
    ,A2.customer_code
    , A2.customer_name
    , A3.CUSTOMER_NAME
    , A1.ATTRIBUTE3
    
    , A1.ATTRIBUTE8
    , A1.ATTRIBUTE9
    ,MIN(A1.ETL_CRT_DT) OVER(ORDER BY A1.ETL_CRT_DT) AS CHECK_TIME
    ,'否' AS IS_HX  --  是否核销
    ,NULL AS HX_TIME  --  核销时间
    ,NULL AS HX_PS_UID  --  核销人PS账号
    ,NULL AS HX_NAME  --  核销人姓名
    ,'R250821001' AS RULE_CODE  --  规则编码
    ,'R250821001_J01' AS JOB_CODE   --  作业编码
    ,'是'  AS  IS_NEW_DATA   --是否最新数据
    ,SYSDATE AS ETL_CRT_DT   --  创建时间
    ,SYSDATE AS ETL_UPD_DT -- 更新时间

FROM ODS_IMS.ODS_CRM_CTM_CUST_DOC_CTM_INFO A1
    LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER A2 ON A1.CUSTOMER_ID = A2.CUSTOMER_ID
    LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER A3 ON A1.DZ_CUSTOMER_ID = A3.CUSTOMER_ID
WHERE (
        A2.customer_name,
        A1.ATTRIBUTE3
    ) IN (
        SELECT 
            B2.CUSTOMER_NAME
            , B1.ATTRIBUTE3
        FROM ODS_IMS.ODS_CRM_CTM_CUST_DOC_CTM_INFO B1
            LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER B2 ON B1.DZ_CUSTOMER_ID = B2.CUSTOMER_ID
        GROUP BY
            B1.ATTRIBUTE3,
            B2.CUSTOMER_NAME
        HAVING
            COUNT(DISTINCT NVL (B1.ATTRIBUTE9, 1)) > 1
    ) 




SELECT 
    A2.customer_code
    , A2.customer_name
    , A3.CUSTOMER_CODE
    , A3.CUSTOMER_NAME
    , A1.ATTRIBUTE8
    , A1.ATTRIBUTE9
    , A1.ATTRIBUTE3
FROM ODS_IMS.ODS_CRM_CTM_CUST_DOC_CTM_INFO A1
    LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER A2 ON A1.CUSTOMER_ID = A2.CUSTOMER_ID
    LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER A3 ON A1.DZ_CUSTOMER_ID = A3.CUSTOMER_ID
WHERE (
        A2.customer_name,
        A1.ATTRIBUTE3
    ) IN (
        SELECT 
            B2.CUSTOMER_NAME
            , B1.ATTRIBUTE3
        FROM ODS_IMS.ODS_CRM_CTM_CUST_DOC_CTM_INFO B1
            LEFT JOIN ODS_IMS.CRM_CTM_CUSTOMER B2 ON B1.DZ_CUSTOMER_ID = B2.CUSTOMER_ID
        GROUP BY
            B1.ATTRIBUTE3,
            B2.CUSTOMER_NAME
        HAVING
            COUNT(DISTINCT NVL (B1.ATTRIBUTE9, 1)) > 1
    ) B