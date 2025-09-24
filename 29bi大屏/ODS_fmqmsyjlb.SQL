
select rq 日期,dw 单位,dygh 打压工号,dygxm 打压工姓名
,ddh 订单号,pz 品种,gg 规格,xs 形式,czfl 材质,bmcl 表面,
dyjs 打压件数,ktsyhgjs 壳体试验合格件数,ktsyhgl 壳体试验合格率
,ktsybhgyy 壳体不合格原因,dysyhgjs 低压试验合格件数,
dysyhgl 低压试验合格率,dysybhgyy 低压试验不合格原因
,dynjbzz 低压扭矩标准值,dyscnjz1 低压实测扭矩值1,dyscnjz2 低压实测扭矩值2,
gysyhgjs 高压试验合格件数,gysyhgl 高压试验合格率
,gysybhgyy 高压试验不合格原因,gynjbzz 高压扭矩标准值,gyscnjz 高压实测扭矩值
,gysyhgjs/dyjs AS 一次打压合格率,lry 录入员,gxsj 更新时间
from fmqmsyjlb  