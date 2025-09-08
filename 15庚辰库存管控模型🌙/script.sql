SELECT
	CONVERT(VARCHAR(10), DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0), 120) as PERIOD,---上月第一天
    ckbm,
    ckmc,
    jhq,
    ddh,
    fhdh,
    khm,
    pz,
    gg,
    xs,
    hwh,
    zjc,
    tzlq,
    lq,
    py,
    pk,
    zc,
    tzzc,
    jjc,
    ddxfjs,
    yxhwjc,
    gxsj,
	GETDATE() ETL_CRT_DT,
	GETDATE() ETL_UPD_DT
FROM ${TPC_HWJCB_LAST_MONTH} A


UNION ALL 
SELECT
	CONVERT(VARCHAR(7), GETDATE(), 120) + '-01'  as PERIOD,---本月第一天
    ckbm,
    ckmc,
    jhq,
    ddh,
    fhdh,
    khm,
    pz,
    gg,
    xs,
    hwh,
    zjc,
    tzlq,
    lq,
    py,
    pk,
    zc,
    tzzc,
    jjc,
    ddxfjs,
    yxhwjc,
    gxsj,
	GETDATE() ETL_CRT_DT,
	GETDATE() ETL_UPD_DT
FROM mdgcyw.dbo.tpc_hwjcb