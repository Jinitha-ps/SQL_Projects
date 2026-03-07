
-- -------------------------
-- HOSPITAL INFORMATION MANAGEMENT SYSTEM (FULL SQL PROJECT)
-- -------------------------

-- STEP 1: CREATE DATABASE
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- STEP 2: CREATE MASTER TABLES

-- 2.1 DOCTORS TABLE
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    JoiningDate DATE
);

-- 2.2 PATIENTS TABLE
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Contact VARCHAR(15),
    Address TEXT,
    RegistrationDate DATE
);

-- 2.3 STAFF TABLE
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Phone VARCHAR(15),
    Salary DECIMAL(10, 2),
    JoiningDate DATE
);

-- 2.4 MEDICINES TABLE
CREATE TABLE Medicines (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Type VARCHAR(50),
    Manufacturer VARCHAR(100),
    QuantityInStock INT,
    Price DECIMAL(10, 2),
    ExpiryDate DATE
);

-- 2.5 LAB TESTS TABLE
CREATE TABLE LabTests (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    TestName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2)
);

-- STEP 3: CREATE TRANSACTION TABLES

-- 3.1 APPOINTMENTS TABLE
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Purpose TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 3.2 BILLING TABLE
CREATE TABLE Billing (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    BillDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- 3.3 BILLING DETAILS TABLE
CREATE TABLE BillingDetails (
    BillingDetailID INT AUTO_INCREMENT PRIMARY KEY,
    BillID INT,
    ItemType ENUM('Medicine', 'Test'),
    ItemID INT,
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);

-- STEP 4: INSERT SAMPLE DATA

-- DOCTORS
INSERT INTO Doctors (Name, Specialization, Phone, Email, JoiningDate)
VALUES 
('Dr. Anil Sharma', 'Cardiology', '9876543210', 'anil@hospital.com', '2022-05-01'),
('Dr. Priya Verma', 'Neurology', '9123456780', 'priya@hospital.com', '2023-01-15');

-- PATIENTS
INSERT INTO Patients (Name, Age, Gender, Contact, Address, RegistrationDate)
VALUES 
('Rahul Mehta', 34, 'Male', '9871112222', 'Delhi, India', '2025-07-01'),
('Sneha Iyer', 45, 'Female', '9823456789', 'Mumbai, India', '2025-07-02');

-- MEDICINES
INSERT INTO Medicines (Name, Type, Manufacturer, QuantityInStock, Price, ExpiryDate)
VALUES 
('Paracetamol', 'Tablet', 'Cipla', 100, 1.50, '2026-12-31'),
('Amoxicillin', 'Capsule', 'Pfizer', 50, 2.00, '2025-10-15');

-- LAB TESTS
INSERT INTO LabTests (TestName, Description, Price)
VALUES 
('Blood Test', 'Complete blood count', 400.00),
('X-Ray', 'Chest X-Ray', 700.00);

-- APPOINTMENTS
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Purpose)
VALUES 
(1, 1, '2025-07-28 10:30:00', 'Heart Checkup'),
(2, 2, '2025-07-28 11:30:00', 'Migraine');

-- BILLING AND DETAILS
INSERT INTO Billing (PatientID, BillDate, TotalAmount) VALUES
(1, '2025-07-28', 1200.00);

INSERT INTO BillingDetails (BillID, ItemType, ItemID, Quantity, Price)
VALUES 
(1, 'Medicine', 1, 5, 7.50),
(1, 'Test', 1, 1, 400.00);

-- STEP 5: DATA ANALYSIS QUERIES

-- A. Daily Appointments Count
SELECT DATE(AppointmentDate) AS Day, COUNT(*) AS Appointments
FROM Appointments
GROUP BY DATE(AppointmentDate);

-- B. Doctor-wise Patient Count
SELECT D.Name AS Doctor, COUNT(A.AppointmentID) AS TotalPatients
FROM Doctors D
JOIN Appointments A ON D.DoctorID = A.DoctorID
GROUP BY D.DoctorID;

-- C. Revenue from Billing
SELECT SUM(TotalAmount) AS TotalRevenue FROM Billing;

-- D. Medicine Stock Report
SELECT Name, QuantityInStock, ExpiryDate
FROM Medicines
WHERE QuantityInStock < 50 OR ExpiryDate < CURDATE();
