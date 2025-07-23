INSERT INTO
    MDADS.ADS_CUX_ITEM_BALANCE_V (
        LINE_ID, -- 行编号
        ORG_ID, -- 组织ID
        ORGANIZATION_NAME, --生产线
        PERIOD_NAME, -- 期间(格式:YYYY-MM)
        ORGANIZATION_ID, -- 库存组织ID
        ITEM_ID, -- 物料ID
        ITEM_CODE, -- 物料编码
        ITEM_DESC, -- 物料名称
        FIN_CATE_CODE, -- 财务类别
        FIN_CATE_DESC, -- 物料分类
        BEGIN_QTY, -- 期初库存量
        BEGIN_AMT, -- 期初库存金额
        BEGIN_DIFFE_AMT, -- 期初差异金额
        PERIOD_QTY_DR, -- 本月入库量
        PERIOD_AMT_DR, -- 本月入库金额
        PERIOD_QTY_CR, -- 本月出库量
        PERIOD_AMT_CR, -- 本月出库金额
        PERIOD_DIFFE_AMT_DR, -- 本月新增差异
        PERIOD_DIFFE_AMT_CR, -- 本月结转差异
        STAND_DIFFE_AMT, -- 标准成本更新差异
        ITEM_END_QTY, -- 本月数量
        ITEM_END_AMT, -- 本月金额（万元）
        LAST_ITEM_END_QTY, -- 上月数量
        LAST_ITEM_END_AMT, -- 上月金额（万元）
        END_DIFFE_AMT, -- 期末差异金额
        ACTUAL_UNIT_COST, -- 实际成本
        ITEM_TYPE, -- 物料类型
        ETL_UPD_DT, -- 创建日期
        ETL_CRT_DT -- 更新日期
    )
SELECT
    A1.LINE_ID, -- 行编号
    A1.ORG_ID, -- 组织ID
    B.ORGANIZATION_NAME, -- 生产线
    TO_DATE(A1.PERIOD_NAME,'YYYY-MM'), -- 期间(格式:YYYY-MM)
    A1.ORGANIZATION_ID, -- 库存组织ID
    A1.ITEM_ID, -- 物料ID
    A1.ITEM_CODE, -- 物料编码
    A1.ITEM_DESC, -- 物料名称
    A1.FIN_CATE_CODE, -- 财务类别
    A1.FIN_CATE_DESC, -- 物料分类
    A1.BEGIN_QTY, -- 期初库存量
    A1.BEGIN_AMT, -- 期初库存金额
    A1.BEGIN_DIFFE_AMT, -- 期初差异金额
    A1.PERIOD_QTY_DR, -- 本月入库量
    A1.PERIOD_AMT_DR, -- 本月入库金额
    A1.PERIOD_QTY_CR, -- 本月出库量
    A1.PERIOD_AMT_CR, -- 本月出库金额
    A1.PERIOD_DIFFE_AMT_DR, -- 本月新增差异
    A1.PERIOD_DIFFE_AMT_CR, -- 本月结转差异
    A1.STAND_DIFFE_AMT, -- 标准成本更新差异
    A1.END_QTY AS ITEM_END_QTY, -- 本月数量
    A1.END_AMT / 10000 AS ITEM_END_AMT, -- 本月金额（万元）
    A2.END_QTY AS LAST_ITEM_END_QTY, -- 上月数量
    A2.END_AMT / 10000 AS LAST_ITEM_END_AMT, -- 上月金额（万元）
    A1.END_DIFFE_AMT, -- 期末差异金额
    A1.ACTUAL_UNIT_COST, -- 实际成本
    A1.ITEM_TYPE, -- 物料类型
    SYSDATE, -- 创建日期
    SYSDATE -- 更新日期
FROM
    ODS_EBS.ODS_CUX_ITEM_BALANCE_V A1
    LEFT JOIN ODS_EBS.ODS_CUX_ITEM_BALANCE_V A2 ON A1.ORGANIZATION_ID = A2.ORGANIZATION_ID
    AND A1.ITEM_TYPE = A2.ITEM_TYPE
    AND A1.ITEM_ID = A2.ITEM_ID
    AND A2.PERIOD_NAME = TO_CHAR (
        ADD_MONTHS (
            TO_DATE (A1.PERIOD_NAME, 'YYYY-MM'),
            -1
        ),
        'YYYY-MM'
    )
    LEFT JOIN ODS_EBS.ORG_ORGANIZATION_DEFINITIONS B ON A1.ORGANIZATION_ID = B.ORGANIZATION_ID
WHERE
    A1.PERIOD_NAME >= TO_CHAR (
        ADD_MONTHS (SYSDATE, -24),
        'YYYY-MM'
    )
    AND A1.PERIOD_NAME < TO_CHAR (SYSDATE, 'YYYY-MM')

------------------
BEGIN
  -- 检查是否为每月6号
  IF TO_NUMBER(TO_CHAR(SYSDATE, 'DD')) = 6 THEN
    -- 删除上月数据
    DELETE FROM MDADS.ADS_CUX_ITEM_BALANCE_V
    WHERE PERIOD_NAME = TRUNC(ADD_MONTHS(SYSDATE, -1), 'MM');
INSERT INTO
    MDADS.ADS_CUX_ITEM_BALANCE_V (
        LINE_ID, -- 行编号
        ORG_ID, -- 组织ID
        ORGANIZATION_NAME, --生产线
        PERIOD_NAME, -- 期间(格式:YYYY-MM)
        ORGANIZATION_ID, -- 库存组织ID
        ITEM_ID, -- 物料ID
        ITEM_CODE, -- 物料编码
        ITEM_DESC, -- 物料名称
        FIN_CATE_CODE, -- 财务类别
        FIN_CATE_DESC, -- 物料分类
        BEGIN_QTY, -- 期初库存量
        BEGIN_AMT, -- 期初库存金额
        BEGIN_DIFFE_AMT, -- 期初差异金额
        PERIOD_QTY_DR, -- 本月入库量
        PERIOD_AMT_DR, -- 本月入库金额
        PERIOD_QTY_CR, -- 本月出库量
        PERIOD_AMT_CR, -- 本月出库金额
        PERIOD_DIFFE_AMT_DR, -- 本月新增差异
        PERIOD_DIFFE_AMT_CR, -- 本月结转差异
        STAND_DIFFE_AMT, -- 标准成本更新差异
        ITEM_END_QTY, -- 本月数量
        ITEM_END_AMT, -- 本月金额（万元）
        LAST_ITEM_END_QTY, -- 上月数量
        LAST_ITEM_END_AMT, -- 上月金额（万元）
        END_DIFFE_AMT, -- 期末差异金额
        ACTUAL_UNIT_COST, -- 实际成本
        ITEM_TYPE, -- 物料类型
        ETL_UPD_DT, -- 创建日期
        ETL_CRT_DT -- 更新日期
    )
SELECT
    A1.LINE_ID, -- 行编号
    A1.ORG_ID, -- 组织ID
    B.ORGANIZATION_NAME, -- 生产线
    TO_DATE(A1.PERIOD_NAME,'YYYY-MM'), -- 期间(格式:YYYY-MM)
    A1.ORGANIZATION_ID, -- 库存组织ID
    A1.ITEM_ID, -- 物料ID
    A1.ITEM_CODE, -- 物料编码
    A1.ITEM_DESC, -- 物料名称
    A1.FIN_CATE_CODE, -- 财务类别
    A1.FIN_CATE_DESC, -- 物料分类
    A1.BEGIN_QTY, -- 期初库存量
    A1.BEGIN_AMT, -- 期初库存金额
    A1.BEGIN_DIFFE_AMT, -- 期初差异金额
    A1.PERIOD_QTY_DR, -- 本月入库量
    A1.PERIOD_AMT_DR, -- 本月入库金额
    A1.PERIOD_QTY_CR, -- 本月出库量
    A1.PERIOD_AMT_CR, -- 本月出库金额
    A1.PERIOD_DIFFE_AMT_DR, -- 本月新增差异
    A1.PERIOD_DIFFE_AMT_CR, -- 本月结转差异
    A1.STAND_DIFFE_AMT, -- 标准成本更新差异
    A1.END_QTY AS ITEM_END_QTY, -- 本月数量
    A1.END_AMT / 10000 AS ITEM_END_AMT, -- 本月金额（万元）
    A2.END_QTY AS LAST_ITEM_END_QTY, -- 上月数量
    A2.END_AMT / 10000 AS LAST_ITEM_END_AMT, -- 上月金额（万元）
    A1.END_DIFFE_AMT, -- 期末差异金额
    A1.ACTUAL_UNIT_COST, -- 实际成本
    A1.ITEM_TYPE, -- 物料类型
    SYSDATE, -- 创建日期
    SYSDATE -- 更新日期
FROM
    ODS_EBS.ODS_CUX_ITEM_BALANCE_V A1
    LEFT JOIN ODS_EBS.ODS_CUX_ITEM_BALANCE_V A2 ON A1.ORGANIZATION_ID = A2.ORGANIZATION_ID
    AND A1.ITEM_TYPE = A2.ITEM_TYPE
    AND A1.ITEM_ID = A2.ITEM_ID
    AND A2.PERIOD_NAME = TO_CHAR (
        ADD_MONTHS (
            TO_DATE (A1.PERIOD_NAME, 'YYYY-MM'),
            -1
        ),
        'YYYY-MM'
    )
    LEFT JOIN ODS_EBS.ORG_ORGANIZATION_DEFINITIONS B ON A1.ORGANIZATION_ID = B.ORGANIZATION_ID
WHERE
    A1.PERIOD_NAME = TO_CHAR (
        ADD_MONTHS (SYSDATE, -1),
        'YYYY-MM'
    );
    COMMIT;
  END IF;
  END;