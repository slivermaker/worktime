CREATE TABLE  DWD_SALE_DLY2_TMP AS(
    SELECT * FROM TF_DWD_SALE_DLY WHERE 1=0
)

TRUNCATE TABLE DWD_SALE_DLY2_TMP;
-----   将艾瓦兹插入到临时表中   -----
INSERT INTO DWD_SALE_DLY2_TMP (
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO
,PROJECT_NAME
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS
,DEPT2_HIS
,DEPT3_HIS
,DEPT1
,DEPT2
,DEPT3
,PRODUCE_COMPANY
,PRODUCE_COMPANY_SN
,PRODUCT_SORT1
,PRODUCT_SORT2
,PRODUCT_SORT3
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,BUSINESS_TYPE
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS 
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME
,FULL_NAME      
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
SELECT SYS_GUID() AS ID                                                   --UUID主键                  
,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                              --账期期间
,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
,'玫德艾瓦兹（济南）金属制品有限公司' AS COMPANY_SALE                             --销售公司
,'玫德艾瓦兹'   AS COMPANY_SN                                             --销售公司简称  
,'玫德艾瓦兹国内销售' AS DEPT1_HIS                        --历史部门
,G4.ORGNAME AS DEPT2_HIS                                                  --历史大区
,G3.ORGNAME AS DEPT3_HIS                                                  --历史科室
,'玫德艾瓦兹国内销售' AS DEPT1                            --部门
,'玫德艾瓦兹国内销售(未映射)' AS DEPT2                                                      --大区
,'玫德艾瓦兹国内销售(未映射)' AS DEPT3                                                      --科室
,'玫德艾瓦兹（济南）金属制品有限公司' AS PRODUCE_COMPANY                          --生产公司
,'玫德艾瓦兹' PRODUCE_COMPANY_SN ,                                        --生产公司简称
 NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                           --产品大类
 NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                           --产品中类
 NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                            --产品小类
,' ' AS FIELD                                                             --领域
,B.MATERIAL_DESCRIPTION AS MAT_DESC                                       --产品名称
,C.FORM AS PRODUCT_FORM                                                   --产品形式
,C.TEXTURE AS TEXTURE                                                     --材质分类
,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
,C.VARIETY AS MAT_VARIETY                                               --品种
,C.SPECIFICATION AS MAT_SPEC                                            --规格
,'CNY' AS CURRENCY                                                      --币种
,'中国' AS COUNTRY                                                      --国别
,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                               --开单客户最新名称
,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                             --分销客户最新名称/最终客户最新名称 
,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
,I.EMPNAME AS SALESMAN                                                   --业务员
,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
,' ' AS MANAGER                                                          --主管
,' ' AS LEADER                                                           --科室负责人
,' ' AS ISNEWCUS                                                         --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
,NULL AS BUSINESS_TYPE       
,A.STATUS   AS  STATUS                                                   --基础信息状态生效
,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                       --已出库
,CASE WHEN A.STATUS = 'C' AND A.EXPORT_CONFIRM_FLAG = 'Y' THEN '是' ELSE '否' END AS ISSTATUS -- 是否已生效且出库  
,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT--重量                            
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/1.13*DECODE(G1.ORGNAME,'10_玫德集团2061',0.965,1)  AS AMT_M_FACT_OUTTAX--底表字段：无税金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
,SYSDATE ETL_CRT_DT
,SYSDATE ETL_UPD_DT
,'国内' AS BUSINESS
,A.CUSTOMER_ID
,A.INCEPT_ADDRESS_ID
,G1.ORGNAME
,G2.FULL_NAME FULL_NAME      
,C.splcsj AS product_first_mass_prod_dt --  产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A 
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
WHERE H.ORDER_TYPE_NAME IN ('内销常规订单','内销调账销售订单','内销调账红冲订单','内销退货订单','服务销售订单','工具归还订单','工具借出订单')
AND G1.ORGNAME IN ('42_玫德艾瓦兹421','10_玫德集团2061')
AND G2.ORGNAME ='42_OU_玫德艾瓦兹441'
AND A.DELIVERY_CODE <>'DE2404012761'
and to_char(A.EXPORT_CONFIRM_DATE,'yyyymm') < '202412' ;


--将阀门插入临时表

INSERT INTO   DWD_SALE_DLY2_TMP  
(
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,produce_company 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,business_type
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS
,ORG_NAME
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,FULL_NAME--20250125
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
SELECT SYS_GUID() AS ID                                                      --UUID主键
      ,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                       --账期期间
      ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                     --业务日期
      ,A.DELIVERY_CODE AS DELIVERY_CODE                                      --发货单号
      ,B.LINE_NO AS BIZ_LINE_NO                                              --业务单据明细行号
      ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS     --订单编号
      ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                       --订单类型
      ,L.ORDER_NUM AS ORDER_NO                                               --明细订单编号
      ,A.ATTRIBUTE21 AS PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
      ,'济南迈克阀门科技有限公司' AS COMPANY_SALE                            --销售公司
      ,'迈克阀门'    AS COMPANY_SN                                           --销售公司简称  
      ,'迈克阀门国内营销中心'  AS DEPT1_HIS                                  --历史部门          
      ,G4.ORGNAME AS DEPT2_HIS                                               --历史大区        
      ,G3.ORGNAME AS DEPT3_HIS                                               --历史科室     
      ,'迈克阀门国内营销中心'  AS DEPT1                                      --部门    
      ,G4.ORGNAME AS DEPT2                                                   --大区
      ,G3.ORGNAME AS DEPT3                                                   --科室
      --,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company              --生产公司（库存组织）
      ,'济南迈克阀门科技有限公司' AS produce_company                         --生产公司
      ,'迈克阀门'  PRODUCE_COMPANY_SN ,                                      --生产公司简称
       NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                    --产品大类
       NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                    --产品中类
       NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                     --产品小类 
      ,A.CONTAINER_TYPE AS FIELD                                             --领域     
      ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                    --产品名称
      ,C.FORM AS PRODUCT_FORM                                                --产品形式 
      ,C.TEXTURE AS TEXTURE                                                  --材质分类         
      ,C.SURFACE_TREATMENT AS MAT_SURFACE                                    --表面       
      ,C.PRODUCT_SORT AS MAT_SORT                                            --产品分类新    
      ,K.ATTR5_NAME AS MAT_ATTR5                                             --属性5      
      ,B.MATERIAL_CODE AS MAT_CODE                                           --物料编号     
      ,C.VARIETY AS MAT_VARIETY                                              --品种       
      ,C.SPECIFICATION AS MAT_SPEC                                           --规格       
      ,'CNY' AS CURRENCY                                                     --币种       
      ,'中国' AS COUNTRY                                                     --国别         
      ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
      ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
      ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
      ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
      ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
      ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
      ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME --隶属省
      ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME            --隶属市       
      ,I.EMPNAME AS SALESMAN_HIS                                                  --历史业务员
      ,I.EMPNAME AS SALESMAN                                                      --业务员
      ,EMP.USERID AS SALESMAN_ID_HIS                                              --历史业务员账号 
      ,EMP.USERID AS SALESMAN_ID                                                  --最新业务员账号 
      ,' ' AS MANAGER                                                             --主管      
      ,' ' AS LEADER                                                              --科室负责人   
      ,' 'AS ISNEWCUS                                                             --是否新客户  
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) 
        and trunc(C.splcsj + C.pallet_num) >= trunc(A.export_confirm_date) 
    then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
      ,' ' AS ISUPSELLPROD                                                        --是否老客户新产品
    ,' ' AS business_type                                       --三新类型
    ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
    ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
    ,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库 
      ,J.DICTNAME AS MEASUREMENT_UNIT                                             --计量单位    
      ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT                --重量                            
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP                      --合计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT                       --总计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT   --市场折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT     --商业折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE                       --项目差价
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP               --临时：表头费用
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY                   --临时：表头总数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX                             --临时：表头总箱数
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT                              -- 销售金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT                      -- 订单金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12                        -- 费用金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/(100+NVL(REPLACE(A.IS_CUSTOMER_UNRELATED,'%',''),13))*100  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT                    --底表字段：实发数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT                     --底表字段：箱数 
      ,SYSDATE ETL_CRT_DT
      ,SYSDATE ETL_UPD_DT
    ,'国内' AS BUSINESS
    ,G1.ORGNAME AS ORG_NAME
      ,A.CUSTOMER_ID
      ,INCEPT_ADDRESS_ID
      ,G2.FULL_NAME
,C.splcsj --  产品首批量产时间
,A.export_confirm_date  --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE  B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
WHERE 
--1单据状态条件
--NVL(A.STATUS,' ') <> 'E'
--A.STATUS = 'C'--基础信息状态生效C
--AND A.EXPORT_CONFIRM_FLAG = 'Y'--已出库
--AND A.ERP_FLAG = 'Y'--已过EBS
 H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销退货订单' ,'内销发货调整订单','内销收费样品订单','服务销售订单','内销外协常规订单')--订单类型，更新是否销售业绩单据    -- 2024-3-5 增加订单类型： 服务销售订单
--2.2特异条件  各个单位不同，关联映射表，更新销售业绩账套字段
AND G1.ORGNAME IN ('10_玫德集团2061','11_迈克阀门2064') --账套，更新销售业绩账套字段-联合条件   ,'玫德雅昌集团有限公司'
AND G2.ORGNAME IN ('FM1_迈克阀门124')   --生产公司，更新销售业绩账套字段-联合条件    'MD1_玫德集团122' , 
AND D.CUSTOMER_NEW_NAME NOT IN ('销售计划科','迈克阀门国内销售支持科','迈克阀门系统集成科','品牌推广科')
and  to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' ;

----将母公司数据导入----

INSERT INTO   DWD_SALE_DLY2_TMP
(
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,produce_company 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,business_type
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME
,FULL_NAME --20250125
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)

SELECT
SYS_GUID() AS ID                                                          --UUID主键                  
,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                          --账期期间
,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
,'玫德集团有限公司' AS COMPANY_SALE                                       --销售公司
,'母公司'   AS COMPANY_SN                                                 --销售公司简称  
,'国内销售部'  AS DEPT1_HIS                                               --历史部门
,G4.ORGNAME AS DEPT2_HIS                                                  --历史大区
,G3.ORGNAME AS DEPT3_HIS                                                  --历史科室
,'国内销售部'  AS DEPT1                                                   --部门
,G4.ORGNAME AS DEPT2                                                      --大区
, G3.ORGNAME AS DEPT3                                                      --科室
,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company                   --生产公司（库存组织）
,'母公司' PRODUCE_COMPANY_SN ,                                            --生产公司简称
 NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                       --产品大类
 NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                       --产品中类
 NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                       --产品小类
,M.MAIN_FIELD AS FIELD                                                   --领域
,B.MATERIAL_DESCRIPTION AS MAT_DESC                                      --产品名称
,C.FORM AS PRODUCT_FORM                                                  --产品形式
,C.TEXTURE AS TEXTURE                                                    --材质分类
,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
,C.VARIETY AS MAT_VARIETY                                               --品种
,C.SPECIFICATION AS MAT_SPEC                                            --规格
,'CNY' AS CURRENCY                                                      --币种
,'中国' AS COUNTRY                                                      --国别
,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称 
,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
,I.EMPNAME AS SALESMAN                                                   --业务员
,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
,' ' AS MANAGER                                                          --主管
,' ' AS LEADER                                                           --科室负责人
,' 'AS ISNEWCUS                                                          --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) 
        and trunc(C.splcsj + C.pallet_num) >= trunc(A.export_confirm_date) 
    then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
--,ZB.business_type AS business_type                                       --三新类型
,null AS business_type       
,A.STATUS   AS  STATUS                                                            --基础信息状态生效
,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库  
,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                   --商业折扣类型
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT--重量                            
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/(100+NVL(REPLACE(A.IS_CUSTOMER_UNRELATED,'%',''),13))*100  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
,SYSDATE ETL_CRT_DT
,SYSDATE ETL_UPD_DT
,'国内' AS BUSINESS
,A.CUSTOMER_ID
,A.INCEPT_ADDRESS_ID
,G1.ORGNAME ORG_NAME 
,G2.FULL_NAME 
,C.splcsj --  产品首批量产时间
,A.export_confirm_date  --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A 
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE        B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
--LEFT JOIN ODS_IMS.TF_ODS_IMS_ISNEW_MARK ZB ON B.DELIVERY_LINE_ID = ZB.delivery_line_id
LEFT JOIN ODS_IMS.ODS_CRM_DOMAIN_BASE M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE AND M.STATUS = 'C'  --领域表
WHERE 
 H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销退货订单' ,'内销发货调整订单','内销收费样品订单')--订单类型，更新是否销售业绩单据    
AND G1.ORGNAME = '10_玫德集团2061' --账套，更新销售业绩账套字段-联合条件
AND G2.ORGNAME IN ('MD1_玫德集团122' ,'LY_玫德临沂127')   --生产公司，更新销售业绩账套字段-联合条件
and to_char(A.EXPORT_CONFIRM_DATE,'yyyymm')<'202412' ;

------玫德威海


INSERT INTO DWD_SALE_DLY2_TMP (
ID,
PERIOD,
BIZ_DATE,
DELIVERY_CODE,
BIZ_LINE_NO,
ORDER_NOS,
ORDER_TYPE,
ORDER_NO,
PROJECT_NAME,
COMPANY_SALE,
COMPANY_SN,
DEPT1_HIS,
DEPT2_HIS,
DEPT3_HIS,
DEPT1,
DEPT2,
DEPT3,
PRODUCE_COMPANY,
PRODUCE_COMPANY_SN,
PRODUCT_SORT1,
PRODUCT_SORT2,
PRODUCT_SORT3,
FIELD,
MAT_DESC,
PRODUCT_FORM,
TEXTURE,
MAT_SURFACE,
MAT_SORT,
MAT_ATTR5,
MAT_CODE,
MAT_VARIETY,
MAT_SPEC,
CURRENCY,
COUNTRY,
CUSTOMER_CODE,
CUSTOMER_NAME,
CUSTOMER_NEW_NAME,
CUSTOMER_CODE1,
CUSTOMER_NAME1,
CUSTOMER_NEW_NAME1,
PROVINCE_NAME,
CITY_NAME,
SALESMAN_HIS,
SALESMAN,
SALESMAN_ID_HIS,
SALESMAN_ID,
MANAGER,
LEADER,
ISNEWCUS,
ISNEWPROD,
ISUPSELLPROD,
MEASUREMENT_UNIT,
TRADE_DISCOUNT_TYPE,
LINE_NET_WEIGHT,
TOTAL_AMOUNT_OUTEXP,
TOTAL_AMOUNT,
MARKET_DISCOUNT_AMOUNT,
TRADE_DISCOUNT_AMOUNT,
QTY_OUT_LINE,
TOTAL_AMOUNT_EXP,
BEFORE_DISCOUNT_AMOUNT,
TOTAL_QUANTITY,
TOTAL_BOX,
AMT_M_FACT,
ORDER_AMOUNT,
ATTRIBUTE12,
AMT_M_FACT_OUTTAX,
QTY_M_FACT,
BOX_M_FACT,
ETL_CRT_DT,
ETL_UPD_DT,
BUSINESS_TYPE,
STATUS,
EXPORT_CONFIRM_FLAG,
ISSTATUS,
BUSINESS,
INVENTORY_CODE,
INVENTORY_DESC
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME
,FULL_NAME
,product_first_mass_prod_dt	--	产品首批量产时间
,transfer_finance_dt	--	转财务日期
,new_product_end_dt	--	新产品结束时间
,FULL_NAME_SN   --库存组织名称
) 
SELECT SYS_GUID() AS ID                                                         --UUID主键                  
      ,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                              --账期期间
      ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
      ,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
      ,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
      ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
      ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
      ,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
      ,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
      ,'玫德集团威海有限公司' AS COMPANY_SALE                                   --销售公司
      ,'玫德威海'   AS COMPANY_SN                                               --销售公司简称  
      ,'玫德威海销售部'  AS DEPT1_HIS                                           --历史部门
      ,G4.ORGNAME AS DEPT2_HIS                                                  --历史大区
      ,G3.ORGNAME AS DEPT3_HIS                                                  --历史科室
      ,'玫德威海销售部'  AS DEPT1                                               --部门
      ,CASE WHEN D.CUSTOMER_NEW_NAME = '上海先韧机械有限公司' THEN '玫德庚辰协同'
            WHEN I.EMPNAME IN ('许美艳','杨青鹿') THEN '玫德庚辰协同'
            ELSE '玫德威海生铁销售科' END AS DEPT2                                              --大区
      ,CASE WHEN D.CUSTOMER_NEW_NAME = '上海先韧机械有限公司' THEN '玫德庚辰协同'
            WHEN I.EMPNAME IN ('许美艳','杨青鹿') THEN '玫德庚辰协同'
            ELSE '玫德威海生铁销售科' END AS DEPT3                                              --科室
      ,REPLACE(G2.FULL_NAME,'库存组织','') AS PRODUCE_COMPANY                                --生产公司（库存组织）
      ,'玫德威海' PRODUCE_COMPANY_SN                                            --生产公司简称
      ,NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1                            --产品大类
      ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                            --产品中类
      ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                            --产品小类
      ,' ' AS FIELD                                                             --领域
      ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                       --产品名称
      ,C.FORM AS PRODUCT_FORM                                                   --产品形式
      ,C.TEXTURE AS TEXTURE                                                     --材质分类
      ,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
      ,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
      ,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
      ,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
      ,C.VARIETY AS MAT_VARIETY                                               --品种
      ,C.SPECIFICATION AS MAT_SPEC                                            --规格
      ,'CNY' AS CURRENCY                                                      --币种
      ,'中国' AS COUNTRY                                                        --国别
      ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
      ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
      ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                               --开单客户最新名称
      ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
      ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
      ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                             --分销客户最新名称/最终客户最新名称 
      ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
      ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME         --隶属市
      ,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
      ,CASE WHEN D.CUSTOMER_NEW_NAME = '上海先韧机械有限公司' THEN '/'
            WHEN I.EMPNAME IN ('许美艳','杨青鹿') THEN '/'
            ELSE I.EMPNAME END AS SALESMAN                                                   --业务员
      ,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
      ,CASE WHEN D.CUSTOMER_NEW_NAME = '上海先韧机械有限公司' THEN '/'
            WHEN I.EMPNAME IN ('许美艳','杨青鹿') THEN '/'
            ELSE EMP.USERID END AS SALESMAN_ID                                               --最新业务员账号
      ,' ' AS MANAGER                                                          --主管
      ,ORG.DEPARTMENT_MANAGER_NAME AS LEADER                                   --科室负责人
      ,' 'AS ISNEWCUS                                                          --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
      ,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
      ,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
      ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT * DECODE(J.DICTNAME,'吨',1000,1) AS LINE_NET_WEIGHT--重量                            
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/1.13  AS AMT_M_FACT_OUTTAX--底表字段：无税金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
      ,SYSDATE ETL_CRT_DT
      ,SYSDATE ETL_UPD_DT
      ,ZB.BUSINESS_TYPE AS BUSINESS_TYPE                                       --三新类型
      ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
      ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
      ,CASE WHEN A.STATUS = 'C' AND A.EXPORT_CONFIRM_FLAG = 'Y' AND B.EXPORT_WAREHOUSES_ID IS NOT NULL  THEN '是' ELSE '否' END AS ISSTATUS -- 是否已生效且出库  
      ,'国内' AS BUSINESS
      ,B.EXPORT_WAREHOUSES_ID AS INVENTORY_CODE
      ,INV.INVENTORY_DESC     AS INVENTORY_DESC
	  ,A.CUSTOMER_ID
      ,A.INCEPT_ADDRESS_ID
      ,G1.ORGNAME ORG_NAME
      ,G2.FULL_NAME
,C.splcsj AS product_first_mass_prod_dt	--	产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt	--	转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt	--	新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
 FROM ODS_IMS.CRM_LG_DELIVERY_HEADER  A 
 LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE B    ON A.DELIVERY_HEAD_ID = B.DELIVERY_HEAD_ID 
 LEFT JOIN MDDIM.TD_DIM_MATERIALS      C     ON B.MATERIAL_CODE = C.MATERIAL_CODE AND C.ORG_ID = A.DELIVERY_ORG
 LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D     ON A.CUSTOMER_ID = D.CUSTOMER_ID
 LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1    ON A.INVOICE_CUSTOMER_ID = D1.CUSTOMER_ID
 LEFT JOIN MDDIM.TD_DIM_AREA           E     ON D.PROVINCE_ID = E.AREA_ID
 LEFT JOIN MDDIM.TD_DIM_AREA           E1    ON D.CITY_ID = E1.AREA_ID
 LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H     ON A.ORDER_TYPE_ID = H.ORDER_TYPE_ID
 LEFT JOIN ODS_IMS.OM_EMPLOYEE I             ON I.EMPID = A.SALES_ASSISTANT_ID
 LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP          ON I.EMPCODE = EMP.PERSON_CODE
 LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1         ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
 LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L     ON B.ORDER_ID = L.ORDER_ID
 LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J          ON L.VALUATION_TYPE = J.DICTID AND J.DICTTYPEID='valuation_type'
 LEFT JOIN ODS_IMS.OM_BUSIORG G1             ON A.ORG_ID = G1.BUSIORGID
 LEFT JOIN ODS_IMS.OM_BUSIORG G2             ON A.DELIVERY_ORG = G2.BUSIORGID
 LEFT JOIN ODS_IMS.OM_BUSIORG G3             ON A.SALES_AREA_ID = G3.BUSIORGID
 LEFT JOIN ODS_IMS.OM_BUSIORG G4             ON A.DEPT_ID = G4.BUSIORGID
 LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
 LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
 LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL       ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
 LEFT JOIN ODS_IMS.TF_ODS_IMS_ISNEW_MARK ZB  ON B.DELIVERY_LINE_ID = ZB.DELIVERY_LINE_ID
 LEFT JOIN MDDIM.DIM_DEPARTMENT_D ORG ON  ORG.DEPARTMENT_NAME='玫德威海生铁销售科'
 LEFT JOIN ODS_IMS.CRM_INV_INVENTORY INV ON B.EXPORT_WAREHOUSES_ID = INV.INVENTORY_ID
WHERE H.ORDER_TYPE_NAME IN ('内销常规订单','内销调账销售订单','内销调账红冲订单','服务销售订单','工具归还订单','工具借出订单','内销物资销售订单','内销外协常规订单') --订单类型   
  AND G1.ORGNAME = '47_玫德威海2461'
  AND to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' ; 




----玫德雅昌

INSERT INTO   DWD_SALE_DLY2_TMP 
(
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,produce_company 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,business_type
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME     --2025.1.21     同步母公司抽取账套数据    修改人：常耀辉
,FULL_NAME
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
SELECT
SYS_GUID() AS ID                                                          --UUID主键                  
,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                          --账期期间
,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
,'玫德雅昌集团有限公司' AS COMPANY_SALE                                   --玫德雅昌集团有限公司
,'玫德雅昌'   AS COMPANY_SN                                                 --玫德雅昌  
,'玫德雅昌国内营销中心'  AS DEPT1_HIS                                               --玫德雅昌国内营销中心
,CASE WHEN G4.ORGNAME LIKE '%销售%办公室%' THEN '玫德雅昌' || G4.ORGNAME ELSE G4.ORGNAME  end DEPT2_HIS                                                  --历史大区
,CASE WHEN G3.ORGNAME LIKE '%销售%办公室%' THEN '玫德雅昌' || G3.ORGNAME ELSE G3.ORGNAME  end DEPT3_HIS                                                  --历史科室
,'玫德雅昌国内营销中心'  AS DEPT1                                                   --玫德雅昌国内营销中心
,CASE WHEN G4.ORGNAME LIKE '%销售%办公室%' THEN '玫德雅昌' || G4.ORGNAME ELSE G4.ORGNAME  end DEPT2                                                      --大区
,CASE WHEN G3.ORGNAME LIKE '%销售%办公室%' THEN '玫德雅昌' || G3.ORGNAME ELSE G3.ORGNAME  end DEPT3                                                      --科室
,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company                   --生产公司（库存组织）
,'玫德雅昌' PRODUCE_COMPANY_SN ,                                            --玫德雅昌
 NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                       --产品大类
 NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                       --产品中类
 NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                       --产品小类
,M.MAIN_FIELD AS FIELD                                                   --领域
,B.MATERIAL_DESCRIPTION AS MAT_DESC                                      --产品名称
,C.FORM AS PRODUCT_FORM                                                  --产品形式
,C.TEXTURE AS TEXTURE                                                    --材质分类
,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
,C.VARIETY AS MAT_VARIETY                                               --品种
,C.SPECIFICATION AS MAT_SPEC                                            --规格
,'CNY' AS CURRENCY                                                      --币种
,'中国' AS COUNTRY                                                      --国别
,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称 
,DECODE(D1.PROVINCE_ID, NULL, D1.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
,DECODE(D1.CITY_ID, NULL, D1.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
--,i2.operatorname --制单人
,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
,I.EMPNAME AS SALESMAN                                                   --业务员
,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
,' ' AS MANAGER                                                          --主管
,' ' AS LEADER                                                           --科室负责人
,' 'AS ISNEWCUS                                                          --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) 
        and trunc(C.splcsj + C.pallet_num) >= trunc(A.export_confirm_date) 
    then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
,ZB.business_type AS business_type                                       --三新类型
,A.STATUS   AS  STATUS                                                            --基础信息状态生效
,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' AND EMP.USERID <> 'liuguoqiang01' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库  
,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT--重量                            
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/(100+NVL(REPLACE(A.IS_CUSTOMER_UNRELATED,'%',''),13))*100  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
,SYSDATE ETL_CRT_DT
,SYSDATE ETL_UPD_DT
,'国内' AS BUSINESS
,A.CUSTOMER_ID
,INCEPT_ADDRESS_ID
,G1.ORGNAME         --2025.1.21     同步母公司抽取账套数据    修改人：常耀辉
,G2.FULL_NAME
,C.splcsj --  产品首批量产时间
,A.export_confirm_date  --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A 
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE        B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
LEFT JOIN ODS_IMS.TF_ODS_IMS_ISNEW_MARK ZB ON B.DELIVERY_LINE_ID = ZB.delivery_line_id

LEFT JOIN  ODS_IMS.ac_operator I2 
ON A.CREATED_BY = I2.OPERATORID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP2 
ON I2.USERID = EMP2.USERID

LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD,STATUS FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE AND M.STATUS = 'C'  --领域表

WHERE 
--A.STATUS = 'C'--基础信息状态生效C
A.EXPORT_CONFIRM_FLAG = 'Y'--已出库
AND  H.ORDER_TYPE_NAME in ('内销物资销售订单',
'内销调账红冲订单',
'内销退货订单',
'内销常规订单',
'内销调账销售订单',
'服务销售退货订单','服务销售订单', 
'内销物资销售退货订单','工具归还订单','工具借出订单')--订单类型，更新是否销售业绩单据   

--AND D.CUSTOMER_NAME  <> '玫德雅昌（鹤壁）管业有限公司'
AND G1.ORGNAME IN ('87_玫德雅昌集团2601','88_玫德雅昌(德庆)2621') --账套，更新销售业绩账套字段-联合条件
AND i2.operatorname NOT IN ('财务制单','陶洁','林鸿杰','朱碧林','李春燕','陈丽珍')
AND G4.ORGNAME NOT IN ('鹤壁工厂生产部')  --部门为鹤壁工厂生产部的属于走账，不计入明细表
--AND G4.ORGNAME NOT IN ('鹤壁工厂销售一部','鹤壁工厂销售二部' ,'鹤壁工厂生产部','鹤壁工厂销售部','玫德雅昌海外销售部','济南雅昌销售部')
AND EMP2.DEPARTMENT_NAME <> '玫德雅昌财务部'
AND  to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' ;



-----------------------------------------------玫德雅昌鹤壁-------------------------------------
INSERT INTO DWD_SALE_DLY2_TMP (
 ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,PRODUCE_COMPANY 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,MEASUREMENT_UNIT
,BUSINESS_TYPE
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT
,INVENTORY_CODE
,INVENTORY_DESC
,BUSINESS 
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME
,FULL_NAME
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
SELECT SYS_GUID() AS ID                                                      --UUID主键
      ,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                       --账期期间
      ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                     --业务日期
      ,A.DELIVERY_CODE AS DELIVERY_CODE                                      --发货单号
      ,B.LINE_NO AS BIZ_LINE_NO                                              --业务单据明细行号
      ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS     --订单编号
      ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                       --订单类型
      ,L.ORDER_NUM AS ORDER_NO                                               --明细订单编号
      ,A.ATTRIBUTE21 AS PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
      ,'玫德雅昌（鹤壁）管业有限公司' AS COMPANY_SALE                            --销售公司
      ,'玫德雅昌' AS COMPANY_SN                                           --销售公司简称  
      ,G3.ORGNAME AS DEPT1_HIS                                               --历史部门   G3.ORGNAME       
      ,G3.ORGNAME AS DEPT2_HIS                                               --历史大区   G3.ORGNAME     
      ,G3.ORGNAME AS DEPT3_HIS                                               --历史科室   G3.ORGNAME  
      ,'鹤壁销售部' AS DEPT1                                      --部门    
      ,DECODE(INV.INVENTORY_CODE,'KUW','鹤壁工厂销售一部','KUT','鹤壁工厂销售二部','鹤壁工厂销售一部') AS DEPT2                                                   --大区
      ,DECODE(INV.INVENTORY_CODE,'KUW','鹤壁工厂销售一部','KUT','鹤壁工厂销售二部','鹤壁工厂销售一部') AS DEPT3                                                   --科室
      ,REPLACE(G2.FULL_NAME,'库存组织','') AS PRODUCE_COMPANY              --生产公司（库存组织）
      --,'玫德雅昌（鹤壁）管业有限公司' AS PRODUCE_COMPANY                         --生产公司
      ,'玫德雅昌' AS PRODUCE_COMPANY_SN ,                                      --生产公司简称
       NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                    --产品大类
       NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                    --产品中类
       NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                     --产品小类 
      ,M.MAIN_FIELD AS FIELD                                                 --领域     
      ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                    --产品名称
      ,C.FORM AS PRODUCT_FORM                                                --产品形式 
      ,C.TEXTURE AS TEXTURE                                                  --材质分类         
      ,C.SURFACE_TREATMENT AS MAT_SURFACE                                    --表面       
      ,C.PRODUCT_SORT AS MAT_SORT                                            --产品分类新    
      ,K.ATTR5_NAME AS MAT_ATTR5                                             --属性5      
      ,B.MATERIAL_CODE AS MAT_CODE                                           --物料编号     
      ,C.VARIETY AS MAT_VARIETY                                              --品种       
      ,C.SPECIFICATION AS MAT_SPEC                                           --规格       
      ,'CNY' AS CURRENCY                                                     --币种       
      ,'中国' AS COUNTRY                                                     --国别         
      ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
      ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
      ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
      ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
      ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
      ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
      ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME --隶属省
      ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME            --隶属市       
      ,I.EMPNAME AS SALESMAN_HIS                                                  --历史业务员
      ,I.EMPNAME AS SALESMAN                                                      --业务员
      ,EMP.USERID AS SALESMAN_ID_HIS                                              --历史业务员账号 
      ,EMP.USERID AS SALESMAN_ID                                                  --最新业务员账号 
      ,' ' AS MANAGER                                                             --主管      
      ,DEPT.DEPARTMENT_MANAGER_NAME AS LEADER                                     --科室负责人   
      ,' 'AS ISNEWCUS                                                             --是否新客户  
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) 
        and trunc(C.splcsj + C.pallet_num) >= trunc(A.export_confirm_date) 
    then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
      ,' ' AS ISUPSELLPROD                                                        --是否老客户新产品
      ,J.DICTNAME AS MEASUREMENT_UNIT                                             --计量单位    
      ,' ' AS BUSINESS_TYPE                                       --三新类型
      ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
      ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
      ,CASE WHEN A.STATUS = 'C' AND A.EXPORT_CONFIRM_FLAG = 'Y' THEN '是' ELSE '否' END AS ISSTATUS -- 是否已生效且出库 
      ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT * DECODE(H.ORDER_TYPE_NAME,'服务销售订单',0,1)  AS LINE_NET_WEIGHT                --重量                            
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP                      --合计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT                       --总计金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT   --市场折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT     --商业折扣额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE                       --项目差价
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP               --临时：表头费用
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY                   --临时：表头总数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX                             --临时：表头总箱数
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT                              -- 销售金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT                      -- 订单金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12                        -- 费用金额汇总
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/(100+NVL(REPLACE(A.IS_CUSTOMER_UNRELATED,'%',''),13))*100  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT                    --底表字段：实发数量
      ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT                     --底表字段：箱数 
      ,SYSDATE ETL_CRT_DT
      ,SYSDATE ETL_UPD_DT
      ,INV.INVENTORY_CODE 
      ,INV.INVENTORY_DESC
      ,'国内' AS BUSINESS
  ,A.CUSTOMER_ID
    ,INCEPT_ADDRESS_ID
  ,G1.ORGNAME
    ,G2.FULL_NAME
,C.splcsj --  产品首批量产时间
,A.export_confirm_date  --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE  B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID
LEFT JOIN ODS_IMS.CRM_INV_INVENTORY INV ON B.SHIP_WAREHOUSES_ID = INV.INVENTORY_ID 
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE = C.MATERIAL_CODE AND C.ORG_ID = A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
--LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
LEFT JOIN MDDIM.DIM_DEPARTMENT_D  DEPT ON DECODE(INV.INVENTORY_CODE,'KUW','鹤壁工厂销售一部','KUT','鹤壁工厂销售二部','鹤壁工厂销售一部') = DEPT.DEPARTMENT_NAME
LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD,STATUS FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE AND M.STATUS = 'C'  --领域表
WHERE A.STATUS = 'C'--基础信息状态生效C
AND A.EXPORT_CONFIRM_FLAG = 'Y'--已出库
AND G1.ORGNAME IN ('49_玫德雅昌鹤壁2501') --账套，更新销售业绩账套字段-联合条件   ,'玫德雅昌集团有限公司'
AND EXISTS(SELECT 1 FROM DUAL
            WHERE H.ORDER_TYPE_NAME ='服务销售订单'
              AND A.EXPORT_CONFIRM_DATE < DATE'2023-01-01'
              AND B.MATERIAL_DESCRIPTION = '运费︱运费'   --运费︱运费
            UNION ALL
           SELECT 1 FROM DUAL
            WHERE H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销退货订单' ,'内销发货调整订单','内销收费样品订单','来料加工订单','内销外协常规订单','工具归还订单','工具借出订单')--订单类型，更新是否销售业绩单据
           )  
AND  to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' ;



-----------------------------------------------玫德庚辰 -----------------------------------------------
INSERT INTO   DWD_SALE_DLY2_TMP 
(
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,produce_company 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,business_type
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME  --2025.1.21
,FULL_NAME  --2025.1.25
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
select
          SYS_GUID() AS ID                                                      --UUID主键
          ,R.PERIOD                                       --账期期间
          ,R.BIZ_DATE                                     --业务日期
          ,R.DELIVERY_CODE                                      --发货单号
          ,R.BIZ_LINE_NO                                              --业务单据明细行号
          ,R.ORDER_NOS     --订单编号
          ,R.ORDER_TYPE                                       --订单类型
          ,R.ORDER_NO                                               --明细订单编号
          ,R.PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,R.COMPANY_SALE                            --销售公司
          ,R.COMPANY_SN                                           --销售公司简称  
          ,R.DEPT1_HIS                                  --历史部门          
          ,R.DEPT2_HIS                                               --历史大区        
          ,R.DEPT3_HIS                                               --历史科室     
          ,R.DEPT1                                      --部门    
          ,R.DEPT2                                                   --大区
          ,R.DEPT3                                                   --科室
          ,R.produce_company                         --生产公司
          ,R.PRODUCE_COMPANY_SN                                      --生产公司简称
          ,R.PRODUCT_SORT1                    --产品大类
          ,R.PRODUCT_SORT2                    --产品中类
          ,R.PRODUCT_SORT3                     --产品小类 
          ,R.FIELD                                                          --领域     
          ,R.MAT_DESC                                    --产品名称
          ,R.PRODUCT_FORM                                                --产品形式 
          ,R.TEXTURE                                                  --材质分类         
          ,R.MAT_SURFACE                                    --表面       
          ,R.MAT_SORT                                            --产品分类新    
          ,R.MAT_ATTR5                                             --属性5      
          ,R.MAT_CODE                                           --物料编号     
          ,R.MAT_VARIETY                                              --品种       
          ,R.MAT_SPEC                                           --规格       
          ,R.CURRENCY                                                     --币种       
          ,R.COUNTRY                                                     --国别         
          ,R.CUSTOMER_CODE                                       --开单客户编号  
          ,R.CUSTOMER_NAME                                       --开单客户名称
          ,R.CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,R.CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,R.CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,R.CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,R.PROVINCE_NAME --隶属省
          ,R.CITY_NAME            --隶属市       
          ,R.SALESMAN_HIS                                                  --历史业务员
          ,R.SALESMAN                                                      --业务员
          ,R.SALESMAN_ID_HIS                                              --历史业务员账号 
          ,R.SALESMAN_ID                                                  --最新业务员账号 
          ,R.MANAGER                                                             --主管      
          ,R.LEADER                                                              --科室负责人   
          ,R.ISNEWCUS                                                             --是否新客户   
          ,R.ISNEWPROD                                                            --是否新产品   
          ,R.ISUPSELLPROD                                                        --是否老客户新产品
          ,R.business_type                                       --三新类型
          ,R.STATUS                                                            --基础信息状态生效
          ,R.EXPORT_CONFIRM_FLAG                                              --已出库
          ,R.ISSTATUS -- 是否已生效且出库 
          ,R.MEASUREMENT_UNIT                                             --计量单位    
          ,R.TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
          ,R.LINE_NET_WEIGHT                --重量                            
          ,R.TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,R.TOTAL_AMOUNT                       --总计金额
          ,R.MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,R.TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,R.QTY_OUT_LINE                       --项目差价
          ,R.TOTAL_AMOUNT_EXP               --临时：表头费用
          ,R.BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,R.TOTAL_QUANTITY                   --临时：表头总数量
          ,R.TOTAL_BOX                             --临时：表头总箱数
          ,R.AMT_M_FACT                              -- 销售金额
          ,R.ORDER_AMOUNT                      -- 订单金额汇总
          ,R.ATTRIBUTE12                        -- 费用金额汇总
          ,CASE WHEN R.DELIVERY_CODE LIKE '%-ST' or R.DELIVERY_CODE LIKE '%-SL' 
                THEN (R.AMT_M_FACT_OUTTAX+R.LINE_NET_WEIGHT*300/1000)/1.13
                ELSE (R.AMT_M_FACT_OUTTAX)/1.13   
                END  AMT_M_FACT_OUTTAX            --底表字段：无税金额
          ,R.QTY_M_FACT                    --底表字段：实发数量
          ,R.BOX_M_FACT                     --底表字段：箱数 
          ,R.ETL_CRT_DT
          ,R.ETL_UPD_DT
          ,R.BUSINESS
        ,R.CUSTOMER_ID
          ,R.INCEPT_ADDRESS_ID
          ,r.ORG_NAME
          ,r.FULL_NAME   --2025.1.21
,R.product_first_mass_prod_dt --  产品首批量产时间
,R.transfer_finance_dt  --  转财务日期
,R.new_product_end_dt --  新产品结束时间
,R.FULL_NAME_SN
from 
(
    SELECT 
           TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                       --账期期间
          ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                     --业务日期
          ,A.DELIVERY_CODE AS DELIVERY_CODE                                      --发货单号
          ,B.LINE_NO AS BIZ_LINE_NO                                              --业务单据明细行号
          ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS     --订单编号
          ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                       --订单类型
          ,L.ORDER_NUM AS ORDER_NO                                               --明细订单编号
          ,A.ATTRIBUTE21 AS PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,'临沂玫德庚辰金属材料有限公司' AS COMPANY_SALE                            --销售公司
          ,'玫德庚辰'    AS COMPANY_SN                                           --销售公司简称  
          ,'玫德庚辰销售部'  AS DEPT1_HIS                                  --历史部门          
          ,G4.ORGNAME AS DEPT2_HIS                                               --历史大区        
          ,G3.ORGNAME AS DEPT3_HIS                                               --历史科室     
          ,'玫德庚辰销售部'  AS DEPT1                                      --部门  
          ,case 
      when G3.ORGNAME = '浙江' then '玫德庚辰南方区'
            when G3.ORGNAME = '鲁西' then '玫德庚辰北方区'
          when G3.ORGNAME = '鲁东' then '玫德庚辰北方区'
          --when G3.ORGNAME = '玫德庚辰销售部' then '玫德庚辰南方区'
          when G4.ORGNAME = '玫德庚辰生产部' then '玫德庚辰南方区'
          when G4.ORGNAME = '玫德庚辰财务部' then '玫德庚辰南方区'
            else G4.ORGNAME  end AS DEPT2                                                   --大区
          ,--case
          --when G3.ORGNAME = '浙江' then '玫德庚辰皖浙沪区'
            --when G3.ORGNAME = '鲁西' then '玫德庚辰鲁西区'
          --when G3.ORGNAME = '鲁东' then '玫德庚辰鲁东区'
           G3.ORGNAME   AS DEPT3                                                   --科室
          --,G1.ORGNAME AS  ZHANGTAO                                                  --账套
          --,G2.ORGNAME AS  SHANGCHAN                                                 --生产公司               
          --,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company              --生产公司（库存组织）
          ,REPLACE(G2.FULL_NAME,'库存组织','') AS  produce_company                         --生产公司
          ,'玫德庚辰'  PRODUCE_COMPANY_SN ,                                      --生产公司简称
           NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1,                    --产品大类
           NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2,                    --产品中类
           NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                     --产品小类 
          ,M.MAIN_FIELD AS FIELD                                                 --领域     
          ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                    --产品名称
          ,C.FORM AS PRODUCT_FORM                                                --产品形式 
          ,C.TEXTURE AS TEXTURE                                                  --材质分类         
          ,C.SURFACE_TREATMENT AS MAT_SURFACE                                    --表面       
          ,C.PRODUCT_SORT AS MAT_SORT                                            --产品分类新    
          ,K.ATTR5_NAME AS MAT_ATTR5                                             --属性5      
          ,B.MATERIAL_CODE AS MAT_CODE                                           --物料编号     
          ,C.VARIETY AS MAT_VARIETY                                              --品种       
          ,C.SPECIFICATION AS MAT_SPEC                                           --规格       
          ,'CNY' AS CURRENCY                                                     --币种       
          ,'中国' AS COUNTRY                                                     --国别         
          ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
          ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
          ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME --隶属省
          ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME            --隶属市       
          ,I.EMPNAME AS SALESMAN_HIS                                                  --历史业务员
          ,I.EMPNAME AS SALESMAN                                                      --业务员
          ,EMP.USERID AS SALESMAN_ID_HIS                                              --历史业务员账号 
          ,EMP.USERID AS SALESMAN_ID                                                  --最新业务员账号 
          ,' ' AS MANAGER                                                             --主管      
          ,MK.DEPARTMENT_MANAGER_NAME AS LEADER                                                              --科室负责人   
          ,' 'AS ISNEWCUS                                                             --是否新客户   
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉  
          ,' ' AS ISUPSELLPROD                                                        --是否老客户新产品
        ,' ' AS business_type                                       --三新类型
        ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
        ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
        ,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库 
        --,J.DICTNAME AS MEASUREMENT_UNIT                                             --计量单位   
          ,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位 
          ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
        --,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * case when A.NET_WEIGHT = 0 then 0 else B.LINE_NET_WEIGHT end   LINE_NET_WEIGHT                --重量
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT * DECODE(J.DICTNAME,'吨',1000,1) AS LINE_NET_WEIGHT--重量                                     
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT                       --总计金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE                       --项目差价
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP               --临时：表头费用
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY                   --临时：表头总数量
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX                             --临时：表头总箱数
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT                              -- 销售金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT                      -- 订单金额汇总
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12                        -- 费用金额汇总
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT                    --底表字段：实发数量
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT                     --底表字段：箱数 
          ,SYSDATE ETL_CRT_DT
          ,SYSDATE ETL_UPD_DT
          ,'国内' AS BUSINESS
    ,A.CUSTOMER_ID
        ,A.INCEPT_ADDRESS_ID
        ,G1.ORGNAME    ORG_NAME
        ,G2.FULL_NAME FULL_NAME
,C.splcsj AS product_first_mass_prod_dt --  产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME AS FULL_NAME_SN
    FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A
    LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE  B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
    LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE = C.MATERIAL_CODE AND C.ORG_ID = A.DELIVERY_ORG
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
    LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
    LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
    --LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
    LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J          ON L.VALUATION_TYPE = J.DICTID AND J.DICTTYPEID='valuation_type'
    LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
    LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
    LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
    LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
    LEFT JOIN  MDDIM.dim_department_d MK  ON G3.ORGNAME = MK.DEPARTMENT_NAME
    left join  ODS_IMS.CRM_CTM_CUST_FINAL_CTM ZB on A.CUSTOMER_ID=ZB.CUSTOMER_ID
    LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD,STATUS FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE AND M.STATUS = 'C'  --领域表
     WHERE 
         H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','服务销售订单','工具归还订单','工具借出订单')
         AND G1.ORGNAME IN ( '16_玫德庚辰2242' )
         AND G2.ORGNAME = 'GC1_玫德庚辰127'  
         AND G3.ORGNAME IN('玫德庚辰鲁东区','玫德庚辰鲁西区','玫德庚辰津冀区','玫德庚辰皖浙沪区','玫德庚辰苏北区','玫德庚辰苏南区','玫德庚辰福广区','玫德庚辰风电领域事业部','玫德庚辰沟槽领域事业部','鲁东','鲁西','玫德庚辰销售部','玫德庚辰仓储二科','浙江','玫德庚辰浙沪区','玫德庚辰安徽区')
         AND  D1.CUSTOMER_NEW_NAME not in ('玫德集团临沂有限公司')   
         --and TRUNC(A.EXPORT_CONFIRM_DATE,'MM') = TO_DATE('2023/12/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
         AND TRUNC(A.EXPORT_CONFIRM_DATE,'MM') >= TO_DATE('2022/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND TRUNC(A.EXPORT_CONFIRM_DATE,'MM') < TO_DATE('2024/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')--出库日期，增量导入时间戳
     and I.EMPNAME not in('高文清','魏双')
 )  R 
 group by

          R.PERIOD                                       --账期期间
          ,R.BIZ_DATE                                     --业务日期
          ,R.DELIVERY_CODE                                      --发货单号
          ,R.BIZ_LINE_NO                                              --业务单据明细行号
          ,R.ORDER_NOS     --订单编号
          ,R.ORDER_TYPE                                       --订单类型
          ,R.ORDER_NO                                               --明细订单编号
          ,R.PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,R.COMPANY_SALE                            --销售公司
          ,R.COMPANY_SN                                           --销售公司简称  
          ,R.DEPT1_HIS                                  --历史部门          
          ,R.DEPT2_HIS                                               --历史大区        
          ,R.DEPT3_HIS                                               --历史科室     
          ,R.DEPT1                                      --部门    
          ,R.DEPT2                                                   --大区
          ,R.DEPT3                                                   --科室
          ,R.produce_company                         --生产公司
          ,R.PRODUCE_COMPANY_SN                                      --生产公司简称
          ,R.PRODUCT_SORT1                    --产品大类
          ,R.PRODUCT_SORT2                    --产品中类
          ,R.PRODUCT_SORT3                     --产品小类 
          ,R.FIELD                                                          --领域     
          ,R.MAT_DESC                                    --产品名称
          ,R.PRODUCT_FORM                                                --产品形式 
          ,R.TEXTURE                                                  --材质分类         
          ,R.MAT_SURFACE                                    --表面       
          ,R.MAT_SORT                                            --产品分类新    
          ,R.MAT_ATTR5                                             --属性5      
          ,R.MAT_CODE                                           --物料编号     
          ,R.MAT_VARIETY                                              --品种       
          ,R.MAT_SPEC                                           --规格       
          ,R.CURRENCY                                                     --币种       
          ,R.COUNTRY                                                     --国别         
          ,R.CUSTOMER_CODE                                       --开单客户编号  
          ,R.CUSTOMER_NAME                                       --开单客户名称
          ,R.CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,R.CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,R.CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,R.CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,R.PROVINCE_NAME --隶属省
          ,R.CITY_NAME            --隶属市       
          ,R.SALESMAN_HIS                                                  --历史业务员
          ,R.SALESMAN                                                      --业务员
          ,R.SALESMAN_ID_HIS                                              --历史业务员账号 
          ,R.SALESMAN_ID                                                  --最新业务员账号 
          ,R.MANAGER                                                             --主管      
          ,R.LEADER                                                              --科室负责人   
          ,R.ISNEWCUS                                                             --是否新客户   
          ,R.ISNEWPROD                                                            --是否新产品   
          ,R.ISUPSELLPROD                                                        --是否老客户新产品
          ,R.business_type                                       --三新类型
          ,R.STATUS                                                            --基础信息状态生效
          ,R.EXPORT_CONFIRM_FLAG                                              --已出库
          ,R.ISSTATUS -- 是否已生效且出库 
          ,R.MEASUREMENT_UNIT                                             --计量单位    
          ,R.TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
          ,R.LINE_NET_WEIGHT                --重量                            
          ,R.TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,R.TOTAL_AMOUNT                       --总计金额
          ,R.MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,R.TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,R.QTY_OUT_LINE                       --项目差价
          ,R.TOTAL_AMOUNT_EXP               --临时：表头费用
          ,R.BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,R.TOTAL_QUANTITY                   --临时：表头总数量
          ,R.TOTAL_BOX                             --临时：表头总箱数
          ,R.AMT_M_FACT                              -- 销售金额
          ,R.ORDER_AMOUNT                      -- 订单金额汇总
          ,R.ATTRIBUTE12                        -- 费用金额汇总
          ,R.QTY_M_FACT                    --底表字段：实发数量
          ,R.BOX_M_FACT                     --底表字段：箱数 
          ,R.ETL_CRT_DT
          ,R.ETL_UPD_DT
          ,R.BUSINESS
      ,R.CUSTOMER_ID
            ,R.INCEPT_ADDRESS_ID
            ,r.ORG_NAME
           ,r.FULL_NAME
,R.product_first_mass_prod_dt --  产品首批量产时间
,R.transfer_finance_dt  --  转财务日期
,R.new_product_end_dt --  新产品结束时间
,R.FULL_NAME_SN
;



---------------------------玫德庚辰2-----------------------------------------------------------
INSERT INTO   DWD_SALE_DLY2_TMP 
(
ID            
,PERIOD         
,BIZ_DATE       
,DELIVERY_CODE      
,BIZ_LINE_NO          
,ORDER_NOS        
,ORDER_TYPE       
,ORDER_NO       
,PROJECT_NAME     
,COMPANY_SALE
,COMPANY_SN     
,DEPT1_HIS            
,DEPT2_HIS            
,DEPT3_HIS       
,DEPT1            
,DEPT2            
,DEPT3        
,produce_company 
,PRODUCE_COMPANY_SN     
,PRODUCT_SORT1    
,PRODUCT_SORT2      
,PRODUCT_SORT3      
,FIELD                
,MAT_DESC       
,PRODUCT_FORM     
,TEXTURE        
,MAT_SURFACE      
,MAT_SORT             
,MAT_ATTR5        
,MAT_CODE       
,MAT_VARIETY      
,MAT_SPEC       
,CURRENCY       
,COUNTRY        
,CUSTOMER_CODE      
,CUSTOMER_NAME   
,CUSTOMER_NEW_NAME
,CUSTOMER_CODE1       
,CUSTOMER_NAME1   
,CUSTOMER_NEW_NAME1
,PROVINCE_NAME      
,CITY_NAME    
,SALESMAN_HIS    
,SALESMAN 
,SALESMAN_ID_HIS
,SALESMAN_ID         
,MANAGER        
,LEADER                    
,ISNEWCUS       
,ISNEWPROD            
,ISUPSELLPROD
,business_type
,STATUS
,EXPORT_CONFIRM_FLAG
,ISSTATUS       
,MEASUREMENT_UNIT   
,TRADE_DISCOUNT_TYPE  
,LINE_NET_WEIGHT    
,TOTAL_AMOUNT_OUTEXP  
,TOTAL_AMOUNT     
,MARKET_DISCOUNT_AMOUNT 
,TRADE_DISCOUNT_AMOUNT  
,QTY_OUT_LINE     
,TOTAL_AMOUNT_EXP   
,BEFORE_DISCOUNT_AMOUNT 
,TOTAL_QUANTITY     
,TOTAL_BOX        
,AMT_M_FACT       
,ORDER_AMOUNT     
,ATTRIBUTE12      
,AMT_M_FACT_OUTTAX    
,QTY_M_FACT       
,BOX_M_FACT       
,ETL_CRT_DT       
,ETL_UPD_DT 
,BUSINESS
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME--2025.1.21
,FULL_NAME
,product_first_mass_prod_dt --  产品首批量产时间
,transfer_finance_dt  --  转财务日期
,new_product_end_dt --  新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
select
          SYS_GUID() AS ID                                                      --UUID主键
          ,R.PERIOD                                       --账期期间
          ,R.BIZ_DATE                                     --业务日期
          ,R.DELIVERY_CODE                                      --发货单号
          ,R.BIZ_LINE_NO                                              --业务单据明细行号
          ,R.ORDER_NOS     --订单编号
          ,R.ORDER_TYPE                                       --订单类型
          ,R.ORDER_NO                                               --明细订单编号
          ,R.PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,R.COMPANY_SALE                            --销售公司
          ,R.COMPANY_SN                                           --销售公司简称  
          ,R.DEPT1_HIS                                  --历史部门          
          ,R.DEPT2_HIS                                               --历史大区        
          ,R.DEPT3_HIS                                               --历史科室     
          ,R.DEPT1                                      --部门    
          ,R.DEPT2                                                   --大区
          ,R.DEPT3                                                   --科室
          ,R.produce_company                         --生产公司
          ,R.PRODUCE_COMPANY_SN                                      --生产公司简称
          ,R.PRODUCT_SORT1                    --产品大类
          ,R.PRODUCT_SORT2                    --产品中类
          ,R.PRODUCT_SORT3                     --产品小类 
          ,R.FIELD                                                          --领域     
          ,R.MAT_DESC                                    --产品名称
          ,R.PRODUCT_FORM                                                --产品形式 
          ,R.TEXTURE                                                  --材质分类         
          ,R.MAT_SURFACE                                    --表面       
          ,R.MAT_SORT                                            --产品分类新    
          ,R.MAT_ATTR5                                             --属性5      
          ,R.MAT_CODE                                           --物料编号     
          ,R.MAT_VARIETY                                              --品种       
          ,R.MAT_SPEC                                           --规格       
          ,R.CURRENCY                                                     --币种       
          ,R.COUNTRY                                                     --国别         
          ,R.CUSTOMER_CODE                                       --开单客户编号  
          ,R.CUSTOMER_NAME                                       --开单客户名称
          ,R.CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,R.CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,R.CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,R.CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,R.PROVINCE_NAME --隶属省
          ,R.CITY_NAME            --隶属市       
          ,R.SALESMAN_HIS                                                  --历史业务员
          ,R.SALESMAN                                                      --业务员
          ,R.SALESMAN_ID_HIS                                              --历史业务员账号 
          ,R.SALESMAN_ID                                                  --最新业务员账号 
          ,R.MANAGER                                                             --主管      
          ,R.LEADER                                                              --科室负责人   
          ,R.ISNEWCUS                                                             --是否新客户   
          ,R.ISNEWPROD                                                            --是否新产品   
          ,R.ISUPSELLPROD                                                        --是否老客户新产品
          ,R.business_type                                       --三新类型
          ,R.STATUS                                                            --基础信息状态生效
          ,R.EXPORT_CONFIRM_FLAG                                              --已出库
          ,R.ISSTATUS -- 是否已生效且出库 
          ,R.MEASUREMENT_UNIT                                             --计量单位    
          ,R.TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
          ,R.LINE_NET_WEIGHT                --重量                            
          ,R.TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,R.TOTAL_AMOUNT                       --总计金额
          ,R.MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,R.TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,R.QTY_OUT_LINE                       --项目差价
          ,R.TOTAL_AMOUNT_EXP               --临时：表头费用
          ,R.BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,R.TOTAL_QUANTITY                   --临时：表头总数量
          ,R.TOTAL_BOX                             --临时：表头总箱数
          ,R.AMT_M_FACT                              -- 销售金额
          ,R.ORDER_AMOUNT                      -- 订单金额汇总
          ,R.ATTRIBUTE12                        -- 费用金额汇总
          ,CASE WHEN R.DELIVERY_CODE LIKE '%-ST' --or R.DELIVERY_CODE LIKE '%-SL' 
                THEN (R.AMT_M_FACT_OUTTAX+R.LINE_NET_WEIGHT*100/1000)/1.13
                WHEN R.DELIVERY_CODE LIKE '%-SL'
                THEN (R.AMT_M_FACT_OUTTAX+R.LINE_NET_WEIGHT*300/1000)/1.13 
                ELSE R.AMT_M_FACT_OUTTAX/1.13   
                END  AMT_M_FACT_OUTTAX            --底表字段：无税金额
          ,R.QTY_M_FACT                    --底表字段：实发数量
          ,R.BOX_M_FACT                     --底表字段：箱数 
          ,R.ETL_CRT_DT
          ,R.ETL_UPD_DT
          ,R.BUSINESS
    ,R.CUSTOMER_ID
        ,R.INCEPT_ADDRESS_ID
    ,r.ORG_NAME
        ,r.FULL_NAME
,R.product_first_mass_prod_dt --  产品首批量产时间
,R.transfer_finance_dt  --  转财务日期
,R.new_product_end_dt --  新产品结束时间
,R.FULL_NAME_SN
from 
(
  SELECT 
           TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                       --账期期间
          ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                     --业务日期
          ,A.DELIVERY_CODE AS DELIVERY_CODE                                      --发货单号
          ,B.LINE_NO AS BIZ_LINE_NO                                              --业务单据明细行号
          ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS     --订单编号
          ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                       --订单类型
          ,L.ORDER_NUM AS ORDER_NO                                               --明细订单编号
          ,A.ATTRIBUTE21 AS PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,'临沂玫德庚辰金属材料有限公司' AS COMPANY_SALE                            --销售公司
          ,'玫德庚辰'    AS COMPANY_SN                                           --销售公司简称  
          ,'玫德庚辰销售部'  AS DEPT1_HIS                                  --历史部门          
          ,G4.ORGNAME AS DEPT2_HIS                                               --历史大区        
          ,G3.ORGNAME AS DEPT3_HIS                                               --历史科室     
          ,'玫德庚辰销售部'  AS DEPT1                                      --部门  
          ,G4.ORGNAME   AS DEPT2                                                   --大区
          ,G3.ORGNAME  AS DEPT3                                                   --科室
          ,REPLACE(G2.FULL_NAME,'库存组织','') AS  produce_company                         --生产公司
          ,'玫德庚辰'  PRODUCE_COMPANY_SN                                      --生产公司简称
          ,NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1                    --产品大类
          ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                    --产品中类
          ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT3                     --产品小类 
          ,M.MAIN_FIELD AS FIELD                                                 --领域     
          ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                    --产品名称
          ,C.FORM AS PRODUCT_FORM                                                --产品形式 
          ,C.TEXTURE AS TEXTURE                                                  --材质分类         
          ,C.SURFACE_TREATMENT AS MAT_SURFACE                                    --表面       
          ,C.PRODUCT_SORT AS MAT_SORT                                            --产品分类新    
          ,K.ATTR5_NAME AS MAT_ATTR5                                             --属性5      
          ,B.MATERIAL_CODE AS MAT_CODE                                           --物料编号     
          ,C.VARIETY AS MAT_VARIETY                                              --品种       
          ,C.SPECIFICATION AS MAT_SPEC                                           --规格       
          ,'CNY' AS CURRENCY                                                     --币种       
          ,'中国' AS COUNTRY                                                     --国别         
          ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
          ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
          ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME --隶属省
          ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME            --隶属市       
          ,I.EMPNAME AS SALESMAN_HIS                                                  --历史业务员
          ,I.EMPNAME AS SALESMAN                                                      --业务员
          ,EMP.USERID AS SALESMAN_ID_HIS                                              --历史业务员账号 
          ,EMP.USERID AS SALESMAN_ID                                                  --最新业务员账号 
          ,' ' AS MANAGER                                                             --主管      
          ,MK.DEPARTMENT_MANAGER_NAME AS LEADER                                                              --科室负责人   
          ,' 'AS ISNEWCUS                                                             --是否新客户   
          ,case
          when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
          '是'
          else
          '否'
         end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
          ,' ' AS ISUPSELLPROD                                                        --是否老客户新产品
          ,' ' AS business_type                                       --三新类型
          ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
          ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
          ,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库 
          --,J.DICTNAME AS MEASUREMENT_UNIT                                             --计量单位   
          ,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位 
          ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
        --,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * case when A.NET_WEIGHT = 0 then 0 else B.LINE_NET_WEIGHT end   LINE_NET_WEIGHT                --重量  
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LINE_NET_WEIGHT * DECODE(J.DICTNAME,'吨',1000,1) AS LINE_NET_WEIGHT--重量                                
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT                       --总计金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE                       --项目差价
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP               --临时：表头费用
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY                   --临时：表头总数量
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX                             --临时：表头总箱数
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT                              -- 销售金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT                      -- 订单金额汇总
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12                        -- 费用金额汇总
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT                    --底表字段：实发数量
          ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT                     --底表字段：箱数 
          ,SYSDATE ETL_CRT_DT
          ,SYSDATE ETL_UPD_DT
          ,'国内' AS BUSINESS
        ,A.CUSTOMER_ID
        ,A.INCEPT_ADDRESS_ID
        ,G1.ORGNAME ORG_NAME
        ,G2.FULL_NAME FULL_NAME
        ,C.splcsj AS product_first_mass_prod_dt  --  产品首批量产时间
        ,A.export_confirm_date AS transfer_finance_dt  --  转财务日期   IMS 无
        ,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt  --  新产品结束时间    邵贤鹏提供规则
        ,G2.ORGNAME AS FULL_NAME_SN   --库存组织名称
    FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A
    LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE  B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
    LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE = C.MATERIAL_CODE AND C.ORG_ID = A.DELIVERY_ORG
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
    LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
    LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
    LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
    LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
    --LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
    LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
    LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J          ON L.VALUATION_TYPE = J.DICTID AND J.DICTTYPEID='valuation_type'
    LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
    LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
    LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
    LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
    LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
    LEFT JOIN  MDDIM.dim_department_d MK  ON G3.ORGNAME = MK.DEPARTMENT_NAME
    left join  ODS_IMS.CRM_CTM_CUST_FINAL_CTM ZB on A.CUSTOMER_ID=ZB.CUSTOMER_ID
    LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD,STATUS FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE AND M.STATUS = 'C'  --领域表
    WHERE 
         H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销外协常规订单','服务销售订单','工具归还订单','工具借出订单','内销物资销售订单')
         AND G1.ORGNAME IN ('16_玫德庚辰2242','46_浙江顺泰佳2381','84_尚莱贸易2702')
         AND G2.ORGNAME = 'GC1_玫德庚辰127'  
         --AND G3.ORGNAME IN('玫德庚辰鲁东区','玫德庚辰鲁西区','玫德庚辰津冀区','玫德庚辰皖浙沪区','玫德庚辰苏北区','玫德庚辰苏南区','玫德庚辰福广区','玫德庚辰风电领域事业部','玫德庚辰沟槽领域事业部','鲁东','鲁西','玫德庚辰销售部','玫德庚辰仓储二科','浙江','玫德庚辰浙沪区','玫德庚辰安徽区','玫德庚辰销售支持科')
         --AND  D1.CUSTOMER_NEW_NAME not in ('玫德集团临沂有限公司')   
         AND TRUNC(A.EXPORT_CONFIRM_DATE,'MM') >= TO_DATE('2024/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')--出库日期，增量导入时间戳

         and  to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' 

 )  R 
 group by

          R.PERIOD                                       --账期期间
          ,R.BIZ_DATE                                     --业务日期
          ,R.DELIVERY_CODE                                      --发货单号
          ,R.BIZ_LINE_NO                                              --业务单据明细行号
          ,R.ORDER_NOS     --订单编号
          ,R.ORDER_TYPE                                       --订单类型
          ,R.ORDER_NO                                               --明细订单编号
          ,R.PROJECT_NAME                                         --项目名称（渠道/用户/项目名称）
          ,R.COMPANY_SALE                            --销售公司
          ,R.COMPANY_SN                                           --销售公司简称  
          ,R.DEPT1_HIS                                  --历史部门          
          ,R.DEPT2_HIS                                               --历史大区        
          ,R.DEPT3_HIS                                               --历史科室     
          ,R.DEPT1                                      --部门    
          ,R.DEPT2                                                   --大区
          ,R.DEPT3                                                   --科室
          ,R.produce_company                         --生产公司
          ,R.PRODUCE_COMPANY_SN                                      --生产公司简称
          ,R.PRODUCT_SORT1                    --产品大类
          ,R.PRODUCT_SORT2                    --产品中类
          ,R.PRODUCT_SORT3                     --产品小类 
          ,R.FIELD                                                          --领域     
          ,R.MAT_DESC                                    --产品名称
          ,R.PRODUCT_FORM                                                --产品形式 
          ,R.TEXTURE                                                  --材质分类         
          ,R.MAT_SURFACE                                    --表面       
          ,R.MAT_SORT                                            --产品分类新    
          ,R.MAT_ATTR5                                             --属性5      
          ,R.MAT_CODE                                           --物料编号     
          ,R.MAT_VARIETY                                              --品种       
          ,R.MAT_SPEC                                           --规格       
          ,R.CURRENCY                                                     --币种       
          ,R.COUNTRY                                                     --国别         
          ,R.CUSTOMER_CODE                                       --开单客户编号  
          ,R.CUSTOMER_NAME                                       --开单客户名称
          ,R.CUSTOMER_NEW_NAME                                   --开单客户最新名称
          ,R.CUSTOMER_CODE1                                     --分销客户编号/最终客户
          ,R.CUSTOMER_NAME1                                     --分销客户名称/最终客户 
          ,R.CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称  
          ,R.PROVINCE_NAME --隶属省
          ,R.CITY_NAME            --隶属市       
          ,R.SALESMAN_HIS                                                  --历史业务员
          ,R.SALESMAN                                                      --业务员
          ,R.SALESMAN_ID_HIS                                              --历史业务员账号 
          ,R.SALESMAN_ID                                                  --最新业务员账号 
          ,R.MANAGER                                                             --主管      
          ,R.LEADER                                                              --科室负责人   
          ,R.ISNEWCUS                                                             --是否新客户   
          ,R.ISNEWPROD                                                            --是否新产品   
          ,R.ISUPSELLPROD                                                        --是否老客户新产品
          ,R.business_type                                       --三新类型
          ,R.STATUS                                                            --基础信息状态生效
          ,R.EXPORT_CONFIRM_FLAG                                              --已出库
          ,R.ISSTATUS -- 是否已生效且出库 
          ,R.MEASUREMENT_UNIT                                             --计量单位    
          ,R.TRADE_DISCOUNT_TYPE                                         --商业折扣类型  
          ,R.LINE_NET_WEIGHT                --重量                            
          ,R.TOTAL_AMOUNT_OUTEXP                      --合计金额
          ,R.TOTAL_AMOUNT                       --总计金额
          ,R.MARKET_DISCOUNT_AMOUNT   --市场折扣额
          ,R.TRADE_DISCOUNT_AMOUNT     --商业折扣额
          ,R.QTY_OUT_LINE                       --项目差价
          ,R.TOTAL_AMOUNT_EXP               --临时：表头费用
          ,R.BEFORE_DISCOUNT_AMOUNT   --临时：表头折前金额
          ,R.TOTAL_QUANTITY                   --临时：表头总数量
          ,R.TOTAL_BOX                             --临时：表头总箱数
          ,R.AMT_M_FACT                              -- 销售金额
          ,R.ORDER_AMOUNT                      -- 订单金额汇总
          ,R.ATTRIBUTE12                        -- 费用金额汇总
          ,R.QTY_M_FACT                    --底表字段：实发数量
          ,R.BOX_M_FACT                     --底表字段：箱数 
          ,R.ETL_CRT_DT
          ,R.ETL_UPD_DT
          ,R.BUSINESS
        ,R.CUSTOMER_ID
        ,R.INCEPT_ADDRESS_ID
        ,r.ORG_NAME
        ,r.FULL_NAME
        ,R.product_first_mass_prod_dt --  产品首批量产时间
        ,R.transfer_finance_dt  --  转财务日期
        ,R.new_product_end_dt --  新产品结束时间
        ,R.FULL_NAME_SN
;

-------管道

INSERT INTO
    DWD_SALE_DLY2_TMP (
        ID,
        PERIOD,
        BIZ_DATE,
        DELIVERY_CODE,
        BIZ_LINE_NO,
        ORDER_NOS,
        ORDER_TYPE,
        ORDER_NO,
        PROJECT_NAME,
        COMPANY_SALE,
        COMPANY_SN,
        DEPT1_HIS,
        DEPT2_HIS,
        DEPT3_HIS,
        DEPT1,
        DEPT2,
        DEPT3,
        PRODUCE_COMPANY,
        PRODUCE_COMPANY_SN,
        product_sort1,
        product_sort2,
        PRODUCT_SORT3,
        FIELD,
        MAT_DESC,
        PRODUCT_FORM,
        TEXTURE,
        MAT_SURFACE,
        MAT_SORT,
        MAT_ATTR5,
        MAT_CODE,
        MAT_VARIETY,
        MAT_SPEC,
        CURRENCY,
        COUNTRY,
        CUSTOMER_CODE,
        CUSTOMER_NAME,
        CUSTOMER_NEW_NAME,
        CUSTOMER_CODE1,
        CUSTOMER_NAME1,
        CUSTOMER_NEW_NAME1,
        PROVINCE_NAME,
        CITY_NAME,
        SALESMAN_HIS,
        SALESMAN,
        SALESMAN_ID_HIS,
        SALESMAN_ID,
        MANAGER,
        LEADER,
        ISNEWCUS,
        ISNEWPROD,
        ISUPSELLPROD,
        MEASUREMENT_UNIT,
        TRADE_DISCOUNT_TYPE,
        LINE_NET_WEIGHT,
        TOTAL_AMOUNT_OUTEXP,
        TOTAL_AMOUNT,
        MARKET_DISCOUNT_AMOUNT,
        TRADE_DISCOUNT_AMOUNT,
        QTY_OUT_LINE,
        TOTAL_AMOUNT_EXP,
        BEFORE_DISCOUNT_AMOUNT,
        TOTAL_QUANTITY,
        TOTAL_BOX,
        AMT_M_FACT,
        ORDER_AMOUNT,
        ATTRIBUTE12,
        AMT_M_FACT_OUTTAX,
        QTY_M_FACT,
        BOX_M_FACT,
        ETL_CRT_DT,
        ETL_UPD_DT,
        BUSINESS_TYPE,
        STATUS,
        EXPORT_CONFIRM_FLAG,
        ISSTATUS,
        BUSINESS,
        INVENTORY_CODE,
        INVENTORY_DESC,
        INCEPT_ADDRESS_ID,
        ORG_NAME,
        FULL_NAME, --20250125
        PRODUCT_ID, --产品ID
        VALUATION_UNIT, --计价单位
        COST_CNT --成本数量
,
        GROSS_WGT,
        MAT_CODE_U9,
        PRODUCT_FIRST_MASS_PROD_DT,
        NEW_PRODUCT_END_DT
    )
    ----------T0用于判断是否新产品


SELECT  SYS_GUID() ID
    ,PERIOD
    ,BIZ_DATE
    ,DELIVERY_CODE
    ,BIZ_LINE_NO
    ,ORDER_NOS
    ,ORDER_TYPE
    ,ORDER_NO
    ,PROJECT_NAME
    ,'济南迈科管道科技有限公司'               AS COMPANY_SALE
    ,'迈科管道'                       AS COMPANY_SN
    ,DEPT1_HIS
    ,CASE   WHEN DEPT2_HIS = '迈科管道销售计划科' THEN '迈科管道销售计划科'
        WHEN dept2_HIS IN ( '鲁东销售部', '鲁东分公司') THEN  '济南玛钢钢管制造有限公司鲁东分公司'
        WHEN dept2_HIS='迈科智能营销部' THEN '迈科智能营销部'
        ELSE  dept2_HIS
    END dept2_HIS
    ,CASE   WHEN DEPT3_HIS = '迈科管道销售计划科' THEN '迈科管道销售计划科'
        WHEN dept3_HIS  in( '鲁东销售部', '鲁东分公司') THEN  '济南玛钢钢管制造有限公司鲁东分公司'
        WHEN dept3_HIS='迈科智能营销部' THEN '迈科智能营销部'
        ELSE dept3_HIS
    END dept3_HIS
    ,DEPT1
    ,CASE   WHEN DEPT2_HIS = '迈科管道销售计划科' THEN '迈科管道销售计划科'
        WHEN dept2_HIS in( '鲁东销售部', '鲁东分公司')THEN  '济南玛钢钢管制造有限公司鲁东分公司'
        WHEN dept2='迈科智能营销部' THEN '迈科智能营销部'
        ELSE  dept2_HIS
    END dept2
    ,CASE   WHEN DEPT3_HIS = '迈科管道销售计划科' THEN '迈科管道销售计划科'
        WHEN dept3_HIS  in( '鲁东销售部', '鲁东分公司') THEN  '济南玛钢钢管制造有限公司鲁东分公司'
        WHEN dept3='迈科智能营销部' THEN '迈科智能营销部'
        ELSE dept3_HIS
    END dept3
    ,PRODUCE_COMPANY                    AS PRODUCE_COMPANY
    ,PRODUCE_COMPANY_SN                   AS PRODUCE_COMPANY_SN
, nvl(A.PRODUCT_SORT1,'未归类产品')  product_sort1
,  nvl(A.PRODUCT_SORT2,'未归类产品')  product_sort2
 ,   nvl( A.PRODUCT_SORT3,'未归类产品')  PRODUCT_SORT3
    ,FIELD
    ,MAT_DESC
    ,PRODUCT_FORM
    ,TEXTURE
    ,MAT_SURFACE
    ,MAT_SORT
    ,MAT_ATTR5
    ,A.MAT_CODE
    ,MAT_VARIETY
    ,MAT_SPEC
    ,CURRENCY
    ,COUNTRY
    ,CUSTOMER_CODE
    ,CUSTOMER_NAME
    ,CUSTOMER_NEW_NAME
    ,CUSTOMER_CODE1
    ,CUSTOMER_NAME1
    ,CUSTOMER_NEW_NAME1
    ,PROVINCE_NAME
    ,CITY_NAME
    ,a.SALESMAN_HIS AS SALESMAN_HIS
    ,a.salesman AS SALESMAN
    --,a.SALESMAN_ID_HIS  AS SALESMAN_ID_HIS
    --,a.SALESMAN_ID AS SALESMAN_ID
    ,C.USERID AS SALESMAN_ID
    ,C.USERID AS SALESMAN_ID
    ,D.DEPARTMENT_MANAGER_NAME MANAGER
    ,D.DEPARTMENT_LEADER_NAME LEADER
    ,ISNEWCUS
    ,CASE WHEN A.BIZ_DATE BETWEEN E.START_DT AND E.END_DT THEN '是' ELSE '否' END
    ,ISUPSELLPROD
    ,MEASUREMENT_UNIT
    ,TRADE_DISCOUNT_TYPE
    ,LINE_NET_WEIGHT
    ,TOTAL_AMOUNT_OUTEXP
    ,TOTAL_AMOUNT
    ,MARKET_DISCOUNT_AMOUNT
    ,TRADE_DISCOUNT_AMOUNT
    ,QTY_OUT_LINE
    ,TOTAL_AMOUNT_EXP
    ,BEFORE_DISCOUNT_AMOUNT
    ,TOTAL_QUANTITY
    ,TOTAL_BOX
    ,AMT_M_FACT
    ,ORDER_AMOUNT
    ,ATTRIBUTE12
    ,AMT_M_FACT_OUTTAX
    ,QTY_M_FACT
    ,BOX_M_FACT
    ,SYSDATE                    AS ETL_CRT_DT
    ,SYSDATE                    AS  ETL_UPD_DT
    ,BUSINESS_TYPE
    ,STATUS
    ,EXPORT_CONFIRM_FLAG
    ,'是'                      AS ISSTATUS
    ,BUSINESS
    ,INVENTORY_CODE
    ,INVENTORY_DESC
    ,INCEPT_ADDRESS_ID
    ,PRODUCE_COMPANY ORG_NAME
    ,FULL_NAME
    ,PRODUCT_ID
    ,VALUATION_UNIT
    ,COST_CNT
    ,GROSS_WGT
    ,A.CODE
    ,E.START_DT
    ,E.END_DT
FROM
(
SELECT  NULL            AS ID  --UUID主键
    ,A1.BUSINESSDATE      AS PERIOD  --账期期间
    ,A1.BUSINESSDATE      AS BIZ_DATE  --业务日期
    ,A1.DOCNO         AS DELIVERY_CODE  --发货单号
    ,A3.ID            AS BIZ_LINE_NO  --发货单明细行序号
    ,A8.CODE          AS ORDER_NOS  --订单编号
    ,TO_CHAR(A3.SOTDocType)   AS ORDER_TYPE  --订单类型
    ,TO_CHAR(A3.SOLineNo)   AS ORDER_NO  --明细订单编号
    ,PRJ.NAME          AS PROJECT_NAME  --项目名称（渠道/用户/项目名称）
    ,'济南迈科管道科技有限公司'  AS COMPANY_SALE  --销售公司
    ,'迈科管道'         AS COMPANY_SN  --销售公司简称
    ,'迈科管道国内营销中心'    AS DEPT1_HIS  --历史部门
    ,A10.NAME         AS DEPT2_HIS  --历史大区
    ,A10.NAME         AS DEPT3_HIS  --历史科室
    ,'迈科管道国内营销中心'    AS DEPT1  --部门
    ,A10.NAME         AS DEPT2  --大区
    ,A10.NAME         AS DEPT3  --科室
    ,A9.NAME          AS PRODUCE_COMPANY  --生产公司（库存组织）
    --,A9.NAME          AS PRODUCE_COMPANY_SN  --生产公司简称
    ,'迈科管道'         AS PRODUCE_COMPANY_SN
    -- 产品大中小类
     ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B5.NAME  WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B3.NAME     END PRODUCT_SORT1
      ,CASE
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 15 THEN B7.NAME
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 11 AND B3.NAME   = '直缝钢管' THEN
              CASE
                  WHEN (INSTR(a11.name, '_') > 0) AND
                       (   SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%GG%'
                        OR SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%N%')
                  THEN '定制化直缝钢管'
                  ELSE '标准直缝钢管'
              END ELSE '未归类产品'
      END PRODUCT_SORT2
       ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B9.NAME      WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B5.NAME    END PRODUCT_SORT3


    ,CASE 
        WHEN A5.TRADECATEGORY = '2002' THEN '燃气'
        WHEN A5.TRADECATEGORY = '2003' THEN '热力'
        WHEN A5.TRADECATEGORY = '2004' THEN '水务'
        WHEN A5.TRADECATEGORY = '2005' THEN '消防'
        WHEN A5.TRADECATEGORY = '2006' THEN '其他'
        ELSE ''
    END               AS FIELD  --领域 ODS_MAIKE_U9.CBO_CustomerSite A7 ON A1.CODE = A7.CODE AND A1.id = A7.customer AND A1.id = A7.customer
    ,A13.NAME         AS MAT_DESC  --产品名称  25.02.07改为 财务分类-名称（提供人：于睿） 修改人：王泽祥
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG2  AS PRODUCT_FORM  --产品形式
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG3  AS TEXTURE  --材质分类
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG4  AS MAT_SURFACE  --表面
    ,A12.NAME         AS MAT_SORT  --产品分类新
    ,A12.NAME         AS MAT_ATTR5  --属性5
    ,A11.NAME         AS MAT_CODE  --物料编号  25.02.07改为 物料表-名称（提供人：于睿） 修改人：王泽祥
    ,A11.NAME         AS MAT_VARIETY  --品种
    ,A11.SPECS          AS MAT_SPEC  --规格
    ,A14.SYMBOL         AS CURRENCY  --币种
    ,'中国'           AS COUNTRY  --国别
    ,A5.CODE          AS CUSTOMER_CODE  --开单客户编号
    ,A5.NAME          AS CUSTOMER_NAME  --开单客户名称
    ,A5.NAME          AS CUSTOMER_NEW_NAME  --开单客户最新名称
    ,A5.CODE          AS CUSTOMER_CODE1  --分销客户编号/最终客户
    ,A5.NAME          AS CUSTOMER_NAME1  --分销客户名称/最终客户
    ,A5.NAME          AS CUSTOMER_NEW_NAME1  --分销客户最终名称/最终客户
    ,A5.PROVINCE        AS PROVINCE_NAME  --隶属省
    ,A5.CITY          AS CITY_NAME  --隶属市
    ,A7.NAME          AS SALESMAN_HIS  --历史业务员
    ,A7.NAME          AS SALESMAN  --业务员
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID_HIS  --历史业务员账号
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID  --最新业务员账号
    ,NULL             AS MANAGER  --主管
    ,NULL             AS LEADER  --科室负责人
    ,NULL             AS ISNEWCUS  --是否新客户
    ,NULL             AS ISNEWPROD  --是否新产品
    ,NULL             AS ISUPSELLPROD  --是否老客户新产品
    ,TO_CHAR(A3.WeightUom)    AS MEASUREMENT_UNIT  --计量单位
    ,NULL             AS TRADE_DISCOUNT_TYPE  --商业折扣类型

    ,CASE
      WHEN  A3.DescFlexField_PubDescSeg15  = 'KG'  THEN A3.QtyPriceAmount
       ELSE  A3.WEIGHT
     END    AS LINE_NET_WEIGHT  --重量

    ,A3.TOTALMONEY        AS TOTAL_AMOUNT_OUTEXP  --合计金额
    ,0              AS TOTAL_AMOUNT  --总计金额
    ,0              AS MARKET_DISCOUNT_AMOUNT  --市场折扣额
    ,0              AS TRADE_DISCOUNT_AMOUNT  --商业折扣额
    ,0              AS QTY_OUT_LINE  --项目差价
    ,0              AS TOTAL_AMOUNT_EXP  --表头费用
    ,0              AS BEFORE_DISCOUNT_AMOUNT  --表头折前金额
    ,A3.TOTALACCOUNTQTYPRICEAMOUNT    AS TOTAL_QUANTITY  --表头总数量
    ,0              AS TOTAL_BOX  --表头总箱数
    ,A3.TOTALMONEY        AS AMT_M_FACT  --销售金额
    ,A3.TOTALMONEY        AS ORDER_AMOUNT  --订单金额汇总
    ,A3.TOTALMONEY        AS ATTRIBUTE12  --费用金额汇总
    ,A3.TOTALNETMONEY       AS AMT_M_FACT_OUTTAX  --无税金额
    ,A3.SHIPQTYINVAMOUNT    AS QTY_M_FACT  --实发数量
    ,A3.SHIPQTYINVAMOUNT    AS BOX_M_FACT  --箱数
    ,SYSDATE            AS ETL_CRT_DT  --记录第一次创建时间
    ,SYSDATE            AS ETL_UPD_DT  --记录最后更新日期
    ,NULL               AS BUSINESS_TYPE  --三新类型
    ,NULL               AS STATUS  --是否已生效
    ,NULL               AS EXPORT_CONFIRM_FLAG  --发货确认标识
    ,NULL               AS ISSTATUS  --是否已生效且出库
    ,'国内'             AS BUSINESS  --业务（国内/海外）
    ,NULL               AS INVENTORY_CODE  --仓库编码
    ,NULL               AS INVENTORY_DESC  --仓库名称
    ,A3.ShipToSite_CustomerSite     AS INCEPT_ADDRESS_ID  --收货地址ID             --2024.12.26   张铨金提供规则，通过SM_SHIPLINE取收货地址ID    修改人：常耀辉
    ,'迈科管道库存组织' FULL_NAME
    ,A3.ITEMINFO_ITEMID AS PRODUCT_ID
    ,A1.DESCFLEXFIELD_PUBDESCSEG15 AS VALUATION_UNIT
    ,A3.SHIPQTYCOSTAMOUNT AS COST_CNT
    ,A3.WEIGHT GROSS_WGT
    ,A11.CODE
FROM    ODS_MAIKE_U9.SM_SHIP            A1
JOIN    ODS_MAIKE_U9.SM_SHIP_TRL        A2
ON      A1.ID = A2.ID
AND     A2.SysMLFlag = 'zh-CN'
JOIN    ODS_MAIKE_U9.SM_SHIPLINE        A3
ON      A1.ID = A3.SHIP
--LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite CUS               --关联客户地址，取客户收货地址
--  ON A3.ShipToSite_CustomerSite = CUS.id
--LEFT JOIN ODS_MAIKE_U9.CBO_Operators OPE                  --通过客户收货地址取业务员ID
--  ON CUS.descflexfield_privatedescseg1 = OPE.code
/*LEFT JOIN MDDWI.TF_DWI_EMPLOYEE EMP
  ON */
LEFT JOIN   ODS_MAIKE_U9.SM_SHIPDOCTYPE_TRL   A4
ON      A1.DOCUMENTTYPE = A4.ID
AND     A4.SYSMLFLAG = 'zh-CN'  --单据类型表
AND     A4.NAME IN ('国内销售出货','回收物资销售')
LEFT JOIN   (
        SELECT    B1.id
              ,B1.TRADECATEGORY
              ,B1.code
              ,B2.NAME  AS Name
              ,B6.NAME  AS PROVINCE
              ,B7.NAME  AS CITY
        FROM      ODS_MAIKE_U9.CBO_Customer    B1
        JOIN    ODS_MAIKE_U9.CBO_Customer_Trl    B2
        ON      B1.id = B2.id
        AND     B2.SysMlFlag ='zh-CN'
        AND     B1.ORG = '1001805064098230'
        LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite    B3
        ON      B1.id = B3.customer
        LEFT JOIN ODS_MAIKE_U9.Base_Location_trl   B4
        ON      B3.OfficeSite= B4.id
        AND     B4.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_Location     B5
        ON      B4.id = B5.id
        LEFT JOIN ODS_MAIKE_U9.Base_Province_trl   B6
        ON      B5.province = B6.id
        AND     B6.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_City_Trl     B7
        ON      B5.City  = B7.id
        AND     B7.sysmlflag = 'zh-CN'
   WHERE  B3.CODE NOT LIKE '%-%'
      )                   A5
ON      A1.OrderBy_Customer = A5.id
LEFT JOIN ODS_MAIKE_U9.CBO_OPERATORS      A6  --业务员表
ON      A1.SELLER = A6.ID
LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS_TRL    A7  --业务员表
ON      A1.SELLER = A7.ID
AND     A7.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT      A8 --项目表
ON      A8.ID = A3.PROJECT
LEFT JOIN ODS_MAIKE_U9.ODS_CBO_PROJECT_TRL PRJ   --项目信息表，关联出项目名称   修改人：常耀辉   2025.1.22
  ON PRJ.SYSMLFLAG = 'zh-CN'
  AND A8.ID = PRJ.ID
LEFT JOIN   ODS_MAIKE_U9.Base_Organization_Trl  A9 -- 组织表
ON      A1.ORG = A9.ID
AND     A9.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_DEPARTMENT_TRL   A10 --部门表
ON      A1.SALEDEPT = A10.ID
AND     A10.SYSMLFLAG='zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER     A11 --物料
ON      A3.ITEMINFO_ITEMID = A11.ID
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A12 --销售分类
ON      A12.ID = A11.SALECATEGORY
AND     A12.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A13 --财务分类
ON      A13.ID = A11.ASSETCATEGORY
AND     A13.SYSMLFLAG = 'zh-CN'
LEFT JOIN  (
        SELECT  B10.ID,
            B10.CODE,
            B11.NAME,
            B10.SYMBOL
        FROM    ODS_MAIKE_U9.Base_Currency      B10
        JOIN    ODS_MAIKE_U9.Base_Currency_Trl    B11
        ON    B10.ID = B11.ID
        AND   B11.SysMlFlag ='zh-CN'
        AND   B10.code ='C001' --币种编码
      )                                     A14
ON      A1.AC = A14.id
-- LEFT JOIN   ODS_MAIKE_U9.BASE_UOM_TRL      A15
-- ON          TO_CHAR(A3.WEIGHTUOM) = A15.ID
-- AND         A15.SYSMLFLAG = 'zh-CN'
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B3 ON substr(A3.ITEMINFO_ITEMCODE,1,3) = B3.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B5 ON substr(A3.ITEMINFO_ITEMCODE,1,5) = B5.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B7 ON substr(A3.ITEMINFO_ITEMCODE,1,7) = B7.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B9 ON substr(A3.ITEMINFO_ITEMCODE,1,9) = B9.COMBINENAME  --组织为“迈科管道集团”下的产品

WHERE A5.NAME NOT LIKE '%济南玛钢钢管制造有限公司%' AND (A7.NAME <> '宋宪举' OR TRUNC(A1.BUSINESSDATE,'yy') < TO_DATE('2024','yyyy'))
--AND   A4.NAME in ('国内销售出货') 已在表关联中实现
AND   (
      (
        A5.NAME NOT IN
        (
          '山东迈科智能科技有限公司',
                '玛钢钢管内销',
                '山东迈科供应链管理有限公司',
          '济南迈克工艺品有限公司',
                '济南迈科管道科技有限公司',
                '玫德集团威海有限公司',
          '玫德集团有限公司',
                '济南科德智能科技有限公司',
          '济南迈克阀门科技有限公司',
          '玫德集团临沂有限公司',
          '玫德雅昌（济南）管业有限公司',
          '临沂玫德庚辰金属材料有限公司',
          '内销通用',
          '玫德艾瓦兹（济南）金属制品有限公司',
          '玫德雅昌（鹤壁）管业有限公司'
        )
        --AND A2.SHIPMEMO NOT LIKE '%退%货%'
        AND A2.ShipMemo NOT LIKE '%样品%'
      )
      OR
      (
        A5.NAME = '玫德集团有限公司'
        AND A2.SHIPMEMO LIKE '%联塑%'
      )
      OR
      (
        A5.NAME NOT IN
        (
          '山东迈科智能科技有限公司',
                '玛钢钢管内销',
                '山东迈科供应链管理有限公司',
          '济南迈克工艺品有限公司',
                '济南迈科管道科技有限公司',
                '玫德集团威海有限公司',
          '玫德集团有限公司',
                '济南科德智能科技有限公司',
          '济南迈克阀门科技有限公司',
          '玫德集团临沂有限公司',
          '玫德雅昌（济南）管业有限公司',
          '临沂玫德庚辰金属材料有限公司',
          '内销通用',
          '玫德艾瓦兹（济南）金属制品有限公司',
          '玫德雅昌（鹤壁）管业有限公司'
        )
        AND A2.SHIPMEMO IS NULL
      )
    )
--AND  A10.NAME NOT IN ('国内销售客服部','国内市场部','国内客服部')
AND   A10.NAME NOT IN ('迈科智能营销部','国内预制事业二部')
AND   (SUBSTR(A3.DescFlexField_PrivateDescSeg2,-3,3) NOT IN( '-YP','_YP' ) OR SUBSTR(A3.DescFlexField_PrivateDescSeg2,-3,3) IS NULL) --
AND   A1.DOCNO NOT LIKE '%-BH' --单据编号
AND   A4.NAME IS NOT NULL
AND   TRUNC(A1.BUSINESSDATE,'dd') >= TO_DATE('20220101','YYYYMMDD')  --AND   A1.BUSINESSDATE  < '2023-12-01 00:00:00.000'
AND   A1.STATUS = 3 --状态=已核准
AND   A9.NAME = '济南迈科管道科技有限公司'  -- 账套=济南迈科管道科技有限公司
AND   (A4.NAME <> '回收物资销售' OR A7.NAME = '吴超')  --   25.6.19   回收物资销售只取吴超数据

------------------------------------------------------

UNION ALL

SELECT  NULL            AS ID  --UUID主键
    ,A1.BUSINESSDATE      AS PERIOD  --账期期间
    ,A1.BUSINESSDATE      AS BIZ_DATE  --业务日期
    ,A1.DOCNO           AS DELIVERY_CODE  --发货单号
    ,A3.ID            AS BIZ_LINE_NO  --发货单明细行序号
    ,A3.SRCDOCNO          AS ORDER_NOS  --订单编号
    ,TO_CHAR(A3.SOTDocType)   AS ORDER_TYPE  --订单类型
    ,TO_CHAR(A3.SOLineNo)   AS ORDER_NO  --明细订单编号
    ,PRJ.NAME          AS PROJECT_NAME  --项目名称（渠道/用户/项目名称）
    ,'济南迈科管道科技有限公司'  AS COMPANY_SALE  --销售公司
    ,'迈科管道'         AS COMPANY_SN  --销售公司简称
    ,'迈科管道国内营销中心'    AS DEPT1_HIS  --历史部门
    ,A10.NAME         AS DEPT2_HIS  --历史大区
    ,A10.NAME         AS DEPT3_HIS  --历史科室
    ,'迈科管道国内营销中心'    AS DEPT1  --部门
    ,A10.NAME         AS DEPT2  --大区
    ,A10.NAME         AS DEPT3  --科室
    ,A9.NAME          AS PRODUCE_COMPANY  --生产公司（库存组织）
    --,A9.NAME          AS PRODUCE_COMPANY_SN  --生产公司简称
    ,'迈科管道'         AS PRODUCE_COMPANY_SN
   ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B5.NAME  WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B3.NAME     END PRODUCT_SORT1
      --产品大类编码
              --产品大类编码
      ,CASE
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 15 THEN B7.NAME
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 11 AND B3.NAME   = '直缝钢管' THEN
              CASE
                  WHEN (INSTR(a11.name, '_') > 0) AND
                       (   SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%GG%'
                        OR SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%N%')
                  THEN '定制化直缝钢管'
                  ELSE '标准直缝钢管'
              END ELSE '未归类产品'
      END PRODUCT_SORT2
       ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B9.NAME      WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B5.NAME    END PRODUCT_SORT3
    ,CASE 
        WHEN A5.TRADECATEGORY = '2002' THEN '燃气'
        WHEN A5.TRADECATEGORY = '2003' THEN '热力'
        WHEN A5.TRADECATEGORY = '2004' THEN '水务'
        WHEN A5.TRADECATEGORY = '2005' THEN '消防'
        WHEN A5.TRADECATEGORY = '2006' THEN '其他'
        ELSE ''
    END               AS FIELD  --领域
    ,A13.NAME         AS MAT_DESC  --产品名称  25.02.07改为 财务分类-名称（提供人：于睿） 修改人：王泽祥
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG2  AS PRODUCT_FORM  --产品形式
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG3  AS TEXTURE  --材质分类
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG4  AS MAT_SURFACE  --表面
    ,A12.NAME         AS MAT_SORT  --产品分类新
    ,A12.NAME         AS MAT_ATTR5  --属性5
    ,A11.NAME         AS MAT_CODE  --物料编号  25.02.07改为 物料表-名称（提供人：于睿） 修改人：王泽祥物料编号
    ,A11.NAME         AS MAT_VARIETY  --品种
    ,A11.SPECS          AS MAT_SPEC  --规格
    ,A14.SYMBOL         AS CURRENCY  --币种
    ,'中国'           AS COUNTRY  --国别
    ,A5.CODE          AS CUSTOMER_CODE  --开单客户编号
    ,A5.NAME          AS CUSTOMER_NAME  --开单客户名称
    ,A5.NAME          AS CUSTOMER_NEW_NAME  --开单客户最新名称
    ,A5.CODE          AS CUSTOMER_CODE1  --分销客户编号/最终客户
    ,A5.NAME          AS CUSTOMER_NAME1  --分销客户名称/最终客户
    ,A5.NAME          AS CUSTOMER_NEW_NAME1  --分销客户最终名称/最终客户
    ,A5.PROVINCE        AS PROVINCE_NAME  --隶属省
    ,A5.CITY          AS CITY_NAME  --隶属市
    ,A7.NAME          AS SALESMAN_HIS  --历史业务员
    ,A7.NAME          AS SALESMAN  --业务员
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID_HIS  --历史业务员账号
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID  --最新业务员账号
    ,NULL             AS MANAGER  --主管
    ,NULL             AS LEADER  --科室负责人
    ,NULL             AS ISNEWCUS  --是否新客户
    ,NULL             AS ISNEWPROD  --是否新产品
    ,NULL             AS ISUPSELLPROD  --是否老客户新产品
    ,TO_CHAR(A3.WeightUom)    AS MEASUREMENT_UNIT  --计量单位
    ,NULL           AS TRADE_DISCOUNT_TYPE  --商业折扣类型
    ,A3.Weight          AS LINE_NET_WEIGHT  --重量
    ,A3.TOTALMONEY        AS TOTAL_AMOUNT_OUTEXP  --合计金额
    ,0              AS TOTAL_AMOUNT  --总计金额
    ,0              AS MARKET_DISCOUNT_AMOUNT  --市场折扣额
    ,0              AS TRADE_DISCOUNT_AMOUNT  --商业折扣额
    ,0              AS QTY_OUT_LINE  --项目差价
    ,0              AS TOTAL_AMOUNT_EXP  --表头费用
    ,0              AS BEFORE_DISCOUNT_AMOUNT  --表头折前金额
    ,A3.TOTALACCOUNTQTYPRICEAMOUNT    AS TOTAL_QUANTITY  --表头总数量
    ,0              AS TOTAL_BOX  --表头总箱数
    ,A3.TOTALMONEY        AS AMT_M_FACT  --销售金额
    ,A3.TOTALMONEY        AS ORDER_AMOUNT  --订单金额汇总
    ,A3.TOTALMONEY        AS ATTRIBUTE12  --费用金额汇总
    ,A3.TOTALNETMONEY       AS AMT_M_FACT_OUTTAX  --无税金额
    ,A3.SHIPQTYINVAMOUNT    AS QTY_M_FACT  --实发数量
    ,A3.SHIPQTYINVAMOUNT    AS BOX_M_FACT  --箱数
    ,SYSDATE            AS ETL_CRT_DT  --记录第一次创建时间
    ,SYSDATE            AS ETL_UPD_DT  --记录最后更新日期
    ,NULL               AS BUSINESS_TYPE  --三新类型
    ,NULL               AS STATUS  --是否已生效
    ,NULL               AS EXPORT_CONFIRM_FLAG  --发货确认标识
    ,NULL               AS ISSTATUS  --是否已生效且出库
    ,'国内'             AS BUSINESS  --业务（国内/海外）
    ,NULL               AS INVENTORY_CODE  --仓库编码
    ,NULL               AS INVENTORY_DESC  --仓库名称
    ,A3.ShipToSite_CustomerSite     AS INCEPT_ADDRESS_ID  --收货地址ID             --2024.12.26   张铨金提供规则，通过SM_SHIPLINE取收货地址ID    修改人：常耀辉
    ,'玛钢钢管库存组织'   FULL_NAME
    ,A3.ITEMINFO_ITEMID AS PRODUCT_ID
    ,A1.DESCFLEXFIELD_PUBDESCSEG15 AS VALUATION_UNIT
    ,A3.SHIPQTYCOSTAMOUNT AS COST_CNT
    ,A3.WEIGHT GROSS_WGT
    ,A11.CODE
FROM    ODS_MAIKE_U9.SM_SHIP        A1
JOIN    ODS_MAIKE_U9.SM_SHIP_TRL      A2
ON      A1.ID = A2.ID
AND     A2.SysMLFlag = 'zh-CN'
JOIN    ODS_MAIKE_U9.SM_SHIPLINE      A3
ON      A1.ID = A3.SHIP
--LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite CUS               --关联客户地址，取客户收货地址
--  ON A3.ShipToSite_CustomerSite = CUS.id
--LEFT JOIN ODS_MAIKE_U9.CBO_Operators OPE                  --通过客户收货地址取业务员ID
--  ON CUS.descflexfield_privatedescseg1 = OPE.code
LEFT JOIN ODS_MAIKE_U9.SM_SHIPDOCTYPE_TRL   A4
ON      A1.DOCUMENTTYPE = A4.ID
AND     A4.SYSMLFLAG = 'zh-CN'   --单据类型表
AND     A4.NAME = '签收标准出货'
LEFT JOIN   (
        select    B1.id
              ,B1.TRADECATEGORY
              ,B1.code
              ,B2.NAME  AS Name
              ,B6.NAME  AS PROVINCE
              ,B7.NAME  AS CITY
        FROM      ODS_MAIKE_U9.CBO_Customer     B1
        JOIN    ODS_MAIKE_U9.CBO_Customer_Trl B2
        ON      B1.id = B2.id
        AND     B2.SysMlFlag ='zh-CN'
        AND     B1.ORG = '1001805064089836'
        LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite   B3
        ON      B1.id = B3.customer
        LEFT  JOIN  ODS_MAIKE_U9.Base_Location_trl  B4
        ON      B3.OfficeSite= B4.id
        AND     B4.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_Location    B5
        ON      B4.id = B5.id
        LEFT JOIN ODS_MAIKE_U9.Base_Province_trl  B6
        ON      B5.province = B6.id
        AND     B6.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_City_Trl    B7
        ON      B5.City = B7.id
        AND     B7.sysmlflag = 'zh-CN'
  WHERE  B3.CODE NOT LIKE '%-%'
      )                   A5
ON      A1.OrderBy_Customer = A5.id

LEFT JOIN ODS_MAIKE_U9.CBO_OPERATORS      A6  --业务员表
ON      A1.SELLER = A6.ID
LEFT JOIN ODS_MAIKE_U9.CBO_OPERATORS_TRL    A7   --业务员表
ON      A1.SELLER = A7.ID
AND     A7.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT      A8 --项目表
ON      A8.ID = A3.PROJECT
LEFT JOIN ODS_MAIKE_U9.ODS_CBO_PROJECT_TRL PRJ   --项目信息表，关联出项目名称   修改人：常耀辉   2025.1.22
  ON PRJ.SYSMLFLAG = 'zh-CN'
  AND A8.ID = PRJ.ID
LEFT JOIN   ODS_MAIKE_U9.Base_Organization_Trl  A9 -- 组织表
ON      A1.ORG = A9.ID
AND     A9.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_DEPARTMENT_TRL   A10 --部门表
ON      A1.SALEDEPT = A10.ID
AND     A10.SYSMLFLAG='zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER     A11 --物料
ON      A3.ITEMINFO_ITEMID = A11.ID
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A12 --销售分类
ON      A12.ID = A11.SALECATEGORY
AND     A12.SYSMLFLAG = 'zh-CN'
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A13 --财务分类
ON      A13.ID = A11.ASSETCATEGORY
AND     A13.SYSMLFLAG = 'zh-CN'
LEFT JOIN  (
        SELECT  B10.ID
            ,B10.CODE
            ,B11.NAME
            ,B10.SYMBOL
        FROM    ODS_MAIKE_U9.Base_Currency B10
        JOIN    ODS_MAIKE_U9.Base_Currency_Trl B11
        ON    B10.ID = B11.ID
        AND   B11.SysMlFlag ='zh-CN'
        AND   B10.code ='C001'
      )                   A14
ON      A1.AC =A14.id
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B3 ON substr(A3.ITEMINFO_ITEMCODE,1,3) = B3.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B5 ON substr(A3.ITEMINFO_ITEMCODE,1,5) = B5.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B7 ON substr(A3.ITEMINFO_ITEMCODE,1,7) = B7.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B9 ON substr(A3.ITEMINFO_ITEMCODE,1,9) = B9.COMBINENAME  --组织为“迈科管道集团”下的产品

WHERE   A3.TOTALNETMONEY<>0  AND (A7.NAME <> '宋宪举' OR TRUNC(A1.BUSINESSDATE,'yy') < TO_DATE('2024','yyyy'))
AND   (
      (
        (
          A5.NAME NOT IN
          (
            '山东迈科智能科技有限公司',
                    '玛钢钢管内销',
                    '山东迈科供应链管理有限公司',
              '济南迈克工艺品有限公司',
                    '济南迈科管道科技有限公司',
                    '玫德集团威海有限公司',
              '玫德集团有限公司',
                    '济南科德智能科技有限公司',
              '济南迈克阀门科技有限公司',
              '玫德集团临沂有限公司',
              '玫德雅昌（济南）管业有限公司',
              '临沂玫德庚辰金属材料有限公司',
              '内销通用',
              '玫德艾瓦兹（济南）金属制品有限公司',
              '玫德雅昌（鹤壁）管业有限公司'
          )
          AND TRUNC(A1.BUSINESSDATE,'dd') >= TO_DATE('20220101','YYYYMMDD')
        )
      )
      --AND A1.BUSINESSDATE  < '2023-12-01 00:00:00.000'
      OR
      (
        A5.NAME = '玫德集团临沂有限公司'
        AND TRUNC(A1.BUSINESSDATE,'dd') >= TO_DATE('20231001','YYYYMMDD')
      )
    )
AND   A4.NAME IS NOT NULL
AND   A1.STATUS = 3 --状态=已核准
AND   A9.NAME = '济南玛钢钢管制造有限公司' --账套=济南玛钢钢管制造有限公司
------------------------------------------------------------------------------------------------------------
UNION ALL

SELECT  NULL            AS ID  --UUID主键
    ,A1.BUSINESSDATE      AS PERIOD  --账期期间
    ,A1.BUSINESSDATE      AS BIZ_DATE  --业务日期
    ,A1.DOCNO         AS DELIVERY_CODE  --发货单号
    ,A3.ID            AS BIZ_LINE_NO  --发货单明细行序号
    ,A8.CODE          AS ORDER_NOS  --订单编号
    ,TO_CHAR(A3.SOTDocType)   AS ORDER_TYPE  --订单类型
    ,TO_CHAR(A3.SOLineNo)   AS ORDER_NO  --明细订单编号
    ,PRJ.NAME          AS PROJECT_NAME  --项目名称（渠道/用户/项目名称）
    ,'济南迈科管道科技有限公司'  AS COMPANY_SALE  --销售公司
    ,'迈科管道'         AS COMPANY_SN  --销售公司简称
    ,'迈科智能营销部'       AS DEPT1_HIS  --历史部门
    ,'迈科智能营销部'       AS DEPT2_HIS  --历史大区
    ,'迈科智能营销部'       AS DEPT3_HIS  --历史科室
    ,'迈科智能营销部'       AS DEPT1  --部门
    ,'迈科智能营销部'       AS DEPT2  --大区
    ,'迈科智能营销部'       AS DEPT3  --科室
    ,A9.NAME          AS PRODUCE_COMPANY  --生产公司（库存组织）
    --,A9.NAME          AS PRODUCE_COMPANY_SN  --生产公司简称
    ,'迈科管道'         AS PRODUCE_COMPANY_SN
   ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B5.NAME  WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B3.NAME     END PRODUCT_SORT1
      --产品大类编码
              --产品大类编码
      ,CASE
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 15 THEN B7.NAME
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 11 AND B3.NAME   = '直缝钢管' THEN
              CASE
                  WHEN (INSTR(a11.name, '_') > 0) AND
                       (   SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%GG%'
                        OR SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%N%')
                  THEN '定制化直缝钢管'
                  ELSE '标准直缝钢管'
              END ELSE '未归类产品'
      END PRODUCT_SORT2
       ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B9.NAME      WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B5.NAME    END PRODUCT_SORT3
    ,CASE 
        WHEN A5.TRADECATEGORY = '2002' THEN '燃气'
        WHEN A5.TRADECATEGORY = '2003' THEN '热力'
        WHEN A5.TRADECATEGORY = '2004' THEN '水务'
        WHEN A5.TRADECATEGORY = '2005' THEN '消防'
        WHEN A5.TRADECATEGORY = '2006' THEN '其他'
        ELSE ''
    END               AS FIELD  --领域
    ,A13.NAME         AS MAT_DESC  --产品名称  25.02.07改为 财务分类-名称（提供人：于睿） 修改人：王泽祥
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG2  AS PRODUCT_FORM  --产品形式
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG3  AS TEXTURE  --材质分类
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG4  AS MAT_SURFACE  --表面
    ,A12.NAME         AS MAT_SORT  --产品分类新
    ,A12.NAME         AS MAT_ATTR5  --属性5
    ,A11.NAME         AS MAT_CODE  --物料编号  25.02.07改为 物料表-名称（提供人：于睿） 修改人：王泽祥
    ,A11.NAME         AS MAT_VARIETY  --品种
    ,A11.SPECS          AS MAT_SPEC  --规格
    ,A14.SYMBOL         AS CURRENCY  --币种
    ,'中国'           AS COUNTRY  --国别
    ,A5.CODE          AS CUSTOMER_CODE  --开单客户编号
    ,A5.NAME          AS CUSTOMER_NAME  --开单客户名称
    ,A5.NAME          AS CUSTOMER_NEW_NAME  --开单客户最新名称
    ,A5.CODE          AS CUSTOMER_CODE1  --分销客户编号/最终客户
    ,A5.NAME          AS CUSTOMER_NAME1  --分销客户名称/最终客户
    ,A5.NAME          AS CUSTOMER_NEW_NAME1  --分销客户最终名称/最终客户
    ,A5.PROVINCE        AS PROVINCE_NAME  --隶属省
    ,A5.CITY          AS CITY_NAME  --隶属市
    ,A7.NAME          AS SALESMAN_HIS  --历史业务员
    ,A7.NAME          AS SALESMAN  --业务员
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID_HIS  --历史业务员账号
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID  --最新业务员账号
    ,NULL             AS MANAGER  --主管
    ,NULL             AS LEADER  --科室负责人
    ,NULL             AS ISNEWCUS  --是否新客户
    ,NULL             AS ISNEWPROD  --是否新产品
    ,NULL             AS ISUPSELLPROD  --是否老客户新产品
    ,TO_CHAR(A3.WeightUom)    AS MEASUREMENT_UNIT  --计量单位
    ,NULL           AS TRADE_DISCOUNT_TYPE  --商业折扣类型

    ,CASE
      WHEN  A3.DescFlexField_PubDescSeg15  = 'KG'  THEN A3.QtyPriceAmount
       ELSE  A3.WEIGHT
     END    AS LINE_NET_WEIGHT  --重量

    ,A3.TOTALMONEY        AS TOTAL_AMOUNT_OUTEXP  --合计金额
    ,0              AS TOTAL_AMOUNT  --总计金额
    ,0              AS MARKET_DISCOUNT_AMOUNT  --市场折扣额
    ,0              AS TRADE_DISCOUNT_AMOUNT  --商业折扣额
    ,0              AS QTY_OUT_LINE  --项目差价
    ,0              AS TOTAL_AMOUNT_EXP  --表头费用
    ,0              AS BEFORE_DISCOUNT_AMOUNT  --表头折前金额
    ,A3.TOTALACCOUNTQTYPRICEAMOUNT    AS TOTAL_QUANTITY  --表头总数量
    ,0              AS TOTAL_BOX  --表头总箱数
    ,A3.TOTALMONEY        AS AMT_M_FACT  --销售金额
    ,A3.TOTALMONEY        AS ORDER_AMOUNT  --订单金额汇总
    ,A3.TOTALMONEY        AS ATTRIBUTE12  --费用金额汇总
    ,A3.TOTALNETMONEY       AS AMT_M_FACT_OUTTAX  --无税金额
    ,A3.SHIPQTYINVAMOUNT    AS QTY_M_FACT  --实发数量
    ,A3.SHIPQTYINVAMOUNT    AS BOX_M_FACT  --箱数
    ,SYSDATE            AS ETL_CRT_DT  --记录第一次创建时间
    ,SYSDATE            AS ETL_UPD_DT  --记录最后更新日期
    ,NULL               AS BUSINESS_TYPE  --三新类型
    ,NULL               AS STATUS  --是否已生效
    ,NULL               AS EXPORT_CONFIRM_FLAG  --发货确认标识
    ,NULL               AS ISSTATUS  --是否已生效且出库
    ,'国内'             AS BUSINESS  --业务（国内/海外）
    ,NULL               AS INVENTORY_CODE  --仓库编码
    ,NULL               AS INVENTORY_DESC  --仓库名称
    ,A3.ShipToSite_CustomerSite     AS INCEPT_ADDRESS_ID  --收货地址ID             --2024.12.26   张铨金提供规则，通过SM_SHIPLINE取收货地址ID    修改人：常耀辉
    ,'迈科管道库存组织'   FULL_NAME
    ,A3.ITEMINFO_ITEMID AS PRODUCT_ID
    ,A1.DESCFLEXFIELD_PUBDESCSEG15 AS VALUATION_UNIT
    ,A3.SHIPQTYCOSTAMOUNT AS COST_CNT
    ,A3.WEIGHT GROSS_WGT
    ,A11.CODE
FROM    ODS_MAIKE_U9.SM_SHIP        A1
JOIN    ODS_MAIKE_U9.SM_SHIP_TRL      A2
ON      A1.ID = A2.ID
AND     A2.SysMLFlag = 'zh-CN'
JOIN    ODS_MAIKE_U9.SM_SHIPLINE      A3
ON      A1.ID = A3.SHIP
--LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite CUS               --关联客户地址，取客户收货地址
--  ON A3.ShipToSite_CustomerSite = CUS.id
--LEFT JOIN ODS_MAIKE_U9.CBO_Operators OPE                  --通过客户收货地址取业务员ID
--  ON CUS.descflexfield_privatedescseg1 = OPE.code
LEFT JOIN ODS_MAIKE_U9.SM_SHIPDOCTYPE_TRL   A4
ON      A1.DOCUMENTTYPE = A4.ID
AND     A4.SYSMLFLAG = 'zh-CN' --单据类型表
AND     A4.NAME ='国内销售出货'
LEFT JOIN   (
        SELECT    B1.id
              ,B1.TRADECATEGORY
              ,B1.code
              ,B2.NAME  AS Name
              ,B6.NAME  AS PROVINCE
              ,B7.NAME  AS CITY
        FROM      ODS_MAIKE_U9.CBO_Customer     B1
        JOIN    ODS_MAIKE_U9.CBO_Customer_Trl   B2
        ON      B1.id = B2.id
        AND     B2.SysMlFlag ='zh-CN'
        AND     B1.ORG = '1001805064098230'
        LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite   B3
        ON      B1.id = B3.customer
        LEFT  JOIN  ODS_MAIKE_U9.Base_Location_trl  B4
        ON      B3.OfficeSite= B4.id
        AND     B4.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_Location    B5
        ON      B4.id = B5.id
        LEFT JOIN ODS_MAIKE_U9.Base_Province_trl  B6
        ON      B5.province = B6.id
        AND     B6.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_City_Trl    B7
        ON      B5.City = B7.id
        AND     B7.sysmlflag = 'zh-CN'
WHERE  B3.CODE NOT LIKE '%-%'
      )                   A5
ON      A1.OrderBy_Customer = A5.id
LEFT JOIN ODS_MAIKE_U9.CBO_OPERATORS      A6
ON      A1.SELLER = A6.ID   --业务员表
LEFT JOIN ODS_MAIKE_U9.CBO_OPERATORS_TRL    A7
ON      A1.SELLER = A7.ID
AND     A7.SYSMLFLAG = 'zh-CN'  --业务员表
LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT      A8
ON      A8.ID = A3.PROJECT   --项目表
LEFT JOIN ODS_MAIKE_U9.ODS_CBO_PROJECT_TRL PRJ   --项目信息表，关联出项目名称   修改人：常耀辉   2025.1.22
  ON PRJ.SYSMLFLAG = 'zh-CN'
  AND A8.ID = PRJ.ID
LEFT JOIN   ODS_MAIKE_U9.Base_Organization_Trl  A9
ON      A1.ORG = A9.ID
AND     A9.SysMLFlag='zh-CN' -- 组织表
LEFT JOIN   ODS_MAIKE_U9.CBO_DEPARTMENT_TRL   A10
ON      A1.SALEDEPT = A10.ID
AND     A10.SYSMLFLAG='zh-CN' --部门表
LEFT JOIN ODS_MAIKE_U9.CBO_ITEMMASTER     A11
ON      A3.ITEMINFO_ITEMID = A11.ID  --物料
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A12
ON      A12.ID = A11.SALECATEGORY
AND     A12.SYSMLFLAG = 'zh-CN'  --销售分类
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A13
ON      A13.ID = A11.ASSETCATEGORY
AND     A13.SYSMLFLAG = 'zh-CN'  --财务分类
 LEFT JOIN  (
        SELECT  B10.ID
            ,B10.CODE
            ,B11.NAME
            ,B10.SYMBOL
        FROM    ODS_MAIKE_U9.Base_Currency    B10
        JOIN    ODS_MAIKE_U9.Base_Currency_Trl  B11
        ON    B10.ID = B11.ID
        AND   B11.SysMlFlag = 'zh-CN'
        AND   B10.code = 'C001'
      )                   A14
ON      A1.AC = A14.id
-- LEFT JOIN   ODS_MAIKE_U9.BASE_UOM_TRL      A15
-- ON          TO_CHAR(A3.WEIGHTUOM) = A15.ID
-- AND         A15.SYSMLFLAG = 'zh-CN'
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B3 ON substr(A3.ITEMINFO_ITEMCODE,1,3) = B3.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B5 ON substr(A3.ITEMINFO_ITEMCODE,1,5) = B5.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B7 ON substr(A3.ITEMINFO_ITEMCODE,1,7) = B7.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B9 ON substr(A3.ITEMINFO_ITEMCODE,1,9) = B9.COMBINENAME  --组织为“迈科管道集团”下的产品

WHERE     A5.NAME <> '山东迈科智能科技有限公司'
AND     A4.NAME IS NOT NULL
AND     A10.NAME IN ('迈科智能营销部','国内预制事业二部')
AND     A1.STATUS = 3 --状态=已核准
AND     A9.NAME  =  '济南迈科管道科技有限公司'  -- 账套=济南迈科管道科技有限公司
------------------------------------------------------------------------------------------------------------
UNION ALL

SELECT  NULL            AS ID  --UUID主键
    ,A1.BUSINESSDATE      AS PERIOD  --账期期间
    ,A1.BUSINESSDATE      AS BIZ_DATE  --业务日期
    ,A1.DOCNO         AS DELIVERY_CODE  --发货单号
    ,A3.ID            AS BIZ_LINE_NO  --发货单明细行序号
    ,A8.CODE          AS ORDER_NOS  --订单编号
    ,TO_CHAR(A3.SOTDocType)   AS ORDER_TYPE  --订单类型
    ,TO_CHAR(A3.SOLineNo)   AS ORDER_NO  --明细订单编号
    ,PRJ.NAME          AS PROJECT_NAME  --项目名称（渠道/用户/项目名称）
    ,'济南迈科管道科技有限公司'  AS COMPANY_SALE  --销售公司
    ,'迈科管道'         AS COMPANY_SN  --销售公司简称
    ,'迈科智能营销部'      AS DEPT1_HIS  --历史部门
    ,'迈科智能营销部'      AS DEPT2_HIS  --历史大区
    ,'迈科智能营销部'      AS DEPT3_HIS  --历史科室
    ,'迈科智能营销部'      AS DEPT1  --部门
    ,'迈科智能营销部'      AS DEPT2  --大区
    ,'迈科智能营销部'      AS DEPT3  --科室
    ,A9.NAME          AS PRODUCE_COMPANY  --生产公司（库存组织）
    --,A9.NAME          AS PRODUCE_COMPANY_SN  --生产公司简称
    ,'迈科管道'         AS PRODUCE_COMPANY_SN
   ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B5.NAME  WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B3.NAME     END PRODUCT_SORT1
      --产品大类编码
              --产品大类编码
      ,CASE
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 15 THEN B7.NAME
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 11 AND B3.NAME   = '直缝钢管' THEN
              CASE
                  WHEN (INSTR(a11.name, '_') > 0) AND
                       (   SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%GG%'
                        OR SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%N%')
                  THEN '定制化直缝钢管'
                  ELSE '标准直缝钢管'
              END ELSE '未归类产品'
      END PRODUCT_SORT2
       ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B9.NAME      WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B5.NAME    END PRODUCT_SORT3
    ,CASE 
        WHEN A5.TRADECATEGORY = '2002' THEN '燃气'
        WHEN A5.TRADECATEGORY = '2003' THEN '热力'
        WHEN A5.TRADECATEGORY = '2004' THEN '水务'
        WHEN A5.TRADECATEGORY = '2005' THEN '消防'
        WHEN A5.TRADECATEGORY = '2006' THEN '其他'
        ELSE ''
    END               AS FIELD  --领域
    ,A13.NAME         AS MAT_DESC  --产品名称  25.02.07改为 财务分类-名称（提供人：于睿） 修改人：王泽祥
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG2  AS PRODUCT_FORM  --产品形式
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG3  AS TEXTURE  --材质分类
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG4  AS MAT_SURFACE  --表面
    ,A12.NAME         AS MAT_SORT  --产品分类新
    ,A12.NAME         AS MAT_ATTR5  --属性5
    ,A11.NAME         AS MAT_CODE  --物料编号  25.02.07改为 物料表-名称（提供人：于睿） 修改人：王泽祥
    ,A11.NAME         AS MAT_VARIETY  --品种
    ,A11.SPECS          AS MAT_SPEC  --规格
    ,A14.SYMBOL         AS CURRENCY  --币种
    ,'中国'           AS COUNTRY  --国别
    ,A5.CODE          AS CUSTOMER_CODE  --开单客户编号
    ,A5.NAME          AS CUSTOMER_NAME  --开单客户名称
    ,A5.NAME          AS CUSTOMER_NEW_NAME  --开单客户最新名称
    ,A5.CODE          AS CUSTOMER_CODE1  --分销客户编号/最终客户
    ,A5.NAME          AS CUSTOMER_NAME1  --分销客户名称/最终客户
    ,A5.NAME          AS CUSTOMER_NEW_NAME1  --分销客户最终名称/最终客户
    ,A5.PROVINCE        AS PROVINCE_NAME  --隶属省
    ,A5.CITY          AS CITY_NAME  --隶属市
    ,A7.NAME          AS SALESMAN_HIS  --历史业务员
    ,A7.NAME          AS SALESMAN  --业务员
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID_HIS  --历史业务员账号
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID  --最新业务员账号
    ,NULL             AS MANAGER  --主管
    ,NULL             AS LEADER  --科室负责人
    ,NULL             AS ISNEWCUS  --是否新客户
    ,NULL             AS ISNEWPROD  --是否新产品
    ,NULL             AS ISUPSELLPROD  --是否老客户新产品
    ,TO_CHAR(A3.WeightUom)    AS MEASUREMENT_UNIT  --计量单位
    ,NULL             AS TRADE_DISCOUNT_TYPE  --商业折扣类型

  ,CASE
         WHEN  A3.DescFlexField_PubDescSeg15  = 'KG'  THEN A3.QtyPriceAmount
       ELSE  A3.WEIGHT
    END    AS LINE_NET_WEIGHT  --重量

    ,A3.TOTALMONEY        AS TOTAL_AMOUNT_OUTEXP  --合计金额
    ,0              AS TOTAL_AMOUNT  --总计金额
    ,0              AS MARKET_DISCOUNT_AMOUNT  --市场折扣额
    ,0              AS TRADE_DISCOUNT_AMOUNT  --商业折扣额
    ,0              AS QTY_OUT_LINE  --项目差价
    ,0              AS TOTAL_AMOUNT_EXP  --表头费用
    ,0              AS BEFORE_DISCOUNT_AMOUNT  --表头折前金额
    ,A3.TOTALACCOUNTQTYPRICEAMOUNT    AS TOTAL_QUANTITY  --表头总数量
    ,0              AS TOTAL_BOX  --表头总箱数
    ,A3.TOTALMONEY        AS AMT_M_FACT  --销售金额
    ,A3.TOTALMONEY        AS ORDER_AMOUNT  --订单金额汇总
    ,A3.TOTALMONEY        AS ATTRIBUTE12  --费用金额汇总
    ,A3.TOTALNETMONEY       AS AMT_M_FACT_OUTTAX  --无税金额
    ,A3.SHIPQTYINVAMOUNT    AS QTY_M_FACT  --实发数量
    ,A3.SHIPQTYINVAMOUNT    AS BOX_M_FACT  --箱数
    ,SYSDATE            AS ETL_CRT_DT  --记录第一次创建时间
    ,SYSDATE            AS ETL_UPD_DT  --记录最后更新日期
    ,NULL               AS BUSINESS_TYPE  --三新类型
    ,NULL               AS STATUS  --是否已生效
    ,NULL               AS EXPORT_CONFIRM_FLAG  --发货确认标识
    ,NULL               AS ISSTATUS  --是否已生效且出库
    ,'国内'             AS BUSINESS  --业务（国内/海外）
    ,NULL               AS INVENTORY_CODE  --仓库编码
    ,NULL               AS INVENTORY_DESC  --仓库名称
    ,A3.ShipToSite_CustomerSite     AS INCEPT_ADDRESS_ID  --收货地址ID             --2024.12.26   张铨金提供规则，通过SM_SHIPLINE取收货地址ID    修改人：常耀辉
    ,'山东迈科库存组织'   FULL_NAME
    ,A3.ITEMINFO_ITEMID AS PRODUCT_ID
    ,A1.DESCFLEXFIELD_PUBDESCSEG15 AS VALUATION_UNIT
    ,A3.SHIPQTYCOSTAMOUNT AS COST_CNT
    ,A3.WEIGHT GROSS_WGT
    ,A11.CODE
FROM    ODS_MAIKE_U9.SM_SHIP        A1
JOIN    ODS_MAIKE_U9.SM_SHIP_TRL      A2
ON      A1.ID = A2.ID
AND     A2.SysMLFlag = 'zh-CN'
JOIN    ODS_MAIKE_U9.SM_SHIPLINE      A3
ON      A1.ID = A3.SHIP
--LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite CUS               --关联客户地址，取客户收货地址
--  ON A3.ShipToSite_CustomerSite = CUS.id
--LEFT JOIN ODS_MAIKE_U9.CBO_Operators OPE                  --通过客户收货地址取业务员ID
--  ON CUS.descflexfield_privatedescseg1 = OPE.code
LEFT JOIN   ODS_MAIKE_U9.SM_SHIPDOCTYPE_TRL   A4
ON      A1.DOCUMENTTYPE = A4.ID
AND     A4.SYSMLFLAG = 'zh-CN'  --单据类型表
AND     A4.NAME ='标准销售[默认]'
LEFT JOIN (
        SELECT    B1.id
              ,B1.TRADECATEGORY
              ,B1.code
              ,B2.NAME AS Name
              ,B6.NAME AS PROVINCE
              ,B7.NAME AS CITY
        from      ODS_MAIKE_U9.CBO_Customer     B1
        JOIN    ODS_MAIKE_U9.CBO_Customer_Trl   B2
        ON      B1.id = B2.id
        AND     B2.SysMlFlag ='zh-CN'
        AND     B1.ORG = '1002210292605733'
        LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite   B3
        ON      B1.id = B3.customer
        LEFT  JOIN  ODS_MAIKE_U9.Base_Location_trl  B4
        ON      B3.OfficeSite= B4.id
        AND     B4.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_Location B5
        ON      B4.id = B5.id
        LEFT JOIN ODS_MAIKE_U9.Base_Province_trl  B6
        ON      B5.province = B6.id
        AND     B6.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_City_Trl    B7
        ON      B5.City = B7.id
        AND     B7.sysmlflag = 'zh-CN'
  WHERE  B3.CODE NOT LIKE '%-%'
      )                   A5
ON      A1.OrderBy_Customer = A5.id
LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS      A6
ON      A1.SELLER = A6.ID   --业务员表
LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS_TRL    A7
ON      A1.SELLER = A7.ID
AND     A7.SYSMLFLAG = 'zh-CN'  --业务员表
LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT      A8
ON      A8.ID = A3.PROJECT   --项目表
LEFT JOIN ODS_MAIKE_U9.ODS_CBO_PROJECT_TRL PRJ   --项目信息表，关联出项目名称   修改人：常耀辉   2025.1.22
  ON PRJ.SYSMLFLAG = 'zh-CN'
  AND A8.ID = PRJ.ID
LEFT JOIN   ODS_MAIKE_U9.Base_Organization_Trl  A9
ON      A1.ORG = A9.ID
AND     A9.SysMLFlag='zh-CN'-- 组织表
LEFT JOIN   ODS_MAIKE_U9.CBO_DEPARTMENT_TRL   A10
ON      A1.SALEDEPT = A10.ID
AND     A10.SYSMLFLAG='zh-CN' --部门表
LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER     A11
ON      A3.ITEMINFO_ITEMID = A11.ID  --物料
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A12
ON      A12.ID = A11.SALECATEGORY
AND     A12.SYSMLFLAG = 'zh-CN'  --销售分类
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL     A13
ON      A13.ID = A11.ASSETCATEGORY
AND     A13.SYSMLFLAG = 'zh-CN'  --财务分类
LEFT JOIN  (
        SELECT  B10.ID
            ,B10.CODE
            ,B11.NAME
            ,B10.SYMBOL
        FROM    ODS_MAIKE_U9.Base_Currency B10
        JOIN    ODS_MAIKE_U9.Base_Currency_Trl B11
        ON    B10.ID = B11.ID
        AND   B11.SysMlFlag ='zh-CN'
        AND   B10.code ='C001'
      )                   A14
ON      A1.AC =A14.id
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B3 ON substr(A3.ITEMINFO_ITEMCODE,1,3) = B3.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B5 ON substr(A3.ITEMINFO_ITEMCODE,1,5) = B5.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B7 ON substr(A3.ITEMINFO_ITEMCODE,1,7) = B7.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B9 ON substr(A3.ITEMINFO_ITEMCODE,1,9) = B9.COMBINENAME  --组织为“迈科管道集团”下的产品
-- LEFT JOIN   ODS_MAIKE_U9.BASE_UOM_TRL      A15
-- ON          TO_CHAR(A3.WEIGHTUOM) = A15.ID
-- AND         A15.SYSMLFLAG = 'zh-CN'

WHERE     A5.NAME <> '永清县科启商贸有限公司'
AND     A4.NAME IS NOT NULL
AND     A1.STATUS = 3 --状态=已核准
AND     A9.NAME  =  '山东迈科智能科技有限公司'  -- 账套山东迈科智能科技有限公司
--AND  A10.NAME ='迈科智能营销部'
------------------------------------------------------------------------------------------------------------
UNION ALL

SELECT   NULL            AS ID  --UUID主键
    ,A1.BUSINESSDATE      AS PERIOD  --账期期间
    ,A1.BUSINESSDATE      AS BIZ_DATE  --业务日期
    ,A1.DOCNO         AS DELIVERY_CODE  --发货单号
    ,A3.ID            AS BIZ_LINE_NO  --发货单明细行序号
    ,A8.CODE          AS ORDER_NOS  --订单编号
    ,TO_CHAR(A3.SOTDocType)   AS ORDER_TYPE  --订单类型
    ,TO_CHAR(A3.SOLineNo)   AS ORDER_NO  --明细订单编号
    ,PRJ.NAME          AS PROJECT_NAME  --项目名称（渠道/用户/项目名称）
    ,'济南迈科管道科技有限公司'  AS COMPANY_SALE  --销售公司
    ,'迈科管道'         AS COMPANY_SN  --销售公司简称
    ,'迈科智能营销部'      AS DEPT1_HIS  --历史部门
    ,'迈科智能营销部'      AS DEPT2_HIS  --历史大区
    ,'迈科智能营销部'      AS DEPT3_HIS  --历史科室
    ,'迈科智能营销部'      AS DEPT1  --部门
    ,'迈科智能营销部'      AS DEPT2  --大区
    ,'迈科智能营销部'      AS DEPT3  --科室
    ,A9.NAME          AS PRODUCE_COMPANY  --生产公司（库存组织）
    --,A9.NAME          AS PRODUCE_COMPANY_SN  --生产公司简称
    ,'迈科管道'         AS PRODUCE_COMPANY_SN
   ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B5.NAME  WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B3.NAME     END PRODUCT_SORT1
      --产品大类编码
              --产品大类编码
      ,CASE
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 15 THEN B7.NAME
          WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = 11 AND B3.NAME   = '直缝钢管' THEN
              CASE
                  WHEN (INSTR(a11.name, '_') > 0) AND
                       (   SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%GG%'
                        OR SUBSTR(a11.name, 1, INSTR(a11.name, '_') - 1) LIKE '%N%')
                  THEN '定制化直缝钢管'
                  ELSE '标准直缝钢管'
              END ELSE '未归类产品'
      END PRODUCT_SORT2
       ,CASE WHEN LENGTH(A3.ITEMINFO_ITEMCODE) = '15' THEN B9.NAME      WHEN  LENGTH(A3.ITEMINFO_ITEMCODE) = '11' THEN B5.NAME    END PRODUCT_SORT3
    ,CASE 
        WHEN A5.TRADECATEGORY = '2002' THEN '燃气'
        WHEN A5.TRADECATEGORY = '2003' THEN '热力'
        WHEN A5.TRADECATEGORY = '2004' THEN '水务'
        WHEN A5.TRADECATEGORY = '2005' THEN '消防'
        WHEN A5.TRADECATEGORY = '2006' THEN '其他'
        ELSE ''
    END               AS FIELD  --领域
    ,A13.NAME         AS MAT_DESC  --产品名称  25.02.07改为 财务分类-名称（提供人：于睿） 修改人：王泽祥
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG2  AS PRODUCT_FORM  --产品形式
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG3  AS TEXTURE  --材质分类
    ,A11.DESCFLEXFIELD_PRIVATEDESCSEG4  AS MAT_SURFACE  --表面
    ,A12.NAME         AS MAT_SORT  --产品分类新
    ,A12.NAME         AS MAT_ATTR5  --属性5
    ,A11.NAME         AS MAT_CODE  --物料编号  25.02.07改为 物料表-名称（提供人：于睿） 修改人：王泽祥
    ,A11.NAME         AS MAT_VARIETY  --品种
    ,A11.SPECS          AS MAT_SPEC  --规格
    ,A14.SYMBOL         AS CURRENCY  --币种
    ,'中国'           AS COUNTRY  --国别
    ,A5.CODE          AS CUSTOMER_CODE  --开单客户编号
    ,A5.NAME          AS CUSTOMER_NAME  --开单客户名称
    ,A5.NAME          AS CUSTOMER_NEW_NAME  --开单客户最新名称
    ,A5.CODE          AS CUSTOMER_CODE1  --分销客户编号/最终客户
    ,A5.NAME          AS CUSTOMER_NAME1  --分销客户名称/最终客户
    ,A5.NAME          AS CUSTOMER_NEW_NAME1  --分销客户最终名称/最终客户
    ,A5.PROVINCE        AS PROVINCE_NAME  --隶属省
    ,A5.CITY          AS CITY_NAME  --隶属市
    ,A7.NAME          AS SALESMAN_HIS  --历史业务员
    ,A7.NAME          AS SALESMAN  --业务员
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID_HIS  --历史业务员账号
    ,A6.DescFlexField_PrivateDescSeg1 AS SALESMAN_ID  --最新业务员账号
    ,NULL             AS MANAGER  --主管
    ,NULL             AS LEADER  --科室负责人
    ,NULL             AS ISNEWCUS  --是否新客户
    ,NULL             AS ISNEWPROD  --是否新产品
    ,NULL             AS ISUPSELLPROD  --是否老客户新产品
    ,TO_CHAR(A3.WeightUom)    AS MEASUREMENT_UNIT  --计量单位
    ,NULL             AS TRADE_DISCOUNT_TYPE  --商业折扣类型

    ,CASE
         WHEN  A3.DescFlexField_PubDescSeg15  = 'KG'  THEN A3.QtyPriceAmount
       ELSE  A3.WEIGHT
    END    AS LINE_NET_WEIGHT  --重量

    ,A3.TOTALMONEY        AS TOTAL_AMOUNT_OUTEXP  --合计金额
    ,0              AS TOTAL_AMOUNT  --总计金额
    ,0              AS MARKET_DISCOUNT_AMOUNT  --市场折扣额
    ,0              AS TRADE_DISCOUNT_AMOUNT  --商业折扣额
    ,0              AS QTY_OUT_LINE  --项目差价
    ,0              AS TOTAL_AMOUNT_EXP  --表头费用
    ,0              AS BEFORE_DISCOUNT_AMOUNT  --表头折前金额
    ,A3.TOTALACCOUNTQTYPRICEAMOUNT    AS TOTAL_QUANTITY  --表头总数量
    ,0              AS TOTAL_BOX  --表头总箱数
    ,A3.TOTALMONEY        AS AMT_M_FACT  --销售金额
    ,A3.TOTALMONEY        AS ORDER_AMOUNT  --订单金额汇总
    ,A3.TOTALMONEY        AS ATTRIBUTE12  --费用金额汇总
    ,A3.TOTALNETMONEY       AS AMT_M_FACT_OUTTAX  --无税金额
    ,A3.SHIPQTYINVAMOUNT    AS QTY_M_FACT  --实发数量
    ,A3.SHIPQTYINVAMOUNT    AS BOX_M_FACT  --箱数
    ,SYSDATE            AS ETL_CRT_DT  --记录第一次创建时间
    ,SYSDATE            AS ETL_UPD_DT  --记录最后更新日期
    ,NULL               AS BUSINESS_TYPE  --三新类型
    ,NULL               AS STATUS  --是否已生效
    ,NULL               AS EXPORT_CONFIRM_FLAG  --发货确认标识
    ,NULL               AS ISSTATUS  --是否已生效且出库
    ,'国内'             AS BUSINESS  --业务（国内/海外）
    ,NULL               AS INVENTORY_CODE  --仓库编码
    ,NULL               AS INVENTORY_DESC  --仓库名称
    ,A3.ShipToSite_CustomerSite     AS INCEPT_ADDRESS_ID  --收货地址ID             --2024.12.26   张铨金提供规则，通过SM_SHIPLINE取收货地址ID    修改人：常耀辉
    ,'迈科管道库存组织'   FULL_NAME
    ,A3.ITEMINFO_ITEMID AS PRODUCT_ID
    ,A3.DESCFLEXFIELD_PUBDESCSEG15 AS VALUATION_UNIT
    ,A3.SHIPQTYCOSTAMOUNT AS COST_CNT
    ,A3.WEIGHT GROSS_WGT
    ,A11.CODE
FROM    ODS_MAIKE_U9.SM_SHIP    A1
JOIN    ODS_MAIKE_U9.SM_SHIP_TRL A2
ON      A1.ID = A2.ID
AND     A2.SysMLFlag = 'zh-CN'
JOIN    ODS_MAIKE_U9.SM_SHIPLINE A3
ON      A1.ID = A3.SHIP
--LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite CUS               --关联客户地址，取客户收货地址
--  ON A3.ShipToSite_CustomerSite = CUS.id
--LEFT JOIN ODS_MAIKE_U9.CBO_Operators OPE                  --通过客户收货地址取业务员ID
--  ON CUS.descflexfield_privatedescseg1 = OPE.code
LEFT JOIN   ODS_MAIKE_U9.SM_SHIPDOCTYPE_TRL A4
ON      A1.DOCUMENTTYPE = A4.ID
AND     A4.SYSMLFLAG = 'zh-CN'  --单据类型表
AND     A4.NAME ='标准销售[默认]'
LEFT JOIN   (
        SELECT    B1.id,
              B1.TRADECATEGORY,
              B1.code,
              B2.NAME  as Name,
              B6.NAME AS PROVINCE ,
              B7.NAME AS CITY
        from    ODS_MAIKE_U9.CBO_Customer B1
        JOIN    ODS_MAIKE_U9.CBO_Customer_Trl B2
        ON      B1.id = B2.id
        AND     B2.SysMlFlag ='zh-CN'
        AND     B1.ORG = '1002609119712676'
        LEFT JOIN ODS_MAIKE_U9.CBO_CustomerSite B3
        ON      B1.id = B3.customer
        LEFT JOIN ODS_MAIKE_U9.Base_Location_trl B4
        ON      B3.OfficeSite= B4.id
        AND     B4.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_Location B5
        ON      B4.id = B5.id
        LEFT JOIN ODS_MAIKE_U9.Base_Province_trl B6
        ON      B5.province = B6.id
        AND     B6.sysmlflag = 'zh-CN'
        LEFT JOIN ODS_MAIKE_U9.Base_City_Trl B7
        ON      B5.City  = B7.id
        AND     B7.sysmlflag = 'zh-CN'
  WHERE  B3.CODE NOT LIKE '%-%'
      ) A5
ON      A1.OrderBy_Customer = A5.id
LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS A6
ON      A1.SELLER = A6.ID   --业务员表
LEFT JOIN   ODS_MAIKE_U9.CBO_OPERATORS_TRL A7
ON      A1.SELLER = A7.ID
AND     A7.SYSMLFLAG = 'zh-CN'  --业务员表
LEFT JOIN   ODS_MAIKE_U9.CBO_PROJECT A8
ON      A8.ID = A3.PROJECT   --项目表
LEFT JOIN ODS_MAIKE_U9.ODS_CBO_PROJECT_TRL PRJ   --项目信息表，关联出项目名称   修改人：常耀辉   2025.1.22
  ON PRJ.SYSMLFLAG = 'zh-CN'
  AND A8.ID = PRJ.ID
LEFT JOIN   ODS_MAIKE_U9.Base_Organization_Trl A9
ON      A1.ORG = A9.ID
AND     A9.SysMLFlag='zh-CN' -- 组织表
LEFT JOIN   ODS_MAIKE_U9.CBO_DEPARTMENT_TRL A10
ON      A1.SALEDEPT = A10.ID
AND     A10.SYSMLFLAG='zh-CN' --部门表
LEFT JOIN   ODS_MAIKE_U9.CBO_ITEMMASTER A11
ON      A3.ITEMINFO_ITEMID = A11.ID  --物料
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL A12
ON      A12.ID = A11.SALECATEGORY
AND     A12.SYSMLFLAG = 'zh-CN'  --销售分类
LEFT JOIN   ODS_MAIKE_U9.CBO_CATEGORY_TRL A13
ON      A13.ID = A11.ASSETCATEGORY
AND     A13.SYSMLFLAG = 'zh-CN'  --财务分类
LEFT JOIN   (
        SELECT  B10.ID,
            B10.CODE,
            B11.NAME,
            B10.SYMBOL
        FROM    ODS_MAIKE_U9.Base_Currency B10
        JOIN    ODS_MAIKE_U9.Base_Currency_Trl B11
        ON    B10.ID = B11.ID
        AND   B11.SysMlFlag ='zh-CN'
        AND   B10.code ='C001'
      ) A14
ON      A1.AC =A14.id
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B3 ON substr(A3.ITEMINFO_ITEMCODE,1,3) = B3.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B5 ON substr(A3.ITEMINFO_ITEMCODE,1,5) = B5.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B7 ON substr(A3.ITEMINFO_ITEMCODE,1,7) = B7.COMBINENAME  --组织为“迈科管道集团”下的产品
LEFT JOIN   (select DISTINCT T.NAME, T.COMBINENAME from ODS_MAIKE_U9.CBO_Category_TRL T JOIN ODS_MAIKE_U9.CBO_Category T1 ON T.ID = T1.ID   where T1.ORG = '1001805064089606' AND    t.sysmlflag='zh-CN' )   B9 ON substr(A3.ITEMINFO_ITEMCODE,1,9) = B9.COMBINENAME  --组织为“迈科管道集团”下的产品
-- LEFT JOIN   ODS_MAIKE_U9.BASE_UOM_TRL      A15
-- ON          TO_CHAR(A3.WEIGHTUOM) = A15.ID
-- AND         A15.SYSMLFLAG = 'zh-CN'

WHERE     A5.NAME <> '山东迈科智能科技有限公司'
AND     A4.NAME IS NOT NULL
AND     A1.STATUS = 3 --状态=已核准
AND     A9.NAME  =  '永清县科启商贸有限公司'  -- 账套=永清县科启商贸有限公司
--AND  A10.NAME ='迈科智能营销部'
)                       A
-- LEFT JOIN (
--         SELECT  ORGNAME
--             ,FULL_NAME
--         FROM  MDDIM.TD_DIM_BUSINESS_ORGANIZATION
--       )                 B
-- ON      TO_CHAR(A.COMPANY_SN) = B.FULL_NAME
LEFT JOIN MDDIM.DIM_EMPLOYEE_D      C  
ON      A.SALESMAN_ID =  C.PERSON_CODE             --2024.12.27  管道修改字段值,从PS账号改成员工工号，更新关联条件， 修改人：常耀辉
LEFT JOIN   MDDIM.DIM_DEPARTMENT_D      D
ON      C.DEPARTMENT_CODE = D.DEPARTMENT_CODE
LEFT JOIN DWD_U9_NEW_PRODUCT_STG E
    ON A.CODE = E.MAT_CODE_U9
 --LEFT JOIN MDDIM.DIM_PRODUCT_D  PRO ON A.PRODUCT_SORT2 = PRO.PRODUCT_SORT2;

WHERE to_char(A.PERIOD,'yyyymm') < '202412' ;


update DWD_SALE_DLY2_TMP
set
    PROVINCE_NAME = '山东省'
    -- CITY_NAME = '济南市'
where
    CUSTOMER_NAME = '济南港华燃气有限公司（失效）';

update DWD_SALE_DLY2_TMP
set
    CITY_NAME = '济南市'
where
    CUSTOMER_NAME = '济南港华燃气有限公司（失效）';


--更新管道产品大类 --邱治钧 、生旭辉-2025-5-13
UPDATE DWD_SALE_DLY2_TMP
SET
    PRODUCT_SORT1 = '装配式管道解决方案',
    PRODUCT_SORT2 = 'BIM深化设计服务',
    PRODUCT_SORT3 = 'BIM深化设计服务'
WHERE
    PRODUCT_SORT1 = '消防管道预制及工程'
    AND COMPANY_SN = '迈科管道';



  ---------------------------济南雅昌--------------------------------------
  INSERT INTO   DWD_SALE_DLY2_TMP
  (
  ID            
  ,PERIOD         
  ,BIZ_DATE       
  ,DELIVERY_CODE      
  ,BIZ_LINE_NO          
  ,ORDER_NOS        
  ,ORDER_TYPE       
  ,ORDER_NO       
  ,PROJECT_NAME     
  ,COMPANY_SALE
  ,COMPANY_SN     
  ,DEPT1_HIS            
  ,DEPT2_HIS            
  ,DEPT3_HIS       
  ,DEPT1            
  ,DEPT2            
  ,DEPT3        
  ,produce_company 
  ,PRODUCE_COMPANY_SN     
  ,PRODUCT_SORT1    
  ,PRODUCT_SORT2      
  ,PRODUCT_SORT3      
  ,FIELD                
  ,MAT_DESC       
  ,PRODUCT_FORM     
  ,TEXTURE        
  ,MAT_SURFACE      
  ,MAT_SORT             
  ,MAT_ATTR5        
  ,MAT_CODE       
  ,MAT_VARIETY      
  ,MAT_SPEC       
  ,CURRENCY       
  ,COUNTRY        
  ,CUSTOMER_CODE      
  ,CUSTOMER_NAME   
  ,CUSTOMER_NEW_NAME
  ,CUSTOMER_CODE1       
  ,CUSTOMER_NAME1   
  ,CUSTOMER_NEW_NAME1
  ,PROVINCE_NAME      
  ,CITY_NAME    
  ,SALESMAN_HIS    
  ,SALESMAN 
  ,SALESMAN_ID_HIS
  ,SALESMAN_ID         
  ,MANAGER        
  ,LEADER                    
  ,ISNEWCUS       
  ,ISNEWPROD            
  ,ISUPSELLPROD
  ,business_type
  ,STATUS
  ,EXPORT_CONFIRM_FLAG
  ,ISSTATUS       
  ,MEASUREMENT_UNIT   
  ,TRADE_DISCOUNT_TYPE  
  ,LINE_NET_WEIGHT    
  ,TOTAL_AMOUNT_OUTEXP  
  ,TOTAL_AMOUNT     
  ,MARKET_DISCOUNT_AMOUNT 
  ,TRADE_DISCOUNT_AMOUNT  
  ,QTY_OUT_LINE     
  ,TOTAL_AMOUNT_EXP   
  ,BEFORE_DISCOUNT_AMOUNT 
  ,TOTAL_QUANTITY     
  ,TOTAL_BOX        
  ,AMT_M_FACT       
  ,ORDER_AMOUNT     
  ,ATTRIBUTE12      
  ,AMT_M_FACT_OUTTAX    
  ,QTY_M_FACT       
  ,BOX_M_FACT       
  ,ETL_CRT_DT       
  ,ETL_UPD_DT 
  ,BUSINESS
,CUSTOMER_ID
,INCEPT_ADDRESS_ID
,ORG_NAME
,FULL_NAME
,product_first_mass_prod_dt	--	产品首批量产时间
,transfer_finance_dt	--	转财务日期
,new_product_end_dt	--	新产品结束时间
,FULL_NAME_SN   --库存组织名称
  )
  
   
  SELECT
  SYS_GUID() AS ID                                                          --UUID主键                  
  ,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                          --账期期间
  ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
  ,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
  ,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
  ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
  ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
  ,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
  ,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
  ,'玫德雅昌（济南）管业有限公司' AS COMPANY_SALE                                       --销售公司
  ,'济南雅昌'   AS COMPANY_SN                                                 --销售公司简称  
  ,'济南雅昌国内销售部'  AS DEPT1_HIS                                               --历史部门
  ,G4.ORGNAME AS DEPT2_HIS                                                  --历史大区
  ,G3.ORGNAME AS DEPT3_HIS                                                  --历史科室
  ,'济南雅昌国内销售部'  AS DEPT1                                                   --部门
  --,G4.ORGNAME AS DEPT2                                                            -- 大区
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '济南雅昌华北区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '济南雅昌华南区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('湖北省','江西省','江苏省') then '济南雅昌华东区（江苏区）'
          else '济南雅昌华东区'  end AS DEPT2                                                  --大区
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '济南雅昌华北区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '济南雅昌华南区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('湖北省','江西省','江苏省') then '济南雅昌华东区（江苏区）'
          else '济南雅昌华东区'  end AS DEPT3                                           --科室
  --,G3.ORGNAME AS DEPT3                                                      --科室
  ,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company                   --生产公司（库存组织）
  ,'济南雅昌' PRODUCE_COMPANY_SN                                             --生产公司简称
  --,'卡压管件' AS PRODUCT_SORT1                       --产品大类
  --,'卡压管件' AS PRODUCT_SORT2                       --产品中类
  --,'卡压管件' AS PRODUCT_SORT3                       --产品小类
  ,NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1                       --产品大类
  ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                       --产品中类
  ,NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                       --产品小类
  --,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT1                       --产品大类
  --,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                       --产品中类
  --,NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                       --产品小
  ,M.MAIN_FIELD AS FIELD                                                            --领域
  ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                      --产品名称
  ,C.FORM AS PRODUCT_FORM                                                  --产品形式
  ,C.TEXTURE AS TEXTURE                                                    --材质分类
  ,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
  ,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
  ,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
  ,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
  ,C.VARIETY AS MAT_VARIETY                                               --品种
  ,C.SPECIFICATION AS MAT_SPEC                                            --规格
  ,'CNY' AS CURRENCY                                                      --币种
  ,'中国' AS COUNTRY                                                      --国别
  ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
  ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
  ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
  ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
  ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
  ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称 
  ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
  ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
  ,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
  --,I.EMPNAME AS SALESMAN                                                   --业务员
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '李强'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '吕凯'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('湖北省','江西省','江苏省') then '罗京'
          else '齐超'  end AS SALESMAN                                           --科室
  
  ,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
  --,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then 'liqiang06'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then 'lvkai'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then 'luojing'
          else 'qichao'  end AS SALESMAN_ID
  ,' ' AS MANAGER                                                          --主管
  ,' ' AS LEADER                                                           --科室负责人
  ,' 'AS ISNEWCUS                                                          --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
  ,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
  --,ZB.business_type AS business_type                                       --三新类型
  ,'' AS business_type                                       --三新类型
  ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
  ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
  ,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库  
  ,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
  ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1,      'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT--重量                       
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/1.13  AS AMT_M_FACT_OUTTAX--底表字段：无税金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
  ,SYSDATE ETL_CRT_DT
  ,SYSDATE ETL_UPD_DT
  ,'国内' AS BUSINESS
,A.CUSTOMER_ID
,A.INCEPT_ADDRESS_ID
,G1.ORGNAME ORG_NAME
,G2.FULL_NAME
,C.splcsj AS product_first_mass_prod_dt --  产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
  FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A 
  LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE        B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
  LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
  LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
  LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
  LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
  LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
  LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
  LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
  LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
  LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
  LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
  LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
  LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
  LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
  LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
  LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
  LEFT JOIN ODS_IMS.TF_ODS_IMS_ISNEW_MARK ZB ON B.DELIVERY_LINE_ID = ZB.delivery_line_id
  LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE  --领域表
  WHERE 
   H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销物资销售订单','内销退货订单' ,'内销物资销售退货订单' )
  AND G1.ORGNAME = '89_玫德雅昌(济南)2581' 
  AND TRUNC(A.EXPORT_CONFIRM_DATE,'MM') < TO_DATE('2024/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')--出库日期，增量导入时间戳

UNION ALL

 SELECT
  SYS_GUID() AS ID                                                          --UUID主键                  
  ,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                          --账期期间
  ,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期 
  ,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
  ,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
  ,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),''),CHR(13),'') AS ORDER_NOS        --订单编号
  ,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
  ,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号 
  ,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
  ,'玫德雅昌（济南）管业有限公司' AS COMPANY_SALE                                       --销售公司
  ,'济南雅昌'   AS COMPANY_SN                                                 --销售公司简称  
  ,'济南雅昌国内销售部'  AS DEPT1_HIS                                               --历史部门
  ,G4.ORGNAME AS DEPT2_HIS                                                  --历史大区
  ,G3.ORGNAME AS DEPT3_HIS                                                  --历史科室
  ,'济南雅昌国内销售部'  AS DEPT1                                                   --部门
  --,G4.ORGNAME AS DEPT2                                                            -- 大区
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '济南雅昌华北区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '济南雅昌华南区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('湖北省','江西省','江苏省') then '济南雅昌华东区（江苏区）'
          else '济南雅昌华东区'  end AS DEPT2                                                  --大区
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '济南雅昌华北区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '济南雅昌华南区'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('湖北省','江西省','江苏省') then '济南雅昌华东区（江苏区）'
          else '济南雅昌华东区'  end AS DEPT3                                           --科室
  --,G3.ORGNAME AS DEPT3                                                      --科室
  ,REPLACE(G2.FULL_NAME,'库存组织','') AS produce_company                   --生产公司（库存组织）
  ,'济南雅昌' PRODUCE_COMPANY_SN                                             --生产公司简称
  --,'卡压管件'  AS PRODUCT_SORT1                       --产品大类
  --,'卡压管件' AS PRODUCT_SORT2                       --产品中类
  --,'卡压管件' AS PRODUCT_SORT3                       --产品小类
  ,NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1                       --产品大类
  ,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                       --产品中类
  ,NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                       --产品小
  ,M.MAIN_FIELD AS FIELD                                                            --领域
  ,B.MATERIAL_DESCRIPTION AS MAT_DESC                                      --产品名称
  ,C.FORM AS PRODUCT_FORM                                                  --产品形式
  ,C.TEXTURE AS TEXTURE                                                    --材质分类
  ,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
  ,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
  ,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
  ,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
  ,C.VARIETY AS MAT_VARIETY                                               --品种
  ,C.SPECIFICATION AS MAT_SPEC                                            --规格
  ,'CNY' AS CURRENCY                                                      --币种
  ,'中国' AS COUNTRY                                                      --国别
  ,D.CUSTOMER_CODE AS CUSTOMER_CODE                                       --开单客户编号  
  ,D.CUSTOMER_NAME AS CUSTOMER_NAME                                       --开单客户名称
  ,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                                   --开单客户最新名称
  ,D1.CUSTOMER_CODE AS CUSTOMER_CODE1                                     --分销客户编号/最终客户
  ,D1.CUSTOMER_NAME AS CUSTOMER_NAME1                                     --分销客户名称/最终客户 
  ,D1.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME1                                 --分销客户最新名称/最终客户最新名称 
  ,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
  ,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
  ,I.EMPNAME AS SALESMAN_HIS                                               --历史业务员
  --,I.EMPNAME AS SALESMAN                                                   --业务员
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then '李强'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then '吕凯'
          else '齐超'  end AS SALESMAN                                           --业务员
  
  ,EMP.USERID AS SALESMAN_ID_HIS                                           --历史业务员账号 
  --,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
  ,case when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('黑龙江省','甘肃省','宁夏回族自治区','青海省','北京市','陕西省','河北省') then 'liqiang06'
        when DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) in ('广东省','广西壮族自治区') then 'lvkai'
          else 'qichao'  end AS SALESMAN_ID        --业务员账号
  ,' ' AS MANAGER                                                          --主管
  ,' ' AS LEADER                                                           --科室负责人
  ,' 'AS ISNEWCUS                                                          --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
  ,' ' AS ISUPSELLPROD                                                     --是否老客户新产品
  --,ZB.business_type AS business_type                                       --三新类型
  ,'' AS business_type                                       --三新类型
  ,A.STATUS   AS  STATUS                                                            --基础信息状态生效
  ,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                                              --已出库
  ,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库  
  ,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
  ,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1,      'C', 1, 0) * B.LINE_NET_WEIGHT  AS LINE_NET_WEIGHT--重量                       
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/1.13  AS AMT_M_FACT_OUTTAX--底表字段：无税金额
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
  ,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数  
  ,SYSDATE ETL_CRT_DT
  ,SYSDATE ETL_UPD_DT
  ,'国内' AS BUSINESS
,A.CUSTOMER_ID
,A.INCEPT_ADDRESS_ID
,G1.ORGNAME ORG_NAME
,G2.FULL_NAME
,C.splcsj AS product_first_mass_prod_dt --  产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt --  转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt --  新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
  FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A 
  LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE        B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID 
  LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
  LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
  LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
  LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
  LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
  LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
  LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
  LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
  LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
  LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
  LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
  LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
  LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
  LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
  LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
  LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER 
  LEFT JOIN ODS_IMS.TF_ODS_IMS_ISNEW_MARK ZB ON B.DELIVERY_LINE_ID = ZB.delivery_line_id
  LEFT JOIN (SELECT DISTINCT ORG_ID,CUSTOMER_CODE,MAIN_FIELD FROM ODS_IMS.ODS_CRM_DOMAIN_BASE) M ON A.ORG_ID = M.ORG_ID AND D.CUSTOMER_CODE = M.CUSTOMER_CODE  --领域表
  WHERE 
   H.ORDER_TYPE_NAME  IN('内销常规订单','内销调账销售订单','内销调账红冲订单','内销物资销售订单','内销退货订单' ,'内销物资销售退货订单','工具归还订单','工具借出订单' )
  AND G1.ORGNAME = '89_玫德雅昌(济南)2581' 
  AND TRUNC(A.EXPORT_CONFIRM_DATE,'MM') >= TO_DATE('2024/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') 
  and A.STATUS = 'C'--基础信息状态生效C
  AND A.EXPORT_CONFIRM_FLAG = 'Y'--已出库
  and to_char(A.EXPORT_CONFIRM_DATE,'yyyymm') < '202412' 
  ;



--------山东晨晖
INSERT INTO MDDWD.DWD_SALE_DLY2_TMP
(
    id
    ,period
    ,biz_date
    ,delivery_code
    ,biz_line_no
    ,order_nos
    ,order_type
    ,order_no
    ,project_name
    ,company_sale
    ,company_sn
    ,dept1_his
    ,dept2_his
    ,dept3_his
    ,dept1
    ,dept2
    ,dept3
    ,produce_company
    ,produce_company_sn
    ,product_sort1
    ,product_sort2
    ,product_sort3
    ,field
    ,mat_desc
    ,product_form
    ,texture
    ,mat_surface
    ,mat_sort
    ,mat_attr5
    ,mat_code
    ,mat_variety
    ,mat_spec
    ,currency
    ,country
    ,customer_code
    ,customer_name
    ,customer_new_name
    ,customer_code1
    ,customer_name1
    ,customer_new_name1
    ,province_name
    ,city_name
    ,salesman_his
    ,salesman
    ,salesman_id_his
    ,salesman_id
    ,manager
    ,leader
    ,isnewcus
    ,isnewprod
    ,isupsellprod
    ,measurement_unit
    ,trade_discount_type
    ,line_net_weight
    ,total_amount_outexp
    ,total_amount
    ,market_discount_amount
    ,trade_discount_amount
    ,qty_out_line
    ,total_amount_exp
    ,before_discount_amount
    ,total_quantity
    ,total_box
    ,amt_m_fact
    ,order_amount
    ,attribute12
    ,amt_m_fact_outtax
    ,qty_m_fact
    ,box_m_fact
    ,business_type
    ,status
    ,export_confirm_flag
    ,isstatus
    ,business
    ,inventory_code
    ,inventory_desc
    ,company_sale_act
    ,org_name
    ,company_sale_area
    ,new_bg
    ,etl_crt_dt
    ,etl_upd_dt
	,CUSTOMER_ID
	,INCEPT_ADDRESS_ID
    ,FULL_NAME
,product_first_mass_prod_dt	--	产品首批量产时间
,transfer_finance_dt	--	转财务日期
,new_product_end_dt	--	新产品结束时间
,FULL_NAME_SN   --库存组织名称
)
SELECT
SYS_GUID() AS ID                                                          --UUID主键
,TRUNC(A.EXPORT_CONFIRM_DATE,'MM') AS PERIOD                                          --账期期间
,A.EXPORT_CONFIRM_DATE AS BIZ_DATE                                        --业务日期
,A.DELIVERY_CODE AS DELIVERY_CODE                                         --发货单号
,B.LINE_NO AS BIZ_LINE_NO                                                 --业务单据明细行号
,REPLACE( REPLACE(A.SOURCE_NO,CHR(10),NULL),CHR(13),NULL) AS ORDER_NOS        --订单编号
,H.ORDER_TYPE_NAME AS ORDER_TYPE                                          --订单类型
,L.ORDER_NUM AS ORDER_NO                                                  --明细订单编号
,A.ATTRIBUTE21 AS PROJECT_NAME                                            --项目名称（渠道/用户/项目名称）
,'山东晨晖电子科技有限公司' AS COMPANY_SALE                                --销售公司
,'山东晨晖'   AS COMPANY_SN                                                --销售公司简称
,'山东晨晖国内营销中心'      AS DEPT1_HIS                                  --历史部门
,G4.ORGNAME                 AS DEPT2_HIS                                  --历史大区
,G3.ORGNAME                 AS DEPT3_HIS                                  --历史科室
,'山东晨晖国内营销中心'  AS DEPT1                                          --部门
,CASE WHEN G4.ORGNAME LIKE '玫德%' THEN G4.ORGNAME WHEN G3.ORGNAME='山东晨晖电表销售科' THEN '山东晨晖市场战略规划部' ELSE G4.ORGNAME END  AS DEPT2     --大区                                                   --大区
,CASE WHEN G3.ORGNAME LIKE '玫德%' THEN G3.ORGNAME ELSE G3.ORGNAME END  AS DEPT3                                                                       --科室
,REPLACE(G2.FULL_NAME,'库存组织',NULL)             AS PRODUCT_COMPANY      --生产公司（库存组织）
,'山东晨晖'             AS PRODUCT_COMPANY_SN                            --生产公司简称
,NVL(CPFL.REF07,'未归类产品') AS PRODUCT_SORT1                           --产品大类
,NVL(CPFL.REF08,'未归类产品') AS PRODUCT_SORT2                           --产品中类
,NVL(CPFL.REF09,'未归类产品') AS PRODUCT_SORT3                           --产品小类
,NULL AS FIELD                                                            --领域
,B.MATERIAL_DESCRIPTION AS MAT_DESC                                      --产品名称
,C.FORM AS PRODUCT_FORM                                                  --产品形式
,C.TEXTURE AS TEXTURE                                                    --材质分类
,C.SURFACE_TREATMENT AS MAT_SURFACE                                     --表面
,C.PRODUCT_SORT AS MAT_SORT                                             --产品分类新
,K.ATTR5_NAME AS MAT_ATTR5                                              --属性5
,B.MATERIAL_CODE AS MAT_CODE                                            --物料编号
,C.VARIETY AS MAT_VARIETY                                               --品种
,C.SPECIFICATION AS MAT_SPEC                                            --规格
,'CNY' AS CURRENCY                                                      --币种
,'中国' AS COUNTRY                                                      --国别
,D.CUSTOMER_CODE    AS CUSTOMER_CODE                                    --开单客户编号
,D.CUSTOMER_NAME    AS CUSTOMER_NAME                                    --开单客户名称
,D.CUSTOMER_NEW_NAME AS CUSTOMER_NEW_NAME                               --开单客户最新名称
,D1.CUSTOMER_CODE         AS CUSTOMER_CODE1                             --分销客户编号/最终客户
,D1.CUSTOMER_NAME         AS CUSTOMER_NAME1                             --分销客户名称/最终客户
,D1.CUSTOMER_NEW_NAME     AS CUSTOMER_NEW_NAME1                         --分销客户最终名称/最终客户
,DECODE(D.PROVINCE_ID, NULL, D.PROVINCE_NAME, E.AREA_NAME) AS PROVINCE_NAME--隶属省
,DECODE(D.CITY_ID, NULL, D.CITY_NAME, E1.AREA_NAME) AS CITY_NAME        --隶属市
,I.EMPNAME  AS SALESMAN_HIS                                              --历史业务员
,I.EMPNAME  AS SALESMAN                                                   --业务员
,EMP.USERID AS SALESMAN_ID_HIS                                          --历史业务员账号
,EMP.USERID AS SALESMAN_ID                                               --最新业务员账号
,NULL         AS MANAGER                                                  --主管
,NULL         AS LEADER                                                   --科室负责人
,NULL         AS ISNUEWCUS                                                --是否新客户
,case
    when trunc(A.export_confirm_date) >= trunc(C.splcsj) and
         trunc(C.splcsj + C.pallet_num) >=
         trunc(A.export_confirm_date) then
     '是'
    else
     '否'
end  ISNEWPROD       --2025.02.25  更新是否新产品，原字段为' '，修改人：常耀辉 
,NULL         AS ISUPSELLPROD                                             --是否老客户新产品
,J.DICTNAME AS MEASUREMENT_UNIT                                         --计量单位
,J1.DICTNAME AS TRADE_DISCOUNT_TYPE                                     --商业折扣类型
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.EXTIMATE_QTY  AS EXTIMATE_QTY--数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.AMOUNT AS TOTAL_AMOUNT_OUTEXP --合计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_AMOUNT AS TOTAL_AMOUNT--总计金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.MARKET_DISCOUNT_AMOUNT AS MARKET_DISCOUNT_AMOUNT --市场折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TRADE_DISCOUNT_AMOUNT AS TRADE_DISCOUNT_AMOUNT--商业折扣额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.QTY_OUT_LINE AS QTY_OUT_LINE  --项目差价
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_EXP_AMOUNT AS TOTAL_AMOUNT_EXP --临时：表头费用
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.BEFORE_DISCOUNT_AMOUNT AS BEFORE_DISCOUNT_AMOUNT  --临时：表头折前金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_QUANTITY AS TOTAL_QUANTITY--临时：表头总数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * A.TOTAL_BOX AS TOTAL_BOX--临时：表头总箱数
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT  AS AMT_M_FACT   -- 销售金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ORDER_AMOUNT  AS ORDER_AMOUNT   -- 订单金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.ATTRIBUTE12  AS ATTRIBUTE12   -- 费用金额汇总
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.AMOUNT/(100+NVL(REPLACE(A.IS_CUSTOMER_UNRELATED,'%',''),13))*100  AS AMT_M_FACT_OUTTAX                  --底表字段：无税金额
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_QUANTITY  AS QTY_M_FACT--底表字段：实发数量
,DECODE(H.BUSINESS_TYPE, 'A', 1, 'B', -1, 'C', 1, 0) * B.LOADING_BOX_QTY  AS BOX_M_FACT --底表字段：箱数
,H.BUSINESS_TYPE            AS BUSINESS_TYPE                            --三新类型
,A.STATUS   AS  STATUS                                                   --基础信息状态生效
,A.EXPORT_CONFIRM_FLAG   AS    EXPORT_CONFIRM_FLAG                       --发货确认标识
,case when A.STATUS = 'C' and A.EXPORT_CONFIRM_FLAG = 'Y' then '是' else '否' end AS ISSTATUS -- 是否已生效且出库
,'国内' AS BUSINESS
,NULL     AS INVENTORY_CODE                                               --仓库编码
,NULL     AS INVENTORY_DESC                                               --仓库名称
,NULL     AS COMPANY_SALE_ACT                                             --实际销售公司
,G1.ORGNAME     AS ORG_NAME                                                     --账套
,NULL     AS COMPANY_SALE_AREA                                            --销售公司大区
,NULL     AS NEW_BG                                                       --最新BG组别
,SYSDATE    AS ETL_CRT_DT                                               --创建时间
,SYSDATE    AS ETL_UPD_DT                                               --更新时间
,A.CUSTOMER_ID
,A.INCEPT_ADDRESS_ID
,G2.FULL_NAME
,C.splcsj AS product_first_mass_prod_dt	--	产品首批量产时间
,A.export_confirm_date AS transfer_finance_dt	--	转财务日期   IMS 无
,trunc(C.splcsj + C.pallet_num) AS new_product_end_dt	--	新产品结束时间    邵贤鹏提供规则
,G2.ORGNAME
FROM ODS_IMS.CRM_LG_DELIVERY_HEADER A
LEFT JOIN ODS_IMS.CRM_LG_DELIVERY_LINE  B ON A.DELIVERY_HEAD_ID=B.DELIVERY_HEAD_ID
LEFT JOIN MDDIM.TD_DIM_MATERIALS      C ON B.MATERIAL_CODE=C.MATERIAL_CODE AND C.ORG_ID=A.DELIVERY_ORG
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D ON A.CUSTOMER_ID=D.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_CUSTOMER       D1 ON A.INVOICE_CUSTOMER_ID=D1.CUSTOMER_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E ON D.PROVINCE_ID = E.AREA_ID
LEFT JOIN MDDIM.TD_DIM_AREA           E1 ON D.CITY_ID = E1.AREA_ID
LEFT JOIN MDDIM.TD_DIM_SO_ORDER_TYPE  H ON A.ORDER_TYPE_ID=H.ORDER_TYPE_ID
LEFT JOIN ODS_IMS.OM_EMPLOYEE I ON I.EMPID = A.SALES_ASSISTANT_ID
LEFT JOIN MDDIM.DIM_EMPLOYEE_D EMP ON I.EMPCODE = EMP.PERSON_CODE
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J ON A.MEASUREMENT_UNITS = J.DICTID AND J.DICTTYPEID='MEASUREMENT_UNITS'
LEFT JOIN ODS_IMS.EOS_DICT_ENTRY J1 ON A.TRADE_DISCOUNT_TYPE = J1.DICTID AND J1.DICTTYPEID='CRM_REBATE_TYPE'
LEFT JOIN ODS_IMS.CRM_SO_ORDER_HEADER L ON B.ORDER_ID=L.ORDER_ID
LEFT JOIN ODS_IMS.OM_BUSIORG G1 ON A.ORG_ID=G1.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G2 ON A.DELIVERY_ORG=G2.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G3 ON A.SALES_AREA_ID=G3.BUSIORGID
LEFT JOIN ODS_IMS.OM_BUSIORG G4 ON A.DEPT_ID = G4.BUSIORGID
LEFT JOIN MDDIM.TD_DIM_BUSINESS_ORGANIZATION M ON G1.FULL_NAME = M.FULL_NAME
LEFT JOIN (SELECT LOOKUP_CODE AS ATTR5_ID,DESCRIPTION AS ATTR5_NAME FROM ODS_IMS.FND_LOOKUP_VALUES WHERE LANGUAGE = USERENV('LANG') AND LOOKUP_TYPE = 'CUX_BOM_PRODUCT_ATTR5' AND ENABLED_FLAG='Y') K ON A.SALES_PRODUCT_TYPE_CODE = K.ATTR5_ID
LEFT JOIN MDDIM.TD_DIM_CPFL_INFO CPFL ON B.MATERIAL_CODE = CPFL.ITEM_NUMBER

WHERE H.ORDER_TYPE_NAME  IN ('内销常规订单','内销调账销售订单','内销调账红冲订单','内销退货订单','内销物资销售订单' ,'内销外协常规订单','服务销售订单','工具归还订单','工具借出订单')--订单类型，更新是否销售业绩单据
AND G1.ORGNAME = '95_山东晨晖2981' --账套，更新销售业绩账套字段-联合条件
--AND G2.ORGNAME IN ('CH1_山东晨晖1341')   --生产公司，更新销售业绩账套字段-联合条件
--AND G4.ORGNAME IN('玫德（河南）销售有限公司')
AND G3.ORGNAME <> '山东晨晖海外业务科'
AND A.EXPORT_CONFIRM_DATE >= DATE'2024-07-01' AND A.EXPORT_CONFIRM_DATE < DATE'2024-12-01'
AND A.STATUS = 'C'  --状态为生效
AND A.EXPORT_CONFIRM_FLAG = 'Y'  --发货确认标识为已出库
and A.DELIVERY_CODE <> '晨晖发货单初始-230'
;
-------晨晖1-6月


INSERT INTO MDDWD.DWD_SALE_DLY2_TMP (
    id, 
    period, 
    biz_date, 
    delivery_code, 
    biz_line_no, 
    order_nos, 
    order_type, 
    order_no, 
    project_name, 
    company_sale, 
    company_sn, 
    dept1_his, 
    dept2_his, 
    dept3_his, 
    dept1, 
    dept2, 
    dept3, 
    produce_company, 
    produce_company_sn, 
    product_sort1, 
    product_sort2, 
    product_sort3, 
    field, 
    mat_desc, 
    product_form, 
    texture, 
    mat_surface, 
    mat_sort, 
    mat_attr5, 
    mat_code, 
    mat_variety, 
    mat_spec, 
    currency, 
    country, 
    customer_code, 
    customer_name, 
    customer_new_name, 
    customer_code1, 
    customer_name1, 
    customer_new_name1, 
    province_name, 
    city_name, 
    salesman_his, 
    salesman, 
    salesman_id_his, 
    salesman_id, 
    manager, 
    leader, 
    isnewcus, 
    isnewprod, 
    isupsellprod, 
    measurement_unit, 
    trade_discount_type, 
    line_net_weight, 
    total_amount_outexp, 
    total_amount, 
    market_discount_amount, 
    trade_discount_amount, 
    qty_out_line, 
    total_amount_exp, 
    before_discount_amount, 
    total_quantity, 
    total_box, 
    amt_m_fact, 
    order_amount, 
    attribute12, 
    amt_m_fact_outtax, 
    qty_m_fact, 
    box_m_fact, 
    etl_crt_dt, 
    etl_upd_dt, 
    business_type, 
    status, 
    export_confirm_flag, 
    isstatus, 
    business, 
    inventory_code, 
    inventory_desc, 
    company_sale_act, 
    org_name, 
    company_sale_area, 
    new_bg, 
    customer_bg_ys, 
    region_name, 
    customer_id, 
    customer_bu_ys, 
    customer_bg_fh, 
    customer_bu_fh, 
    field_ys, 
    related_party_flag, 
    is_xsyj_flag,
    SALESMAN_UID,
    FULL_NAME,
    INCEPT_ADDRESS_ID
	,CORPORATE_ENTITY_NAME_SN
) 
SELECT SYS_GUID() id, 
    period, 
    biz_date, 
    delivery_code, 
    biz_line_no, 
    order_nos, 
    order_type, 
    order_no, 
    project_name, 
    company_sale, 
    company_sn, 
    dept1_his, 
    dept2_his, 
    dept3_his, 
    dept1, 
    dept2, 
    dept3, 
    produce_company, 
    produce_company_sn, 
    product_sort1, 
    product_sort2, 
    product_sort3, 
    field, 
    mat_desc, 
    product_form, 
    texture, 
    mat_surface, 
    mat_sort, 
    mat_attr5, 
    mat_code, 
    mat_variety, 
    mat_spec, 
    currency, 
    country, 
    customer_code, 
    customer_name, 
    customer_new_name, 
    customer_code1, 
    customer_name1, 
    customer_new_name1, 
    province_name, 
    city_name, 
    salesman_his, 
    salesman, 
    salesman_id_his, 
    salesman_id, 
    manager, 
    leader, 
    isnewcus, 
    isnewprod, 
    isupsellprod, 
    measurement_unit, 
    trade_discount_type, 
    line_net_weight, 
    total_amount_outexp, 
    total_amount, 
    market_discount_amount, 
    trade_discount_amount, 
    qty_out_line, 
    total_amount_exp, 
    before_discount_amount, 
    total_quantity, 
    total_box, 
    amt_m_fact, 
    order_amount, 
    attribute12, 
    amt_m_fact_outtax, 
    qty_m_fact, 
    box_m_fact, 
    etl_crt_dt, 
    etl_upd_dt, 
    business_type, 
    status, 
    export_confirm_flag, 
    isstatus, 
    business, 
    inventory_code, 
    inventory_desc, 
    company_sale_act, 
    ORG_NAME org_name, 
    company_sale_area, 
    new_bg, 
    customer_bg_ys, 
    region_name, 
    customer_id, 
    customer_bu_ys, 
    customer_bg_fh, 
    customer_bu_fh, 
    field_ys, 
    related_party_flag, 
    is_xsyj_flag,
    SALESMAN_UID,
    FULL_NAME_SN,
    INCEPT_ADDRESS_ID    --2025.3.15  增加收货地址ID，修改人：常耀辉
	,CORPORATE_ENTITY_NAME_SN   --202505016   增加新生产公司
FROM MDDWD.TF_DWD_SALE_DLY_SDCH_BAK_30;
