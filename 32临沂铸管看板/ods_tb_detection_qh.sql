CREATE TABLE ODS_TB_DETECTION_QH (
    id NUMBER,
    factory_code NUMBER,
    furnace_num VARCHAR2(2000),
    melt_num VARCHAR2(2000),
    qual CHAR(1),
    mark VARCHAR2(2000),
    caliber VARCHAR2(2000),
    c_hl NUMBER,
    si_hl NUMBER,
    mn_hl NUMBER,
    p_hl NUMBER,
    s_hl NUMBER,
    mg_hl NUMBER,
    al_hl NUMBER,
    cr_hl NUMBER,
    cu_hl NUMBER,
    mo_hl NUMBER,
    ni_hl NUMBER,
    sn_hl NUMBER,
    ti_hl NUMBER,
    v_hl NUMBER,
    b_class VARCHAR2(2000),
    remark VARCHAR2(2000),
    create_time DATE,
    etl_crt_dt DATE DEFAULT SYSDATE,
    etl_upd_dt DATE DEFAULT SYSDATE
);

COMMENT ON TABLE ods_tb_detection_qh IS '临沂铸管看板化学成分检验记录';

COMMENT ON COLUMN ods_tb_detection_qh.id IS '业务主键ID';
COMMENT ON COLUMN ods_tb_detection_qh.factory_code IS '车间';
COMMENT ON COLUMN ods_tb_detection_qh.furnace_num IS '炉号';
COMMENT ON COLUMN ods_tb_detection_qh.melt_num IS '炉次号';
COMMENT ON COLUMN ods_tb_detection_qh.qual IS '是否合格';
COMMENT ON COLUMN ods_tb_detection_qh.mark IS '牌号';
COMMENT ON COLUMN ods_tb_detection_qh.caliber IS '口径';
COMMENT ON COLUMN ods_tb_detection_qh.c_hl IS 'C(%)';
COMMENT ON COLUMN ods_tb_detection_qh.si_hl IS 'Si(%)';
COMMENT ON COLUMN ods_tb_detection_qh.mn_hl IS 'Mn(%)';
COMMENT ON COLUMN ods_tb_detection_qh.p_hl IS 'p(%)';
COMMENT ON COLUMN ods_tb_detection_qh.s_hl IS 'S(%)';
COMMENT ON COLUMN ods_tb_detection_qh.mg_hl IS 'Mg(%)';
COMMENT ON COLUMN ods_tb_detection_qh.al_hl IS 'Al(%)';
COMMENT ON COLUMN ods_tb_detection_qh.cr_hl IS 'Cr(%)';
COMMENT ON COLUMN ods_tb_detection_qh.cu_hl IS 'Cu(%)';
COMMENT ON COLUMN ods_tb_detection_qh.mo_hl IS 'Mo(%)';
COMMENT ON COLUMN ods_tb_detection_qh.ni_hl IS 'Ni(%)';
COMMENT ON COLUMN ods_tb_detection_qh.sn_hl IS 'Sn(%)';
COMMENT ON COLUMN ods_tb_detection_qh.ti_hl IS 'Ti(%)';
COMMENT ON COLUMN ods_tb_detection_qh.v_hl IS 'V(%)';
COMMENT ON COLUMN ods_tb_detection_qh.b_class IS '班别';
COMMENT ON COLUMN ods_tb_detection_qh.remark IS '备注';
COMMENT ON COLUMN ods_tb_detection_qh.create_time IS '创建时间';
COMMENT ON COLUMN ods_tb_detection_qh.etl_crt_dt IS '';
COMMENT ON COLUMN ods_tb_detection_qh.etl_upd_dt IS '';



