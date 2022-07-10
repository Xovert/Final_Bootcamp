USE OOVEO_Salon

SELECT * FROM MsStaff
WHERE StaffGender = 'Female'

SELECT StaffName, 'Rp '+CAST(StaffSalary AS varchar) FROM MsStaff
WHERE (StaffName LIKE 'M%' AND StaffSalary >= 10000000)

SELECT TreatmentName, Price FROM MsTreatment
WHERE (TreatmentTypeId = 'TT002' OR TreatmentTypeId = 'TT003')

SELECT 
	ms.StaffName,
	ms.StaffPosition,
	CONVERT(VARCHAR, hss.TransactionDate, 107)[TransactionDate]
FROM MsStaff as ms
JOIN HeaderSalonServices as hss on hss.StaffId = ms.StaffId
WHERE ms.StaffSalary BETWEEN 7000000 AND 10000000

SELECT 
	Substring(mc.CustomerName, 1, CHARINDEX(' ', mc.CustomerName)-1)[Name],
	LEFT(mc.CustomerGender, 1)[Gender],
	hss.PaymentType
FROM MsCustomer as mc JOIN HeaderSalonServices as hss
on hss.CustomerId = mc.CustomerId
WHERE hss.PaymentType = 'Debit'

SELECT
	UPPER(LEFT(mc.CustomerName, 1) + SUBSTRING(mc.CustomerName, CHARINDEX(' ', mc.CustomerName)+1, 1))[Initial],
	DATENAME(WEEKDAY, hss.TransactionDate)[Day]
FROM MsCustomer as mc JOIN HeaderSalonServices as hss
on hss.CustomerId = mc.CustomerId
WHERE DATEDIFF(DAY, hss.TransactionDate, '2012/12/24') < 3

SELECT 
	hss.TransactionDate,
	RIGHT(mc.CustomerName, CHARINDEX(' ', REVERSE(mc.CustomerName))-1)[CustomerName]
FROM HeaderSalonServices as hss JOIN MsCustomer as mc
on mc.CustomerId = hss.CustomerId
WHERE DATENAME(WEEKDAY, hss.TransactionDate) = 'Saturday'

SELECT * FROM MsTreatmentType
SELECT * FROM MsTreatment
SELECT * FROM MsStaff
SELECT * FROM HeaderSalonServices