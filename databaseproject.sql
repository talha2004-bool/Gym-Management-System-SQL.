CREATE DATABASE GymMSs;
USE GymMSs;

-- =========================
-- Membership
CREATE TABLE Membership (
    MembershipID INT PRIMARY KEY,
    Type VARCHAR(50),
    DurationMonths INT,
    Description VARCHAR(100)
);
-- =========================
-- Trainer
CREATE TABLE Trainer (
    TrainerID INT PRIMARY KEY,
    TrainerName VARCHAR(50) not null ,
    Specialization VARCHAR(50),
    Gender VARCHAR(10) not null,
    Phone VARCHAR(20) unique,
    HireDate DATE
);
-- Equipment
CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY,
    EquipmentName VARCHAR(50),
    PurchaseDate DATE,
    LastMaintenance DATE
);
-- Staff
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
     staffname  varchar(50) not null,
    Role VARCHAR(50) not null,
    HireDate DATE,
    Salary DECIMAL(10,2) not null,
    phone varchar(50) unique
   
);
-- Members
CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(50) not null,
    Gender VARCHAR(10),
    Age INT,
    Phone VARCHAR(20) unique,
    Email VARCHAR(50) unique,
    JoinDate DATE,
    MembershipID INT not null,
    FOREIGN KEY (MembershipID) REFERENCES Membership(MembershipID)
);
-- =========================
-- Workout Session
create TABLE WorkoutSession (
    SessionID INT PRIMARY KEY,
    TrainerID INT not null,
    StartTime TIME not null,
    EndTime TIME,
    SessionDate DATE not null,
    MemberID INT,
    FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
-- Attendance
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    MemberID INT not null,
    SessionID INT not null,
    AttendanceDate DATE  not null,
    StaffAttemdanceStatus varchar(50),
	MemberAttendanceStatus VARCHAR(20),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (SessionID) REFERENCES WorkoutSession(SessionID)
);
-- =========================
-- Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    MemberID INT not null,
    Amount INT NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentDate DATETIME default current_timestamp,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
-- Member ↔ Trainer (M:N)
CREATE TABLE MTRelationship (
    TrainerID INT,
    MemberID INT,
    PRIMARY KEY (TrainerID, MemberID),
    FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);
-- Member ↔ Equipment (M:N)
CREATE TABLE EquipmentUse (
    MemberID INT,
    EquipmentID INT,
    PRIMARY KEY (MemberID, EquipmentID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);
-- =========================
-- Member ↔ WorkoutSession (M:N)
CREATE TABLE MWrelation (
    MemberID INT,
    SessionID INT,
    PRIMARY KEY (MemberID, SessionID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (SessionID) REFERENCES WorkoutSession(SessionID)
);
-- Staff ↔ Equipment (Maintains)
CREATE TABLE Maintains (
    StaffID INT,
    EquipmentID INT,
    PRIMARY KEY (StaffID, EquipmentID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID)
);
create table MARelationship(
MemberID int,
 AttendanceID int,

 FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
 foreign key ( AttendanceID)references  Attendance( AttendanceID)

);
create table SARelationship(
  StaffID int,
  AttendanceID int,
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
  foreign key (AttendanceID)references Attendance(AttendanceID)


);

INSERT INTO Membership 
(MembershipID, Type, DurationMonths, Description)VALUES
(1, 'Monthly', 1,  '1 month gym access with basic equipment'),
(2, 'Quarterly', 3, '3 months access with  weight training'),
(3, 'Annual', 12,  '12 months full access including trainer support');
-- ==============================
INSERT INTO Trainer 
(TrainerID, TrainerName, Specialization, Gender, Phone, HireDate)VALUES
(1, 'Talha', 'LEG', 'M', '03284473084', '2026-01-29'),
(2, 'Hazair', 'LEG', 'M', '03285573084', '2026-01-29'),
(3,'Ali','Chest','M','03286673084','2026-01-29'),
(4,'Hamza','Chest','M','03287773084','2026-01-29');
-- =========================
insert into Equipment(EquipmentID, EquipmentName, PurchaseDate,LastMaintenance) values
(1,'Dumbbells','2026-01-01','2026-01-03'),
(2,'powerRack','2026-01-01','2026-01-03'),
(3,'Barbells','2026-01-01','2026-01-03');
-- =========================
INSERT INTO Staff (StaffID, StaffName, Role, HireDate, Salary,phone)VALUES
(1, 'Ali Khan',  'Receptionist', '2025-01-15', 35.0,03284473085),
(2, 'Sara Ahmed', 'Cleaner',      '2025-11-10', 28.0,03284473086),
(3, 'Usman Raza', 'Manager',      '2025-06-01', 75.0,03284473087),
(4, 'Ayesha Noor','Accountant',   '2025-03-20', 60.0,03284473088);
-- =========================
INSERT INTO Members
(MemberID, Name, Gender, Age, Phone, Email, JoinDate, MembershipID )VALUES
(1,'Iqbal','M', 22,'03011223344','Iqbal@gmail.com', '2026-01-10',1),
(2, 'Sara', 'F',25,'03119887766','sara@gmail.com',  '2026-01-05',2),
(3, 'Raza', 'M', 28, '03225556677','raza@gmail.com','2026-01-05',3),
(4,'Noor','F', 21,'03334445566','noor@gmail.com', '2026-01-15', 1);
-- ================================
INSERT INTO WorkoutSession
(SessionID, TrainerID, StartTime, EndTime, SessionDate,MemberID)VALUES
(1, 1, '07:00:00', '08:00:00', '2026-01-10',1),
(2, 2, '08:30:00', '09:30:00', '2026-01-11',2),
(3, 3, '17:00:00', '18:00:00', '2026-01-12',3),
(4, 4, '18:30:00', '20:00:00', '2026-01-13',4);
-- =========================
INSERT INTO Attendance
(AttendanceID, MemberID, SessionID, AttendanceDate,StaffAttemdanceStatus,MemberAttendanceStatus)VALUES
(1, 1,  1, '2026-01-10', 'Present','prestent'),
(2, 2,  2, '2026-01-11', 'Present','present'),
(3, 3,  3, '2026-01-12', 'Absent','Absent'),
(4, 4,  1, '2026-01-13', 'Absent','Absent');
-- =========================
INSERT INTO Payment
(PaymentID, MemberID, Amount, PaymentMethod, PaymentDate)VALUES
(7, 1, 1,  'Cash', '2026-01-13 10:00:00'),
(5, 2, 2,  'Card', '2026-01-13 15:30:00'),
(8, 3, 3,  'Bank Transfer', '2026-01-13 09:45:00'),
(6, 4, 1, 'Cash', '2026-01-13 12:15:00');
-- =========================
INSERT INTO MTRelationship (TrainerID, MemberID)VALUES
(1, 1),(2, 2),(3, 3),(4, 4);
-- =========================
INSERT INTO EquipmentUse (MemberID, EquipmentID)VALUES
(1, 1),(2, 2),(3, 3),(4, 1);
INSERT INTO MWrelation (MemberID, SessionID)VALUES
(1, 1),(2, 2),(3, 3),(4, 4);
-- =========================
INSERT INTO Maintains (StaffID, EquipmentID)VALUES
(1, 1),(2, 2),(3, 3),(4, 3);
INSERT INTO SARelationship (StaffID, AttendanceID)
VALUES (1,1), (2,2);

INSERT INTO MARelationship (MemberID, AttendanceID)
VALUES (1,1), (2,2), (3,3);
INSERT INTO Maintains (StaffID, EquipmentID)
VALUES (1,2),(2,3),(3,1),(4,2);

show tables;
