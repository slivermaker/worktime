CREATE TABLE ads_mkfm_prodution_sum (
    period DATE,
    work_org_name VARCHAR2(2000),
    now_inventory_last NUMBER,
    non_planned_inventory_last NUMBER,
    now_inventory NUMBER,
    non_planned_inventory NUMBER,
    self_produced_piece_count NUMBER,
    self_produced_weight_t NUMBER,
    purchased_piece_count NUMBER,
    purchased_weight_t NUMBER,
    self_produced_piece_m NUMBER,
    self_produced_m_t NUMBER,
    purchased_piece_m NUMBER,
    purchased_m_t NUMBER,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ads_mkfm_prodution_sum IS 'MKFM生产汇总表';

COMMENT ON COLUMN ads_mkfm_prodution_sum.period IS '日期';
COMMENT ON COLUMN ads_mkfm_prodution_sum.work_org_name IS '工作组';
COMMENT ON COLUMN ads_mkfm_prodution_sum.now_inventory_last IS '上月今结存';
COMMENT ON COLUMN ads_mkfm_prodution_sum.non_planned_inventory_last IS '上月计外存';
COMMENT ON COLUMN ads_mkfm_prodution_sum.now_inventory IS '今结存';
COMMENT ON COLUMN ads_mkfm_prodution_sum.non_planned_inventory IS '计外存';
COMMENT ON COLUMN ads_mkfm_prodution_sum.self_produced_piece_count IS '日自产件数';
COMMENT ON COLUMN ads_mkfm_prodution_sum.self_produced_weight_t IS '日自产重量（吨）';
COMMENT ON COLUMN ads_mkfm_prodution_sum.purchased_piece_count IS '日外购件数';
COMMENT ON COLUMN ads_mkfm_prodution_sum.purchased_weight_t IS '日外购重量（吨）';
COMMENT ON COLUMN ads_mkfm_prodution_sum.self_produced_piece_m IS '自产件数汇总';
COMMENT ON COLUMN ads_mkfm_prodution_sum.self_produced_m_t IS '月自产重量汇总（吨）';
COMMENT ON COLUMN ads_mkfm_prodution_sum.purchased_piece_m IS '月外购件数汇总';
COMMENT ON COLUMN ads_mkfm_prodution_sum.purchased_m_t IS '月外购重量汇总（吨）';
COMMENT ON COLUMN ads_mkfm_prodution_sum.etl_crt_dt IS 'ETL创建日期';
COMMENT ON COLUMN ads_mkfm_prodution_sum.etl_upd_dt IS 'ETL更新日期';