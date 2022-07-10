USE OOVEO_Salon

SELECT
	MAX(Price)[Maximum Price],
	MIN(Price)[Minimum Price],
	ROUND(AVG(Price), 0)[Average Price]
FROM MsTreatment

SELECT
	ms.StaffPosition,
	LEFT(ms.StaffGender, 1)[Gender],
	'Rp. ' + CAST(ROUND(AVG(ms.StaffSalary), -5) as varchar)[Average Salary]
FROM MsStaff as ms
GROUP BY ms.StaffPosition, ms.StaffGender

SELECT
	CONVERT(VARCHAR, hss.TransactionDate, 107)[TransactionDate],
	COUNT(hss.TransactionId)[Total Transaction per Day]
FROM HeaderSalonServices as hss
GROUP BY hss.TransactionDate

SELECT
	UPPER(mc.CustomerGender)[CustomerGender],
	COUNT(hss.TransactionId)[Total Transaction]
FROM MsCustomer as mc
JOIN HeaderSalonServices as hss on hss.CustomerId = mc.CustomerId
GROUP BY mc.CustomerGender

SELECT
	mtt.TreatmentTypeName,
	COUNT(dss.TransactionId)[Total Transaction]
FROM MsTreatment as mt
JOIN DetailSalonServices as dss on mt.TreatmentId = dss.TreatmentId
JOIN MsTreatmentType as mtt on mt.TreatmentTypeId = mtt.TreatmentTypeId
GROUP BY mt.TreatmentTypeId, mtt.TreatmentTypeName 
ORDER BY [Total Transaction] DESC

SELECT
	CONVERT(varchar, hss.TransactionDate, 106)[Date],
	'Rp. ' + CAST(SUM(mt.Price)as varchar)[Revenue per Day]
FROM HeaderSalonServices as hss
JOIN DetailSalonServices as dss on dss.TransactionId = hss.TransactionId
JOIN MsTreatment as mt on dss.TreatmentId = mt.TreatmentId
GROUP BY hss.TransactionDate

SELECT
	REPLACE(mtt.TreatmentTypeId,'TT0','Treatment Type ')[ID],
	mtt.TreatmentTypeName,
	CAST(COUNT(mt.TreatmentId) as VARCHAR) + ' Treatment'[Total Treatment per Type]
FROM MsTreatmentType as mtt
JOIN MsTreatment as mt on mtt.TreatmentTypeId = mt.TreatmentTypeId
GROUP BY mtt.TreatmentTypeId, mtt.TreatmentTypeName
HAVING COUNT(mt.TreatmentId) > 5
ORDER BY COUNT(mt.TreatmentId) DESC

SELECT
	hss.TransactionDate,
	mc.CustomerName,
	mt.TreatmentName,
	mt.Price
FROM HeaderSalonServices as hss
JOIN MsCustomer as mc on mc.CustomerId = hss.CustomerId
JOIN MsStaff as ms on ms.StaffId = hss.StaffId
JOIN DetailSalonServices as dss on dss.TransactionId = hss.TransactionId
JOIN MsTreatment mt on mt.TreatmentId = dss.TreatmentId
WHERE DATENAME(WEEKDAY,TransactionDate) = 'Thursday' AND ms.StaffName LIKE '%Ryan%'
ORDER BY TransactionDate, mc.CustomerName ASC

SELECT
	hss.TransactionDate,
	mc.CustomerName,
	SUM(mt.Price)[TotalPrice]
FROM HeaderSalonServices as hss
JOIN MsCustomer as mc on hss.CustomerId = mc.CustomerId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as mt on mt.TreatmentId = dss.TreatmentId
WHERE DAY(hss.TransactionDate) > 20
GROUP BY hss.TransactionDate, mc.CustomerName
ORDER BY TransactionDate

SELECT
	hss.TransactionDate,
	mc.CustomerName,
	SUM(mt.Price)[TotalPrice]
FROM HeaderSalonServices as hss
JOIN MsCustomer as mc on hss.CustomerId = mc.CustomerId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as mt on mt.TreatmentId = dss.TreatmentId
WHERE DAY(hss.TransactionDate) > 20
GROUP BY hss.TransactionDate, mc.CustomerName
ORDER BY TransactionDate

SELECT * FROM MsTreatmentType
SELECT * FROM MsTreatment
SELECT * FROM MsStaff
SELECT * FROM HeaderSalonServices
SELECT * FROM DetailSalonServices
