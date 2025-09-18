CREATE TABLE ODS_CRM_LG_DELIVERY_BOOKING
(
  D_BOOKING_ID NUMBER,
  DELIVERY_HEAD_ID NUMBER,
  BOOKING_NO VARCHAR2(2000),
  VERSION_NO VARCHAR2(2000),
  STATUS VARCHAR2(2000),
  BOOKING_DATE DATE,
  CONSUMER_COUNTRY VARCHAR2(2000),
  CONSUMER_AREA VARCHAR2(2000),
  DEPOT_ID VARCHAR2(2000),
  VOY VARCHAR2(2000),
  BILL_NO VARCHAR2(2000),
  MASTER_BILL_NO VARCHAR2(2000),
  AMS_NO VARCHAR2(2000),
  SCAC_NO VARCHAR2(2000),
  CONSOLIDATOR VARCHAR2(2000),
  PLAN_ARRIVAL_DATE DATE,
  FREE_BOX_DAYS NUMBER,
  FREE_STORAGE_DAYS NUMBER,
  FORWARDER_ID NUMBER,
  PLAN_SHIP_DATE DATE,
  LATEST_DELIVERY_DATE DATE,
  ALL_SHIPPED VARCHAR2(2000),
  TRANSED_ENTRUST VARCHAR2(2000),
  RETRANSE_ENTRUST VARCHAR2(2000),
  AIR_OR_EXPRESS VARCHAR2(2000),
  AWB VARCHAR2(2000),
  REMARK VARCHAR2(2000),
  CREATED_BY NUMBER,
  CREATION_DATE DATE,
  LAST_UPDATE_BY NUMBER,
  LAST_UPDATE_DATE DATE,
  ATTRIBUTE1 VARCHAR2(2000),
  ATTRIBUTE2 VARCHAR2(2000),
  ATTRIBUTE3 VARCHAR2(2000),
  ATTRIBUTE4 VARCHAR2(2000),
  ATTRIBUTE5 VARCHAR2(2000),
  ATTRIBUTE6 VARCHAR2(2000),
  ATTRIBUTE7 VARCHAR2(2000),
  ATTRIBUTE8 VARCHAR2(2000),
  ATTRIBUTE9 VARCHAR2(2000),
  ATTRIBUTE10 VARCHAR2(2000),
  EXPRESS_COMPANY VARCHAR2(2000),
  END_ORDER_DATE DATE,
  END_PORT_DATE DATE,
  EXPECTED_SHIP_DATE DATE,
  ATTRIBUTE11 VARCHAR2(2000),
  ATTRIBUTE12 VARCHAR2(2000),
  ATTRIBUTE13 VARCHAR2(2000),
  ATTRIBUTE14 VARCHAR2(2000),
  ATTRIBUTE15 VARCHAR2(2000),
  ATTRIBUTE16 VARCHAR2(2000),
  ATTRIBUTE17 VARCHAR2(2000),
  ATTRIBUTE18 VARCHAR2(2000),
  ATTRIBUTE19 VARCHAR2(2000),
  ATTRIBUTE20 VARCHAR2(2000),
  ETL_CRT_DT DATE DEFAULT SYSDATE,
  ETL_UPD_DT DATE DEFAULT SYSDATE
);






delivery_head_id
trans_entity_id
customer_id
send_district_id
incept_district_id
price_term_id
route_id
purpose_port_id
container_type
link_man
link_tel
incept_address_id
address_link_man
address_link_tel
currency_code
require_delivery_time
real_delivery_time
dept_id
confirm_flag
remark
created_by
creation_date
last_updated_by
last_update_date
org_id
delivery_code
trans_type
source_type
source_no
standard_freight
improve_freight
link_man_name
address_link_man_name
customer_receive_flag
export_warehouses_id
order_type_id
carrier_id
real_confirm_date
customer_date
export_location_id
receive_inventory_id
receive_location_id
product_org_id
delivery_org
sales_area_id
is_in_transit
is_receive_inventory
is_customer_unrelated
receipt_flag
receipt_date
freight_approval_flag
transport_type
export_confirm_flag
inv_location_type
receive_location_type
receive_by
is_print_lock
print_count
last_print_by
reject_inform_id
red_order_id
source_id
reject_inform_code
red_order_code
source_carrier_id
source_carrier_code
incept_address
customer_address
customer_store_id
counter_inch
contact_tel
contact_name
delivery_type
marked
cust_doc_ctm_info_id
delivery_note
status
delivery_status
commit_date
cust_payment_method_id
cust_payment_method
pre_settlement_days
pre_bill_ratio
amount
sales_assistant_code
cust_sales_code
net_weight
doc_gross_weight
act_gross_weight
container20_qty
container40_qty
delivery_size
delivery_tray
extimate_qty
plan_case_qty
exchange_date
exchange_rate
usd_exchange_rate
expected_date
epidemic_flag
doc_remarks
valuation_type
invoice_customer_id
invoice_customer_add_id
price_list_id
area_manager
contract_id
total_box
total_quantity
apportion_net_weight
province
city
county
vehicle_info_id
vehicle_brand
chauffeur
chauffeur_identity
chauffeur_tel
freight_term
freight_cal_mode
transport_mode
freight_unit_price
auto_freight
designated_freight
total_freight
fee_batch_id
assign_flag
assign_date
assign_by
accept_flag
accept_date
accept_by
close_date
close_by
cancel_date
cancel_by
invoice_flag
product_category
service_name
measurement_units
quantity_illustration
amount_illustration
coalition_delivery_no
ship_sequence
ship_sequence_flag
product_type
packing_order_flag
erp_flag
distance
sales_product_type_code
market_discount_rate
market_discount_amount
trade_discount_rate
trade_discount_amount
before_discount_amount
arrived_flag
arrived_date
arrived_by
freight_subsidy_flag
arrears_begin_date
customer_receive_by
customer_receive_date
created_inv_ex_order_flag
export_confirm_date
allow_flag
total_exp_amount
demand_id
demand_code
inv_type
customs_type
pre_prod_tt_ratio
pre_prod_lc_ratio
pre_ship_tt_ratio
pre_ship_lc_ratio
delivery_request
print_type
sales_assistant_id
customer_receive_qty
trade_discount_type
import_erp_status
failure_reason
erp_created_inv_ex_order_flag
erp_created_inv_ex_order_msg
market_rate_enable_flag
trade_rate_enable_flag
transport_method
price_list_name
total_amount
dz_customer_id
attribute1
attribute2
attribute3
attribute4
attribute5
attribute6
attribute7
attribute8
attribute9
attribute10
express_company
express_code
no_booking_flag
erp_if_flag
contains
mixed_box_qty
effect_date
effect_by
invoice_type
invoice_remark
invoice_illustration
amount_mode
print_inventory_id
doc_net_weight
transport_category
pln_arrive_date
check_flag
form
insurance_amount_usd
sea_amount_usd
check_flag1
sync_erp_return_status
sync_erp_return_date
bulk_carrier
receive_remark
retranse_entrust
invoice_date
del_order_num
red_flag
orig_delivery_head_id
destiny_country
depa_port_id_rt
dest_port_id_rt
total_amount1
invoice_mode_1
product_name
invoice_unit
invoice_remarks
invoice_explain
country
invoice_mode_2
virtual_delivery
project_price_diff
attribute11
attribute12
attribute13
attribute14
attribute15
price_relations
price_relations_trs
attribute16
attribute17
attribute18
attribute19
attribute20
attribute21
attribute22
attribute23
attribute24
attribute25
attribute26
src_last_update_tm
etl_upd_dt
etl_crt_dt
