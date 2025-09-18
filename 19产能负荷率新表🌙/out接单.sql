

    SELECT A.PERIOD_DAY,
       A.ORDER_CODE,
       A.SALE_PLATFORM_NAME,
       A.CUSTOMER_NAME,
       A.CORPORATE_ENTITY_NAME_SN,
       SUM(A.SALES_AMOUNT_Y),
       SUM(A.SALES_WEIGHT_KG),
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
       B.CAPACITY_TYPE,
       A.SALESMAN_NAME,
       A.SALESMAN_PS_UID
 FROM dwd_SALE_REVENUE A
    LEFT JOIN(
        SELECT PRODUCE_COMPANY_NAME_SN,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
        FROM MDDWD.DWD_CNLXDZB
        GROUP BY PRODUCE_COMPANY_NAME_SN,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
    )  B
    ON A.CORPORATE_ENTITY_NAME_SN=B.PRODUCE_COMPANY_NAME_SN AND A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2 AND A.PRODUCT_SORT3=B.PRODUCT_SORT3
 where period_day >=date'2025-01-01'
 AND SALE_PLATFORM_NAME IN('国内销售平台','海外销售平台') 
  GROUP BY  A.PERIOD_DAY,
       A.ORDER_CODE,
       A.SALE_PLATFORM_NAME,
       A.CUSTOMER_NAME,
       A.CORPORATE_ENTITY_NAME_SN,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
       B.CAPACITY_TYPE,
       A.SALESMAN_NAME,
       A.SALESMAN_PS_UID
 


SELECT A.period , 
       A.ORDER_CODE,
       A.EX_IN_ORDER,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
       A.PRODUCT_SORT4,
       B.CAPACITY_TYPE,
       sum(A.WEIHT_T),
       A.CUSTOMER_NAME,
       A.ORG_NAME1,
       A.ORG_NAME2,
       A.ORG_NAME3,
       A.ORG_NAME4,
       A.ORG_NAME5,
       A.ORG_NAME6,
       A.SALESMAN_NAME,
       A.salesman_ps_uid ,
       A.is_save_order ,
       A.measurement_unit 
        FROM MDDWD.DWD_PRODUCT_ORDER A
    LEFT JOIN(
        SELECT PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
        FROM MDDWD.DWD_CNLXDZB
        GROUP BY PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
    )  B
    ON A.PRODUCT_LINE=B.PRODUCTION_LINE AND A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2 AND A.PRODUCT_SORT3=B.PRODUCT_SORT3
    WHERE A.PERIOD>=DATE'2025-01-01' 
    group by 
    A.period , 
       A.ORDER_CODE,
       A.EX_IN_ORDER,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
       A.PRODUCT_SORT4,
       B.CAPACITY_TYPE,
       A.CUSTOMER_NAME,
       A.ORG_NAME1,
       A.ORG_NAME2,
       A.ORG_NAME3,
       A.ORG_NAME4,
       A.ORG_NAME5,
       A.ORG_NAME6,
       A.SALESMAN_NAME,
       A.salesman_ps_uid ,
       A.is_save_order ,
       A.measurement_unit 
    
    
    

-----------------------------------


------------------------------------------------------------





























SELECT A.PERIOD_DAY,
          c.PRODUCTION_LINE,
       A.ORDER_CODE,
       A.PRODUCT_SPECIFICATION,
       A.PRODUCT_FORM,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
       SUM(A.DELIVERY_CNT),
       SUM(A.SALES_AMOUNT_Y),
       SUM(A.SALES_WEIGHT_KG)
       
 FROM dwd_SALE_REVENUE A
    LEFT JOIN(
        SELECT PRODUCE_COMPANY_NAME_SN,
        PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
        FROM MDDWD.DWD_CNLXDZB
        GROUP BY PRODUCE_COMPANY_NAME_SN,
        PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
    )  B
    ON A.CORPORATE_ENTITY_NAME_SN=B.PRODUCE_COMPANY_NAME_SN AND A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2 AND A.PRODUCT_SORT3=B.PRODUCT_SORT3 
    left join(
        SELECT distinct
            production_line,
            produce_company_name_sn
        FROM mddwd.dwd_cnlxdzb
    
    )c on C.produce_company_name_sn=a.CORPORATE_ENTITY_NAME_SN
    
 where period_day >=date'2025-01-01' AND B.CAPACITY_TYPE IS NULL
 AND SALE_PLATFORM_NAME IN('国内销售平台','海外销售平台') 
 and c.PRODUCTION_LINE is not null
  GROUP BY   A.PERIOD_DAY,
            c.PRODUCTION_LINE,
       A.ORDER_CODE,
       A.PRODUCT_SPECIFICATION,
       A.PRODUCT_FORM,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3
 



 ------------------------------------
 SELECT A.period , 
       c.production_line,
       A.PRODUCT_LINE,
       A.ORDER_CODE,
       a.ITEM_CATE as 品种,
       a. ITEM_SPEC as 规格,
       a.ITEM_STYLE as 形式,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,
      -- B.CAPACITY_TYPE,
       sum(A.WEIHT_T)
        FROM MDDWD.DWD_PRODUCT_ORDER A
    LEFT JOIN(
        SELECT PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
        FROM MDDWD.DWD_CNLXDZB
        GROUP BY PRODUCTION_LINE,
            PRODUCT_SORT1,
            PRODUCT_SORT2,
            PRODUCT_SORT3,
            CAPACITY_TYPE
    )  B
    ON CASE WHEN A.PRODUCT_LINE = '母公司' THEN '玛钢制造部' ELSE A.PRODUCT_LINE END =B.PRODUCTION_LINE AND A.PRODUCT_SORT1=B.PRODUCT_SORT1
    AND A.PRODUCT_SORT2=B.PRODUCT_SORT2 AND A.PRODUCT_SORT3=B.PRODUCT_SORT3
        left join(
        SELECT distinct
            production_line,
            produce_company_name_sn
        FROM mddwd.dwd_cnlxdzb
    
    )c on C.PRODUCTION_LINE=CASE WHEN A.PRODUCT_LINE = '母公司' THEN '玛钢制造部' ELSE A.PRODUCT_LINE END
    WHERE A.PERIOD>=DATE'2025-01-01'  and  b.capacity_type is null 
    and c.PRODUCTION_LINE is not null
    group by 
    A.period , 
    c.production_line,
       A.ORDER_CODE,
       a.ITEM_CATE,
       a. ITEM_SPEC,
       a.ITEM_STYLE,
       A.PRODUCT_LINE,
       A.PRODUCT_SORT1,
       A.PRODUCT_SORT2,
       A.PRODUCT_SORT3,



       