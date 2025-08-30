ads_panorama_analysis


period --时间
province -- 客户所属省  
city -- 客户所属市  
bu -- BU  
bg  --bg
product_sort1 -- 产品大类  
product_sort2 -- 产品中类  
sales_total_last_amount -- 去年销售合计（万元）  
sales_total_last_weight_T -- 去年销售量合计（吨）  
customer_name -- 客户名称
cooperation_status -- 与我司合作状态


customer_level  --客户等级

follower--跟进人
 follower_org  --跟进人组织
 brand--品牌
contact_info  --联系人信息
customer_type  --客户类型
customer_address  --客户地址
registered_capital--注册资本


CREATE TABLE ads_panorama_analysis (
    period DATE,
    province VARCHAR2(2000),
    city VARCHAR2(2000),
    bu VARCHAR2(2000),
    bg VARCHAR2(2000),
    product_sort1 VARCHAR2(2000),
    product_sort2 VARCHAR2(2000),
    sales_total_last_amount NUMBER,
    sales_total_last_weight_T NUMBER,
    customer_name VARCHAR2(2000),
    cooperation_status VARCHAR2(2000),
    customer_level VARCHAR2(2000),
    follower VARCHAR2(2000),
    follower_org VARCHAR2(2000),
    brand VARCHAR2(2000),
    contact_info VARCHAR2(2000),
    customer_type VARCHAR2(2000),
    customer_address VARCHAR2(2000),
    registered_capital NUMBER,
    etl_crt_dt DATE,
    etl_upd_dt DATE
);

COMMENT ON TABLE ads_panorama_analysis IS '全景分析表';

COMMENT ON COLUMN ads_panorama_analysis.period IS '时间';
COMMENT ON COLUMN ads_panorama_analysis.province IS '客户所属省';
COMMENT ON COLUMN ads_panorama_analysis.city IS '客户所属市';
COMMENT ON COLUMN ads_panorama_analysis.bu IS 'BU';
COMMENT ON COLUMN ads_panorama_analysis.bg IS 'bg';
COMMENT ON COLUMN ads_panorama_analysis.product_sort1 IS '产品大类';
COMMENT ON COLUMN ads_panorama_analysis.product_sort2 IS '产品中类';
COMMENT ON COLUMN ads_panorama_analysis.sales_total_last_amount IS '去年销售合计（万元）';
COMMENT ON COLUMN ads_panorama_analysis.sales_total_last_weight_T IS '去年销售量合计（吨）';
COMMENT ON COLUMN ads_panorama_analysis.customer_name IS '客户名称';
COMMENT ON COLUMN ads_panorama_analysis.cooperation_status IS '与我司合作状态';
COMMENT ON COLUMN ads_panorama_analysis.customer_level IS '客户等级';
COMMENT ON COLUMN ads_panorama_analysis.follower IS '跟进人';
COMMENT ON COLUMN ads_panorama_analysis.follower_org IS '跟进人组织';
COMMENT ON COLUMN ads_panorama_analysis.brand IS '品牌';
COMMENT ON COLUMN ads_panorama_analysis.contact_info IS '联系人信息';
COMMENT ON COLUMN ads_panorama_analysis.customer_type IS '客户类型';
COMMENT ON COLUMN ads_panorama_analysis.customer_address IS '客户地址';
COMMENT ON COLUMN ads_panorama_analysis.registered_capital IS '注册资本';
COMMENT ON COLUMN ads_panorama_analysis.etl_crt_dt IS 'ETL创建时间';
COMMENT ON COLUMN ads_panorama_analysis.etl_upd_dt IS 'ETL更新时间';