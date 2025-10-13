with tmpdwd as (
     SELECT 
            PERIOD_DAY AS PERIOD,
            SALES_WEIGHT_KG,
            ORDER_CODE,
            CASE WHEN   CUSTOMER_COUNTRY='泰国' THEN 0 else  1 end as is_export_sale
     
     FROM DWD_SALE_REVENUE where CORPORATE_ENTITY_NAME_SN ='泰钢管配件' 
)
select * from  tmpdwd