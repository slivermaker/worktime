
XH    序号
GW    岗位
SCX    生产线
CQ     厂区
XM    姓名
ID    ID
GXR    更新人
GXSJ    更新时间

来自ODS_TSRYJCK



WITH PS AS(

     SELECT A.SCX,A.CQ,A.GW,A.XM,B.PS_USER_ID AS PSID
     FROM ODS_ERP.ODS_TSRYJCK A LEFT JOIN MDDWI.TF_DWI_EMPLOYEE B 
     on B.EMPLID=A.ID  
 )


    SELECT 
        SCX AS 生产线,
        CQ AS 厂区,
        LISTAGG(CASE WHEN GW = '科长' THEN XM END, ',') WITHIN GROUP (ORDER BY XM) AS 科长级别预警,
        LISTAGG(CASE WHEN GW = '总裁' THEN XM END, ',') WITHIN GROUP (ORDER BY XM) AS 总裁级别预警,
        LISTAGG(CASE WHEN GW = '主席' THEN XM END, ',') WITHIN GROUP (ORDER BY XM) AS 主席级别预警
    FROM PS
    where scx not in ('董事局主席团','生产管理中心','质量运营及流程IT部')
    GROUP BY SCX, CQ



