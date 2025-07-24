-- 创建年度计划与产能对比表
CREATE TABLE "MDADS"."ADS_YEARLY_PLAN_VS_CAP" 
(
    "PERIOD" DATE,                             -- 日期
    "PRODUCTION_NAME" VARCHAR2(2000),           -- 生产线
    "FACTORY_NAME" VARCHAR2(2000),              -- 厂区名称
    "CAPACITY_TYPE" VARCHAR2(2000),             -- 产能类型
    "MONTHLY_WORKING_DAYS" NUMBER,             -- 月生产天数
    "MONTHLY_CAPACITY" NUMBER,                 -- 月产能
    "YEAR_CAPACITY" NUMBER,                    -- 年产能
    "MEASUREMENT_NAME" VARCHAR2(2000),           -- 计量单位
    "SALE_TAR_INTER" NUMBER,                  -- 国内销量目标_吨
    "SALE_TAR_OVER" NUMBER,                   -- 国外销量目标_吨
    "ORDER_QTY_INTER" NUMBER,                  -- 月累计国内接单量
    "ORDER_QTY_OVER" NUMBER,                   -- 月累计国外接单量
    "ORDER_QTY_INTER_LAST" NUMBER,             -- 去年同期月累计国内接单量
    "ORDER_QTY_OVER_LAST" NUMBER,              -- 去年同期月累计国外接单量
    "ORDER_QTY_INTER_SUM_LAST" NUMBER,         -- 去年国内接单量
    "ORDER_QTY_OVER_SUM_LAST" NUMBER,          -- 去年海外接单量
    "IS_MEET_STANDARD" VARCHAR2(2000),           -- 是否达标
    "ETL_CRT_DT" DATE DEFAULT SYSDATE,    -- ETL创建时间
    "ETL_UPD_DT" DATE DEFAULT SYSDATE    -- ETL更新时间
) 
TABLESPACE "MDADS_DAT";

-- 添加表注释
COMMENT ON TABLE "MDADS"."ADS_YEARLY_PLAN_VS_CAP" IS '年度计划与产能对比表';

-- 添加字段注释
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."PERIOD" IS '日期';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."PRODUCTION_NAME" IS '生产线';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."FACTORY_NAME" IS '厂区名称';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."CAPACITY_TYPE" IS '产能类型';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."MONTHLY_WORKING_DAYS" IS '月生产天数';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."MONTHLY_CAPACITY" IS '月产能';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."YEAR_CAPACITY" IS '年产能';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."MEASUREMENT_NAME" IS '计量单位';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."SALE_TAR_INTER" IS '国内销量目标_吨';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."SALE_TAR_OVER" IS '国外销量目标_吨';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_INTER" IS '月累计国内接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_OVER" IS '月累计国外接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_INTER_LAST" IS '去年同期月累计国内接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_OVER_LAST" IS '去年同期月累计国外接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_INTER_SUM_LAST" IS '去年国内接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ORDER_QTY_OVER_SUM_LAST" IS '去年海外接单量';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."IS_MEET_STANDARD" IS '是否达标';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ETL_CRT_DT" IS 'ETL创建时间';
COMMENT ON COLUMN "MDADS"."ADS_YEARLY_PLAN_VS_CAP"."ETL_UPD_DT" IS 'ETL更新时间';



INSERT INTO ADS_YEARLY_PLAN_VS_CAP(
    PERIOD ,                             -- 日期
    PRODUCTION_NAME ,           -- 生产线
    FACTORY_NAME ,              -- 厂区名称
    CAPACITY_TYPE ,             -- 产能类型
    MONTHLY_WORKING_DAYS ,             -- 月生产天数
    MONTHLY_CAPACITY ,                 -- 月产能
    YEAR_CAPACITY ,                    -- 年产能
    MEASUREMENT_NAME ,           -- 计量单位
    SALE_TAR_INTER ,                  -- 国内销量目标_吨
    SALE_TAR_OVER ,                   -- 国外销量目标_吨
    ORDER_QTY_INTER ,                  -- 月累计国内接单量
    ORDER_QTY_OVER ,                   -- 月累计国外接单量
    ORDER_QTY_INTER_LAST ,             -- 去年同期月累计国内接单量
    ORDER_QTY_OVER_LAST ,              -- 去年同期月累计国外接单量
    ORDER_QTY_INTER_SUM_LAST ,         -- 去年国内接单量
    ORDER_QTY_OVER_SUM_LAST ,          -- 去年海外接单量
    IS_MEET_STANDARD ,           -- 是否达标
    ETL_CRT_DT ,
    ETL_UPD_DT 

)
SELECT(

)
FROM  MDDWD.DWD_SALES_TARGET A
    LEFT JOIN MDDWD.DWD_CNJCB B ON 




