-------管道

INSERT INTO
    DWD_SALE_DLY_TMP1 (
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
;

update DWD_SALE_DLY_TMP1
set
    PROVINCE_NAME = '山东省'
    -- CITY_NAME = '济南市'
where
    CUSTOMER_NAME = '济南港华燃气有限公司（失效）';

update DWD_SALE_DLY_TMP1
set
    CITY_NAME = '济南市'
where
    CUSTOMER_NAME = '济南港华燃气有限公司（失效）';

commit;

--更新管道产品大类 --邱治钧 、生旭辉-2025-5-13
UPDATE DWD_SALE_DLY_TMP1
SET
    PRODUCT_SORT1 = '装配式管道解决方案',
    PRODUCT_SORT2 = 'BIM深化设计服务',
    PRODUCT_SORT3 = 'BIM深化设计服务'
WHERE
    PRODUCT_SORT1 = '消防管道预制及工程'
    AND COMPANY_SN = '迈科管道';