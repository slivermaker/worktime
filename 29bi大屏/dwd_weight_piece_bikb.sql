INSERT INTO DWD_WEIGHT_PIECE_BIKB (
    KBID,
    PERIOD,
    GROUP_ID,
    ORDER_ID,
    PRODUCT_VARIETY,
    PRODUCT_FORM,
    PRODUCT_SPECIFICATION,
    PRODUCT_TEXTURE,
    SURFACE_TREATMENT,
    PROCESS_STEP,
    UPDATE_TIME,
    CNT,
    UNIT_WEIGHT
)
SELECT 
    kbid,
    to_date(a.rq,'YY.MM.DD') as period,
    a.zh as group_id,
    a.ddh as order_id,
    a.pz as PRODUCT_VARIETY,
    a.gg as PRODUCT_FORM,
    a.xs as PRODUCT_SPECIFICATION,
    a.czfl as PRODUCT_TEXTURE,
    a.bmcl as SURFACE_TREATMENT,
    a.gb as process_step,
    --max(a.gxsj) as update_time,
    A.GXSJ,
    js as cnt,
    b.nwgt as unit_weight
FROM ods_erp.ods_fmzpmxb a
LEFT JOIN ods_erp.ods_invitem b
    ON a.pz = b.type2
    AND a.gg = b.type3
    AND a.xs = b.type4
    AND a.czfl = b.czfl
    AND a.bmcl = b.bmcl
WHERE a.gb IN ('成套','质检') and a.dw='蝶阀止回阀装配线'
