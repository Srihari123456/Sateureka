-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 16, 2020 at 12:06 PM
-- Server version: 10.1.40-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `satdb`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetScientistLevel` (IN `EmployeeNumber` VARCHAR(4), OUT `EmployeeLevel` VARCHAR(20))  BEGIN
    DECLARE credit DECIMAL(10,2) ;
 
    SELECT salary 
    INTO credit
    FROM salary_info
    WHERE emp_id =  EmployeeNumber;
 
    IF( credit > 50000 )THEN
        SET EmployeeLevel = 'PLATINUM';
    ELSEIF (credit <= 50000 AND credit > 10000 )THEN
        SET EmployeeLevel = 'GOLD';
    ELSE
        SET EmployeeLevel = 'SILVER';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_scientist_profile` (IN `names` VARCHAR(40), OUT `de_pos` VARCHAR(40), OUT `de_exp` VARCHAR(40), OUT `de_sat` VARCHAR(40), OUT `de_m` VARCHAR(40))  NO SQL
BEGIN   
DECLARE de_names VARCHAR( 40 ) DEFAULT "";
DECLARE de_nams VARCHAR( 40 ) DEFAULT ""; 
DECLARE de_na VARCHAR( 40 ) DEFAULT "";
DECLARE de_n VARCHAR( 40 ) DEFAULT ""; 

SELECT POSITION INTO de_names FROM scientists WHERE emp_id = names;  
SELECT EXPERTISE INTO de_nams FROM scientists WHERE emp_id = names;
SELECT sat_name INTO de_na FROM scientists NATURAL JOIN mission NATURAL JOIN satellites WHERE emp_id = names;  

SELECT mission_name INTO de_n FROM scientists NATURAL JOIN mission NATURAL JOIN satellites WHERE emp_id = names;  


 SET de_exp = de_nams;
 SET de_pos = de_names;
 SET de_sat = de_na;
 SET de_m = de_n;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `list_name` (IN `loc` VARCHAR(20), INOUT `name_list` VARCHAR(400))  NO SQL
BEGIN
DECLARE is_done INTEGER DEFAULT 0;
DECLARE s_name varchar(200) DEFAULT "";
DECLARE stud_cursor CURSOR FOR
SELECT ename FROM organisation NATURAL JOIN intern NATURAL JOIN scientists WHERE location = loc;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET is_done = 1;
OPEN stud_cursor;
get_list : LOOP
FETCH stud_cursor INTO s_name;
IF is_done = 1 THEN
LEAVE get_list;
END IF;
SET name_list = CONCAT(s_name,' ;', name_list);
END LOOP get_list;
CLOSE stud_cursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MissionName` (IN `Empid` VARCHAR(4), OUT `M_Name` VARCHAR(20), OUT `S_Name` VARCHAR(20))  NO SQL
BEGIN
    DECLARE mid VARCHAR(100);
 
SELECT 
    mission_id
INTO mid FROM
    scientists
WHERE
    emp_id = Empid;
 
    CASE mid
        WHEN  'M001' THEN
           SET M_Name = 'Mahabali';
           SET S_Name = 'Ladee';
        WHEN 'M002' THEN
           SET M_Name = 'Grahanam';
           SET S_Name = 'Chandrayaan-2';
        WHEN  'M003' THEN
           SET M_Name = 'Jatayu';
           SET S_Name = 'Maven';
        WHEN 'M004' THEN
           SET M_Name = 'Mars Orbiter Mission';
           SET S_Name = 'Mangalyaan';
        WHEN  'M005' THEN
           SET M_Name = 'Shukyayaan';
           SET S_Name = 'Saral';
        WHEN 'M006' THEN
           SET M_Name = 'Aditya-1';
           SET S_Name = 'Galex';
        WHEN  'M007' THEN
           SET M_Name = 'Akshara';
           SET S_Name = 'Cartosat-2';
        WHEN 'M008' THEN
           SET M_Name = 'NISAR';
           SET S_Name = 'INSAT-3A';
        WHEN  'M009' THEN
           SET M_Name = 'Gaganyaan';
           SET S_Name = 'Bhaskara';
        WHEN 'M010' THEN
           SET M_Name = 'Astrosat';
           SET S_Name = 'Mariner';
                                                       
        ELSE
           SET M_Name = 'Enter a valid mission no';
           SET S_Name = ' ';
    END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Salary_in_lakhs(procedure)` (IN `e` VARCHAR(4), OUT `c` DECIMAL(8,4))  NO SQL
BEGIN
DECLARE D INT ;

SELECT salary into D from `salary_info` where emp_id = e;

SET c = D/100000;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_astronaut_role` (`inpname` VARCHAR(20)) RETURNS VARCHAR(60) CHARSET latin1 NO SQL
BEGIN   
DECLARE de_name VARCHAR( 60 ) DEFAULT "";  
SELECT role INTO de_name FROM astronauts NATURAL JOIN assigned_astro WHERE Astro_name = inpname;  
RETURN de_name;  
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_scientist_level_function` (`EmployeeNumber` VARCHAR(4)) RETURNS VARCHAR(20) CHARSET latin1 NO SQL
BEGIN
    DECLARE EmployeeLevel VARCHAR(20) ;
 	DECLARE credit INT;
    
    SELECT salary 
    INTO credit
    FROM salary_info
    WHERE emp_id =  EmployeeNumber;
 
    IF( credit > 50000 )THEN
        SET EmployeeLevel = 'PLATINUM';
    ELSEIF (credit <= 50000 AND credit > 10000 )THEN
        SET EmployeeLevel = 'GOLD';
    ELSE
        SET EmployeeLevel = 'SILVER';
    END IF;
    RETURN  EmployeeLevel;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Mission_Status` (`mid` VARCHAR(4)) RETURNS VARCHAR(20) CHARSET latin1 NO SQL
BEGIN
DECLARE C VARCHAR(20) ;

SELECT sat_status into C from `mission` natural join `satellites` where mission_id = mid;

RETURN C;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Payload_proportion(in percentage)` (`s` VARCHAR(4)) RETURNS FLOAT NO SQL
    DETERMINISTIC
BEGIN
DECLARE C NUMERIC(6,6) ;

SELECT payload_prop into C from `payload` where sat_id = s;

RETURN C*100;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `Salary(In lakhs)` (`e` VARCHAR(4)) RETURNS DECIMAL(8,4) NO SQL
BEGIN
DECLARE C INT ;

SELECT salary into C from `salary_info` where emp_id = e;

RETURN C/100000;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `uname` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `emp_id` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`uname`, `password`, `emp_id`) VALUES
('\'Srihari\'', '\'Srihari\'', 'E-01'),
('test', 'pwd', 'E-05'),
('srihari', 's', 'E-16'),
('ssk', 'ssk', 'E-04');

-- --------------------------------------------------------

--
-- Stand-in structure for view `active - satellites`
-- (See below for the actual view)
--
CREATE TABLE `active - satellites` (
`sat_id` varchar(4)
,`sat_name` varchar(25)
,`purpose` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `assigned_astro`
--

CREATE TABLE `assigned_astro` (
  `astro_id` varchar(4) DEFAULT NULL,
  `mission_id` varchar(4) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `assigned_astro`
--

INSERT INTO `assigned_astro` (`astro_id`, `mission_id`, `role`) VALUES
('A-01', 'M001', 'Commanding and piloting space shuttle'),
('A-02', 'M002', 'Respond to and report to emergencies'),
('A-03', 'M003', 'Conduct tests and experiments in zero gravity'),
('A-08', 'M001', 'Communicating constantly with guard and mission co'),
('A-09', 'M002', 'Breif with mission headquarters about upcoming ass'),
('A-10', 'M003', 'Respond to and report emergencies'),
('A-11', 'M005', 'Breif with mission headquarters about upcoming ass'),
('A-14', 'M006', 'Commanding and piloting space shuttle'),
('A-16', 'M007', 'Respond to and report emergencies'),
('A-18', 'M008', 'Commanding and piloting space shuttle'),
('A-19', 'M010', 'Communicating constantly with guard and mission co'),
('A-07', 'M007', 'Conduct tests and experiments in zero gravity'),
('A-06', 'M001', 'Commanding and piloting space shuttle'),
('A-07', 'M001', 'Commanding and piloting space shuttle');

--
-- Triggers `assigned_astro`
--
DELIMITER $$
CREATE TRIGGER `astro_status` BEFORE INSERT ON `assigned_astro` FOR EACH ROW update astronauts set astro_status='Fit' where astro_id=new.astro_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `astronauts`
--

CREATE TABLE `astronauts` (
  `astro_id` varchar(4) NOT NULL,
  `Astro_name` varchar(15) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `weight_kg` int(11) DEFAULT NULL,
  `astro_status` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `astronauts`
--

INSERT INTO `astronauts` (`astro_id`, `Astro_name`, `DOB`, `weight_kg`, `astro_status`) VALUES
('A-01', 'Kiran', '2000-01-01', 60, 'Fit'),
('A-02', 'Karthick Raja', '2000-02-02', 55, 'Fit'),
('A-03', 'Srihari', '1949-03-03', 55, 'Fit'),
('A-04', 'Ananya', '1997-04-04', 80, 'Unfit'),
('A-05', 'Geroge', '1996-05-05', 70, 'Unfit'),
('A-06', 'Tessa', '1995-06-06', 40, 'Fit'),
('A-07', 'Larrissa', '1997-07-07', 55, 'Fit'),
('A-08', 'Tim Bone', '1994-08-08', 50, 'Fit'),
('A-09', 'Mandy', '1993-09-09', 52, 'Fit'),
('A-10', 'Reshmi', '1992-10-10', 62, 'Fit'),
('A-11', 'Keshika', '1991-11-11', 85, 'Fit'),
('A-12', 'Roshini', '1989-12-12', 35, 'Unfit'),
('A-13', 'Nisherita', '1990-01-02', 45, 'Unfit'),
('A-14', 'Arun', '1990-02-03', 35, 'Fit'),
('A-15', 'Roopesh', '1989-03-04', 45, 'Unfit'),
('A-16', 'Vaishakh', '1988-04-05', 45, 'Fit'),
('A-17', 'Vaishnav', '1999-05-06', 55, 'Unfit'),
('A-18', 'Shefali', '1999-05-07', 60, 'Fit'),
('A-19', 'Vineeta', '2001-09-09', 70, 'Fit'),
('A-20', 'Susy', '1995-10-11', 68, 'Unfit');

-- --------------------------------------------------------

--
-- Table structure for table `chatbox`
--

CREATE TABLE `chatbox` (
  `cid` int(11) NOT NULL,
  `message` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chatbox`
--

INSERT INTO `chatbox` (`cid`, `message`) VALUES
(10, 'what is this project');

-- --------------------------------------------------------

--
-- Stand-in structure for view `fit-astronauts`
-- (See below for the actual view)
--
CREATE TABLE `fit-astronauts` (
`astro_id` varchar(4)
,`Astro_name` varchar(15)
,`weight_kg` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `intern`
--

CREATE TABLE `intern` (
  `org_id` varchar(4) DEFAULT NULL,
  `stipend` int(11) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `emp_id` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `intern`
--

INSERT INTO `intern` (`org_id`, `stipend`, `duration`, `emp_id`) VALUES
('O-08', 25000, '6 months', 'E-21'),
('O-08', 13000, '4 months', 'E-22'),
('O-13', 5000, '4 months', 'E-23'),
('O-09', 62000, '7 months', 'E-24'),
('O-01', 180000, '3 months', 'E-25'),
('O-12', 20000, '2 months', 'E-26'),
('O-07', 20000, '1 months', 'E-27'),
('O-11', 6070, '2 months', 'E-28'),
('O-06', 1100, '1 months', 'E-29'),
('O-10', 88800, '3 months', 'E-30'),
('O-10', 200000, '6 months', 'E-31'),
('O-09', 10100, '5 months', 'E-32'),
('O-15', 200000, '1 year', 'E-33'),
('O-16', 400000, '18 months', 'E-34'),
('O-02', 180000, '11 months', 'E-35'),
('O-18', 18000, '1 months', 'E-36'),
('O-17', 20000, '2 weeks', 'E-37'),
('O-03', 116000, '2 months', 'E-38'),
('O-18', 20000, '14 weeks', 'E-39'),
('O-04', 15000, '3 months', 'E-40'),
('O-19', 14000, '4 months', 'E-41'),
('O-05', 115000, '5 months', 'E-42'),
('O-20', 50000, '6 months', 'E-43'),
('O-06', 5000, '1 months', 'E-44'),
('O-07', 1000, '1 week', 'E-45'),
('O-14', 10000, '6 months', 'E-70'),
('O-08', 25000, '6 months', 'E-71'),
('O-08', 13000, '4 months', 'E-72'),
('O-13', 5000, '4 months', 'E-73'),
('O-09', 62000, '7 months', 'E-74'),
('O-01', 180000, '3 months', 'E-75'),
('O-12', 20000, '2 months', 'E-76'),
('O-07', 20000, '1 months', 'E-77'),
('O-11', 6070, '2 months', 'E-78'),
('O-06', 1100, '1 months', 'E-79'),
('O-10', 88800, '3 months', 'E-80'),
('O-10', 200000, '6 months', 'E-81'),
('O-09', 10100, '5 months', 'E-82'),
('O-15', 200000, '1 year', 'E-83'),
('O-16', 400000, '18 months', 'E-84'),
('O-02', 180000, '11 months', 'E-85'),
('O-14', 10000, '6 months', 'E-20');

--
-- Triggers `intern`
--
DELIMITER $$
CREATE TRIGGER `intern_checker` BEFORE INSERT ON `intern` FOR EACH ROW BEGIN
UPDATE `organisation_count` set `count_of_interns` = `count_of_interns` + 1 where org_id = new.org_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `intern_dechecker` BEFORE DELETE ON `intern` FOR EACH ROW begin
UPDATE `organisation_count` set `count_of_interns` = `count_of_interns` -1 where org_id = old.org_id;
delete from `scientists` where emp_id = old.emp_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `internship`
-- (See below for the actual view)
--
CREATE TABLE `internship` (
`emp_id` varchar(4)
,`ename` varchar(20)
,`org_id` varchar(4)
,`name` varchar(40)
,`duration` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mentors`
-- (See below for the actual view)
--
CREATE TABLE `mentors` (
`emp_id` varchar(4)
,`ename` varchar(20)
,`EXPERTISE` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `mission`
--

CREATE TABLE `mission` (
  `mission_id` varchar(4) NOT NULL,
  `mission_name` varchar(20) DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `no_of_memebers` int(11) DEFAULT NULL,
  `sat_id` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mission`
--

INSERT INTO `mission` (`mission_id`, `mission_name`, `deadline`, `no_of_memebers`, `sat_id`) VALUES
('M001', 'Mahabali', '2018-03-15', 87, 'S017'),
('M002', 'Grahanam', '2019-11-21', 122, 'S005'),
('M003', 'Jatayu', '2019-04-15', 94, 'S014'),
('M004', 'Mars Orbiter Mission', '2016-04-24', 127, 'S020'),
('M005', 'Shukyayaan', '2013-06-01', 221, 'S009'),
('M006', 'Aditya-1', '2016-03-25', 81, 'S019'),
('M007', 'Akshara', '2015-06-10', 93, 'S006'),
('M008', 'NISAR', '2009-02-15', 99, 'S008'),
('M009', 'Gaganyaan', '2017-09-12', 222, 'S011'),
('M010', 'Astrosat', '2016-05-14', 113, 'S018');

-- --------------------------------------------------------

--
-- Table structure for table `organisation`
--

CREATE TABLE `organisation` (
  `org_id` varchar(4) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `location` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organisation`
--

INSERT INTO `organisation` (`org_id`, `name`, `location`) VALUES
('O-01', 'IIT-Madras', 'Chennai'),
('O-02', 'IIT-Bombay', 'Mumbai'),
('O-03', 'IISC-Bangalore', 'Bangalore'),
('O-04', 'Symbiosis', 'Pune'),
('O-05', 'Aligarh Institute', 'Punjab'),
('O-06', 'NIT-Roorkee', 'Roorkee'),
('O-07', 'Anna University', 'Chennai'),
('O-08', 'Patiala Institute', 'Punjab'),
('O-09', 'SIMS', 'Andra Pradesh'),
('O-10', 'AIIMS', 'Delhi'),
('O-11', 'HITS', 'Chandigarh'),
('O-12', 'Vivekananda Coleege', 'Madhya Pradesh'),
('O-13', 'Jamia Millia Islamia', 'Telangana'),
('O-14', 'Jawaharlal Nehru Institute', 'Sikkim'),
('O-15', 'St.John College of Arts', 'Kerala'),
('O-16', 'University of Calicut', 'Jaipur'),
('O-17', 'Dr. APJ Abdul Kalam Institute of Eminenc', 'Lucknow'),
('O-18', 'Vardhman Mahaveer Institute', 'Kota'),
('O-19', 'Jiwaji University', 'Gwalior'),
('O-20', 'Osmania University', 'Hyderabad');

-- --------------------------------------------------------

--
-- Table structure for table `organisation_count`
--

CREATE TABLE `organisation_count` (
  `org_id` varchar(4) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `count_of_interns` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `organisation_count`
--

INSERT INTO `organisation_count` (`org_id`, `name`, `count_of_interns`) VALUES
('O-01', 'IIT-Madras', 2),
('O-02', 'IIT-Bombay', 2),
('O-03', 'IISC-Bangalore', 1),
('O-04', 'Symbiosis', 1),
('O-05', 'Aligarh Institute', 1),
('O-06', 'NIT-Roorkee', 3),
('O-07', 'Anna University', 3),
('O-08', 'Patiala Institute', 4),
('O-09', 'SIMS', 4),
('O-10', 'AIIMS', 4),
('O-11', 'HITS', 2),
('O-12', 'Vivekananda Coleege', 2),
('O-13', 'Jamia Millia Islamia', 2),
('O-14', 'Jawaharlal Nehru Institute', 2),
('O-15', 'St.John College of Arts', 2),
('O-16', 'University of Calicut', 2),
('O-17', 'Dr. APJ Abdul Kalam Institute of Eminence', 1),
('O-18', 'Vardhman Mahaveer Institute', 2),
('O-19', 'Jiwaji University', 1),
('O-20', 'Osmania University', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payload`
--

CREATE TABLE `payload` (
  `rocket_id` varchar(3) DEFAULT NULL,
  `sat_id` varchar(4) DEFAULT NULL,
  `fuel` varchar(20) DEFAULT NULL,
  `payload_prop` float DEFAULT NULL,
  `capacity_tons` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payload`
--

INSERT INTO `payload` (`rocket_id`, `sat_id`, `fuel`, `payload_prop`, `capacity_tons`) VALUES
('R08', 'S020', '120', 0.02506, 3),
('R09', 'S019', '390', 0.05341, 1),
('R10', 'S018', '120', 0.03409, 3),
('R11', 'S017', '852', 0.0263, 1),
('R12', 'S016', '360', 0.0225, 1),
('R13', 'S015', '407', 0.0433, 1),
('R14', 'S014', '882', 0.0649, 1),
('R15', 'S013', '819', 0.0141, 1),
('R16', 'S012', '120', 0.1971, 1),
('R17', 'S011', '120', 0.0435, 2),
('R18', 'S010', '334', 0.09346, 1),
('R19', 'S009', '345', 0.0465, 2),
('R20', 'S008', '1887', 0.1666, 2),
('R21', 'S007', '600', 0.2597, 1),
('R01', 'S006', '155', 0.43478, 1),
('R02', 'S005', '810', 0.5, 1),
('R03', 'S004', '992', 0.5, 1),
('R04', 'S003', '455', 0.4503, 1),
('R05', 'S002', '443', 0.5031, 1),
('R06', 'S001', '331', 0.4434, 1);

--
-- Triggers `payload`
--
DELIMITER $$
CREATE TRIGGER `fuel_status` AFTER UPDATE ON `payload` FOR EACH ROW begin
if (new.fuel < 0.5*old.fuel)
then
update `satellites` set `sat_status` = "Fuel Warning" where sat_id = new.sat_id;
end if;

if (new.fuel > 0.75*old.fuel)
then
update `satellites` set `sat_status` = "Active" where sat_id = new.sat_id;
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `resigned_or_retired`
--

CREATE TABLE `resigned_or_retired` (
  `emp_id` varchar(4) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resigned_or_retired`
--

INSERT INTO `resigned_or_retired` (`emp_id`, `ename`, `dob`, `position`) VALUES
('E-01', 'ERWIN', '1991-01-12', 'shuttle launch director'),
('E-20', 'Blake', '1991-01-12', 'Software Engineer'),
('E991', 'srihari', '1978-03-23', 'shuttle launch director');

-- --------------------------------------------------------

--
-- Table structure for table `rocket`
--

CREATE TABLE `rocket` (
  `rocket_id` varchar(3) NOT NULL,
  `rocketname` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rocket`
--

INSERT INTO `rocket` (`rocket_id`, `rocketname`) VALUES
('R01', 'Atlas-Agena'),
('R02', 'Thor-Delta'),
('R03', 'Scout'),
('R04', 'Rehbar I'),
('R05', 'Saturn V'),
('R06', 'Ariane 5'),
('R07', 'Atlas-Centaur'),
('R08', 'Titan IIIB'),
('R09', 'Thor Burner'),
('R10', 'Apollo 11'),
('R11', 'Vanguard'),
('R12', 'Juno I'),
('R13', 'Atlas Able'),
('R14', 'Space shuttle'),
('R15', 'Taurus'),
('R16', 'Minotaur-C'),
('R17', 'Pegasus'),
('R18', 'Falcon I'),
('R19', 'Electron'),
('R20', 'Deacon'),
('R21', 'Skylark');

-- --------------------------------------------------------

--
-- Table structure for table `salary_info`
--

CREATE TABLE `salary_info` (
  `emp_id` varchar(4) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `salary_info`
--

INSERT INTO `salary_info` (`emp_id`, `salary`) VALUES
('E-02', 800000),
('E-03', 1600000),
('E-04', 1000000),
('E-05', 1200000),
('E-06', 600000),
('E-07', 300000),
('E-08', 200000),
('E-09', 80000),
('E-10', 95000),
('E-11', 200000),
('E-12', 300000),
('E-13', 250000),
('E-14', 350000),
('E-15', 450000),
('E-16', 135000),
('E-17', 155000),
('E-18', 125000),
('E-19', 115000),
('E-21', 25000),
('E-22', 35000),
('E-23', 45000),
('E-24', 45000),
('E-25', 45000),
('E-26', 45000),
('E-27', 45000),
('E-28', 45000),
('E-29', 45000),
('E-30', 45000),
('E-31', 335000),
('E-32', 35000),
('E-33', 35000),
('E-34', 35000),
('E-35', 35000),
('E-36', 35000),
('E-37', 35000),
('E-38', 35000),
('E-39', 35000),
('E-40', 35000),
('E-41', 23000),
('E-42', 13000),
('E-43', 43000),
('E-44', 67000),
('E-45', 20000),
('E-46', 1800000),
('E-47', 2000000),
('E-48', 1800000),
('E-49', 1800000),
('E-50', 1800000),
('E-61', 500000),
('E-62', 800000),
('E-63', 1600000),
('E-64', 1000000),
('E-65', 1200000),
('E-66', 600000),
('E-67', 300000),
('E-68', 200000),
('E-69', 80000),
('E-70', 95000),
('E-71', 200000),
('E-72', 300000),
('E-73', 250000),
('E-74', 350000),
('E-75', 450000),
('E-76', 135000),
('E-77', 155000),
('E-78', 125000),
('E-79', 115000),
('E-80', 100000),
('E-81', 25000),
('E-82', 35000),
('E-83', 45000),
('E-84', 45000),
('E-85', 45000),
('E-86', 45000),
('E-87', 45000),
('E-88', 45000),
('E-89', 45000),
('E-90', 45000),
('E-51', 335000),
('E-52', 35000),
('E-53', 35000),
('E-54', 35000),
('E-55', 35000),
('E-56', 35000),
('E-57', 35000),
('E-58', 35000),
('E-59', 35000),
('E-60', 35000),
('E-91', 23000),
('E-92', 13000),
('E-93', 43000),
('E-94', 67000),
('E-95', 20000),
('E-96', 1800000),
('E-97', 2000000),
('E-98', 1800000),
('E-99', 1800000),
('E-01', 8000000);

-- --------------------------------------------------------

--
-- Table structure for table `satellites`
--

CREATE TABLE `satellites` (
  `sat_id` varchar(4) NOT NULL,
  `sat_name` varchar(25) DEFAULT NULL,
  `purpose` varchar(50) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `sat_status` varchar(10) DEFAULT NULL,
  `POL` varchar(20) DEFAULT NULL,
  `DOL` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `satellites`
--

INSERT INTO `satellites` (`sat_id`, `sat_name`, `purpose`, `weight`, `sat_status`, `POL`, `DOL`) VALUES
('S001', 'Cartosat-1', 'Scientific Study', 5, 'Active', 'Calangute', '0000-00-00'),
('S002', 'Aryabhatta', 'Mineralogical mapping of lunar surface', 5, 'Active', 'Nellore', '2010-10-22'),
('S003', 'Chandrayaan-1', 'Chemical mapping of lunar surface', 2, 'Active', 'Sriharikota', '2008-08-02'),
('S004', 'RISAT-1', 'Topographic mapping of lunar surface', 3, 'Active', 'Nellore', '2012-10-10'),
('S005', 'Chandrayaan-2', 'Operate rover on surface', 5, 'Active', 'Sriharikota', '2019-11-19'),
('S006', 'Cartosat-2', 'Spot imageries', 5, 'Fuel Warni', 'Candolim', '2015-06-06'),
('S007', 'Kalpana-1', 'Collection of weather data', 4, 'Active', 'Arambol', '2008-04-04'),
('S008', 'INSAT-3A', 'Telecommunication and broadcast', 5, 'Active', 'Vagator', '2009-05-05'),
('S009', 'SARAL', 'Sea surface,wave heights,wind speed', 4, 'Fuel Warni', 'Sriharikota', '2013-06-01'),
('S010', 'OCEANSAT-I', 'Hydro existence in Pluto', 5, 'Active', 'Arambol', '2014-07-01'),
('S011', 'Bhaskara', 'Ability to soft landing', 4, 'Fuel Warni', 'Calangute', '2017-09-11'),
('S012', 'Juno', 'Reveal Jupiter formation', 3, 'Fuel Warni', 'Calangute', '2019-06-03'),
('S013', 'Mars Odyssey', 'Reveal Mars formation', 2, 'Active', 'Varkala', '2016-04-04'),
('S014', 'Maven', 'Degradation of atmosphere over time', 6, 'Active', 'Vagator', '2019-04-05'),
('S015', 'Sputnik', 'Satellite tester', 5, 'Active', 'Goa', '1999-12-02'),
('S016', 'Pioneer', 'Explore interplanetary medium', 3, 'Active', 'Vankala', '2000-01-03'),
('S017', 'Ladee', 'Demonstrate Operational capabilities', 3, 'Active', 'Arambol', '2004-08-05'),
('S018', 'Mariner', 'Venus Explanation', 4, 'Fuel Warni', 'Goa', '2007-02-18'),
('S019', 'Galex', 'Observe thousands of galaxies', 3, 'Active', 'Vagator', '2000-12-21'),
('S020', 'Mangalyaan', 'Demonstrate rocket launch system', 5, 'Fuel Warni', 'Sriharikota', '2016-04-24');

-- --------------------------------------------------------

--
-- Table structure for table `scientists`
--

CREATE TABLE `scientists` (
  `emp_id` varchar(4) NOT NULL,
  `ename` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `mission_id` varchar(4) DEFAULT NULL,
  `EXPERTISE` varchar(50) DEFAULT NULL,
  `POSITION` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scientists`
--

INSERT INTO `scientists` (`emp_id`, `ename`, `dob`, `mission_id`, `EXPERTISE`, `POSITION`) VALUES
('E-01', 'ERWIN', '0000-00-00', 'M001', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-02', 'Lakshman', '1991-01-12', 'M001', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-03', 'Srisha', '1991-01-12', 'M001', 'Navigation Expert', 'Launch Weather Officer'),
('E-04', 'Ramesh', '1991-01-12', 'M001', 'Satellite Designer', 'Engineering support head'),
('E-05', 'Aishwarya', '1991-01-12', 'M001', 'Payload Expert', 'Vehicle manager'),
('E-06', 'Ramya', '1991-01-12', 'M001', 'Structural Engineer', 'International Space Station Manager'),
('E-07', 'Siva', '1991-01-12', 'M001', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-08', 'Deepika', '1991-01-12', 'M001', 'System ENgineer', 'Chief engineer'),
('E-09', 'Arjun', '1991-01-12', 'M001', 'Operational InterCommunication', 'project director'),
('E-10', 'Karun', '1991-01-12', 'M001', 'Software Engineering', 'Software Engineer'),
('E-11', 'Navin', '1991-01-12', 'M002', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-12', 'Pallavi', '1991-01-12', 'M002', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-13', 'Akshaya', '1991-01-12', 'M002', 'Navigation Expert', 'Launch Weather Officer'),
('E-14', 'Pooja', '1991-01-12', 'M002', 'Satellite Designer', 'Engineering support head'),
('E-15', 'Sivesh', '1991-01-12', 'M002', 'Payload Expert', 'Vehicle manager'),
('E-16', 'Naresh', '1991-01-12', 'M002', 'Structural Engineer', 'International Space Station Manager'),
('E-17', 'Krithika', '1991-01-12', 'M002', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-18', 'Kamal', '1991-01-12', 'M002', 'System ENgineer', 'Chief engineer'),
('E-19', 'Ramki', '1991-01-12', 'M002', 'Operational InterCommunication', 'project director'),
('E-20', 'Blake', '1978-03-23', 'M002', 'Software Engineering', 'Software Engineer'),
('E-21', 'Jessica', '1991-01-12', 'M003', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-22', 'Huda', '1991-01-12', 'M003', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-23', 'Rupert', '1991-01-12', 'M003', 'Navigation Expert', 'Launch Weather Officer'),
('E-24', 'Sathish', '1991-01-12', 'M003', 'Satellite Designer', 'Engineering support head'),
('E-25', 'Dawan', '1991-01-12', 'M003', 'Payload Expert', 'Vehicle manager'),
('E-26', 'Darwin', '1991-01-12', 'M003', 'Structural Engineer', 'International Space Station Manager'),
('E-27', 'Nithya', '1991-01-12', 'M003', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-28', 'Nila', '1991-01-12', 'M003', 'System ENgineer', 'Chief engineer'),
('E-29', 'Mahesh', '1991-01-12', 'M003', 'Operational InterCommunication', 'project director'),
('E-30', 'Divya', '1991-01-12', 'M003', 'Software Engineering', 'Software Engineer'),
('E-31', 'Guru', '1991-01-12', 'M004', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-32', 'krish', '1991-01-12', 'M004', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-33', 'Vinay', '1991-01-12', 'M004', 'Navigation Expert', 'Launch Weather Officer'),
('E-34', 'Vineet', '1991-01-12', 'M004', 'Satellite Designer', 'Engineering support head'),
('E-35', 'MIshti', '1991-01-12', 'M004', 'Payload Expert', 'Vehicle manager'),
('E-36', 'Lavanya', '1991-01-12', 'M004', 'Structural Engineer', 'International Space Station Manager'),
('E-37', 'Dhanush', '1991-01-12', 'M004', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-38', 'Jegan', '1991-01-12', 'M004', 'System ENgineer', 'Chief engineer'),
('E-39', 'Anirudh', '1991-01-12', 'M004', 'Operational InterCommunication', 'project director'),
('E-40', 'Sourav', '1991-01-12', 'M004', 'Software Engineering', 'Software Engineer'),
('E-41', 'Rahul', '1991-01-12', 'M005', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-42', 'NIvedhs', '1991-01-12', 'M005', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-43', 'Siddharth', '1991-01-12', 'M005', 'Navigation Expert', 'Launch Weather Officer'),
('E-44', 'rohan', '1991-01-12', 'M005', 'Satellite Designer', 'Engineering support head'),
('E-45', 'Reshmi', '1991-01-12', 'M005', 'Payload Expert', 'Vehicle manager'),
('E-46', 'Ruper', '1991-01-12', 'M005', 'Structural Engineer', 'International Space Station Manager'),
('E-47', 'arj', '1991-01-12', 'M005', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-48', 'Jeg', '1991-01-12', 'M005', 'System ENgineer', 'Chief engineer'),
('E-49', 'Anirudh', '1991-01-12', 'M005', 'Operational InterCommunication', 'project director'),
('E-50', 'Souav', '1991-01-12', 'M005', 'Software Engineering', 'Software Engineer'),
('E-51', 'Rahul', '1991-01-12', 'M006', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-52', 'NIvedhs', '1991-01-12', 'M006', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-53', 'Siddharth', '1991-01-12', 'M006', 'Navigation Expert', 'Launch Weather Officer'),
('E-54', 'rohan', '1991-01-12', 'M006', 'Satellite Designer', 'Engineering support head'),
('E-55', 'Reshmi', '1991-01-12', 'M006', 'Payload Expert', 'Vehicle manager'),
('E-56', 'Ruper', '1991-01-12', 'M006', 'Structural Engineer', 'International Space Station Manager'),
('E-57', 'arj', '1991-01-12', 'M006', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-58', 'Jeg', '1991-01-12', 'M006', 'System ENgineer', 'Chief engineer'),
('E-59', 'Anirudh', '1991-01-12', 'M006', 'Operational InterCommunication', 'project director'),
('E-60', 'Souav', '1991-01-12', 'M006', 'Software Engineering', 'Software Engineer'),
('E-61', 'Guru', '1991-01-12', 'M007', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-62', 'krish', '1991-01-12', 'M007', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-63', 'Vinay', '1991-01-12', 'M007', 'Navigation Expert', 'Launch Weather Officer'),
('E-64', 'Vineet', '1991-01-12', 'M007', 'Satellite Designer', 'Engineering support head'),
('E-65', 'MIshti', '1991-01-12', 'M007', 'Payload Expert', 'Vehicle manager'),
('E-66', 'Lavanya', '1991-01-12', 'M007', 'Structural Engineer', 'International Space Station Manager'),
('E-67', 'Dhanush', '1991-01-12', 'M007', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-68', 'Jegan', '1991-01-12', 'M007', 'System ENgineer', 'Chief engineer'),
('E-69', 'Anirudh', '1991-01-12', 'M007', 'Operational InterCommunication', 'project director'),
('E-70', 'Sourav', '1991-01-12', 'M007', 'Software Engineering', 'Software Engineer'),
('E-71', 'Jessica', '1991-01-12', 'M008', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-72', 'Huda', '1991-01-12', 'M008', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-73', 'Rupert', '1991-01-12', 'M008', 'Navigation Expert', 'Launch Weather Officer'),
('E-74', 'Sathish', '1991-01-12', 'M008', 'Satellite Designer', 'Engineering support head'),
('E-75', 'Dawan', '1991-01-12', 'M008', 'Payload Expert', 'Vehicle manager'),
('E-76', 'Darwin', '1991-01-12', 'M008', 'Structural Engineer', 'International Space Station Manager'),
('E-77', 'Nithya', '1991-01-12', 'M008', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-78', 'Nila', '1991-01-12', 'M008', 'System ENgineer', 'Chief engineer'),
('E-79', 'Mahesh', '1991-01-12', 'M008', 'Operational InterCommunication', 'project director'),
('E-80', 'Divya', '1991-01-12', 'M008', 'Software Engineering', 'Software Engineer'),
('E-81', 'Navi', '1991-01-12', 'M009', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-82', 'Pallav', '1991-01-12', 'M009', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-83', 'Akshay', '1991-01-12', 'M009', 'Navigation Expert', 'Launch Weather Officer'),
('E-84', 'Pooj', '1991-01-12', 'M009', 'Satellite Designer', 'Engineering support head'),
('E-85', 'Sives', '1991-01-12', 'M009', 'Payload Expert', 'Vehicle manager'),
('E-86', 'Nares', '1991-01-12', 'M009', 'Structural Engineer', 'International Space Station Manager'),
('E-87', 'Krithika', '1991-01-12', 'M009', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-88', 'Kamal', '1991-01-12', 'M009', 'System ENgineer', 'Chief engineer'),
('E-89', 'Ramki', '1991-01-12', 'M009', 'Operational InterCommunication', 'project director'),
('E-90', 'Blake', '1991-01-12', 'M009', 'Software Engineering', 'Software Engineer'),
('E-91', 'ERWIN', '1991-01-12', 'M010', 'PROPULSION CONTROL EXPERT', 'shuttle launch director'),
('E-92', 'Lakshman', '1991-01-12', 'M010', 'Spacecraft Autonomy Designer', 'ground launch sequencer'),
('E-93', 'Srisha', '1991-01-12', 'M010', 'Navigation Expert', 'Launch Weather Officer'),
('E-94', 'Ramesh', '1991-01-12', 'M010', 'Satellite Designer', 'Engineering support head'),
('E-95', 'Aishwarya', '1991-01-12', 'M010', 'Payload Expert', 'Vehicle manager'),
('E-96', 'Ramya', '1991-01-12', 'M010', 'Structural Engineer', 'International Space Station Manager'),
('E-97', 'Siva', '1991-01-12', 'M010', 'Flight Hardware Monitor', 'Preflight Mission Chairman'),
('E-98', 'Deepika', '1991-01-12', 'M010', 'System ENgineer', 'Chief engineer'),
('E-99', 'Arjun', '1991-01-12', 'M010', 'Operational InterCommunication', 'project director');

--
-- Triggers `scientists`
--
DELIMITER $$
CREATE TRIGGER `resigned_or_retire` BEFORE DELETE ON `scientists` FOR EACH ROW BEGIN
INSERT INTO `resigned_or_retired`(`emp_id`,`ename`,`dob`,`position`) values (OLD.emp_id,OLD.ename,OLD.dob,OLD.position);
DELETE FROM `SALARY_INFO` WHERE emp_id = old.emp_id; 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `view_list`
--

CREATE TABLE `view_list` (
  `vid` int(11) DEFAULT NULL,
  `view_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `view_list`
--

INSERT INTO `view_list` (`vid`, `view_name`) VALUES
(0, 'active - satellites'),
(1, 'fit-astronauts'),
(2, 'internship'),
(3, 'mentors');

-- --------------------------------------------------------

--
-- Structure for view `active - satellites`
--
DROP TABLE IF EXISTS `active - satellites`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `active - satellites`  AS  select `satellites`.`sat_id` AS `sat_id`,`satellites`.`sat_name` AS `sat_name`,`satellites`.`purpose` AS `purpose` from `satellites` where (`satellites`.`sat_status` = 'Active') ;

-- --------------------------------------------------------

--
-- Structure for view `fit-astronauts`
--
DROP TABLE IF EXISTS `fit-astronauts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `fit-astronauts`  AS  select `astronauts`.`astro_id` AS `astro_id`,`astronauts`.`Astro_name` AS `Astro_name`,`astronauts`.`weight_kg` AS `weight_kg` from `astronauts` where (`astronauts`.`astro_status` = 'Fit') ;

-- --------------------------------------------------------

--
-- Structure for view `internship`
--
DROP TABLE IF EXISTS `internship`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `internship`  AS  select `intern`.`emp_id` AS `emp_id`,`scientists`.`ename` AS `ename`,`organisation`.`org_id` AS `org_id`,`organisation`.`name` AS `name`,`intern`.`duration` AS `duration` from ((`organisation` join `intern` on((`organisation`.`org_id` = `intern`.`org_id`))) join `scientists` on((`intern`.`emp_id` = `scientists`.`emp_id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `mentors`
--
DROP TABLE IF EXISTS `mentors`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mentors`  AS  select `scientists`.`emp_id` AS `emp_id`,`scientists`.`ename` AS `ename`,`scientists`.`EXPERTISE` AS `EXPERTISE` from `scientists` where (not(`scientists`.`emp_id` in (select `intern`.`emp_id` from `intern`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `assigned_astro`
--
ALTER TABLE `assigned_astro`
  ADD KEY `astro_id` (`astro_id`),
  ADD KEY `mission_id` (`mission_id`);

--
-- Indexes for table `astronauts`
--
ALTER TABLE `astronauts`
  ADD PRIMARY KEY (`astro_id`);

--
-- Indexes for table `chatbox`
--
ALTER TABLE `chatbox`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `intern`
--
ALTER TABLE `intern`
  ADD KEY `org_id` (`org_id`),
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `mission`
--
ALTER TABLE `mission`
  ADD PRIMARY KEY (`mission_id`),
  ADD KEY `sat_id` (`sat_id`);

--
-- Indexes for table `organisation`
--
ALTER TABLE `organisation`
  ADD PRIMARY KEY (`org_id`);

--
-- Indexes for table `payload`
--
ALTER TABLE `payload`
  ADD KEY `rocket_id` (`rocket_id`),
  ADD KEY `sat_id` (`sat_id`);

--
-- Indexes for table `resigned_or_retired`
--
ALTER TABLE `resigned_or_retired`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `rocket`
--
ALTER TABLE `rocket`
  ADD PRIMARY KEY (`rocket_id`);

--
-- Indexes for table `salary_info`
--
ALTER TABLE `salary_info`
  ADD KEY `emp_id` (`emp_id`);

--
-- Indexes for table `satellites`
--
ALTER TABLE `satellites`
  ADD PRIMARY KEY (`sat_id`);

--
-- Indexes for table `scientists`
--
ALTER TABLE `scientists`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `mission_id` (`mission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chatbox`
--
ALTER TABLE `chatbox`
  MODIFY `cid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `accounts`
--
ALTER TABLE `accounts`
  ADD CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `scientists` (`emp_id`);

--
-- Constraints for table `assigned_astro`
--
ALTER TABLE `assigned_astro`
  ADD CONSTRAINT `assigned_astro_ibfk_1` FOREIGN KEY (`astro_id`) REFERENCES `astronauts` (`astro_id`),
  ADD CONSTRAINT `assigned_astro_ibfk_2` FOREIGN KEY (`mission_id`) REFERENCES `mission` (`mission_id`);

--
-- Constraints for table `intern`
--
ALTER TABLE `intern`
  ADD CONSTRAINT `intern_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `organisation` (`org_id`),
  ADD CONSTRAINT `intern_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `scientists` (`emp_id`);

--
-- Constraints for table `mission`
--
ALTER TABLE `mission`
  ADD CONSTRAINT `mission_ibfk_1` FOREIGN KEY (`sat_id`) REFERENCES `satellites` (`sat_id`);

--
-- Constraints for table `payload`
--
ALTER TABLE `payload`
  ADD CONSTRAINT `payload_ibfk_1` FOREIGN KEY (`rocket_id`) REFERENCES `rocket` (`rocket_id`),
  ADD CONSTRAINT `payload_ibfk_2` FOREIGN KEY (`sat_id`) REFERENCES `satellites` (`sat_id`);

--
-- Constraints for table `salary_info`
--
ALTER TABLE `salary_info`
  ADD CONSTRAINT `salary_info_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `scientists` (`emp_id`);

--
-- Constraints for table `scientists`
--
ALTER TABLE `scientists`
  ADD CONSTRAINT `scientists_ibfk_1` FOREIGN KEY (`mission_id`) REFERENCES `mission` (`mission_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
