
 SELECT * FROM CRM_SO_ORDER_HEADER    DIM  ORG_ID DELIVERY_ORG   STATUS  DELIVERY_REQUEST  ORDER_TYPE_ID   IS_INTERNATIONAL_TRADE
 
 SELECT * FROM ODS_CRM_LG_DELIVERY_PLAN
 
 SELECT * FROM 
 
 
 
 SELECT * FROM mddim.dim_org_d where SOURCE_SYS='IMS' and ORG_NAME like'%泰钢管配件%'
 SELECT distinct DELIVERY_ORG FROM CRM_SO_ORDER_HEADER 


SELECT 
    a.org_id
    ,b.org_name  
FROM CRM_SO_ORDER_HEADER A 
--left join mddim.dim_org_d b on a.org_id=b.org_id
where 
    a.org_id in(19,20,97) --得一  卓睿  香港
    AND A.DELIVERY_ORG =1112--68_泰钢管配件2402
    AND A.STATUS=             --订单状态
    AND A.DELIVERY_REQUEST=   --发货状态？
    AND A.ORDER_TYPE_ID=      --订单类型
    AND A.IS_INTERNATIONAL_TRADE='Y' --外销
    


