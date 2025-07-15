--DWD 山东晨晖销售目标达成
--插入表名需改成正式环境表
INSERT INTO MDDWD.DWD_SALE_DLY_TMP1
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
WHERE PERIOD < DATE'2024-7-1'