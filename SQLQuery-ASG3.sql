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

SELECT * FROM MsTreatmentType
SELECT * FROM MsTreatment
SELECT * FROM MsStaff
SELECT * FROM HeaderSalonServices
SELECT * FROM DetailSalonServices