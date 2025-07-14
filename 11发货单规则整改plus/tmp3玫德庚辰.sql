




-----------------------------------------------玫德庚辰 -----------------------------------------------
INSERT INTO   DWD_SALE_DLY_TMP1 
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



--------------------------------------------------------------------------------------
INSERT INTO   DWD_SALE_DLY_TMP1 
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

         and  to_char(A.EXPORT_CONFIRM_DATE,'yyyyMM')  < '202412' ;

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


-------------------------------------2025.4.16新增账套   修改人：常耀辉

--------------------------------------------------------------------------------------
INSERT INTO   DWD_SALE_DLY_TMP1 
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
,R.FULL_NAME_SN   --库存组织名称
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
          G1.ORGNAME IN ('105_玫德铸管(临沂)3621')
          AND C.FORM IN ('40G','43G','44G','46G','Q0J','Q2J','Q3J','Q4J')    --已经在是否计入国内销售业绩处进行判断
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

update DWD_SALE_DLY_TMP1  set dept1 = '玫德威海销售',dept2 = '玫德威海销售',dept3 = '玫德庚辰烟威区' where PRODUCE_COMPANY_SN = '玫德庚辰' and SALESMAN in ('边东升','张志超') and PERIOD >= TO_DATE('2024/01/01 00:00:00', 'YYYY-MM-DD HH24:MI:SS');

