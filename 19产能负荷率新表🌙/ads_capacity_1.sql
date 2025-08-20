-- 创建表
CREATE TABLE ads_capacity_1 (
    PERIOD DATE,
    produce_company_name_sn VARCHAR2(2000),
    production_line VARCHAR2(2000),
    capacity_type VARCHAR2(2000),
    working_days NUMBER,
    year_capacity NUMBER,
    unit VARCHAR2(2000),
    in_sale_begin NUMBER,
    over_sale_begin NUMBER,
    in_sale_mid NUMBER,
    over_sale_mid NUMBER,
    ETL_CRT_DT DATE,
    ETL_UPD_DT DATE
);

-- 添加表注释
COMMENT ON TABLE ads_capacity_1 IS '年度目标和产能对比表';

-- 添加列注释
COMMENT ON COLUMN ads_capacity_1.PERIOD IS '日期';
COMMENT ON COLUMN ads_capacity_1.produce_company_name_sn IS '生产公司';
COMMENT ON COLUMN ads_capacity_1.production_line IS '生产线';
COMMENT ON COLUMN ads_capacity_1.capacity_type IS '产能类型';
COMMENT ON COLUMN ads_capacity_1.working_days IS '月生产天数';
COMMENT ON COLUMN ads_capacity_1.year_capacity IS '年产能';
COMMENT ON COLUMN ads_capacity_1.unit IS '计量单位';
COMMENT ON COLUMN ads_capacity_1.in_sale_begin IS '国内年初销量目标';
COMMENT ON COLUMN ads_capacity_1.over_sale_begin IS '海外年初销量目标';
COMMENT ON COLUMN ads_capacity_1.in_sale_mid IS '国内年中销量目标';
COMMENT ON COLUMN ads_capacity_1.over_sale_mid IS '海外年中销量目标';
COMMENT ON COLUMN ads_capacity_1.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN ads_capacity_1.ETL_UPD_DT IS 'ETL更新日期';