DELETE FROM ADS_SALE_PRODUCT
WHERE
    PERIOD_M = ADD_MONTHS (TRUNC (SYSDATE -1, 'MM'), -1);

WITH
    ADS_SALTGT_NEWM AS ()
INSERT INTO
    ADS_SALE_PRODUCT (
        PERIOD_M,
        ORG_NAME1,
        CORPORATE_ENTITY_NAME_SN,
        SALES_PRODUCT_TYPE,
        WEIGHT_M_ACC_ACTUAL_T,
        WEIGHT_M_ACC_QB_TARGET_T,
        WEIGHT_M_ACC_TZ_TARGET_T,
        WEIGHT_M_ACC_SAMEP_T,
        ETL_CRT_DT,
        ETL_UPD_DT,
        ORDER_WGT_KG,
        ORDER_WGT_SAMEP_KG
    )
SELECT
    ADD_MONTHS (TRUNC (SYSDATE -1, 'MM'), -1) AS PERIOD_M,
    平台 AS ORG_NAME1,
    nvl (
        b.PRODUCT_COMPANY_FULL_NAME,
        产线
    ) CORPORATE_ENTITY_NAME_SN,
    产品系列 AS SALES_PRODUCT_TYPE,
    SUM(发货月累计实际完成) AS WEIGHT_M_ACC_ACTUAL_T,
    SUM(确保目标) AS WEIGHT_M_ACC_QB_TARGET_T,
    SUM(挑战目标) AS WEIGHT_M_ACC_TZ_TARGET_T,
    SUM(同比发货值) AS WEIGHT_M_ACC_SAMEP_T,
    SYSDATE AS ETL_CRT_DT,
    SYSDATE AS ETL_UPD_DT,
    SUM(接单重量) AS 接单重量,
    sum(同比接单重量) as 同比接单重量
FROM (
        SELECT
            MARKET_TYPE 平台, PRODUCE_COMPANY_NAME_SN 产线, NVL (
                SALES_PRODUCT_TYPE, PRODUCT_SORT_H
            ) 产品系列, MACC_COMPLETION 发货月累计实际完成, MACC_TGT 确保目标, 0 AS 挑战目标, YOY_MACC_VAL 同比发货值, 0 接单重量, 0 同比接单重量
        FROM ADS_SALTGT_M
        WHERE
            YPERIOD = ADD_MONTHS (TRUNC (SYSDATE -1, 'MM'), -1)
            AND OPS_TYPE = '发货'
            AND INDEX_TYPE = '重量'
            AND SALES_TARGET_TYPE = '确保目标'
        UNION ALL
        SELECT
            MARKET_TYPE 平台, PRODUCE_COMPANY_NAME_SN 产线, NVL (
                SALES_PRODUCT_TYPE, PRODUCT_SORT_H
            ) 产品系列, 0 发货月累计实际完成, 0 确保目标, MACC_TGT AS 挑战目标, 0 同比发货值, 0 接单重量, 0 同比接单重量
        FROM ADS_SALTGT_M
        WHERE
            YPERIOD = ADD_MONTHS (TRUNC (SYSDATE -1, 'MM'), -1)
            AND OPS_TYPE = '发货'
            AND INDEX_TYPE = '重量'
            AND SALES_TARGET_TYPE = '挑战目标'
        UNION ALL
        SELECT
            MARKET_TYPE 平台, PRODUCE_COMPANY_NAME_SN 产线, NVL (
                SALES_PRODUCT_TYPE, PRODUCT_SORT_H
            ) 产品系列, M_COMPLETION 发货月累计实际完成, M_TGT 确保目标, 0 AS 挑战目标, YOY_M_VAL 同比发货值, 0 接单重量, 0 同比接单重量
        FROM ADS_SALTGT_d
        WHERE
            OPS_TYPE = '发货'
            AND INDEX_TYPE = '重量'
            AND SALES_TARGET_TYPE = '确保目标'
        UNION ALL
        SELECT
            MARKET_TYPE 平台, PRODUCE_COMPANY_NAME_SN 产线, NVL (
                SALES_PRODUCT_TYPE, PRODUCT_SORT_H
            ) 产品系列, 0 发货月累计实际完成, 0 确保目标, M_TGT AS 挑战目标, 0 同比发货值, 0 接单重量, 0 同比接单重量
        FROM ADS_SALTGT_d
        WHERE
            OPS_TYPE = '发货'
            AND INDEX_TYPE = '重量'
            AND SALES_TARGET_TYPE = '挑战目标'
    ) a
    left join MDDIM.DIM_INVENTORY_PRODUCT_MAPPING b on a.产线 = b.INVENTORY_ORG_SN
GROUP BY
    平台,
    nvl (
        b.PRODUCT_COMPANY_FULL_NAME,
        产线
    ),
    产品系列;

DELETE FROM ADS_SALE_PRODUCT
where
    ORG_NAME1 NOT in('国内销售平台', '海外销售平台', '工业&电力BG')
    OR ORG_NAME1 IS NULL;

DELETE FROM ADS_SALE_PRODUCT
where
    WEIGHT_M_ACC_ACTUAL_T + weight_m_acc_qb_target_t + weight_m_acc_tz_target_t + weight_m_acc_samep_t = 0;