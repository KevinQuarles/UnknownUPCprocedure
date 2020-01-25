USE BusinessAnalysis
GO


alter PROCEDURE [DBO].[usp_MonthEndUnknown] (@CREATEDATE DATETIME)

AS

BEGIN

SET @CREATEDATE = (select max(local_createDate) FROM OpenPlayUnknown_Sales)

--1
----------------------------------------------------------Populate Unknown Sales---------------------------------------------------------
--select top 10 * FROM OpenPlayUnknown_Sales
--select max(local_createDate) FROM OpenPlayUnknown_Sales -- 

----2019-09-30 09:21:16.530

INSERT INTO OpenPlayUnknown_Sales (
	salesId ,
	recordseq ,
	distributorid ,
	formattypeid ,
	[date] ,
	partitionId,
	amountusd ,
	quantity ,
	upc ,
	isrc ,
	distributorSuppliedUpc ,
	distributorSuppliedIsrc ,
	distributorSuppliedAlbum ,
	distributorSuppliedTrack ,
	distributorSuppliedArtist ,
	label ,
	jobnumber ,
	new_jobnumber ,
	--added_to_OP bit NOT NULL DEFAULT 0,
	--updated_in_sales bit NOT NULL DEFAULT 0,
	local_createDate , 
	date_updated_in_sales

)
	SELECT
		salesId,
		recordseq,
		distributorid,
		formattypeid,
		[date],
		partitionId,
		amountusd, 
		quantity, 
		upc,
		isrc,
		distributorSuppliedUpc,
		distributorSuppliedIsrc,
		distributorSuppliedAlbum,
		distributorSuppliedTrack,
		distributorSuppliedArtist,
		CASE
			-- in the future, possibly distributor acct id / distributoracct 
			WHEN distributorsuppliedlabel like '%Rounder%' or distributorsuppliedlabelid like '%rounder%' or distributorsuppliedcompany like '%rounder%' or distributorsuppliedcompanyid like '%rounder%' OR jobnumber = 'P99989' THEN 'Rounder'
			WHEN distributorsuppliedlabel like '%telarc%' or distributorsuppliedlabelid like '%telarc%' or distributorsuppliedcompany like '%telarc%' or distributorsuppliedcompanyid like '%telarc%' THEN 'Telarc'
			WHEN distributorsuppliedlabel like '%fearless%' or distributorsuppliedlabelid like '%fearless%' or distributorsuppliedcompany like '%fearless%' or distributorsuppliedcompanyid like '%fearless%' OR jobnumber = 'P99985' THEN 'fearless'
			WHEN distributorsuppliedlabel like '%savoy%' or distributorsuppliedlabelid like '%savoy%' or distributorsuppliedcompany like '%savoy%' or distributorsuppliedcompanyid like '%savoy%' THEN 'savoy'
			WHEN distributorsuppliedlabel like '%victory%' or distributorsuppliedlabelid like '%victory%' or distributorsuppliedcompany like '%victory%' or distributorsuppliedcompanyid like '%victory%' THEN 'victory'
			WHEN distributorsuppliedlabel like '%kidz%' or distributorsuppliedlabelid like '%kidz%' or distributorsuppliedcompany like '%kidz%' or distributorsuppliedcompanyid like '%kidz%' OR jobnumber = 'P99994' THEN 'kidz bop'
			WHEN distributorsuppliedlabel like '%razor%' or distributorsuppliedlabelid like '%razor%' or distributorsuppliedcompany like '%razor%' or distributorsuppliedcompanyid like '%razor%' OR jobnumber in ('p99984' , 'p99983', 'p99982') THEN 'razor'
			--WHEN distributorsuppliedlabel like '%musart%' or distributorsuppliedlabelid like '%musart%' or distributorsuppliedcompany like '%musart%' or distributorsuppliedcompanyid like '%musart%' OR jobnumber = 'P99978' THEN 'musart'
			WHEN distributorsuppliedlabel like '%wind%' or distributorsuppliedlabelid like '%wind%' or distributorsuppliedcompany like '%wind%' or distributorsuppliedcompanyid like '%wind%' OR jobnumber = 'P99986' THEN 'wind'
			WHEN distributorsuppliedlabel like '%varese%' or distributorsuppliedlabelid like '%varese%' or distributorsuppliedcompany like '%varese%' or distributorsuppliedcompanyid like '%varese%' OR jobnumber = 'P99972' THEN 'varese'
			WHEN distributorsuppliedlabel like '%welk%' or distributorsuppliedlabelid like '%welk%' or distributorsuppliedcompany like '%welk%' or distributorsuppliedcompanyid like '%welk%' THEN 'welk'
			WHEN distributorsuppliedlabel like '%sugar%' or distributorsuppliedlabelid like '%sugar%' or distributorsuppliedcompany like '%sugar%' or distributorsuppliedcompanyid like '%sugar%' THEN 'sugar hill'
			WHEN distributorsuppliedlabel like '%vanguard%' or distributorsuppliedlabelid like '%vanguard%' or distributorsuppliedcompany like '%vanguard%' or distributorsuppliedcompanyid like '%vanguard%' THEN 'vanguard'
			WHEN distributorsuppliedlabel like '%veejay%' or distributorsuppliedlabelid like '%veejay%' or distributorsuppliedcompany like '%veejay%' or distributorsuppliedcompanyid like '%veejay%' THEN 'veejay'
			WHEN distributorsuppliedlabel like '%vee jay%' or distributorsuppliedlabelid like '%vee jay%' or distributorsuppliedcompany like '%vee jay%' or distributorsuppliedcompanyid like '%vee jay%' THEN 'veejay'
			WHEN distributorsuppliedlabel like '%sergio%' or distributorsuppliedlabelid like '%sergio%' or distributorsuppliedcompany like '%sergio%' or distributorsuppliedcompanyid like '%sergio%' THEN 'sergio'
			WHEN distributorsuppliedlabel like '%spirit%' or distributorsuppliedlabelid like '%spirit%' or distributorsuppliedcompany like '%spirit%' or distributorsuppliedcompanyid like '%spirit%' THEN 'spirit'
			WHEN distributorsuppliedlabel like '%fania%' or distributorsuppliedlabelid like '%fania%' or distributorsuppliedcompany like '%fania%' or distributorsuppliedcompanyid like '%fania%' THEN 'fania'
			WHEN distributorsuppliedlabel like '%independiente%' or distributorsuppliedlabelid like '%independiente%' or distributorsuppliedcompany like '%independiente%' or distributorsuppliedcompanyid like '%independiente%' THEN 'independiente'
			WHEN distributorsuppliedlabel like '%big picture%' or distributorsuppliedlabelid like '%big picture%' or distributorsuppliedcompany like '%big picture%' or distributorsuppliedcompanyid like '%big picture%' THEN 'big picture'
			WHEN distributorsuppliedlabel like '%rem%' or distributorsuppliedlabelid like '%rem%' or distributorsuppliedcompany like '%rem%' or distributorsuppliedcompanyid like '%rem%' THEN 'r.e.m.'
			WHEN distributorsuppliedlabel like '%r.e.m.%' or distributorsuppliedlabelid like '%r.e.m.%' or distributorsuppliedcompany like '%r.e.m.%' or distributorsuppliedcompanyid like '%r.e.m.%' THEN 'r.e.m.'
			WHEN distributorsuppliedlabel like '%hightone%' or distributorsuppliedlabelid like '%hightone%' or distributorsuppliedcompany like '%hightone%' or distributorsuppliedcompanyid like '%hightone%' THEN 'hightone'
			WHEN distributorsuppliedlabel like '%mflp%' or distributorsuppliedlabelid like '%mflp%' or distributorsuppliedcompany like '%mflp%' or distributorsuppliedcompanyid like '%mflp%' THEN 'mflp'
			WHEN distributorsuppliedlabel like '%fania%' or distributorsuppliedlabelid like '%fania%' or distributorsuppliedcompany like '%fania%' or distributorsuppliedcompanyid like '%fania%' OR jobnumber = 'P99969' THEN 'fania'
			WHEN distributorsuppliedlabel like '%bigger picture%' or distributorsuppliedlabelid like '%bigger picture%' or distributorsuppliedcompany like '%bigger picture%' or distributorsuppliedcompanyid like '%bigger picture%' OR jobnumber = 'P99967' THEN 'bigger picture'
		ELSE NULL END as label,
		jobnumber,
		NULL as new_jobnumber,
		GETDATE(),
		NULL as date_update_in_sales
	FROM sales.dbo.sales 
	WHERE 
		
		sales.CreateDate >= @CREATEDATE -- get the max local_createdate (i.e. the last time this was run, and get everything in sales with createdate later than that --- 
			--AND sales.CreateDate NOT IN ('2019-10-02 17:53:41.257')
			AND preAcquisition = 0 
			AND (
				JobNumber IN (SELECT JobNumber FROM sales.dbo.generalprojects WHERE jobnumber <> 'P25060') 
				OR JobNumber IS NULL 
				OR JobNumber = '' 
				OR JobNumber IN ('0', '-1', '-2', '-3', '-4')
			) 
			AND (
				ISRC IS NOT NULL
				OR UPC IS NOT NULL
				OR DistributorSuppliedISRC IS NOT NULL
				OR DistributorSuppliedUPC IS NOT NULL
			)	-- this clause included becuase NULL upc/isrc/dsupc/dsisrc might be already in OP and is therefore not in scope
			and (JobNumber <> 'P99978' --Musart Exclusion
			OR DistributorId NOT IN (194, 204)--Musart Exclusion
			OR sales.DistributorSuppliedLabel <> 'MUSART'
			OR sales.DistributorSuppliedLabelId <> 'MUSART'
			OR sales.DistributorSuppliedCompany <> 'MUSART'
			OR sales.DistributorSuppliedCompanyId <> 'MUSART')


		-- execute time restarted 11:22Am 9/30/19
		-- execute time 1:11.  118720 rows

--DELETE 
--SELECT DISTINCT local_createDate FROM  DBO.OpenPlayUnknown_Sales WHERE label LIKE '%MUSART%' AND local_createDate > '2019-08-07 08:20:26.193' 
--SELECT top 10* FROM  DBO.OpenPlayUnknown_Sales 




UPDATE 
	openPlayUnknown_sales 
SET 
	is_unknowable = 1
WHERE 
	(upc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') OR upc IS NULL) AND 
	(distributorsuppliedupc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') OR distributorsuppliedupc IS NULL) AND 
	(isrc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') OR isrc IS NULL) AND 
	(distributorsuppliedisrc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') OR distributorsuppliedisrc IS NULL) 
	AND local_createDate > @CREATEDATE
	AND is_unknowable = 0


--1A
--------------------------Make Sales Exclusions--------------------------------

--tracks
		update OpenPlayUnknown_Sales
		set added_to_OP = 1 
		--select count(*)
		FROM 
			OpenPlayUnknown_Sales 
			join ares.rec.track on track.isrc = openplayunknown_sales.isrc 
		WHERE 
			added_to_OP = 0
			

	--tracks (distributorSuppliedIsrc)
		update OpenPlayUnknown_Sales
		set added_to_OP = 1 
		--select count(*)
		FROM 
			OpenPlayUnknown_Sales
			join ares.rec.track on track.isrc = openplayunknown_sales.distributorSuppliedIsrc 
		WHERE 
			added_to_OP = 0


	--albums
		update OpenPlayUnknown_Sales
		set added_to_OP = 1 
		--select count(*)
		FROM 
			OpenPlayUnknown_Sales openplayunknown 
			join ares.rec.album  on album.upc = openplayunknown.upc 
		WHERE 
			added_to_OP = 0 


	--albums (distributorsupplied)
		update OpenPlayUnknown_Sales
		set added_to_OP = 1 
		--select count(*)
		FROM 
			OpenPlayUnknown_Sales openplayunknown 
			join ares.rec.album  on album.upc = openplayunknown.distributorSuppliedUpc 
		WHERE 
			added_to_OP = 0 
			

			
	--sales
		select sa.jobnumber, ou.jobnumber
		FROM 
			OpenPlayUnknown_Sales OU
			join Sales.dbo.sales SA on OU.salesid = SA.salesid
		WHERE 
			updated_In_Sales = 0 
			and sa.jobnumber <> ou.jobnumber



		update ou
		set updated_in_sales = 1
		FROM 
			OpenPlayUnknown_Sales OU
			join Sales.dbo.sales SA on OU.salesid = SA.salesid
		WHERE 
			updated_In_Sales = 0 
			and sa.jobnumber <> ou.jobnumber

--2
----------------------Populate UPS, ISRC---------------------------------


		--select COUNT(*) from OpenPlayUnknown_upc
		
		TRUNCATE TABLE OpenPlayUnknown_upc

		INSERT INTO 
			OpenPlayUnknown_upc ( upc, AmountUSD_AllTime, AmountUSD_2018, AmountUSD_2019)
		SELECT 
			COALESCE(upc, distributorsuppliedupc) 
			, SUM(Amountusd)
			, SUM(CASE WHEN YEAR(date) = 2018 THEN Amountusd ELSE 0 END)
			, SUM(CASE WHEN YEAR(date) = 2019 THEN Amountusd ELSE 0 END)
			
				FROM 
			OpenPlayUnknown_Sales
		WHERE 
			(upc is not null or distributorsuppliedupc is not null) 
			AND coalesce(upc, distributorsuppliedUPC) NOT IN ( '', '-1','-2', '-3', '-4', '0')
			and added_to_OP = 0 
			AND updated_In_Sales = 0 
			AND isKnown_dirtyUPC = 0 
			AND is_passThru = 0 
			AND IS_unknowable = 0
		GROUP BY 
			COALESCE(upc, distributorsuppliedupc) 
		



		TRUNCATE TABLE OpenPlayUnknown_isrc

	
		INSERT INTO 
			OpenPlayUnknown_isrc (isrc, AmountUSD_AllTime, AmountUSD_2018, AmountUSD_2019)
		SELECT 
			COALESCE(isrc, distributorsuppliedisrc) 
			, SUM(Amountusd)
			, SUM(CASE WHEN YEAR(date) = 2018 THEN Amountusd ELSE 0 END)
			, SUM(CASE WHEN YEAR(date) = 2019 THEN Amountusd ELSE 0 END)
			
		
		FROM 
			OpenPlayUnknown_Sales
		WHERE 
			(isrc IS NOT NULL OR distributorsuppliedisrc IS NOT NULL) 
			AND coalesce(isrc, distributorsuppliedisrc) NOT IN ( '', '-1','-2', '-3', '-4', '0')
			and added_to_OP = 0 
			AND updated_In_Sales = 0 
			AND isKnown_dirtyUPC = 0 
			AND is_passThru = 0 
			AND IS_unknowable = 0
		GROUP BY  
			COALESCE(isrc, distributorsuppliedisrc) 






	DELETE FROM openPlayUnknown_upc WHERE amountUSD_Alltime IS NULL OR amountusd_alltime = 0
	DELETE FROM openPlayUnknown_isrc WHERE amountUSD_Alltime IS NULL OR amountusd_alltime = 0


--3
---------------Populate Meta---------------------------------



TRUNCATE TABLE openPlayUnknown_meta 


INSERT INTO openPlayUnknown_meta (
	upc , isrc, distributorsuppliedAlbum, distributorsuppliedTrack, distributorsuppliedArtist, label)
SELECT 
	DISTINCT 
	COALESCE (
		CASE WHEN upc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') 
		THEN NULL ELSE UPC END, 
		CASE WHEN distributorsuppliedupc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') 
		THEN NULL ELSE distributorsuppliedUpc END) AS UPC , 
	
	COALESCE (
		CASE WHEN isrc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') 
		THEN NULL ELSE isrc END, 
		CASE WHEN distributorsuppliedisrc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC') 
		THEN NULL ELSE distributorsuppliedisrc END) AS isrc ,

	distributorsuppliedAlbum, 
	distributorsuppliedTrack,
	distributorsuppliedArtist,
	label
FROM 
	openPlayUnknown_sales
WHERE 
	added_to_OP = 0 AND updated_In_Sales = 0 AND isKnown_dirtyUPC = 0 AND is_passThru = 0 AND IS_unknowable = 0


--4

-------------------------- misc initial cleanup -------------------------------

	/*
/* synch up bit flags */	
	UPDATE a SET a.added_to_OP = 1 
	FROM 
		openPlayUnknown_sales a 
	JOIN 
		openPlayUnknown_upc b on COALESCE(a.upc, a.distributorsuppliedupc) = b.upc
	WHERE 
		COALESCE(a.upc, a.distributorsuppliedupc)  IS NOT NULL 
		AND b.added_to_OP = 1
	
		
	UPDATE a SET a.updated_in_sales = 1 
	FROM 
		openPlayUnknown_sales a 
	JOIN 
		openPlayUnknown_upc b on COALESCE(a.upc, a.distributorsuppliedupc) = b.upc
	WHERE 
		COALESCE(a.upc, a.distributorsuppliedupc)  IS NOT NULL 
		AND b.updated_in_sales = 1 AND a.updated_in_sales = 0

	UPDATE a SET a.isKnown_dirtyUPC = 1 
	FROM 
		openPlayUnknown_sales a 
	JOIN 
		openPlayUnknown_upc b on COALESCE(a.upc, a.distributorsuppliedupc) = b.upc
	WHERE 
		COALESCE(a.upc, a.distributorsuppliedupc)  IS NOT NULL 
		AND b.isKnown_dirtyUPC = 1 AND a.isKnown_dirtyUPC = 0

	UPDATE a SET a.is_passThru = 1 
	FROM 
		openPlayUnknown_sales a 
	JOIN 
		openPlayUnknown_upc b on COALESCE(a.upc, a.distributorsuppliedupc) = b.upc
	WHERE 
		COALESCE(a.upc, a.distributorsuppliedupc)  IS NOT NULL 
		AND b.is_passThru = 1 AND a.is_passThru = 0


		*/

	
----	UPDATE openPlayUnknown_sales SET is_passThru = 0 WHERE is_passThru IS NULL

	



SELECT DISTINCT COALESCE(upc, distributorsuppliedupc) AS upc, Label 
		INTO #label
		FROM 
			OpenPlayUnknown_Sales
		WHERE
			(upc IS NOT NULL OR distributorsuppliedupc IS NOT NULL) 
			AND coalesce(upc, distributorsuppliedUPC) NOT IN ( '', '-1','-2', '-3', '-4', '0')


		UPDATE a SET a.label = b.label
		FROM OpenPlayUnknown_upc a
			JOIN #label b on a.upc = b.upc
		WHERE b.label IS NOT NULL
		
		UPDATE a SET a.is_passthru = 1 
		FROM openPlayUnknown_upc a 
		JOIN openPlayUnknown_passthru b on a.upc= b.upc -- 50
		
		UPDATE a SET a.is_passthru = 1, updated_in_sales = 1
		FROM openPlayUnknown_upc a 
		JOIN openPlayUnknown_passthru b on (RIGHT(a.upc,11))= (RIGHT(b.upc,11))
		WHERE a.upc NOT IN (select a.upc 	FROM openPlayUnknown_upc a 
		JOIN openPlayUnknown_passthru b on a.upc= b.upc)


/* ? */ 
UPDATE openPlayunknown_Isrc SET Is_Not_ISRC = 1 WHERE isrc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC')
UPDATE openPlayUnknown_isrc SET has_related_upc = 1 WHERE ISRC IN (SELECT isrc FROM openPlayUnknown_meta WHERE upc IS NOT NULL)
UPDATE openPlayunknown_upc SET IsNotUpc = 1 WHERE upc IN ('#', '-1', '', '-3', '-', '-2', '-4', 'N/A', ' ', '000000000000NA', 'ALBUM', 'UPC' ,'ISRC')
UPDATE openPlayunknown_Isrc SET In_OP_At_Init = 1 WHERE isrc IN (SELECT isrc FROM sales.dbo.TrackAlbumMapping_unionAcquisition)





--ALTER view vOpenPlayUnknown_upc 
--AS
--SELECT upc, label, amountusd_alltime, amountUSD_2018, amountUSD_2019  
--FROM OpenPlayUnknown_upc UPC
--WHERE added_to_OP = 0 and isKnown_dirtyUPC = 0 and isNotUPC = 0 and is_passthru = 0 and iNOP_AtInit = 0 



--ALTER view vOpenPlayUnknown_ISRC 
--AS
--SELECT isrc, has_related_upc, label, amountusd_alltime, amountUSD_2018, amountUSD_2019 
--FROM OpenPlayUnknown_isrc ISRC
--WHERE added_to_OP = 0 and in_OP_At_Init = 0 AND is_not_isrc = 0

--ALTER VIEW vOpenPlayUnknown_Combined
--AS
--SELECT M.upc as UPC, M.distributorSuppliedArtist as Artist, M.distributorSuppliedAlbum as Album, m.distributorSuppliedTrack as Track
--FROM 
--	vOpenPlayUnknown_upc U
--	JOIN openPlayUnknown_meta M ON U.upc = M.upc and u.upc = m.upc
--	--LEFT JOIN OpenPlayUnknown_ISRC I ON M.isrc = I.isrc
--	--JOIN openPlayUnknown_sALES S ON U.upc = S.upc --OR I.isrc = S.isrc
--	--JOIN SALES.DBO.Distributor D ON S.distributorid = D.DISTRIBUTORID


--SELECT * FROM vOpenPlayUnknown_Combined


select max(local_createDate) FROM OpenPlayUnknown_Sales

END
