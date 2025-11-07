--包装入库明细表
TRUNCATE TABLE MDDWD.DWD_PACK_INWARE;
INSERT INTO MDDWD.DWD_PACK_INWARE
(
    PERIOD
    ,SHIP_DT
    ,ORDER_CODE
    ,PRODUCTION_LINE
    ,FACTORY_NAME
    ,YIELD_TYPE
    ,WAREHOUSE_CODE
    ,WAREHOUSE_NAME
    ,INWARE_ORG
    ,OUTWARE_ORG
    ,GETWARE_ORG
    ,CUSTOMER_NAME
    ,KHXSH
    ,PRODUCT_VARIETY
    ,PRODUCT_SPECIFICATION
    ,PRODUCT_FORM
    ,PRODUCT_TEXTURE
    ,SURFACE_TREATMENT
	,ERP_CODE  --ERP编码
    ,PCS
    ,KHJS
    ,UNIT_WEIGHT
    ,WEIGHT
    ,INPUTMAN
    ,ORIGIN_SYSTEM
    ,ETL_CRT_DT
    ,ETL_UPD_DT
	,update_dt
)
--ERP2012
SELECT  TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,SCX
        ,CB
        ,CLLX
        ,NULL AS CKBM
        ,NULL AS CKMC
        ,RKDW
        ,ZCDW
        ,LQDW
        ,KHM
        ,KHXSH
        ,PZ
        ,GG
        ,XS
        ,CZFL
        ,BMCL
		,NULL AS ERP_CODE
        ,JS
        ,KHJS
        ,DZ
        ,NVL(KHJS * DZ, 0) AS ZL
        ,LRY
        ,'ERP2012' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_JNMD.BZRKB

UNION ALL

--泰钢
SELECT  YYZ_TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,SCX
        ,CB
        ,CLLX
        ,NULL AS CKBM
        ,NULL AS CKMC
        ,RKDW
        ,ZCDW
        ,LQDW
        ,KHM
        ,KHXSH
        ,PZ
        ,GG
        ,XS
        ,CZFL
        ,BMCL
		,NULL AS ERP_CODE
        ,JS
        ,KHJS
        ,DZ
        ,NVL(KHJS * DZ, 0) AS ZL
        ,LRY
        ,'TGERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP.ODS_BZRKB_TG

UNION ALL

--鹤壁
SELECT  TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,SCX
        ,CB
        ,CLLX
        ,NULL AS CKBM
        ,NULL AS CKMC
        ,RKDW
        ,ZCDW
        ,LQDW
        ,KHM
        ,KHXSH
        ,PZ
        ,GG
        ,XS
        ,CZFL
        ,BMCL
		,NULL AS ERP_CODE
        ,JS
        ,KHJS
        ,DZ
        ,NVL(KHJS * DZ, 0) AS ZL
        ,LRY
        ,'HBERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP.ODS_BZRKB_YCYW

UNION ALL

--德庆
SELECT  TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,SCX
        ,CB
        ,CLLX
        ,NULL AS CKBM
        ,NULL AS CKMC
        ,RKDW
        ,ZCDW
        ,LQDW
        ,KHM
        ,KHXSH
        ,PZ
        ,GG
        ,XS
        ,CZFL
        ,BMCL
		,NULL AS ERP_CODE
        ,JS
        ,KHJS
        ,DZ
        ,NVL(KHJS * DZ, 0) AS ZL
        ,LRY
        ,'DQERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP2013.ODS_BZRKB

UNION ALL

--庚辰
SELECT  TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,NULL AS SCX
        ,NULL AS CB
        ,NULL AS CLLX
        ,CKBM
        ,CKMC
        ,RKDW
        ,ZCDW
        ,NULL AS LQDW
        ,KHM
        ,NULL AS KHXSH
        ,PZ
        ,GG
        ,XS
        ,NULL AS CZFL
        ,NULL AS BMCL
		,NULL AS ERP_CODE
        ,NULL AS JS
        ,NULL AS KHJS
        ,NULL AS DZ
        ,NVL(ZL, 0) AS ZL
        ,LRY
        ,'GCERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP2013.ODS_TPC_BZRKB

UNION ALL

--晨晖
SELECT  TO_DATE(BZRKB_CH.RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(BZRKB_CH.JHQ, 'YY.MM.DD') AS SHIP_DT
        ,BZRKB_CH.DDH
        ,BZRKB_CH.SCX
        ,BZRKB_CH.CB
        ,BZRKB_CH.CLLX
        ,NULL AS CKBM
        ,NULL AS CKMC
        ,BZRKB_CH.RKDW
        ,BZRKB_CH.ZCDW
        ,BZRKB_CH.LQDW
        ,BZRKB_CH.KHM
        ,BZRKB_CH.KHXSH
        ,BZRKB_CH.PZ
        ,BZRKB_CH.GG
        ,BZRKB_CH.XS
        ,BZRKB_CH.CZFL
        ,BZRKB_CH.BMCL
		,INV_CH.JDBM
        ,BZRKB_CH.JS
        ,BZRKB_CH.KHJS
        ,BZRKB_CH.DZ
        ,NVL(BZRKB_CH.KHJS * BZRKB_CH.DZ, 0) AS ZL
        ,BZRKB_CH.LRY
        ,'CHERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP.ODS_BZRKB_CH  BZRKB_CH
left join ods_erp.ods_invitem_ch	INV_CH
on BZRKB_CH.xs||' '||BZRKB_CH.czfl||' '||BZRKB_CH.gg||' '||BZRKB_CH.pz||' '||BZRKB_CH.bmcl =INV_CH.ITEMNO

UNION ALL

--威海
SELECT  TO_DATE(RQ, 'YY.MM.DD') AS PERIDO
        ,TO_DATE(JHQ, 'YY.MM.DD') AS SHIP_DT
        ,DDH
        ,NULL AS SCX
        ,NULL AS CB
        ,NULL AS CLLX
        ,CKBM
        ,CKMC
        ,RKDW
        ,ZCDW
        ,NULL AS LQDW
        ,KHM
        ,NULL AS KHXSH
        ,PZ
        ,GG
        ,XS
        ,NULL AS CZFL
        ,NULL AS BMCL
		,NULL AS ERP_CODE
        ,NULL AS JS
        ,NULL AS KHJS
        ,NULL AS DZ
        ,NVL(ZL, 0) AS ZL
        ,LRY
        ,'WHERP' AS ORIGIN_SYSTEM
        ,SYSDATE AS ETL_CRT_DT
        ,SYSDATE AS ETL_UPD_DT
        ,gxsj
FROM    ODS_ERP.ODS_TPC_BZRKB_WH
;
COMMIT;