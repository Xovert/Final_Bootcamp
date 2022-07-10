USE OOVEO_Salon

CREATE TABLE MsCustomerAsg
(
	CustomerId CHAR(5) NOT NULL,
	CustomerName VARCHAR(50),
	CustomerGender VARCHAR(10),
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100),
	CONSTRAINT checkID
		PRIMARY KEY(CustomerId),
		CHECK(CustomerId LIKE 'CU[0-9]{3}'),
	CONSTRAINT checkGender
		CHECK(CustomerGender = 'Male' OR CustomerGender = 'Female'),
)

CREATE TABLE MsStaffAsg
(
	StaffId CHAR(5) NOT NULL,
	StaffName VARCHAR(50),
	StaffGender VARCHAR(10),
	StaffPhone VARCHAR(13),
	StaffAddress VARCHAR(100),
	StaffSalary NUMERIC(11,2),
	StaffPosition VARCHAR(20),
	CONSTRAINT checkStaffID
		PRIMARY KEY(StaffId),
		CHECK(StaffId LIKE 'SF\d{3})'),
	CONSTRAINT checkGenderStaff
		CHECK(StaffGender = 'Male' OR StaffGender = 'Female')
)

CREATE TABLE MsTreatmentTypeAsg(
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentTypeName VARCHAR(50)
	CONSTRAINT TypeId
		PRIMARY KEY (TreatmentTypeId),
		CHECK(TreatmentTypeId LIKE 'TT\d{3}')
)

CREATE TABLE MsTreatmentAsg(
	TreatmentId CHAR(5) NOT NULL,
	TreatmentTypeId CHAR(5),
	TreatmentName VARCHAR(50),
	Price NUMERIC(11,2)
	CONSTRAINT TreatIdAsg
		PRIMARY KEY(TreatmentId),
		CHECK(TreatmentId LIKE 'TM\d{3}'),
	CONSTRAINT TypeIdAsg
		FOREIGN KEY(TreatmentTypeId) REFERENCES MsTreatmentTypeAsg(TreatmentTypeId)
		ON UPDATE CASCADE
)

CREATE TABLE HeaderSalonServicesAsg(
	TransactionId CHAR(5) NOT NULL,
	CustomerId CHAR(5) NOT NULL,
	StaffId CHAR(5) NOT NULL,
	TransactionDate DATE,
	PaymentType VARCHAR(20),
	CONSTRAINT TranId
		PRIMARY KEY (TransactionId),
		CHECK(TransactionId LIKE 'TR\d{3}'),
	CONSTRAINT CustId
		FOREIGN KEY(CustomerId) REFERENCES MsCustomerAsg(CustomerId)
		ON UPDATE CASCADE,
	CONSTRAINT checkStaff
		FOREIGN KEY(StaffId) REFERENCES MsStaffAsg(StaffId)
		ON UPDATE CASCADE
)

CREATE TABLE DetailSalonServicesAsg(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,
	CONSTRAINT TranIdDetail
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServicesAsg(TransactionId)
		ON UPDATE CASCADE,
	CONSTRAINT TreatIdDetail
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatmentAsg(TreatmentId)
		ON UPDATE CASCADE,
	PRIMARY KEY(TransactionId, TreatmentId)
)
--2
DROP TABLE DetailSalonServicesAsg

--3
CREATE TABLE DetailSalonServicesAsg
(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,
	CONSTRAINT TrId
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServicesAsg(TransactionId)
		ON UPDATE CASCADE,
	CONSTRAINT Tr2Id
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatmentAsg(TreatmentId)
		ON UPDATE CASCADE,
)

ALTER TABLE DetailSalonServicesAsg
	ADD PRIMARY KEY (TransactionId,TreatmentId)

--4
ALTER TABLE MsStaffAsg WITH NOCHECK
	ADD CONSTRAINT NewCheck
		CHECK(LEN(StaffName) > 5 AND LEN(StaffName) < 20)

ALTER TABLE MsStaffAsg
	DROP CONSTRAINT NewCheck

--5
ALTER TABLE MsTreatment
	ADD Description VARCHAR(100)

ALTER TABLE MsTreatment
	DROP COLUMN Description

SELECT * FROM MsCustomerAsg
SELECT * FROM MsStaffAsg
SELECT * FROM MsTreatmentTypeAsg
SELECT * FROM MsTreatmentAsg
SELECT * FROM HeaderSalonServicesAsg
SELECT * FROM DetailSalonServicesAsg

DROP TABLE MsCustomerAsg
DROP TABLE MsStaffAsg
DROP TABLE MsTreatmentTypeAsg
DROP TABLE MsTreatmentAsg
DROP TABLE HeaderSalonServicesAsg
DROP TABLE DetailSalonServicesAsg