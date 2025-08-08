

SELECT
	'前工序汇总' gxmc,
	SUM ( ftddqs ) ddqs,
	COUNT ( DISTINCT pz + gg + xs ) sjctgg,
	COUNT ( DISTINCT ddh ) ddgs,
	'100%' jszbl
FROM
	fm_jhjdcx_dp_B7 UNION ALL
SELECT
	ftdw 单位,
	SUM ( ftddqs ) [订单欠数(件)],
	COUNT ( DISTINCT pz + gg + xs ) 涉及成套规格,
	COUNT ( DISTINCT ddh ) 订单个数,
	CAST (
		CAST ( SUM ( ftddqs ) * 100.00 / ( SELECT SUM ( ftddqs ) FROM fm_jhjdcx_dp_B7 ) AS DECIMAL ( 12, 2 ) ) AS VARCHAR ( 20 )
	) + '%'
FROM
	fm_jhjdcx_dp_B7
GROUP BY
	ftdw
ORDER BY
	SUM ( ftddqs ) DESC
	
	
	