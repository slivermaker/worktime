BEGIN

DELETE FROM ADS_PRODUCTION_SATURATION WHERE YPERIOD = TRUNC(SYSDATE - 1) ;
INSERT INTO ADS_PRODUCTION_SATURATION
(
    YPERIOD, --账期期间
    COMPANY_NAME, --公司名称
    COMPANY_NAME_SN, --公司简称
    MANUFACTURING_DEPT_NAME, --制造部名称
    FACTORY_NAME, --厂区名称
    MEASUREMENT_UNITS, --计量单位
    ACTUAL_MONTH_OUTPUT_CNT, --实际月产量
    MONTH_ORDER_CNT,  --本月接单量
    NEXT_MONTH_ORDER_CNT, --次月接单量
    ALL_ORDER_CNT, --所有接单量
    MONTH_SALE_TARGET,  --本月销售目标
    NEXT_MONTH_SALE_TARGET,  --次月销售目标
    LAST_DELIVERY_DT, --最晚交货期
    OUTPUT_UPDATEDMAN,  --产能维护人
    OUTPUT_BRANCHMAN,  --产能审批人
    ETL_CRT_DT,
    ETL_UPD_DT
)
SELECT  TRUNC(SYSDATE - 1) AS YPERIOD,
        T1.SCX AS COMPANY_NAME,
        T3.SCXJC AS COMPANY_NAME_SN,
        T1.ZZB AS MANUFACTURING_DEPT_NAME,
        T1.CQ AS FACTORY_NAME,
        T1.JLDW AS MEASUREMENT_UNITS,
        NVL(T1.YDCN, 0) AS ACTUAL_MONTH_OUTPUT_CNT,
        NVL(T2.MONTH_ORDER_CNT, 0) AS MONTH_ORDER_CNT,  --本月接单量
        NVL(T2.NEXT_MONTH_ORDER_CNT, 0) AS NEXT_MONTH_ORDER_CNT,
        NVL(T2.ALL_ORDER_CNT, 0) AS ALL_ORDER_CNT,
        0,  --本月销售目标
        0,  --次月销售目标
        T2.LAST_DELIVERY_DT,
        NULL,  --产能维护人
        NULL,  --产能审批人
        SYSDATE AS ETL_CRT_DT,
        SYSDATE AS ETL_UPD_DT
FROM    (
    SELECT  SCX,
            ZZB,
            CQ,
            JLDW,
            YDCN,
            ROW_NUMBER() OVER(PARTITION BY SCX, ZZB, CQ ORDER BY SXRQ DESC) RN
    FROM    ODS_ERP.ODS_ERP_ERPSJWHJCB
) T1
LEFT JOIN (
    SELECT  FACTORY_NAME,
            SUM(MONTH_ORDER_CNT) AS MONTH_ORDER_CNT,
            SUM(NEXT_MONTH_ORDER_CNT) AS NEXT_MONTH_ORDER_CNT,
            SUM(ALL_ORDER_CNT) AS ALL_ORDER_CNT,
            MAX(LAST_DELIVERY_DT) AS LAST_DELIVERY_DT
    FROM    (
        SELECT  DECODE(
                    A.CQ
                    ,'玫德威海铸造厂','威海智能铸造事业部'
                    ,'玫德威海','玫德威海炼铁事业部'
                    ,'泰国南洋金属','泰钢管配件'
                    ,'泰钢玛钢厂MTMF','泰钢管配件'
                    ,'泰钢球铁厂QT','泰钢管配件'
                    ,'泰钢铜厂BZ','泰钢管配件'
                    ,A.CQ
                ) AS FACTORY_NAME,
                SUM(
                    CASE
                        WHEN TRUNC(A.JHQ,'MM') = TRUNC(SYSDATE - 1,'MM') AND A.CQ <> '山东晨晖' THEN ZL
                        WHEN TRUNC(A.JHQ,'MM') = TRUNC(SYSDATE - 1,'MM') AND A.CQ = '山东晨晖' THEN SL
                        ELSE 0
                    END
                ) AS MONTH_ORDER_CNT,--当月接单量，250227 晨晖取数量 提出人：张亮
                SUM(
                    CASE
                        WHEN TRUNC(A.JHQ,'MM') = ADD_MONTHS(TRUNC(SYSDATE - 1,'MM'), 1) AND A.CQ <> '山东晨晖' THEN ZL
                        WHEN TRUNC(A.JHQ,'MM') = ADD_MONTHS(TRUNC(SYSDATE - 1,'MM'), 1) AND A.CQ = '山东晨晖' THEN SL
                        ELSE 0
                    END
                ) AS NEXT_MONTH_ORDER_CNT,--次月接单量，250227 晨晖取数量 提出人：张亮
                SUM(
                    CASE
                        WHEN A.CQ = '山东晨晖' THEN SL
                        ELSE ZL
                    END
                ) AS ALL_ORDER_CNT,  --250227 晨晖取数量 提出人：张亮
                MAX(TRUNC(JHQ)) AS LAST_DELIVERY_DT
        FROM    ODS_IMS.ODS_CRM_SO_ORDER_BI A  --IMS
        WHERE   A.JHQ >= TRUNC(SYSDATE - 1,'MM')
            AND A.PLAN_ISUEED_STATE = 'T'
            AND A.CQ NOT LIKE '%管道%'
            AND SUBSTR(A.DDH,7,1) NOT IN ('A','B')
            AND NOT (A.CQ = '鹤壁工厂' AND SUBSTR(A.DDH,1,3)='KKK')  --鹤壁形式的剔除，可以用订单号前三位（代表形式）处理 提出人：邵贤鹏 ，王泽祥，250521
            --AND NOT (A.CQ = '迈克阀门' AND NVL(A.SCX,' ') IN ('F12','F10'))
            AND DDLX NOT IN ('内销物资销售订单','售后退货订单','内销废旧物资销售订单','内销物资销售免费订单','内销补货订单','出口采购物资','内销退货订单','售后维修订单','代管仓调拨订单')
        GROUP BY    DECODE(
                        A.CQ
                        ,'玫德威海铸造厂','威海智能铸造事业部'
                        ,'玫德威海','玫德威海炼铁事业部'
                        ,'泰国南洋金属','泰钢管配件'
                        ,'泰钢玛钢厂MTMF','泰钢管配件'
                        ,'泰钢球铁厂QT','泰钢管配件'
                        ,'泰钢铜厂BZ','泰钢管配件'
                        ,A.CQ
                    )
        UNION ALL
        SELECT  ORG.NAME AS FACTORY_NAME
                ,SUM(
                    CASE
                        WHEN TRUNC(SSL.REQUIREDATE, 'MM') = TRUNC(SYSDATE - 1,'MM') AND SO.DOCNO LIKE '%SOMK%' THEN SL.WEIGHT
                        WHEN TRUNC(SSL.REQUIREDATE, 'MM') = TRUNC(SYSDATE - 1,'MM') AND SO.DOCNO NOT LIKE '%SOMK%' THEN SL.ORDERBYQTYPU
                        ELSE 0
                    END
                ) / 1000 AS MONTH_ORDER_CNT
                ,SUM(
                    CASE
                        WHEN TRUNC(SSL.REQUIREDATE, 'MM') = ADD_MONTHS(TRUNC(SYSDATE - 1,'MM'), 1) AND SO.DOCNO LIKE '%SOMK%' THEN SL.WEIGHT
                        WHEN TRUNC(SSL.REQUIREDATE, 'MM') = ADD_MONTHS(TRUNC(SYSDATE - 1,'MM'), 1) AND SO.DOCNO NOT LIKE '%SOMK%' THEN SL.ORDERBYQTYPU
                        ELSE 0
                    END
                ) / 1000 AS NEXT_MONTH_ORDER_CNT
                ,SUM(
                    CASE
                        WHEN SO.DOCNO LIKE '%SOMK%' THEN SL.WEIGHT
                        ELSE SL.ORDERBYQTYPU
                    END
                ) / 1000 AS ALL_ORDER_CNT
                ,MAX(TRUNC(SSL.REQUIREDATE))
        FROM    ODS_MAIKE_U9.SM_SO                      SO
        LEFT JOIN   ODS_MAIKE_U9.SM_SOLINE              SL  --销售订单行
        ON      SL.SO = SO.ID
        LEFT JOIN   ODS_MAIKE_U9.SM_SOSHIPLINE          SSL  --销售订单子行
        ON      SL.ID = SSL.SOLINE
        LEFT JOIN   ODS_MAIKE_U9.BASE_ORGANIZATION_TRL  ORG  --组织表
        ON      SO.ORG = ORG.ID
        WHERE   SO.STATUS NOT IN ('4','5','6')
		AND 	TRUNC(SSL.REQUIREDATE, 'MM') >= TRUNC(SYSDATE - 1,'MM')
        GROUP BY    ORG.NAME
        /*
        UNION ALL
        SELECT  CB AS FACTORY_NAME,
                NEXTXL AS NEXT_MONTH_ORDER_CNT,
                TOTALXL AS ALL_ORDER_CNT,
                REQUIREDATE AS LAST_DELIVERY_DT
        FROM    ODS_ERP.ODS_SALE_LOAD  --管道
        --WHERE RQ = TO_CHAR(TRUNC(SYSDATE),'YY.MM.DD')
        */  --管道取数逻辑
        UNION ALL
        SELECT  CQ AS FACTORY_NAME,
                NULL AS MONTH_ORDER_CNT,
                CYJDL AS NEXT_MONTH_ORDER_CNT,
                STJDL AS ALL_ORDER_CNT,
                CASE
                    WHEN REGEXP_LIKE('24.11.30','^\d{2}\.((0[13578]|1[02])\.(0[1-9]|[12][0-9]|3[01])|(0[469]|11)\.(0[1-9]|[12][0-9]|30)|02\.(0[1-9]|[12][0-9]))$') THEN
                        TO_DATE(STJDZWJHQ, 'YY.MM.DD')
                    ELSE NULL
                END AS LAST_DELIVERY_DT
        FROM    ODS_ERP.ODS_ERP_JDMFHLJLB TTT --手工
        )
    GROUP BY FACTORY_NAME
) T2
ON  T1.CQ = T2.FACTORY_NAME
LEFT JOIN   ODS_ERP.ODS_GJZBSCX T3
ON  T1.SCX = T3.SCX

WHERE   T1.RN = 1
    AND T1.SCX NOT IN ('济南科德智能科技有限公司','临沂玫德庚辰金属材料有限公司')
    AND NVL(T1.ZZB,' ') <> '玫德威海炼铁事业部'

UNION ALL

SELECT  TRUNC(SYSDATE - 1) AS YPERIOD,
        T1.SCX AS COMPANY_NAME,
        NULL AS COMPANY_NAME_SN,
        NULL AS MANUFACTURING_DEPT_NAME,
        NULL AS FACTORY_NAME,
        JLDW AS MEASUREMENT_UNITS,
        0 AS ACTUAL_MONTH_OUTPUT_CNT,
        0 AS MONTH_ORDER_CNT,  --本月接单量
        0 AS NEXT_MONTH_ORDER_CNT,
        0 AS ALL_ORDER_CNT,
        T4.MONTH_SALE_TARGET,  --本月销售目标
        T4.NEXT_MONTH_SALE_TARGET,  --次月销售目标
        NULL,
        NULL,  --产能维护人
        NULL,  --产能审批人
        SYSDATE AS ETL_CRT_DT,
        SYSDATE AS ETL_UPD_DT
FROM    (
    SELECT  DISTINCT SCX,JLDW
    FROM    ODS_ERP.ODS_ERP_ERPSJWHJCB
    WHERE   NVL(ZZB,' ') <> '玫德威海炼铁事业部'
    ) T1
    LEFT JOIN   ODS_ERP.ODS_GJZBSCX T3
    ON  T1.SCX = T3.SCX
    LEFT JOIN   (
        SELECT  CORPORATE_ENTITY_NAME_SN AS SCX
                ,SUM(CASE WHEN TRUNC(PERIOD,'MM') = TRUNC(SYSDATE - 1,'MM') THEN SALES_WEIGHT_T ELSE 0 END) AS MONTH_SALE_TARGET
                ,SUM(CASE WHEN TRUNC(PERIOD,'MM') = ADD_MONTHS(TRUNC(SYSDATE - 1,'MM'), 1) THEN SALES_WEIGHT_T ELSE 0 END) AS NEXT_MONTH_SALE_TARGET
        FROM    MDDWD.DWD_SALES_TARGET
        WHERE   SALES_TARGET_TYPE = '确保'
            AND SALE_PLATFORM_NAME IN ('国内销售平台','海外销售平台','工业&电力BG')
            AND TRUNC(PERIOD,'YYYY') = TRUNC(SYSDATE -1, 'YYYY')
        GROUP BY    CORPORATE_ENTITY_NAME_SN
    )  T4
    ON  T3.SCXJC = T4.SCX
    WHERE   T1.SCX NOT IN ('济南科德智能科技有限公司','临沂玫德庚辰金属材料有限公司','山东晨晖电子科技有限公司');  --晨晖没有件数目标，先将其置为空，后续考虑解决方案。user:王泽祥

IF TO_CHAR(SYSDATE, 'HH24') <= '12' THEN
  DELETE FROM ADS_PRODUCTION_SATURATION WHERE TRUNC(YPERIOD) = TRUNC(SYSDATE - 1);
END IF;

END;

