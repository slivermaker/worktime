TRUNCATE TABLE MDADS.ADS_KEY_PRODUCTION_CAPACITY;
INSERT INTO MDADS.ADS_KEY_PRODUCTION_CAPACITY 
(
    PERIOD ,                             -- 日期
    PRODUCTION_NAME ,           -- 生产线
    CAPACITY_TYPE ,            -- 产能类型
    MONTHLY_CAPACITY ,                 -- 月产能
    MIN_CAPACITY_RATE ,        -- 最低产能负荷率
    MEASUREMENT_NAME ,         -- 计量单位
    WEIGHT_M_SHIP_T, --重量月度发货_吨
    WEIGHT_M_SHIP_T_LAST, --重量上月发货_吨
    WEIGHT_M_SHIP_T_SAMEP, --重量同期发货_吨
    WEIGHT_M_SHIP_TAR_T, --重量月度目标_吨
    WEIGHT_M_TARGET_T, -- 重量月度目标_吨_不含储备
    WEIGHT_M_ACTUAL_T, -- 重量月度实际_吨_不含储备
    WEIGHT_LAST_M_ACTUAL_T, -- 重量上月实际_吨_不含储备
    WEIGHT_M_SAMEP_T, -- 重量本月同期_吨_不含储备
    WEIGHT_M_TARGET_T_ALL, -- 重量月度目标_吨_含储备
    WEIGHT_M_ACTUAL_T_ALL, -- 重量月度实际_吨_含储备
    WEIGHT_LAST_M_ACTUAL_T_ALL, -- 重量上月实际_吨_含储备
    WEIGHT_M_SAMEP_T_ALL, -- 重量本月同期_吨_含储备
    ACC_CAPACITY, -- 累计产能
    ACC_FINISH, -- 累计完成
    ACC_FINISH_SAMEP, -- 累计同期产能
    IS_KEY_FOCUS , -- 是否重点关注
    ETL_CRT_DT , -- ETL创建时间 
    ETL_UPD_DT    -- ETL更新时间
    ,WEIGHT_M_ACTUAL_T_INTER_UNSAVE--国内重量月度实际_吨_非储备
    ,WEIGHT_M_ACTUAL_T_OVER_UNSAVE--海外重量月度实际_吨_非储备
    ,WEIGHT_M_ACTUAL_T_INTER_SAVE--国内重量月度实际_吨_储备
    ,WEIGHT_M_ACTUAL_T_OVER_SAVE--海外重量月度实际_吨_储备
)
SELECT
    PERIOD, -- 日期
    PRODUCTION_NAME, -- 生产线
    CAPACITY_TYPE, -- 产能类型
    MIN(MONTHLY_CAPACITY), -- 月产能
    MIN(MIN_CAPACITY_RATE), -- 最低产能负荷率
    MIN(MEASUREMENT_NAME), -- 计量单位
    SUM(WEIGHT_M_SHIP_T), -- 重量月度发货_吨
    SUM(WEIGHT_M_SHIP_T_LAST), -- 重量上月发货_吨
    SUM(WEIGHT_M_SHIP_T_SAMEP), -- 重量同期发货_吨
    SUM(WEIGHT_M_SHIP_TAR_T), -- 重量月度目标_吨
    SUM(WEIGHT_M_TARGET_T), -- 重量月度目标_吨_不含储备
    SUM(WEIGHT_M_ACTUAL_T), -- 重量月度实际_吨_不含储备
    SUM(WEIGHT_LAST_M_ACTUAL_T), -- 重量上月实际_吨_不含储备
    SUM(WEIGHT_M_SAMEP_T), -- 重量本月同期_吨_不含储备
    SUM(WEIGHT_M_TARGET_T_ALL), -- 重量月度目标_吨_含储备
    SUM(WEIGHT_M_ACTUAL_T_ALL), -- 重量月度实际_吨_含储备
    SUM(WEIGHT_LAST_M_ACTUAL_T_ALL), -- 重量上月实际_吨_含储备
    SUM(WEIGHT_M_SAMEP_T_ALL), -- 重量本月同期_吨_含储备
    SUM(ACC_CAPACITY), -- 累计产能
    SUM(ACC_FINISH), -- 累计完成
    SUM(ACC_FINISH_SAMEP), -- 累计同期产能
    MAX(IS_KEY_FOCUS), -- 是否重点关注
    SYSDATE ETL_CRT_DT, -- ETL创建时间
    SYSDATE ETL_UPD_DT -- ETL更新时间
    ,SUM(WEIGHT_M_ACTUAL_T_INTER_UNSAVE)--国内重量月度实际_吨_非储备
    ,SUM(WEIGHT_M_ACTUAL_T_OVER_UNSAVE)--海外重量月度实际_吨_非储备
    ,SUM(WEIGHT_M_ACTUAL_T_INTER_SAVE)--国内重量月度实际_吨_储备
    ,SUM(WEIGHT_M_ACTUAL_T_OVER_SAVE)--海外重量月度实际_吨_储备
FROM (
    -- 生产订单业绩数据
    SELECT
        TRUNC(a.PERIOD, 'mm') PERIOD, -- 日期
        A.PRODUCT_LINE AS PRODUCTION_NAME, -- 生产线
        a.CAPACITY_TYPE, -- 产能类型
        C.MONTHLY_CAPACITY, -- 月产能
        C.MIN_CAPACITY_RATE, -- 最低产能负荷率
        C.UNIT AS MEASUREMENT_NAME, -- 计量单位
        0 WEIGHT_M_SHIP_T, -- 重量月度发货_吨
        0 WEIGHT_M_SHIP_T_LAST, -- 重量上月发货_吨
        0 WEIGHT_M_SHIP_T_SAMEP, -- 重量同期发货_吨
        0 WEIGHT_M_SHIP_TAR_T, -- 重量月度目标_吨
        A.WEIGHT_M_TARGET_T, -- 重量月度目标_吨_不含储备
        A.WEIGHT_M_ACTUAL_T_UNSAVE AS WEIGHT_M_ACTUAL_T, -- 重量月度实际_吨_不含储备
        A.WEIGHT_LM_ACTUAL_T_UNSAVE AS WEIGHT_LAST_M_ACTUAL_T, -- 重量上月实际_吨_不含储备
        A.WEIGHT_SAMEP_M_TARGET_T AS WEIGHT_M_SAMEP_T, -- 重量本月同期_吨_不含储备
        A.WEIGHT_M_TARGET_T AS WEIGHT_M_TARGET_T_ALL, -- 重量月度目标_吨_含储备
        A.WEIGHT_M_ACTUAL_T_SAVE + A.WEIGHT_M_ACTUAL_T_UNSAVE AS WEIGHT_M_ACTUAL_T_ALL, -- 重量月度实际_吨_含储备
        A.WEIGHT_LM_ACTUAL_T_SAVE + A.WEIGHT_LM_ACTUAL_T_UNSAVE AS WEIGHT_LAST_M_ACTUAL_T_ALL, -- 重量上月实际_吨_含储备
        A.WEIGHT_SAMEP_M_ACTUAL_T_SAVE + A.WEIGHT_SAMEP_M_ACTUAL_T_UNSAVE AS WEIGHT_M_SAMEP_T_ALL, -- 重量本月同期_吨_含储备
        C.MONTHLY_CAPACITY * EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -1)) ACC_CAPACITY, -- 累计产能
        A.WEIGHT_M_ACC_ACTUAL_T_UNSAVE ACC_FINISH, -- 累计完成
        A.WEIGHT_SAMEP_MACC_ACT_T_UNSAVE ACC_FINISH_SAMEP, -- 累计同期产能
        CASE
            WHEN (A.WEIGHT_M_ACC_ACTUAL_T_UNSAVE < (C.MIN_CAPACITY_T * EXTRACT(MONTH FROM ADD_MONTHS(SYSDATE, -1))))
            OR (A.WEIGHT_LM_ACTUAL_T_UNSAVE < C.MIN_CAPACITY_T AND A.WEIGHT_LSM_ACTUAL_T_UNSAVE < C.MIN_CAPACITY_T) 
            THEN '是'
            ELSE '否'
        END AS IS_KEY_FOCUS -- 是否重点关注
        ,SUM(CASE WHEN ORG_NAME1 = '国内销售平台' THEN A.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS WEIGHT_M_ACTUAL_T_INTER_UNSAVE  --国内重量月度实际_吨_非储备
        ,SUM(CASE WHEN ORG_NAME1 = '海外销售平台' THEN A.WEIGHT_M_ACTUAL_T_UNSAVE ELSE 0 END) AS WEIGHT_M_ACTUAL_T_OVER_UNSAVE  --海外重量月度实际_吨_非储备
        ,SUM(CASE WHEN ORG_NAME1 = '国内销售平台' THEN A.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS WEIGHT_M_ACTUAL_T_INTER_SAVE  --国内重量月度实际_吨_储备
        ,SUM(CASE WHEN ORG_NAME1 = '海外销售平台' THEN A.WEIGHT_M_ACTUAL_T_SAVE ELSE 0 END) AS WEIGHT_M_ACTUAL_T_OVER_SAVE  --海外重量月度实际_吨_储备
    FROM MDDWS.DWS_PRODUCT_ORDER_REVENUE A
    LEFT JOIN MDDWD.DWD_CNJCB C 
        ON A.PRODUCT_LINE = C.PRODUCTION_LINE
        AND a.CAPACITY_TYPE = C.CAPACITY_TYPE
    WHERE   A.ORG_NAME1 IN ('国内销售平台','海外销售平台')
    
    UNION ALL
    
    -- 销售业绩数据
    SELECT
        TRUNC(PERIOD, 'mm') PERIOD,
        a.PRODUCTION_LINE AS PRODUCTION_NAME,
        CAPACITY_TYPE,
        NULL MONTHLY_CAPACITY, 
        NULL MIN_CAPACITY_RATE,
        NULL MEASUREMENT_NAME,
        WEIGHT_M_ACTUAL_T AS WEIGHT_M_SHIP_T,
        WEIGHT_LAST_M_ACTUAL_T AS WEIGHT_M_SHIP_T_LAST,
        WEIGHT_M_SAMEP_T AS WEIGHT_M_SHIP_T_SAMEP,
        WEIGHT_M_TARGET_T AS WEIGHT_M_SHIP_TAR_T,
        0 WEIGHT_M_TARGET_T,
        0 WEIGHT_M_ACTUAL_T,
        0 WEIGHT_LAST_M_ACTUAL_T,
        0 WEIGHT_M_SAMEP_T,
        0 WEIGHT_M_TARGET_T_ALL,
        0 WEIGHT_M_ACTUAL_T_ALL,
        0 WEIGHT_LAST_M_ACTUAL_T_ALL,
        0 WEIGHT_M_SAMEP_T_ALL,
        0 ACC_CAPACITY,
        0 ACC_FINISH,
        0 ACC_FINISH_SAMEP,
        NULL IS_KEY_FOCUS
        ,0 AS WEIGHT_M_ACTUAL_T_INTER_UNSAVE--国内重量月度实际_吨_非储备
        ,0 AS WEIGHT_M_ACTUAL_T_OVER_UNSAVE--海外重量月度实际_吨_非储备
        ,0 AS WEIGHT_M_ACTUAL_T_INTER_SAVE--国内重量月度实际_吨_储备
        ,0 AS WEIGHT_M_ACTUAL_T_OVER_SAVE--海外重量月度实际_吨_储备
    FROM (
        SELECT
            CASE
                WHEN CORPORATE_ENTITY_NAME_SN = '母公司' THEN '玛钢制造部'
                WHEN CORPORATE_ENTITY_NAME_SN = '玫德临沂' THEN '球铁制造部'
                ELSE CORPORATE_ENTITY_NAME_SN
            END AS PRODUCTION_LINE, 
            product_sort1, 
            product_sort2, 
            product_sort3, 
            WEIGHT_M_ACTUAL_T, 
            WEIGHT_LAST_M_ACTUAL_T, 
            WEIGHT_M_SAMEP_T, 
            WEIGHT_M_TARGET_T, 
            PERIOD
        FROM ADS_SALE_revenue ASR
        WHERE
            ASR.SALE_PLATFORM_NAME IN ('国内销售平台', '海外销售平台')
            AND TO_CHAR(PERIOD, 'yyyy') > '2024'
            AND (ASR.IS_MONTH = '是' OR ASR.IS_DAY = '是')
            AND SALES_TARGET_TYPE = '挑战目标'
            AND WEIGHT_M_ACTUAL_T + WEIGHT_M_target_T + WEIGHT_M_SAMEP_T <> 0
    ) a
    LEFT JOIN (
        SELECT DISTINCT
            PRODUCTION_LINE, 
            PRODUCT_SORT1, 
            PRODUCT_SORT2, 
            PRODUCT_SORT3, 
            MAX(CAPACITY_TYPE) CAPACITY_TYPE
        FROM MDDWD.DWD_CNLXDZB
        GROUP BY
            PRODUCTION_LINE, 
            PRODUCT_SORT1, 
            PRODUCT_SORT2, 
            PRODUCT_SORT3
    ) B 
        ON A.PRODUCTION_LINE = B.PRODUCTION_LINE
        AND A.PRODUCT_SORT1 = B.PRODUCT_SORT1
        AND A.PRODUCT_SORT2 = B.PRODUCT_SORT2
        AND A.PRODUCT_SORT3 = B.PRODUCT_SORT3
) a
GROUP BY
    PERIOD,
    PRODUCTION_NAME,
    CAPACITY_TYPE