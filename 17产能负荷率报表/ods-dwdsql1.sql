TRUNCATE TABLE "MDDWD"."DWD_CNJCB";

INSERT INTO "MDDWD"."DWD_CNJCB"(
    id
    ,production_line
    ,factory
    ,capacity_type
    ,working_days
    ,monthly_capacity
    ,unit
    ,min_capacity_rate
    ,min_capacity_t
    ,capacity_responsible
    ,created_by
    ,update_time
    ,etl_create_date
    ,etl_update_date

)SELECT (
    id
    , scx
    , cq
    , cnlx
    , scts
    , ycn
    , jldw
    , zdcnfhl
    , zdcndw
    , cnzrr
    , lry
    , gxsj
    , etl_crt_dt
    , etl_upt_dt
)
FROM "ODS_ERP"."ODS_CNJCB"




TRUNCATE TABLE "MDDWD"."DWD_CNLXDZB";
INSERT INTO "MDDWD"."DWD_CNLXDZB"(
    id
    ,production_line
    ,product_category
    ,product_subcategory
    ,product_type
    ,product_line
    ,capacity_type
    ,start_date
    ,end_date
    ,created_by
    ,update_time
    ,etl_create_date
    ,etl_update_date

)
SELECT(
      id
    , scx
    , cpdl
    , cpzl
    , cpxl
    , pl
    , cnlx
    , ksrq
    , jzrq
    , lry
    , gxsj
    ,etl_crt_dt
    ,etl_upd_dt
)
FROM "ERP_ODS"."DWD_CNLXDZB"