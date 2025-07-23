/*
UPDATE DATE:2025.06.10
UPDATE USER:王泽祥
UPDATE NOTE:订单履约率汇总表改为正确的表
*/
BEGIN
DELETE FROM ADS_ORDER_FULFILLMENT_RATE WHERE YPERIOD = TRUNC(SYSDATE - 1);
INSERT INTO ADS_ORDER_FULFILLMENT_RATE
    (YPERIOD, --账期期间 
     COMPANY_NAME, --公司名称 
     COMPANY_NAME_SN, --公司简称
     MANUFACTURING_DEPT_NAME, --制造部名称 
     FACTORY_NAME, --厂区名称 
     ORDER_CNT, --订单总个数 
     ORDER_MODIFY_CNT, --订单调整个数 
     ORDER_DELAY_CNT, --订单拖期个数 
     ETL_CRT_DT,
     ETL_UPD_DT,
     WARN_STANDARD_VALUE)
    SELECT TRUNC(SYSDATE - 1) AS YPERIOD,
           T1.SCX AS COMPANY_NAME,
           T3.SCXJC AS COMPANY_NAME_SN,
           T1.ZZB AS MANUFACTURING_DEPT_NAME,
           T1.CQ AS FACTORY_NAME,
           NVL(T2.ORDER_CNT, 0) AS ORDER_CNT,
           NVL(T2.ORDER_MODIFY_CNT, 0) AS ORDER_MODIFY_CNT,
           NVL(T2.ORDER_DELAY_CNT, 0) AS ORDER_DELAY_CNT,
           SYSDATE AS ETL_CRT_DT,
           SYSDATE AS ETL_UPD_DT,
           T1.WARN_STANDARD_VALUE
      FROM (SELECT SCX,
                   ZZB,
                   CQ,
                   TO_NUMBER(REPLACE(PJDDLYL, '%', '')) / 100 AS WARN_STANDARD_VALUE,
                   ROW_NUMBER() OVER(PARTITION BY SCX, ZZB, CQ ORDER BY SXRQ DESC) RN
              FROM ODS_ERP.ODS_ERP_ERPSJWHJCB) T1
      LEFT JOIN
      (SELECT FACTORY_NAME,
                      SUM(ORDER_CNT) AS ORDER_CNT,
                      SUM(ORDER_MODIFY_CNT) AS ORDER_MODIFY_CNT,
                      SUM(ORDER_DELAY_CNT) AS ORDER_DELAY_CNT
                 FROM (
                    select CQ      AS FACTORY_NAME,
                        JDZGS   AS ORDER_CNT,
                        JHQTZGS as ORDER_MODIFY_CNT,
                        TQGS    as ORDER_DELAY_CNT
                   from ODS_ERP.ODS_DDLYLHZ  --订单履约率汇总表
                 union all
                 
                 SELECT CASE
                          WHEN CQ = '玫德威海' THEN
                           '威海智能铸造事业部'
                          ELSE
                           CQ
                        END AS FACTORY_NAME,
                        DDZGS AS ORDER_CNT,
                        TZGS AS ORDER_MODIFY_CNT,
                        TQGS AS ORDER_DELAY_CNT
                   FROM ODS_ERP.ODS_ERP_DDLYLJLB --ERP手工
                  WHERE RQ = TO_CHAR(SYSDATE - 1, 'YY.MM.DD')
                    AND CQ <> '玫德威海'
                 UNION ALL
                 SELECT FACTORYAREA AS FACTORY_NAME,
                        TO_NUMBER(ORDERNUMBER) AS ORDER_CNT,
                        TO_NUMBER(MKADJUST) AS ORDER_MODIFY_CNT,
                        DELAYNUMBER AS ORDER_DELAY_CNT
                   FROM ODS_ERP.ODS_PROD_TOTALNUMBER --管道
                 )
     GROUP BY FACTORY_NAME) T2
        ON T1.CQ = T2.FACTORY_NAME
      LEFT JOIN ODS_ERP.ODS_GJZBSCX T3
        ON T1.SCX = T3.SCX
     WHERE T1.RN = 1
       AND T1.SCX NOT IN
           ('济南科德智能科技有限公司', '临沂玫德庚辰金属材料有限公司')
       AND NVL(T1.ZZB, ' ') <> '玫德威海炼铁事业部';
COMMIT;

--删除早上跑的数据
IF TO_CHAR(SYSDATE, 'HH24') <= '12' THEN
  DELETE FROM ADS_ORDER_FULFILLMENT_RATE WHERE TRUNC(YPERIOD) = TRUNC(SYSDATE - 1);
END IF;
END;