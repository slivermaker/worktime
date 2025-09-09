CREATE TABLE DWD_DDTQKHHZB (
    ID NUMBER,                              -- 序号/ID
    ASSESSMENT_DATE VARCHAR2(2000),         -- 考核日期
    PRODUCTION_LINE VARCHAR2(2000),        -- 生产线
    FACTORY VARCHAR2(2000),              -- 厂区
    CUSTOMER_NAME VARCHAR2(2000),           -- 客户名
    ORDER_ID VARCHAR2(2000),                -- 订单号
    DELIVERY_DATE DATE,                     -- 交货期
    WAREHOUSE_ADJUST_DATE DATE,             -- 入库收托调整货位日期
    DELAY_DAYS NUMBER,                      -- 拖期天数
    DELAY_TYPE VARCHAR2(2000),              -- 拖期类别
    DELAY_COUNT NUMBER,                     -- 拖期次数
    RESPONSIBILITY_RATE VARCHAR2(2000),     -- 承担比例
    DEPT_RESPONSIBLE_PERSON VARCHAR2(2000), -- 相应业务科室负责人
    DEPT_HEAD_BONUS_RATE VARCHAR2(2000),    -- 科室负责人考核月绩效奖比例
    PLANNING_DEPARTMENT VARCHAR2(2000),     -- 厂区计划科生产部
    PLANNING_BONUS_RATE VARCHAR2(2000),     -- 计划科考核月绩效奖比例
    FACTORY_DIRECTOR VARCHAR2(2000),          -- 厂长总监
    DIRECTOR_BONUS_RATE VARCHAR2(2000),     -- 厂长总监考核月绩效奖比例
    MANUFACTURE_DIRECTOR VARCHAR2(2000),    -- 制造部总经理总裁
    MFG_DIRECTOR_BONUS_RATE VARCHAR2(2000), -- 总经理总裁考核月绩效奖比例
    PRODUCTION_MANAGER VARCHAR2(2000),      -- 生产管理科负责人
    PRODUCTION_BONUS_RATE VARCHAR2(2000),   -- 生产管理科考核月绩效奖比例
    OTHER_RESPONSIBLE_PERSON VARCHAR2(2000),-- 其他责任人
    DEDUCTION_AMOUNT VARCHAR2(2000),        -- 减发额
    IS_EXCEPTION VARCHAR2(2000),            -- 是否异常
    IS_PUSHED VARCHAR2(2000),                -- 是否推送
    INPUT_PERSON VARCHAR2(2000),             -- 录入员
    UPDATE_TIME DATE,                        -- 更新时间
    WAREHOUSE_MANAGER VARCHAR2(2000),        -- 仓储管理科负责人
    WAREHOUSE_BONUS_RATE VARCHAR2(2000),     -- 仓储管理科考核月绩效奖比例
    TOP_LEVEL_DIRECTOR VARCHAR2(2000),       -- 所有责任单位一级组织总裁
    TOP_DIRECTOR_BONUS_RATE VARCHAR2(2000),  -- 一级组织总裁考核月绩效奖比例
    PACKING_CONFIRM_DATE DATE,               -- 装箱单变更确认时间
    PACKING_CHANGE_REASON VARCHAR2(2000),    -- 装箱单变更原因
    ORDER_DELAY_REASON VARCHAR2(2000),      -- 订单拖期原因
    ADJUSTED_DELIVERY_DATE DATE,             -- 变更后交货期
    DELAY_REASON VARCHAR2(2000),             -- 拖期原因
    DEPARTMENT_TYPE VARCHAR2(2000),      -- 部门类型
    ETL_CRT_DATE DATE,                    -- ETL创建时间
    ETL_UPD_DATE DATE                     -- ETL更新时间
);









SELECT 
    ID,                              -- 序号/ID
    to_date(khrq,'YY.MM.DD'),                            -- 考核日期(ASSESSMENT_DATE)
    SCX,                             -- 生产线(PRODUCTION_LINE)
    CQ,                              -- 厂区(FACTORY)
    KHM,                             -- 客户名(CUSTOMER_NAME)
    DDH,                             -- 订单号(ORDER_ID)
    JHQ,                             -- 交货期(DELIVERY_DATE)
    RKSTTZHWRQ,                      -- 入库收托调整货位日期(WAREHOUSE_ADJUST_DATE)
    TQTS,                            -- 拖期天数(DELAY_DAYS)
    TQLB,                            -- 拖期类别(DELAY_TYPE)
    TQCS,                            -- 拖期次数(DELAY_COUNT)
    CDBL,                            -- 承担比例(RESPONSIBILITY_RATE)
    YWKSFZR,                         -- 业务科室负责人(DEPT_RESPONSIBLE_PERSON)
    KHKSFZRBL,                       -- 科室负责人考核比例(DEPT_HEAD_BONUS_RATE)
    CQJHKSCB,                        -- 厂区计划科生产部(PLANNING_DEPARTMENT)
    KHJHKBL,                         -- 计划科考核比例(PLANNING_BONUS_RATE)
    CZZJ,                            -- 厂长总监(FACTORY_DIRECTOR)
    KHCZBL,                          -- 厂长考核比例(DIRECTOR_BONUS_RATE)
    ZZBZJLZC,                        -- 制造部总经理总裁(MANUFACTURE_DIRECTOR)
    KHZJLBL,                         -- 总经理考核比例(MFG_DIRECTOR_BONUS_RATE)
    SCGLKFZR,                        -- 生产管理科负责人(PRODUCTION_MANAGER)
    KHSCGLBL,                        -- 生产管理科考核比例(PRODUCTION_BONUS_RATE)
    QTZRR,                           -- 其他责任人(OTHER_RESPONSIBLE_PERSON)
    JFE,                             -- 减发额(DEDUCTION_AMOUNT)
    SFYC,                            -- 是否异常(IS_EXCEPTION)
    SFTS,                            -- 是否推送(IS_PUSHED)
    LRY,                             -- 录入员(INPUT_PERSON)
    GXSJ,                            -- 更新时间(UPDATE_TIME)
    CCGLKFZR,                        -- 仓储管理科负责人(WAREHOUSE_MANAGER)
    KHCCGLBL,                        -- 仓储考核比例(WAREHOUSE_BONUS_RATE)
    YJZZZC,                          -- 一级组织总裁(TOP_LEVEL_DIRECTOR)
    KHYJZZZCBL,                      -- 一级组织考核比例(TOP_DIRECTOR_BONUS_RATE)
    ZXDBGQRSJ,                       -- 装箱单变更时间(PACKING_CONFIRM_DATE)
    ZXDBGYY,                         -- 装箱单变更原因(PACKING_CHANGE_REASON)
    DDTQYY,                          -- 订单拖期原因(ORDER_DELAY_REASON)
    BGHJHQ,                          -- 变更后交货期(ADJUSTED_DELIVERY_DATE)
    TCYY,                            -- 拖期原因(DELAY_REASON)
    BMLX,                            -- 部门类型(DEPARTMENT_TYPE)
    ETL_CRT_DT,                      -- ETL创建时间(ETL_CRT_DATE)
    ETL_UPD_DT                       -- ETL更新时间(ETL_UPD_DATE)