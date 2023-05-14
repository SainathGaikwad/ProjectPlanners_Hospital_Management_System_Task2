-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2023 at 08:52 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `Employee_ID` varchar(45) NOT NULL,
  `Employee_Type` int(1) NOT NULL,
  `Specialty` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`Employee_ID`, `Employee_Type`, `Specialty`) VALUES
('d1', 1, 'Radiology'),
('d10', 1, 'Oncology');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `Employee_ID` varchar(45) NOT NULL,
  `Employee_Type` int(10) NOT NULL,
  `FName` varchar(45) NOT NULL,
  `LName` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`Employee_ID`, `Employee_Type`, `FName`, `LName`) VALUES
('d1', 1, 'ragini', 'joshi'),
('d10', 1, 'krishna', 'dumanwar'),
('r14', 3, 'mansi', 'kalse'),
('r15', 3, 'yash katkamwar', 'katkamwar'),
('r16', 3, 'aaaaaaaa', 'bbbbbbb'),
('r17', 3, 'cccccc', 'dddddddd'),
('r18', 3, 'eeeeeeeee', 'fffffff'),
('r19', 3, 'ggggg', 'hhh'),
('r2', 3, 'iii', 'jjjj'),
('r20', 3, 'kkkk', 'lll'),
('r3', 3, 'mmmm', 'mmm'),
('r4', 3, 'nnn', 'ww'),
('r5', 3, 'qqqq', 'aaaaaaa'),
('r6', 3, 'Sanddiey', 'Prestton'),
('r7', 3, 'Fayyez', 'Butterrs'),
('r8', 3, 'Jaammes', 'Smitth'),
('r9', 3, 'Karrenn', 'Moorre');

--
-- Triggers `employee`
--
DELIMITER $$
CREATE TRIGGER `employee_AFTER_INSERT` AFTER INSERT ON `employee` FOR EACH ROW BEGIN
    IF new.Employee_Type = 1 then
	Insert into doctor(Employee_ID, Employee_Type) 
    values(new.Employee_ID, new.Employee_Type);
    elseif new.Employee_Type = 2 then
	Insert into nurse(Employee_ID, Employee_Type) 
    values(new.Employee_ID, new.Employee_Type);
	elseif new.Employee_Type = 3 then
	Insert into receptionist(Employee_ID, Employee_Type) 
    values(new.Employee_ID, new.Employee_Type);
    end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employee_has_patient`
--

CREATE TABLE `employee_has_patient` (
  `employee_Employee_ID` varchar(45) NOT NULL,
  `patient_patient_ID` varchar(45) NOT NULL,
  `employee_Type` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee_has_patient`
--

INSERT INTO `employee_has_patient` (`employee_Employee_ID`, `patient_patient_ID`, `employee_Type`) VALUES
('d1', 'p1', 1);

--
-- Triggers `employee_has_patient`
--
DELIMITER $$
CREATE TRIGGER `employee_has_patient_BEFORE_INSERT` BEFORE INSERT ON `employee_has_patient` FOR EACH ROW BEGIN
     set new.employee_Type = (select Employee_Type from employee where Employee_ID = new.employee_Employee_ID);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `Employee_ID` varchar(45) NOT NULL,
  `Employee_Type` int(1) NOT NULL,
  `Specialty` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_ID` varchar(45) NOT NULL,
  `Fname` varchar(45) NOT NULL,
  `Lname` varchar(45) NOT NULL,
  `Minit` varchar(1) DEFAULT NULL,
  `Birthday` varchar(10) DEFAULT NULL,
  `Sex` varchar(10) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Weight` decimal(10,0) DEFAULT NULL,
  `Height` decimal(10,0) DEFAULT NULL,
  `blood_type` varchar(2) DEFAULT NULL,
  `chief_complaint` varchar(45) DEFAULT NULL,
  `diagnosis` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_ID`, `Fname`, `Lname`, `Minit`, `Birthday`, `Sex`, `Address`, `Weight`, `Height`, `blood_type`, `chief_complaint`, `diagnosis`) VALUES
('g10', 'sai', 'gaikwad', 'a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
('p1', 'gargi', 'deshmukh', 'M', '5/3/1996', 'F', 'Nanded', '177', '68', 'AB', 'Stomach ache', 'Food Poisoning'),
('p10', 'pushkar ', 'wane', 'P', '1/9/2010', 'M', 'Hingoli', '187', '70', 'AB', 'Can\'t focus', 'ADHD'),
('p7', 'aditya', 'chavan', 'M', '3/15/2002', 'F', 'Hyderabad', '147', '65', 'O', 'Head Hurts', 'High Blood Pressure');

--
-- Triggers `patient`
--
DELIMITER $$
CREATE TRIGGER `patient_AFTER_INSERT` AFTER INSERT ON `patient` FOR EACH ROW BEGIN
   Insert into patient_record(patient_ID)
   values(new.patient_ID);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `patient_record`
--

CREATE TABLE `patient_record` (
  `record_ID` int(45) NOT NULL,
  `patient_ID` varchar(45) NOT NULL,
  `date_admitted` timestamp NULL DEFAULT NULL,
  `date_released` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `patient_record`
--

INSERT INTO `patient_record` (`record_ID`, `patient_ID`, `date_admitted`, `date_released`) VALUES
(33, 'p1', '2005-09-21 14:56:43', '2015-06-16 04:14:44'),
(39, 'p7', '2004-12-20 07:32:39', '2010-03-25 08:28:54'),
(42, 'p10', '2010-03-25 08:28:54', '2004-12-20 07:32:39'),
(52, 'g10', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `receptionist`
--

CREATE TABLE `receptionist` (
  `Employee_ID` varchar(45) NOT NULL,
  `Employee_Type` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `receptionist`
--

INSERT INTO `receptionist` (`Employee_ID`, `Employee_Type`) VALUES
('r14', 3),
('r15', 3),
('r16', 3),
('r17', 3),
('r18', 3),
('r19', 3),
('r2', 3),
('r20', 3),
('r3', 3),
('r4', 3),
('r5', 3),
('r6', 3),
('r7', 3),
('r8', 3),
('r9', 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`Employee_ID`),
  ADD KEY `FK_Doctor` (`Employee_ID`,`Employee_Type`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`Employee_ID`),
  ADD UNIQUE KEY `UQ_Employee` (`Employee_ID`,`Employee_Type`);

--
-- Indexes for table `employee_has_patient`
--
ALTER TABLE `employee_has_patient`
  ADD PRIMARY KEY (`employee_Employee_ID`,`patient_patient_ID`),
  ADD KEY `fk_employee_has_patient_patient1_idx` (`patient_patient_ID`),
  ADD KEY `fk_employee_has_patient_employee1_idx` (`employee_Employee_ID`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`Employee_ID`),
  ADD KEY `FK_Nurse` (`Employee_ID`,`Employee_Type`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_ID`);

--
-- Indexes for table `patient_record`
--
ALTER TABLE `patient_record`
  ADD PRIMARY KEY (`record_ID`,`patient_ID`),
  ADD KEY `FK_patient_ID` (`patient_ID`);

--
-- Indexes for table `receptionist`
--
ALTER TABLE `receptionist`
  ADD PRIMARY KEY (`Employee_ID`),
  ADD KEY `FK_Recpetionist` (`Employee_ID`,`Employee_Type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `patient_record`
--
ALTER TABLE `patient_record`
  MODIFY `record_ID` int(45) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `FK_Doctor` FOREIGN KEY (`Employee_ID`,`Employee_Type`) REFERENCES `employee` (`Employee_ID`, `Employee_Type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `employee_has_patient`
--
ALTER TABLE `employee_has_patient`
  ADD CONSTRAINT `fk_employee_has_patient_employee1` FOREIGN KEY (`employee_Employee_ID`) REFERENCES `employee` (`Employee_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_employee_has_patient_patient1` FOREIGN KEY (`patient_patient_ID`) REFERENCES `patient` (`patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `nurse`
--
ALTER TABLE `nurse`
  ADD CONSTRAINT `FK_Nurse` FOREIGN KEY (`Employee_ID`,`Employee_Type`) REFERENCES `employee` (`Employee_ID`, `Employee_Type`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patient_record`
--
ALTER TABLE `patient_record`
  ADD CONSTRAINT `FK_patient_ID` FOREIGN KEY (`patient_ID`) REFERENCES `patient` (`patient_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `receptionist`
--
ALTER TABLE `receptionist`
  ADD CONSTRAINT `FK_Recpetionist` FOREIGN KEY (`Employee_ID`,`Employee_Type`) REFERENCES `employee` (`Employee_ID`, `Employee_Type`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
