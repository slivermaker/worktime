/*
  Description：接单明细表
  Author：王泽祥
  Create date：2024-12-10
  Modify：王泽祥
  Modify note：加入国内接单是否计入销售业绩判断、销售预测金额
  UPDATE DATE:2025-03-28
  UPDATE USER:王泽祥
  UPDATE NOTE:外销接单金额取数规则同步25.03.25规则，外销销售预测金额同步外销接单金额
  UPDATE DATE:2025-04-07
  UPDATE USER:王泽祥
  UPDATE NOTE:按更新后的25.03.25规则，管道外销接单金额越南与泰国取消税率计算
  UPDATE DATE:2025-04-10
  UPDATE USER:王泽祥
  UPDATE NOTE:海外销售预测：IMS端取数逻辑变更同步IMS，账套增加‘1110_山东得一2062’
  UPDATE DATE:2025-04-12
  UPDATE USER:王泽祥
  UPDATE NOTE:IMS内销账期逻辑变更为取订单提交时间
  UPDATE DATE:2025-05-21
  UPDATE USER:王泽祥
  UPDATE NOTE:生产公司取数改为取订单库存组织
  UPDATE DATE:2025-08-14
  UPDATE USER:常耀辉
  UPDATE NOTE:增加U9产品大中小类通过映射表更新的代码
*/

TRUNCATE TABLE MDDWD.DWD_SALE_ORDER;

INSERT INTO MDDWD.DWD_SALE_ORDER
(
    PERIOD  --账期期间
    ,PERIOD_DAY  --账期所属日
    ,ORIGIN_SYSTEM  --所属系统
    ,ORDER_DTL_ID  --订单明细ID
    ,ORDER_HEADER_ID  --订单头ID
    ,ORDER_CODE  --订单编码
    ,ORDER_INVOICE_DT  --订单录入日期
    ,ORDER_BRANCH_APPROVAL_TIME  --订单审批通过时间
    ,ORDER_SHIP_DT	--订单交货期
    ,ORDER_SHIP_ET_M	--订单预计发货月份
    ,ORDER_STATUS_ID  --订单状态ID
    ,ORDER_STATUS_NAME  --订单状态名称
    ,ORDER_TYPE_ID  --订单类型ID
    ,ORDER_TYPE_NAME  --订单类型名称
    ,ORDER_CONTRACT_DT  --订单合同日期
    ,ORDER_IS_CROSS_BORDER  --订单是否国际贸易
    ,ORDER_SHIP_STATUS_ID  --订单发货状态ID
    ,ORDER_PROJECT_ID  --订单项目ID
    ,ORDER_SALESMAN_ID  --订单业务员ID
    ,SALESMAN_ID  --业务员ID
    ,SALESMAN_PS_UID  --业务员PS账号
    ,SALESMAN_NAME  --业务员姓名
    ,DEPT3_LEADER_PS_UID  --科室负责人PS账号
    ,DEPT3_LEADER_NAME  --科室负责人姓名
    ,SALESMAN_LEADER_PS_UID  --业务员上级PS账号
    ,SALESMAN_LEADER_NAME  --业务员上级姓名
    ,ORG_ID  --组织ID
    ,ORG_CODE  --组织编码
    ,ORG_NAME  --组织名称
    ,ORDER_SHIP_ORG_ID  --订单出货组织ID
    ,ORDER_SHIP_ORG_NAME  --订单出货组织名称
    ,PRODUCE_COMPANY_NAME  --生产公司名称
    ,PRODUCE_COMPANY_NAME_SN  --生产公司简称
    ,SALE_PLATFORM_NAME  --销售平台全称
    ,SALE_PLATFORM_NAME_SN  --销售平台简称
    ,SALE_REGION_NAME  --销售大区全称
    ,SALE_REGION_NAME_SN  --销售大区简称
    ,SALE_COMPANY_NAME  --销售公司全称
    ,SALE_COMPANY_NAME_SN  --销售公司简称
    ,SALE_BG_NAME  --销售BG全称
    ,SALE_BG_NAME_SN  --销售BG简称
    ,SALE_BG_DEP_NAME  --销售BG科室全称
    ,SALE_BG_DEP_NAME_SN  --销售BG科室简称
    ,SALE_BU_DEP_NAME  --销售BU业务部全称
    ,SALE_BU_DEP_NAME_SN  --销售BU业务部简称
    ,ORDER_DEPT3_ID  --订单所属科室ID
    ,ORDER_DEPT3_NAME  --订单所属科室名称
    ,DEST_PORT_ID  --目的港ID
    ,DEST_PORT_NAME  --目的港名称
    ,DESTINATION_COUNTRY_ID  --运抵国ID
    ,DESTINATION_COUNTRY_NAME  --运抵国名称
    ,CUSTOMER_ID  --客户ID
    ,CUSTOMER_CODE  --客户编码
    ,CUSTOMER_NAME  --客户名称
    ,CUSTOMER_NAME_SN  --客户简称
    ,CUSTOMER_COUNTRY  --客户隶属国家
    ,CUSTOMER_PROVINCE  --客户隶属省
    ,CUSTOMER_CITY  --客户隶属市
    ,CITY_AREA  --市所属区域
    ,CUSTOMER_BG  --客户隶属BG
    ,CUSTOMER_BU  --客户隶属BU
    ,CUSTOMER_BG_ORG  --客户隶属BG组织
    ,CUSTOMER_BU_ORG  --客户隶属BU组织
    ,CUSTOMER_FIELD  --客户隶属领域
    ,FINAL_CUS_ID  --最终客户ID
    ,FINAL_CUS_NAME  --最终客户名称
    ,ORDER_PRODUCT_ID  --订单产品ID
	,PRODUCT_CODE  --产品编码
    ,PRODUCT_NAME  --产品名称
    ,PRODUCT_SORT1  --产品大类
    ,PRODUCT_SORT2  --产品中类
    ,PRODUCT_SORT3  --产品小类
    ,PRODUCT_FORM  --产品形式
    ,PRODUCT_VARIETY  --产品品种
    ,PRODUCT_SPECIFICATION  --产品规格
    ,PRODUCT_TEXTURE  --产品材质
    ,SURFACE_TREATMENT  --产品表面处理
    ,PRODUCT_LINE  --产品生产线
    ,SALES_PRODUCT_TYPE  --销售产品分类
    ,CURRENCY_EXCHANGE_RATE  --计价货币汇率
    ,CURRENCY  --币种
    ,ORDER_THEORE_NETWEIGHT_KG  --订单理论净重_千克
    ,ORDER_FACT_NETWEIGHT_KG  --订单实际净重_千克
    ,ORDER_SALE_FORE_WGT_KG  --订单销售预测重量_千克
    ,ORDER_TAX_AMT_Y  --订单含税金额_元
    ,ORDER_NOTAX_AMT_Y  --订单无税金额_元
    ,ORDER_SALE_FORE_AMT_Y  --订单销售预测金额_元
    ,ORDER_SYSCRT_BY_NAME  --订单系统录入人姓名
    ,ORDER_CRT_TIME  --订单创建时间
    ,ORDER_LAST_UPD_BY_NAME  --订单最后更新人姓名
    ,ORDER_LAST_UPD_TIME  --订单最后更新时间
    ,ORDER_DTL_SYSCRT_BY_NAME  --订单明细系统录入人姓名
    ,ORDER_DTL_CRT_TIME  --订单明细创建时间
    ,ORDER_DTL_LAST_UPD_BY_NAME  --订单明细最后更新人姓名
    ,ORDER_DTL_LAST_UPD_TIME  --订单明细最后更新时间
    ,ORDER_AMT_Y  --接单额_元
    ,ORDER_WGT_KG  --接单量_千克
    ,SALE_ACH_FLAG  --计入销售业绩标识
    ,IS_SALE_FORE  --是否计入销售预测
    ,ETL_CRT_DT  --创建时间
    ,ETL_UPD_DT  --更新时间
)
SELECT  TRUNC(
            CASE 
                WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'Y' THEN A1.ORDER_BRANCH_APPROVAL_TIME
                WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'N' THEN A1.ORDER_COMMIT_TIME  --IMS内销账期变更为订单提交时间  250412
                ELSE A1.ORDER_INVOICE_DT
            END
        ,'MM')  --账期期间
        ,CASE 
            WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'Y' THEN A1.ORDER_BRANCH_APPROVAL_TIME
            WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'N' THEN A1.ORDER_COMMIT_TIME  --IMS内销账期变更为订单提交时间  250412
            ELSE A1.ORDER_INVOICE_DT
        END AS PERIOD_DAY  --账期所属日
        ,A1.ORIGIN_SYSTEM  --所属系统
        ,A1.ORDER_DTL_ID  --订单明细ID
        ,A1.ORDER_HEADER_ID  --订单头ID
        ,A1.ORDER_CODE  --订单编码
        ,A1.ORDER_INVOICE_DT  --订单录入日期
        ,A1.ORDER_BRANCH_APPROVAL_TIME  --订单审批通过时间
        ,A1.ORDER_SHIP_DT	--订单交货期
        ,A1.ORDER_SHIP_ET_M	--订单预计发货月份
        ,A1.ORDER_STATUS_ID  --订单状态ID
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_STATUS_ID = 'C' THEN '审批通过'
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9' THEN A13.NAME
            ELSE NULL
        END AS ORDER_STATUS_NAME  --订单状态名称
        ,A1.ORDER_TYPE_ID  --订单类型ID
        ,A12.NAME  --订单类型名称
        ,A1.ORDER_CONTRACT_DT  --订单合同日期
        ,A1.ORDER_IS_CROSS_BORDER  --订单是否国际贸易
        ,A1.ORDER_SHIP_STATUS_ID  --订单发货状态ID
        ,A1.ORDER_PROJECT_ID  --订单项目ID
        ,A1.ORDER_SALESMAN_ID  --订单业务员ID
        ,A2.EMPLID  --业务员ID
        ,A1.ORDER_SALESMAN_PS_UID  --业务员PS账号
        ,A2.EMP_NAME  --业务员姓名
        ,A4.PS_USER_ID  --科室负责人PS账号
        ,A3.BU_DEP_MANAGER_NAME  --科室负责人姓名
        ,A41.PS_USER_ID  --业务员上级PS账号
        ,A3.BG_DEP_MANAGER_NAME  --业务员上级姓名
        ,A1.ORDER_ORG_ID  --组织ID
        ,A5.ORG_CODE  --组织编码
        ,A5.ORG_NAME  --组织名称
        ,A1.ORDER_SHIP_ORG_ID  --订单出货组织ID
        ,A6.ORG_NAME  --订单出货组织名称
        --,CASE WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9' THEN '济南迈科管道科技有限公司' ELSE A6.ORG_FULL_NAME END AS PRODUCE_COMPANY_NAME  --生产公司名称
		,A6.ORG_FULL_NAME
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9' THEN '迈科管道'
            WHEN A1.ORDER_SHIP_ORG_ID IN ('33','18','90','175','89') 
                THEN DECODE(A1.ORDER_SHIP_ORG_ID, '33', '迈科管道', '18', '玫德集团', '90', '济南雅昌', '175', '玫德集团', '89', '玫德雅昌（德庆）')
            WHEN A1.ORDER_IS_CROSS_BORDER = 'N' THEN A14.PRODUCE_COMPANY_NAME_SN  --生产公司简称
            ELSE A6.ORG_DESC  
        END AS PRODUCE_COMPANY_NAME_SN  --生产公司简称
        ,A3.SALE_PLATFORM_FULL_NAME  --销售平台全称
        ,A3.SALE_PLATFORM_SHORT_NAME  --销售平台简称
        ,A3.SALE_REGION_FULL_NAME  --销售大区全称
        ,A3.SALE_DEPT2_NAME_SN  --销售大区简称
        ,A3.SALE_COMPANY_FULL_NAME  --销售公司全称
        ,A3.SALE_COMPANY_NAME_SN  --销售公司简称
        ,A3.BG_FULL_NAME  --BG全称
        ,A3.BG_SHORT_NAME  --BG简称
        ,A3.BG_DEP_FULL_NAME  --BG科室全称
        ,A3.BG_DEP_SHORT_NAME  --BG科室简称
        ,A3.BU_DEP_FULL_NAME  --BU业务部全称
        ,A3.BU_DEP_SHORT_NAME  --BU业务部简称
        ,A1.ORDER_SALES_AREA_ID  --订单所属科室ID
        ,A7.ORG_NAME  --订单所属科室名称
        ,A1.ORDER_PORT_ID  --目的港ID
        ,NULL AS DEST_PORT_NAME  --目的港名称
        ,A1.ORDER_DESTINATION_COUNTRY_ID  --运抵国ID
        ,NULL AS DESTINATION_COUNTRY_NAME  --运抵国名称
        ,A1.ORDER_CUSTOMER_ID  --客户ID
        ,NVL(A9.CUSTOMER_CODE, A91.CUSTOMER_CODE)  --客户编码
        ,NVL(A9.CUSTOMER_NAME, A91.CUSTOMER_NAME)  --客户名称
        ,NVL(A9.CUSTOMER_NAME_SN, A91.CUSTOMER_NAME_SN)  --客户简称
        ,NVL(A9.CUSTOMER_COUNTRY, A91.CUSTOMER_COUNTRY)  --客户隶属国家
        ,NVL(A9.CUSTOMER_PROVINCE, A91.CUSTOMER_PROVINCE)  --客户隶属省
        ,NVL(A9.CUSTOMER_CITY, A91.CUSTOMER_CITY)  --客户隶属市
        ,NULL AS CITY_REGION  --市所属区域
        ,NVL(A9.CUSTOMER_BG, A91.CUSTOMER_BG)  --客户隶属BG
        ,NVL(A9.CUSTOMER_BU, A91.CUSTOMER_BU)  --客户隶属BU
        ,NVL(A9.CUSTOMER_BG_ORG,A91.CUSTOMER_BG_ORG) AS CUSTOMER_BG_ORG  --客户隶属BG组织
        ,NVL(A9.CUSTOMER_BU_ORG,A91.CUSTOMER_BU_ORG) AS CUSTOMER_BU_ORG  --客户隶属BU组织
        ,NULL AS CUSTOMER_FIELD  --客户隶属领域
        ,A1.ORDER_FINAL_CUS_ID  --最终客户ID
        ,A10.FINAL_CUS_NAME  --最终客户名称
        ,A1.ORDER_PRODUCT_ID  --订单产品ID
		,A11.PRODUCT_NAME  --产品编码
        ,A11.PRODUCT_NAME  --产品名称
        ,A11.PRODUCT_SORT1  --产品大类
        ,A11.PRODUCT_SORT2  --产品中类
        ,A11.PRODUCT_SORT3  --产品小类
        ,A11.PRODUCT_FORM  --产品形式
        ,A11.PRODUCT_VARIETY  --产品品种
        ,A11.PRODUCT_SPECIFICATION  --产品规格
        ,A11.PRODUCT_TEXTURE  --产品材质
        ,A11.SURFACE_TREATMENT  --产品表面处理
        ,A11.PRODUCT_PRODUCTION_LINE  --产品生产线
        ,A11.SALES_PRODUCT_TYPE  --销售产品分类
        ,A1.CURRENCY_EXCHANGE_RATE  --计价货币汇率
        ,NULL AS CURRENCY  --币种
        ,A1.ORDER_THEORE_NETWEIGHT_KG  --订单理论净重_千克
        ,A1.ORDER_FACT_NETWEIGHT_KG  --订单实际净重_千克
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'Y' THEN A1.ORDER_UNSHIP_WGT_KG
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
                --管道外销
                AND A5.ORG_NAME IN ('济南迈科管道科技有限公司','泰国达美电力有限公司','越南管业股份有限公司','越南对焊管件科技有限公司')  --账套限制
                AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('越南 VBFT','VIET NAM PIPING','泰国 DELTA','天津天应泰','深圳新亮光')  --客户简称限制
                AND A1.ORDER_TYPE_ID NOT IN 
                    (
                    '3','8','11','12'  --样品订单
                    ,'6','9'  --储备订单
                    ,'4','10'  --采购物资订单
                    )  --订单类型限制
                AND A1.ORDER_STATUS_ID NOT IN ('0','4','5')  --订单状态限制
                AND A1.ORDER_SHIP_STATUS_ID <> '2'  --订单发货状态限制
                --AND TRUNC(A1.ORDER_BRANCH_APPROVAL_TIME) BETWEEN DATE'2024-06-01' AND TRUNC(SYSDATE - 1)  --首次审批通过时间限制
            THEN A1.ORDER_FACT_NETWEIGHT_KG
            ELSE 0
        END AS ORDER_SALE_FORE_WGT_KG  --订单销售预测重量_千克
        ,A1.ORDER_TAX_AMT_Y  --订单含税金额_元
        ,A1.ORDER_NOTAX_AMT_Y  --订单无税金额_元
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS' AND A1.ORDER_IS_CROSS_BORDER = 'Y' THEN A1.ORDER_UNSHIP_AMT_Y / (1 + A1.EXPORT_VAT_RATE - A1.EXPORT_REBATE_RATE)  --25.06.11 规则改为未发货金额（USD）×计价货币汇率/（1+进价税率-出口退税率）
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
                --管道外销
                AND A5.ORG_NAME IN ('济南迈科管道科技有限公司','泰国达美电力有限公司','越南管业股份有限公司','越南对焊管件科技有限公司')  --账套限制
                AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('越南 VBFT','VIET NAM PIPING','泰国 DELTA','天津天应泰','深圳新亮光')  --客户简称限制
                AND A1.ORDER_TYPE_ID NOT IN 
                    (
                    '3','8','11','12'  --样品订单
                    ,'6','9'  --储备订单
                    ,'4','10'  --采购物资订单
                    )  --订单类型限制
                AND A1.ORDER_STATUS_ID NOT IN ('0','4','5')  --订单状态限制
                AND A1.ORDER_SHIP_STATUS_ID <> '2'  --订单发货状态限制
                --AND TRUNC(A1.ORDER_BRANCH_APPROVAL_TIME) BETWEEN DATE'2024-06-01' AND TRUNC(SYSDATE - 1)  --首次审批通过时间限制
            THEN CASE
                    WHEN A5.ORG_NAME = '济南迈科管道科技有限公司' AND A15.NAME <> 'TUBE INDUSTRY INVESTMENTS LIMITED' THEN A1.ORDER_TAX_AMT_Y  / (1 + A1.EXPORT_VAT_RATE - A1.EXPORT_REBATE_RATE)  --25.03.28 规则改为销售金额（合同明细中）×计价货币汇率（合同信息中）【DWI的含税金额_元】/（1+进价税率-出口退税率)
                    ELSE A1.ORDER_TAX_AMT_Y   --25.04.07 规则改为销售金额（合同明细中）X计价货币汇率（合同信息中）【DWI的含税金额_元】
                END
            ELSE 0
        END AS ORDER_SALE_FORE_AMT_Y  --订单销售预测金额_元
        ,A1.ORDER_SYSCRT_BY_ID  --订单系统录入人姓名
        ,A1.ORDER_CRT_TIME  --订单创建时间
        ,A1.ORDER_LAST_UPD_BY_ID  --订单最后更新人姓名
        ,A1.ORDER_LAST_UPD_TIME  --订单最后更新时间
        ,A1.ORDER_DTL_SYSCRT_BY_ID  --订单明细系统录入人姓名
        ,A1.ORDER_DTL_CRT_TIME  --订单明细创建时间
        ,A1.ORDER_DTL_LAST_UPD_BY_ID  --订单明细最后更新人姓名
        ,A1.ORDER_DTL_LAST_UPD_TIME  --订单明细最后更新时间
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS'
            THEN CASE
                    WHEN A1.ORDER_ORG_ID IN 
                        (
                            '11'-- 10_玫德集团2061
                            ,'12'-- 11_迈克阀门2064
                            ,'18'-- 17_玫德临沂2244
                            ,'43'-- 42_玫德艾瓦兹421
                            ,'50'-- 49_玫德雅昌鹤壁2501
                            ,'88'-- 87_玫德雅昌集团2601
                            ,'89'-- 88_玫德雅昌(德庆)2621
                            ,'90'-- 89_玫德雅昌(济南)2581
                            ,'403'-- 95_山东晨晖2981
                            ,'155'-- 155_山东德润3341
                        )  --账套限制
                        AND A1.ORDER_TYPE_ID IN
                            (
                                '1100625'  --内销常规订单
                                ,'1100626'  --内销收费样品订单
                                ,'1100962'  --内销外协常规订单
                            )  --订单类型限制
                        AND A1.ORDER_STATUS_ID = 'C'  --订单状态：‘审批通过’
                        AND A1.ORDER_REVIEW_CNT IS NOT NULL  --订单行明细-评审数：不为空
                        AND (SUBSTR(A1.TRANSACTION_PATH,4,1) <> '-' OR A1.TRANSACTION_PATH IS NULL) --销售订单信息-计划编号 第7位不为“-”或为空（为空为现选货）
                    THEN A1.ORDER_REVIEW_CNT * A1.ORDER_PRODUCT_AMOUNT_Y
                    WHEN A5.ORG_NAME IN 
                    (
                        '17_玫德临沂2244',
                        '10_玫德集团2061',
                        '18_香港控股2221',
                        '11_迈克阀门2064',
                        '19_得一国际2321',
                        '89_玫德雅昌(济南)2581',
                        '96_卓睿国际3001',
                        '49_玫德雅昌鹤壁2501',
                        '33_南洋金属3061',
                        '42_玫德艾瓦兹421'
                    )
                    AND UPPER(A91.CUSTOMER_NAME_SN) NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际','天津天应泰','SIAM FITTINGS','波兰国润')
                    AND A1.ORDER_TYPE_ID IN ('1000580','1000589')
                    AND A6.ORG_NAME <> '68_泰钢管配件2402'
                    AND A1.ORDER_IS_CROSS_BORDER = 'Y'
	                AND (
                        A7.ORG_NAME IN (SELECT DEPT3 from  ODS_APD.ODS_APD_ORG_CHANGE_CI_SALPLAT) 
                        OR 
                        A7.ORG_NAME IN (SELECT DESCR FROM ODS_PS.ODS_PS_MD_TREE_DPT_NOW WHERE MD_DEPTID_2 = '1000002303' AND EFF_STATUS = 'A' AND MD_DEPTID_3 <> '1000000894')  --MD_DEPTID_3 泰钢上线IMS前先不取
                    )  --销售区域限制
                     --and ORGMAP.ORGNAME in
                     --    (select dept3 from ODS_APD.ODS_APD_ORG_CHANGE_CI)
                    AND NVL(A1.ORDER_FINAL_CUS_ID,0) <> '100282'
                    AND A1.ORDER_STATUS_ID = 'C'
                    AND TO_CHAR(ORDER_BRANCH_APPROVAL_TIME, 'yyyy') > '2022'
                    THEN A1.ORDER_TAX_AMT_Y / (1 + A1.EXPORT_VAT_RATE - A1.EXPORT_REBATE_RATE)  --25.03.28 规则改为行总金额*计价货币汇率【DWI的含税金额_元】/（1+进价税率-出口退税率）
                    ELSE 0
                END
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
            THEN CASE
                    WHEN A1.ORDER_ORG_ID IN ('1001805064098230','1001805064089836')
                        AND A12.NAME = '标准销售[默认]'
                        AND A7.ORG_NAME IN (SELECT DISTINCT BU_DEP_FULL_NAME FROM MDDIM.DIM_SALE_DEPARTMENT WHERE SALE_PLATFORM_FULL_NAME = '国内销售平台' AND DEP_NATURE = '销售')
                        AND A1.ORDER_STATUS_ID = '3'
                        AND TO_NUMBER(A1.ORDER_DTL_STATUS_ID) < 4
                    THEN CASE
                            WHEN A1.ORDER_ORG_ID = '1001805064089836' THEN A1.ORDER_TAX_AMT_Y / 1.13
                            WHEN NVL(A1.UNIT_OF_MEASURE,AA1.VALUATION_UNIT) = 'PCS' THEN (A1.VALUATION_QUANTITY * A1.ORDER_PRODUCT_AMOUNT_Y) / 1.13
                            ELSE (A1.ORDER_FACT_NETWEIGHT_KG * A1.ORDER_PRODUCT_AMOUNT_Y) / 1.13
                        END
                    WHEN A9.CUSTOMER_NAME_SN NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际') 
                    AND (
                        A5.ORG_NAME = '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7,17)
                        OR
                        A5.ORG_NAME <> '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7)
                    )
                    AND A1.ORDER_STATUS_ID = 2
                    AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('VAN THONG','VIET NAM PIPING','越南 VBFT','越南 BADUONG','泰国 DELTA','天津天应泰')
                    THEN CASE
                            WHEN A5.ORG_NAME = '济南迈科管道科技有限公司' AND A15.NAME <> 'TUBE INDUSTRY INVESTMENTS LIMITED' THEN A1.ORDER_TAX_AMT_Y / (1 + A1.EXPORT_VAT_RATE - A1.EXPORT_REBATE_RATE)  --25.03.28 规则改为销售金额（合同明细中）X计价货币汇率（合同信息中）【DWI的含税金额_元】/（1+进价税率-出口退税率)
                            ELSE A1.ORDER_TAX_AMT_Y  --25.04.07 规则改为销售金额（合同明细中）X计价货币汇率（合同信息中）【DWI的含税金额_元】
                        END
                    ELSE 0
                END
            ELSE 0
        END AS ORDER_AMT_Y  --接单额_元
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS'
            THEN CASE 
                    WHEN A1.ORDER_ORG_ID IN 
                            (
                                '11'-- 10_玫德集团2061
                                ,'12'-- 11_迈克阀门2064
                                ,'18'-- 17_玫德临沂2244
                                ,'43'-- 42_玫德艾瓦兹421
                                ,'50'-- 49_玫德雅昌鹤壁2501
                                ,'88'-- 87_玫德雅昌集团2601
                                ,'89'-- 88_玫德雅昌(德庆)2621
                                ,'90'-- 89_玫德雅昌(济南)2581
                                ,'403'-- 95_山东晨晖2981
                                ,'155'-- 155_山东德润3341
                            )  --账套限制
                        AND A1.ORDER_TYPE_ID IN
                            (
                                '1100625'  --内销常规订单
                                ,'1100626'  --内销收费样品订单
                                ,'1100962'  --内销外协常规订单
                            )  --订单类型限制
                        AND A1.ORDER_STATUS_ID = 'C'  --订单状态：‘审批通过’
                        AND A1.ORDER_REVIEW_CNT IS NOT NULL  --订单行明细-评审数：不为空
                        AND (SUBSTR(A1.TRANSACTION_PATH,4,1) <> '-' OR A1.TRANSACTION_PATH IS NULL) --销售订单信息-计划编号 第7位不为“-”或为空（为空为现选货）
                    THEN A1.ORDER_REVIEW_CNT * A1.ORDER_PRODUCT_WEIGHT_KG
                    WHEN A5.ORG_NAME IN 
                    (
                        '17_玫德临沂2244',
                        '10_玫德集团2061',
                        '18_香港控股2221',
                        '11_迈克阀门2064',
                        '19_得一国际2321',
                        '89_玫德雅昌(济南)2581',
                        '96_卓睿国际3001',
                        '49_玫德雅昌鹤壁2501',
                        '33_南洋金属3061',
                        '42_玫德艾瓦兹421'
                    )
                    AND UPPER(A91.CUSTOMER_NAME_SN) NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际','天津天应泰','SIAM FITTINGS','波兰国润')
                    AND A1.ORDER_TYPE_ID IN ('1000580','1000589')
                    AND A6.ORG_NAME <> '68_泰钢管配件2402'
                    AND A1.ORDER_IS_CROSS_BORDER = 'Y'
	                AND (
                        A7.ORG_NAME IN (SELECT DEPT3 from  ODS_APD.ODS_APD_ORG_CHANGE_CI_SALPLAT) 
                        OR 
                        A7.ORG_NAME IN (SELECT DESCR FROM ODS_PS.ODS_PS_MD_TREE_DPT_NOW WHERE MD_DEPTID_2 = '1000002303' AND EFF_STATUS = 'A' AND MD_DEPTID_3 <> '1000000894')  --MD_DEPTID_3 泰钢上线IMS前先不取
                    )  --销售区域限制
                     --and ORGMAP.ORGNAME in
                     --    (select dept3 from ODS_APD.ODS_APD_ORG_CHANGE_CI)
                    AND NVL(A1.ORDER_FINAL_CUS_ID,0) <> '100282'
                    AND A1.ORDER_STATUS_ID = 'C'
                    AND TO_CHAR(ORDER_BRANCH_APPROVAL_TIME, 'yyyy') > '2022'
                    THEN A1.ORDER_THEORE_NETWEIGHT_KG
                    ELSE 0
                END
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
            THEN CASE
                    WHEN A1.ORDER_ORG_ID IN ('1001805064098230','1001805064089836')
                        AND A12.NAME = '标准销售[默认]'
                        AND A7.ORG_NAME IN (SELECT DISTINCT BU_DEP_FULL_NAME FROM MDDIM.DIM_SALE_DEPARTMENT WHERE SALE_PLATFORM_FULL_NAME = '国内销售平台' AND DEP_NATURE = '销售')
                        AND A1.ORDER_STATUS_ID = '3'
                        AND TO_NUMBER(A1.ORDER_DTL_STATUS_ID) < 4
                    THEN A1.ORDER_FACT_NETWEIGHT_KG
                    WHEN A9.CUSTOMER_NAME_SN NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际') 
                    AND (
                        A5.ORG_NAME = '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7,17)
                        OR
                        A5.ORG_NAME <> '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7)
                    )
                    AND A1.ORDER_STATUS_ID = 2
                    AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('VAN THONG','VIET NAM PIPING','越南 VBFT','越南 BADUONG','泰国 DELTA','天津天应泰')
                    THEN A1.ORDER_FACT_NETWEIGHT_KG
                    ELSE 0
                END
            ELSE 0
        END AS ORDER_WGT_KG  --接单量_千克
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS'
            THEN CASE
                --IMS内销
                WHEN A1.ORDER_ORG_ID IN 
                    (
                        '11'-- 10_玫德集团2061
                        ,'12'-- 11_迈克阀门2064
                        ,'18'-- 17_玫德临沂2244
                        ,'43'-- 42_玫德艾瓦兹421
                        ,'50'-- 49_玫德雅昌鹤壁2501
                        ,'88'-- 87_玫德雅昌集团2601
                        ,'89'-- 88_玫德雅昌(德庆)2621
                        ,'90'-- 89_玫德雅昌(济南)2581
                        ,'403'-- 95_山东晨晖2981
                        ,'155'-- 155_山东德润3341
                    )  --账套限制
                    AND A1.ORDER_TYPE_ID IN
                    (
                        '1100625'  --内销常规订单
                        ,'1100626'  --内销收费样品订单
                        ,'1100962'  --内销外协常规订单
                    )  --订单类型限制
                    AND A1.ORDER_STATUS_ID = 'C'  --订单状态：‘审批通过’
                    AND A1.ORDER_REVIEW_CNT IS NOT NULL  --订单行明细-评审数：不为空
                    AND (SUBSTR(A1.TRANSACTION_PATH,4,1) <> '-' OR A1.TRANSACTION_PATH IS NULL) --销售订单信息-计划编号 第7位不为“-”或为空（为空为现选货）
                    AND A1.ORDER_IS_CROSS_BORDER = 'N'
                THEN '是'
                --IMS外销
                WHEN A5.ORG_NAME IN 
                    (
                        '17_玫德临沂2244',
                        '10_玫德集团2061',
                        '18_香港控股2221',
                        '11_迈克阀门2064',
                        '19_得一国际2321',
                        '89_玫德雅昌(济南)2581',
                        '96_卓睿国际3001',
                        '49_玫德雅昌鹤壁2501',
                        '33_南洋金属3061',
                        '42_玫德艾瓦兹421'
                    )
                    AND UPPER(A91.CUSTOMER_NAME_SN) NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际','天津天应泰','SIAM FITTINGS','波兰国润')
                    AND A1.ORDER_TYPE_ID IN ('1000580','1000589')
                    AND A6.ORG_NAME <> '68_泰钢管配件2402'
                    AND A1.ORDER_IS_CROSS_BORDER = 'Y'
	                AND (
                        A7.ORG_NAME IN (SELECT DEPT3 from  ODS_APD.ODS_APD_ORG_CHANGE_CI_SALPLAT) 
                        OR 
                        A7.ORG_NAME IN (SELECT DESCR FROM ODS_PS.ODS_PS_MD_TREE_DPT_NOW WHERE MD_DEPTID_2 = '1000002303' AND EFF_STATUS = 'A' AND MD_DEPTID_3 <> '1000000894')  --MD_DEPTID_3 泰钢上线IMS前先不取
                    )  --销售区域限制
                     --and ORGMAP.ORGNAME in
                     --    (select dept3 from ODS_APD.ODS_APD_ORG_CHANGE_CI)
                    AND NVL(A1.ORDER_FINAL_CUS_ID,0) <> '100282'
                    AND A1.ORDER_STATUS_ID = 'C'
                    AND TO_CHAR(ORDER_BRANCH_APPROVAL_TIME, 'yyyy') > '2022'
                THEN '是'
                ELSE '否'
            END
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
            THEN CASE
                --管道内销
                WHEN A1.ORDER_ORG_ID IN ('1001805064098230','1001805064089836')
                    AND A12.NAME = '标准销售[默认]'
                    AND A7.ORG_NAME IN (SELECT DISTINCT BU_DEP_FULL_NAME FROM MDDIM.DIM_SALE_DEPARTMENT WHERE SALE_PLATFORM_FULL_NAME = '国内销售平台' AND DEP_NATURE = '销售')
                    AND A1.ORDER_STATUS_ID = '3'
                    AND TO_NUMBER(A1.ORDER_DTL_STATUS_ID) < 4
                THEN '是'
                --管道外销
                WHEN A9.CUSTOMER_NAME_SN NOT IN ('香港 得一国际', '香港 玫德控股', '卓睿国际') 
                    AND (
                        A5.ORG_NAME = '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7,17)
                        OR
                        A5.ORG_NAME <> '越南管业股份有限公司' AND A1.ORDER_TYPE_ID IN (0,2,5,7)
                    )
                    AND A1.ORDER_STATUS_ID = 2
                    AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('VAN THONG','VIET NAM PIPING','越南 VBFT','越南 BADUONG','泰国 DELTA','天津天应泰')
                THEN '是'
                ELSE '否'
            END
            ELSE '否'
        END AS SALE_ACH_FLAG  --计入销售业绩标识
        ,CASE
            WHEN A1.ORIGIN_SYSTEM = 'IMS'
                --IMS外销
                AND A5.ORG_NAME IN
                    (
                        '10_玫德集团2061',
                        '11_迈克阀门2064',
                        '12_迈科管道2066',
                        '17_玫德临沂2244',
                        '18_香港控股2221',
                        '19_得一国际2321',
                        '33_南洋金属3061',
                        '42_玫德艾瓦兹421',
                        '49_玫德雅昌鹤壁2501',
                        '68_泰钢管配件2402',
                        '89_玫德雅昌(济南)2581',
                        '96_卓睿国际3001',
                        '99_沃尔甘3121',
                        '1110_山东得一2062'
                    )  --账套限制
                AND UPPER(A91.CUSTOMER_NAME_SN) NOT IN ('天津天应泰','SIAM FITTINGS','波兰国润')  --客户简称限制
                AND A1.ORDER_TYPE_ID IN ('1000580','1000589')  --订单类型限制（赵晓晓确认剔除后的为'出口订单', '多口岸订单'）
                AND A1.ORDER_STATUS_ID IN ('A1','B','C')  --订单状态限制
                AND A1.ORDER_SHIP_STATUS_ID IN ('未发货','部分发货')
            THEN '是'
            WHEN A1.ORIGIN_SYSTEM = 'MAIKE_U9'
                --管道外销
                AND A5.ORG_NAME IN ('济南迈科管道科技有限公司','泰国达美电力有限公司','越南管业股份有限公司','越南对焊管件科技有限公司')  --账套限制
                AND UPPER(A9.CUSTOMER_NAME_SN) NOT IN ('越南 VBFT','VIET NAM PIPING','泰国 DELTA','天津天应泰','深圳新亮光')  --客户简称限制
                AND A1.ORDER_TYPE_ID NOT IN 
                    (
                    '3','8','11','12'  --样品订单
                    ,'6','9'  --储备订单
                    ,'4','10'  --采购物资订单
                    )  --订单类型限制
                AND A1.ORDER_STATUS_ID NOT IN ('0','4','5')  --订单状态限制
                AND A1.ORDER_SHIP_STATUS_ID <> '2'  --订单发货状态限制
                --AND TRUNC(A1.ORDER_BRANCH_APPROVAL_TIME) BETWEEN DATE'2024-06-01' AND TRUNC(SYSDATE - 1)  --首次审批通过时间限制
            THEN '是'
            ELSE '否'
        END AS IS_SALE_FORE  --是否计入销售预测
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
FROM    MDDWI.DWI_SALE_ORDER                    A1  --订单模型
LEFT JOIN   (SELECT DISTINCT ORDER_CODE, PRODUCT_ID, VALUATION_UNIT FROM MDDWD.DWD_SALE_DELIVERY)             AA1  --发货单明细
ON      A1.ORDER_CODE = AA1.ORDER_CODE
AND		A1.ORDER_PRODUCT_ID = NVL(AA1.PRODUCT_ID,A1.ORDER_PRODUCT_ID)
LEFT JOIN   MDDWI.TF_DWI_EMPLOYEE               A2  --业务员维表
ON      A2.PS_USER_ID = A1.ORDER_SALESMAN_PS_UID
LEFT JOIN   MDDIM.DIM_SALE_DEPARTMENT           A3  --行政组织维表
ON      A3.UNIT_DEP_ID = A2.UNIT_CODE
LEFT JOIN   MDDWI.TF_DWI_EMPLOYEE               A4  --科室负责人维表
ON      A4.EMPLID = A3.BU_DEP_MANAGER_ID
LEFT JOIN   MDDWI.TF_DWI_EMPLOYEE               A41  --销售人员维表
ON      A41.EMPLID = A3.BG_DEP_MANAGER_ID
LEFT JOIN   MDDIM.DIM_ORG_D                     A5  --子公司维表
ON      A5.ORG_ID = A1.ORDER_ORG_ID
AND     A5.SOURCE_SYS = A1.ORIGIN_SYSTEM
LEFT JOIN   MDDIM.DIM_ORG_D                     A6  --子公司维表
ON      A6.ORG_ID = CASE WHEN A1.ORIGIN_SYSTEM = 'IMS' THEN A1.ORDER_SHIP_ORG_ID ELSE A1.ORDER_ORG_ID END
AND     A6.SOURCE_SYS = A1.ORIGIN_SYSTEM
LEFT JOIN   MDDIM.DIM_ORG_D                     A7  --科室 组织维表
ON      A7.ORG_ID = A1.ORDER_SALES_AREA_ID
AND     A7.SOURCE_SYS = A1.ORIGIN_SYSTEM
LEFT JOIN   MDDIM.DIM_CUSTOMER                  A9  --客户维表
ON      A1.ORDER_CUSTOMER_ID = A9.EXP_CUST_ID
AND     A1.ORIGIN_SYSTEM = A9.SOURCE_SYS
LEFT JOIN   MDDIM.DIM_CUSTOMER                  A91  --客户维表
ON      A1.ORDER_CUSTOMER_ID = A91.CUSTOMER_ID
AND     A1.ORIGIN_SYSTEM = A91.SOURCE_SYS
LEFT JOIN   MDDIM.DIM_FINAL_CUSTOMER            A10  --最终客户维表
ON      A1.ORDER_FINAL_CUS_ID = A10.FINAL_CUS_ID
AND     A1.ORIGIN_SYSTEM = A10.SOURCE_SYS
LEFT JOIN   MDDIM.DIM_PRODUCT                   A11  --产品维表
ON      A1.ORDER_PRODUCT_ID = A11.PRODUCT_ID
AND     A11.SOURCE_SYS = A1.ORIGIN_SYSTEM
LEFT JOIN   MDDIM.DIM_CODE_D                    A12  --码值表
ON      A1.ORDER_TYPE_ID = A12.ID
AND     A12.STATUS = 'A'
AND     A1.ORIGIN_SYSTEM = A12.SOURCE_SYS
AND     A12.COMMENT1 = '销售订单单据类型'
LEFT JOIN   MDDIM.DIM_CODE_D                    A13  --码值表
ON      A1.ORDER_STATUS_ID = A13.CODE
AND     A13.STATUS = 'A'
AND     A1.ORIGIN_SYSTEM = A13.SOURCE_SYS
AND     A13.SOURCE_TABLE = '内销订单状态'
LEFT JOIN   (
    SELECT  DISTINCT
            PRODUCE_COMPANY_ORG
            ,PRODUCE_COMPANY_NAME_SN
    FROM    MDDIM.DIM_BUSINESS_ORGANIZATION
)                                               A14
ON  A14.PRODUCE_COMPANY_ORG = A6.ORG_NAME
LEFT JOIN   ODS_MAIKE_U9.ODS_CUST_DOCUMENTCUSTOMERINFO      A15
ON  A15.ID = A1.CUST_DOC_CTM_INFO_ID
AND A1.ORIGIN_SYSTEM = 'MAIKE_U9'

/*
WHERE TRUNC(A1.ORDER_BRANCH_APPROVAL_TIME,'YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), -24)
OR TRUNC(A1.ORDER_COMMIT_TIME,'YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), -24)
OR TRUNC(A1.ORDER_INVOICE_DT,'YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), -24)
OR TRUNC(A1.ORDER_SHIP_DT,'YYYY') >= ADD_MONTHS(TRUNC(SYSDATE, 'YYYY'), -24)
*/
;
MERGE INTO DWD_SALE_ORDER A
USING (
    SELECT DISTINCT 
        B.ITEM,B.PRO1,B.PRO2,B.PRO3
    FROM ods_apd.ods_apd_xinghaoyignshe B
) B
ON (
    A.PRODUCT_CODE = B.ITEM
)
WHEN MATCHED THEN
    UPDATE SET A.PRODUCT_SORT1 = B.PRO1
   ,  A.PRODUCT_SORT2 = B.PRO2
   ,  A.PRODUCT_SORT3 = B.PRO3
;
COMMIT;