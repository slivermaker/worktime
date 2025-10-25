CREATE TABLE ODS_V_DECTION_QH_BOARD (
    spectral_date        VARCHAR2(2000),
    spectral_num         VARCHAR2(2000),
    furnace_num          VARCHAR2(2000),
    iron_weight          VARCHAR2(2000),
    tapping_tem          VARCHAR2(2000),
    pack_tem             VARCHAR2(2000),
    c_hl                 NUMBER,
    si_hl                NUMBER,
    mn_hl                NUMBER,
    p_hl                 NUMBER,
    s_hl                 NUMBER,
    cr_hl                NUMBER,
    mo_hl                NUMBER,
    ni_hl                NUMBER,
    v_hl                 NUMBER,
    al_hl                NUMBER,
    cu_hl                NUMBER,
    ti_hl                NUMBER,
    sn_hl                NUMBER,
    pb_hl                NUMBER,
    mg_hl                NUMBER,
    ce_hl                NUMBER,
    spectral_time        VARCHAR2(2000),
    remark               VARCHAR2(2000),
    etl_crt_dt           DATE DEFAULT SYSDATE,
    etl_upd_dt           DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ods_v_dection_qh_board IS '铸管看板-浇筑-化学成分表';

COMMENT ON COLUMN ods_v_dection_qh_board.spectral_date IS 'spectral_date';
COMMENT ON COLUMN ods_v_dection_qh_board.spectral_num IS 'spectral_num';
COMMENT ON COLUMN ods_v_dection_qh_board.furnace_num IS '炉号';
COMMENT ON COLUMN ods_v_dection_qh_board.iron_weight IS 'iron_weight';
COMMENT ON COLUMN ods_v_dection_qh_board.tapping_tem IS 'tapping_tem';
COMMENT ON COLUMN ods_v_dection_qh_board.pack_tem IS 'pack_tem';
COMMENT ON COLUMN ods_v_dection_qh_board.c_hl IS 'C(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.si_hl IS 'Si(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.mn_hl IS 'Mn(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.p_hl IS 'p(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.s_hl IS 'S(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.cr_hl IS 'Cr(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.mo_hl IS 'Mo(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.ni_hl IS 'Ni(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.v_hl IS 'V(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.al_hl IS 'Al(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.cu_hl IS 'Cu(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.ti_hl IS 'Ti(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.sn_hl IS 'Sn(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.pb_hl IS 'Pb(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.mg_hl IS 'Mg(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.ce_hl IS 'Ce(%)';
COMMENT ON COLUMN ods_v_dection_qh_board.spectral_time IS 'spectral_time';
COMMENT ON COLUMN ods_v_dection_qh_board.remark IS '备注';
COMMENT ON COLUMN ods_v_dection_qh_board.etl_crt_dt IS 'etl_crt_dt';
COMMENT ON COLUMN ods_v_dection_qh_board.etl_upd_dt IS 'etl_upd_dt';