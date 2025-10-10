CREATE TABLE ODS_YJCLJCK (
    ID NUMBER,
    FRX VARCHAR2(2000),
    ZRR VARCHAR2(2000),
    CPLB VARCHAR2(2000),
    JLDW VARCHAR2(2000),
    NCL22 VARCHAR2(2000),
    NCL23 VARCHAR2(2000),
    NCL24 VARCHAR2(2000),
    NCL25 VARCHAR2(2000),
    NYJ3 VARCHAR2(2000),
    NYJ24 VARCHAR2(2000),
    NYJ25 VARCHAR2(2000),
    LRY VARCHAR2(2000),
    GXSJ DATE,
    ETL_CRT_DT DATE DEFAULT SYSDATE,
    ETL_UPD_DT DATE DEFAULT SYSDATE
);

-- 添加表注释
COMMENT ON TABLE ODS_YJCLJCK IS '产能负荷率年度基础库表';

-- 添加字段注释
COMMENT ON COLUMN ODS_YJCLJCK.ID IS '序号';
COMMENT ON COLUMN ODS_YJCLJCK.FRX IS '生产线';
COMMENT ON COLUMN ODS_YJCLJCK.ZRR IS '责任人';
COMMENT ON COLUMN ODS_YJCLJCK.CPLB IS '产能类型';
COMMENT ON COLUMN ODS_YJCLJCK.JLDW IS '计量单位';
COMMENT ON COLUMN ODS_YJCLJCK.NCL22 IS '2022年产量';
COMMENT ON COLUMN ODS_YJCLJCK.NCL23 IS '2023年产量';
COMMENT ON COLUMN ODS_YJCLJCK.NCL24 IS '2024年产量';
COMMENT ON COLUMN ODS_YJCLJCK.NCL25 IS '2025年月累计产量';
COMMENT ON COLUMN ODS_YJCLJCK.NYJ3 IS '三年月均产量';
COMMENT ON COLUMN ODS_YJCLJCK.NYJ24 IS '2024年月均产量';
COMMENT ON COLUMN ODS_YJCLJCK.NYJ25 IS '2025年月均产量';
COMMENT ON COLUMN ODS_YJCLJCK.LRY IS '录入员';
COMMENT ON COLUMN ODS_YJCLJCK.GXSJ IS '更新时间';
COMMENT ON COLUMN ODS_YJCLJCK.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN ODS_YJCLJCK.ETL_UPD_DT IS 'ETL更新日期';






内销物资销售退货订单
内销调账红冲订单
固定资产销售订单
利息收入订单
来料加工订单
加工收入退货订单
出口固定资产销售订单
内销大宗贸易物资销售订单
内销回收废旧物资退货订单
服务销售订单-主营收入调整
内销物资销售免费订单
服务销售订单
内销加工劳务费用
内销新产品订单
研发样品订单
出口新产品样品
多口岸新产品样品
工具归还订单
服务销售退货订单-标书费
固定资产退货订单
玛钢钢管退货订单
内销退货订单
内销废旧物资退货订单
内销物资销售订单
赠送销售
外销订单
出口订单
出口储备
出口样品
出口退货
内销订单
内销计划
内销样品
内销退货
内销补货
多口岸订单
多口岸计划
多口岸样品
多口岸退货
多口岸补货
测试
内销发货调整订单
内销补货订单
内销废旧物资销售订单
内销免费销售订单
内销免费样品订单
内销常规订单
内销收费样品订单
内销调拨订单
内销常规红冲订单
内销新产品样品X
多口岸储备
内销订单X
内销储备X
内销样品X
内销退货X
加工费用订单
索赔费用订单
出口客户询价单
外销加工劳务费用
生产出口储备订单
内销外协常规订单
内销外协退货订单
服务销售退货订单
利息收入退货订单
多口岸价格套算订单
租赁收入订单
租赁收入退货订单
多口岸客户询价单
加工收入订单
服务销售订单-标书费
售后退货订单
售后维修订单
泰钢代垫费用红冲订单
泰钢代垫费用订单
内销回收废旧物资销售订单
服务销售退货订单-主营收入调整
内销免费样品退货订单
内销配套订单
出口采购物资
多口岸采购物资
内销采购物资X
玛钢钢管常规订单
内销常规订单 
内销调账销售订单
价格套算订单
代管仓调拨订单
工具借出订单
测试
泰钢加工收入订单
内销大宗贸易物资销售退货订单




