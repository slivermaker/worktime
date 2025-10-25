CREATE TABLE DIM_GROUP_TO_TYPE_TG (
    ID NUMBER,
    BZDW VARCHAR2(2000),
    RKCZ VARCHAR2(2000),
    LRY VARCHAR2(2000),
    GXSJ DATE,
    ETL_CRT_DT DATE DEFAULT SYSDATE,
    ETL_UPD_DT DATE DEFAULT SYSDATE
);

COMMENT ON TABLE DIM_GROUP_TO_TYPE_TG IS '泰钢单位与入库材质映射表';

COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.ID IS '序号';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.BZDW IS '包装单位';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.RKCZ IS '入库材质';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.LRY IS '录入员';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.GXSJ IS '更新时间';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.ETL_CRT_DT IS 'ETL创建日期';
COMMENT ON COLUMN DIM_GROUP_TO_TYPE_TG.ETL_UPD_DT IS 'ETL更新日期';


INSERT INTO DIM_GROUP_TO_TYPE_TG (
    ID,
    BZDW,
    RKCZ,
    LRY,
    GXSJ,
    ETL_CRT_DT,
    ETL_UPD_DT
)





        crm_lg_delivery_header       dh, --发货申请单头
       crm_lg_delivery_pack_details dpd, --发货申请装箱明细
       /*    crm_pub_pack_list_details    pld, --装箱单明细
       crm_pub_pack_list_details    pld1, --装箱单明细
       crm_pub_pack_list_headers    plh, --装箱单头*/
       (select pld.pack_list_id,
               pld.order_line_id,
               pld.material_id,
               pld.pack_details_id,
               pld.Product_Weight,
               pld.Case_Qty,
               pld.Plan_Qty,
               pld.tray_code,
               plh.pack_list_code,

               cd.warehouses_flag,
               cd.loading_flag,
               pld.case_num
          from crm_pub_pack_list_details pld, crm_pub_pack_list_headers plh,
               crm_lg_container_details cd
         where pld.pack_list_id = plh.pack_list_id
          and  pld.pack_list_id=cd.pack_list_id
          and  pld.tray_code=cd.tray_code       ) pack_list,

       crm_so_order_header so, --订单头：
       crm_so_order_line sol, --订单行：
       crm_so_order_line sol1, --订单行：
       crm_lg_delivery_line cl,
       Crm_Inv_Inventory ci,
       crm_ctm_customer cc, --客户
       crm_pub_materials pm, --物料
       (SELECT EDE.DICTID, EDE.DICTNAME
          FROM EOS_DICT_ENTRY EDE
         WHERE EDE.DICTTYPEID = 'deliveryStatus') t,
       crm_so_order_other_info csoi