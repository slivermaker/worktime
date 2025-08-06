CREATE TABLE MDADS.ADS_XSCKSJ(
    DDH VARCHAR2(4000),--订单号
    FHDH VARCHAR2(4000),--发货单号
    DDLX VARCHAR(4000),--订单类型
    FHDSXSJ DATE,--发货单生效时间
    KHMC VARCHAR2(4000),--客户名称
    zzkh VARCHAR2(4000),--最终客户
    KHFL VARCHAR2(4000),--客户分类
    WLBN VARCHAR(4000),--物料编码

    SL NUMBER ,--数量
    XSJE NUMBER,--金额
    BM VARCHAR2(4000),--部门
    CYFS VARCHAR2(4000),--运输方式
    YWY VARCHAR2(4000),--业务员
    QY VARCHAR2(4000)--区域
    ETL_CRT_DT DATE ,
    ETL_UPD_DT DATE
)


TRUNCATE TABLE MDADS.ADS_XSCKSJ;

INSRT INTO  MDADS.ADS_XSCKSJ(
    DDH ,--订单号
    FHDH ,--发货单号
    DDLX ,--订单类型
    FHDSXSJ DATE,--发货单生效时间
    KHMC ,--客户名称
    zzkh ,--最终客户
    KHFL ,--客户分类
    WLBN ,--物料编码
    SL  ,--数量
    XSJE ,--金额
    BM ,--部门
    CYFS ,--运输方式
    YWY ,--业务员
    QY --区域
    ETL_CRT_DT  ,
    ETL_UPD_DT 
)

SELECT 
    DDH ,--订单号
    FHDH ,--发货单号
    DDLX ,--订单类型
    FHDSXSJ DATE,--发货单生效时间
    KHMC ,--客户名称
    zzkh ,--最终客户
    KHFL ,--客户分类
    WLBN ,--物料编码

    SL  ,--数量
    XSJE ,--金额
    BM ,--部门
    CYFS ,--运输方式
    YWY ,--业务员
    QY --区域
    ETL_CRT_DT  ,
    SYSDATE 
FROM
ODS_ERP2013.ODS_XSCKSJ