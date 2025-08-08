存储过程 proc_fun_fmdpyq1_2 的来源表及关键字段分析
1. 主要来源表
(1) qtkblsbzj 表 (主数据表)
​关键字段:

th - 台号/车间编号
jhscrq - 计划生产日期
scrq - 实际生产日期
pz - 品种
gg - 规格
xs - 形式
sfwc - 是否完成标志(T/F)
hxbj - 核销标记
gxsj - 更新时间
bs - 标识/公司代码(与参数p_bs关联)
(2) jgjtdeb 表 (工时定额表)
​关键字段:

jtlx - 机型类型
pz - 品种
gg - 规格
bhxs - 包含形式
de - 定额工时
ksrq - 开始日期
jzrq - 截止日期
bs - 标识/公司代码
(3) jgjtsl 表 (机型数量表)
​关键字段:

scxh - 生产线号(与qtkblsbzj.th关联)
jtlx - 机型类型(与jgjtdeb.jtlx关联)
bs - 标识/公司代码


TRANS_ODS_XSCNDCTJB
TRANS_ODS_JGJTSL
TRANS_ODS_JGJTDEB
TRANS_ODS_QTKBLSBZJ