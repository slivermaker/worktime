
INSERT INTO ADS_WEIGHT_PIECE_RANK_BIKB (
    GROUP_ID,
    TOTAL_CNT,
    TOTAL_WEIGHT,
    CNT_RANK_DESC,
    CNT_RANK_ASC,
    WEIGHT_RANK_DESC,
    WEIGHT_RANK_ASC
)

LatestMonthData AS (
    SELECT 
        period,
        group_id,
        cnt,
        UNIT_WEIGHT,
        cnt * UNIT_WEIGHT as total_weight
    FROM MDDWD.dwd_weight_piece_bikb
    WHERE TRUNC(period, 'MM') >=TRUNC(SYSADTE-1,MM)
),
sum_wp AS (
    SELECT
        group_id,
        SUM(cnt) AS total_cnt,
        SUM(cnt * UNIT_WEIGHT) AS total_weight
    FROM LatestMonthData
    GROUP BY group_id
)
SELECT
    group_id,
    total_cnt,
    total_weight,
    -- 件数正排名（从高到低）
    RANK() OVER (ORDER BY total_cnt DESC) AS cnt_rank_desc,
    -- 件数倒排名（从低到高）
    RANK() OVER (ORDER BY total_cnt ASC) AS cnt_rank_asc,
    -- 重量正排名（从高到低）
    RANK() OVER (ORDER BY total_weight DESC) AS weight_rank_desc,
    -- 重量倒排名（从低到高）
    RANK() OVER (ORDER BY total_weight ASC) AS weight_rank_asc
FROM sum_wp
WHERE group_id IS NOT NULL
ORDER BY total_cnt DESC;