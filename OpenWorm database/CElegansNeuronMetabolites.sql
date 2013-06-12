CREATE DATABASE  IF NOT EXISTS `celegans_neuron` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `celegans_neuron`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: celegans_neuron
-- ------------------------------------------------------
-- Server version	5.5.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tblneuronxneurotransmitter`
--

DROP TABLE IF EXISTS `tblneuronxneurotransmitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuronxneurotransmitter` (
  `Neuron` varchar(10) DEFAULT NULL,
  `Neurotransmitter` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuronxneurotransmitter`
--

LOCK TABLES `tblneuronxneurotransmitter` WRITE;
INSERT INTO `tblneuronxneurotransmitter` VALUES ('ADAL','Glutamate'),('ADAR','Glutamate'),('ADEL','Dopamine'),('ADER','Dopamine'),('ADFL','Serotonin'),('ADFR','Serotonin'),('AFDL','Glutamate'),('AFDR','Glutamate'),('AIML','Serotonin'),('AIMR','Serotonin'),('AINL','Glutamate'),('AINR','Glutamate'),('AIYL','Acetylcholine'),('AIYR','Acetylcholine'),('ALML','Glutamate'),('ALMR','Glutamate'),('ALNL','Acetylcholine'),('ALNR','Acetylcholine'),('AS1','Acetylcholine'),('AS10','Acetylcholine'),('AS11','Acetylcholine'),('AS2','Acetylcholine'),('AS3','Acetylcholine'),('AS4','Acetylcholine'),('AS5','Acetylcholine'),('AS6','Acetylcholine'),('AS7','Acetylcholine'),('AS8','Acetylcholine'),('AS9','Acetylcholine'),('ASHL','Glutamate'),('ASHR','Glutamate'),('ASKL','Glutamate'),('ASKR','Glutamate'),('AUAL','Glutamate'),('AUAR','Glutamate'),('AVJL','Glutamate'),('AVJR','Glutamate'),('AVL','GABA'),('AVM','Glutamate'),('AWCL','Glutamate'),('AWCR','Glutamate'),('CANL','Monoamine'),('CANR','Monoamine'),('CEPDL','Dopamine'),('CEPDR','Dopamine'),('CEPVL','Dopamine'),('CEPVR','Dopamine'),('DA1','Acetylcholine'),('DA2','Acetylcholine'),('DA3','Acetylcholine'),('DA4','Acetylcholine'),('DA5','Acetylcholine'),('DA6','Acetylcholine'),('DA7','Acetylcholine'),('DA8','Acetylcholine'),('DA9','Acetylcholine'),('DB1','Acetylcholine'),('DB2','Acetylcholine'),('DB3','Acetylcholine'),('DB4','Acetylcholine'),('DB5','Acetylcholine'),('DB6','Acetylcholine'),('DB7','Acetylcholine'),('DVB','GABA'),('FLPL','Glutamate'),('FLPR','Glutamate'),('HSNL','Serotonin'),('HSNR','Serotonin'),('I5','Serotonin'),('I6','Acetylcholine'),('M1','Acetylcholine'),('M2L','Acetylcholine'),('M2R','Acetylcholine'),('M3L','Glutamate'),('M3R','Glutamate'),('M4','Acetylcholine'),('M5','Acetylcholine'),('MCL','Acetylcholine'),('MCR','Acetylcholine'),('NSML','Serotonin'),('NSMR','Serotonin'),('OLQDL','Glutamate'),('OLQDR','Glutamate'),('OLQVL','Glutamate'),('OLQVR','Glutamate'),('PDEL','Dopamine'),('PDER','Dopamine'),('PHBL','Serotonin'),('PHBR','Serotonin'),('PLML','Glutamate'),('PLMR','Glutamate'),('PLNL','Acetylcholine'),('PLNR','Acetylcholine'),('PVDL','Glutamate'),('PVDR','Glutamate'),('RICL','Octopamine'),('RICR','Octopamine'),('RIS','GABA'),('RMED','GABA'),('RMEL','GABA'),('RMER','GABA'),('RMEV','GABA'),('VC1','Serotonin'),('VC2','Serotonin'),('VC3','Serotonin'),('VC4','Serotonin'),('VC5','Serotonin'),('VC6','Serotonin'),('ADAL','Glutamate'),('ADAR','Glutamate'),('ADEL','Dopamine'),('ADER','Dopamine'),('ADFL','Serotonin');
UNLOCK TABLES;

--
-- Table structure for table `tblneuronxneuropeptide`
--

DROP TABLE IF EXISTS `tblneuronxneuropeptide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuronxneuropeptide` (
  `Neuron` varchar(10) DEFAULT NULL,
  `Neuropeptide` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuronxneuropeptide`
--

LOCK TABLES `tblneuronxneuropeptide` WRITE;
INSERT INTO `tblneuronxneuropeptide` VALUES ('ADAL','FLP-8'),('ADAR','FLP-8'),('ADFL','FLP-6'),('ADFL','INS-1'),('ADFL','NLP-3'),('ADFR','FLP-6'),('ADFR','INS-1'),('ADFR','NLP-3'),('ADLL','FLP-21'),('ADLL','FLP-4'),('ADLL','NLP-10'),('ADLL','NLP-7'),('ADLL','NLP-8'),('ADLR','FLP-21'),('ADLR','FLP-4'),('ADLR','NLP-10'),('ADLR','NLP-7'),('ADLR','NLP-8'),('AFDL','FLP-6'),('AFDL','NLP-21'),('AFDL','NLP-7'),('AFDR','FLP-6'),('AFDR','NLP-21'),('AFDR','NLP-7'),('AIAL','FLP-1'),('AIAL','FLP-2'),('AIAL','INS-1'),('AIAR','FLP-1'),('AIAR','FLP-2'),('AIAR','INS-1'),('AIBL','FLP-20'),('AIBR','FLP-20'),('AIML','FLP-10'),('AIML','FLP-22'),('AIML','INS-1'),('AIMR','FLP-10'),('AIMR','FLP-22'),('AIMR','INS-1'),('AINL','FLP-19'),('AINR','FLP-19'),('AIYL','FLP-1'),('AIYL','FLP-18'),('AIYR','FLP-1'),('AIYR','FLP-18'),('ALA','FLP-7'),('ALML','EAT-4'),('ALML','VGluT'),('ALMR','EAT-4'),('ALMR','VGluT'),('ASEL','FLP-21'),('ASEL','NLP-14'),('ASEL','NLP-3'),('ASEL','NLP-7'),('ASER','FLP-21'),('ASER','NLP-14'),('ASER','NLP-3'),('ASER','NLP-7'),('ASHL','FLP-21'),('ASHL','NLP-15'),('ASHL','NLP-3'),('ASHR','FLP-21'),('ASHR','NLP-15'),('ASHR','NLP-3'),('ASIL','NLP-1'),('ASIL','NLP-14'),('ASIL','NLP-18'),('ASIL','NLP-24'),('ASIL','NLP-27'),('ASIL','NLP-5'),('ASIL','NLP-6'),('ASIL','NLP-7'),('ASIL','NLP-9'),('ASIR','NLP-1'),('ASIR','NLP-14'),('ASIR','NLP-18'),('ASIR','NLP-24'),('ASIR','NLP-27'),('ASIR','NLP-5'),('ASIR','NLP-6'),('ASIR','NLP-7'),('ASIR','NLP-9'),('ASJL','NLP-3'),('ASJR','NLP-3'),('ASKL','EAT-4'),('ASKL','NLP-10'),('ASKL','NLP-14'),('ASKL','NLP-8'),('ASKL','VGluT'),('ASKR','EAT-4'),('ASKR','NLP-10'),('ASKR','NLP-14'),('ASKR','NLP-8'),('ASKR','VGluT'),('AUAL','EAT-4'),('AUAL','VGluT'),('AUAR','EAT-4'),('AUAR','VGluT'),('AVAL','FLP-1'),('AVAL','FLP-18'),('AVAR','FLP-1'),('AVAR','FLP-18'),('AVEL','FLP-1'),('AVER','FLP-1'),('AVJL','EAT-4'),('AVJL','VGluT'),('AVJR','EAT-4'),('AVJR','VGluT'),('AVKL','FLP-1'),('AVKR','FLP-1'),('AVM','EAT-4'),('AVM','VGluT'),('AWBL','NLP-3'),('AWBL','NLP-9'),('AWBR','NLP-3'),('AWBR','NLP-9'),('AWCL','NLP-1'),('AWCR','NLP-1'),('BAGL','NLP-3'),('BAGR','NLP-3'),('BDUL','NLP-1'),('BDUL','NLP-15'),('BDUR','NLP-1'),('BDUR','NLP-15'),('CANL','CAT-1'),('CANL','NLP-10'),('CANL','NLP-15'),('CANL','VMaT'),('CANR','CAT-1'),('CANR','NLP-10'),('CANR','NLP-15'),('CANR','VMaT'),('CEPDL','CAT-2'),('CEPDL','TH'),('CEPDR','CAT-2'),('CEPDR','TH'),('CEPVL','CAT-2'),('CEPVL','TH'),('CEPVR','CAT-2'),('CEPVR','TH'),('FLPL','EAT-4'),('FLPL','VGluT'),('FLPR','EAT-4'),('FLPR','VGluT'),('HSNL','CAT-1'),('HSNL','FLP-5'),('HSNL','NLP-15'),('HSNL','NLP-3'),('HSNL','NLP-8'),('HSNL','TPH-1'),('HSNL','VMaT'),('HSNR','CAT-1'),('HSNR','FLP-5'),('HSNR','NLP-15'),('HSNR','NLP-3'),('HSNR','NLP-8'),('HSNR','TPH-1'),('HSNR','VMaT'),('I1L','NLP-3'),('I1R','NLP-3'),('I2L','NLP-3'),('I2L','NLP-8'),('I2R','NLP-3'),('I2R','NLP-8'),('I3','NLP-3'),('I4','NLP-13'),('I4','NLP-3'),('I6','NLP-3'),('LUAL','NLP-13'),('LUAR','NLP-13'),('M1','NLP-3'),('M2L','FLP-18'),('M2L','FLP-21'),('M2L','NLP-13'),('M2L','NLP-3'),('M2R','FLP-18'),('M2R','FLP-21'),('M2R','NLP-13'),('M2R','NLP-3'),('M3L','FLP-18'),('M3L','GLT-1'),('M3L','NLP-3'),('M3R','FLP-18'),('M3R','GLT-1'),('M3R','NLP-3'),('M4','FLP-21'),('M5','FLP-1'),('MCL','FLP-21'),('MCR','FLP-21'),('NSML','NLP-13'),('NSML','NLP-18'),('NSML','NLP-19'),('NSMR','NLP-13'),('NSMR','NLP-18'),('NSMR','NLP-19'),('OLQDL','EAT-4'),('OLQDL','VGluT'),('OLQDR','EAT-4'),('OLQDR','VGluT'),('OLQVL','EAT-4'),('OLQVL','VGluT'),('OLQVR','EAT-4'),('OLQVR','VGluT'),('PDEL','CAT-2'),('PDEL','TH'),('PDER','CAT-2'),('PDER','TH'),('PHAL','NLP-14'),('PHAL','NLP-7'),('PHAR','NLP-14'),('PHAR','NLP-7'),('PHBL','NLP-1'),('PHBR','NLP-1'),('PLML','EAT-4'),('PLML','VGluT'),('PLMR','EAT-4'),('PLMR','VGluT'),('PVDL','EAT-4'),('PVDL','NLP-11'),('PVDL','VGluT'),('PVDR','EAT-4'),('PVDR','NLP-11'),('PVDR','VGluT'),('URXL','FLP-10'),('URXL','FLP-11'),('URXL','FLP-19'),('URXL','FLP-8'),('URXR','FLP-10'),('URXR','FLP-11'),('URXR','FLP-19'),('URXR','FLP-8'),('VC1','CAT-1'),('VC1','ChAT'),('VC1','VAChT'),('VC1','VMaT'),('VC2','CAT-1'),('VC2','ChAT'),('VC2','VAChT'),('VC2','VMaT'),('VC3','CAT-1'),('VC3','ChAT'),('VC3','VAChT'),('VC3','VMaT'),('VC4','CAT-1'),('VC4','ChAT'),('VC4','VAChT'),('VC4','VMaT'),('VC5','CAT-1'),('VC5','ChAT'),('VC5','VAChT'),('VC5','VMaT'),('VC6','CAT-1'),('VC6','ChAT'),('VC6','VAChT'),('VC6','VMaT'),('ADAL','FLP-8'),('ADAR','FLP-8'),('ADFL','FLP-6'),('ADFL','INS-1'),('ADFL','NLP-3');
UNLOCK TABLES;

--
-- Table structure for table `tblneuropeptide`
--

DROP TABLE IF EXISTS `tblneuropeptide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuropeptide` (
  `Neuropeptide` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuropeptide`
--

LOCK TABLES `tblneuropeptide` WRITE;
INSERT INTO `tblneuropeptide` VALUES ('CAT-1'),('CAT-2'),('ChAT'),('EAT-4'),('FLP-1'),('FLP-10'),('FLP-11'),('FLP-18'),('FLP-19'),('FLP-2'),('FLP-20'),('FLP-21'),('FLP-22'),('FLP-4'),('FLP-5'),('FLP-6'),('FLP-7'),('FLP-8'),('GLT-1'),('INS-1'),('NLP-1'),('NLP-10'),('NLP-11'),('NLP-13'),('NLP-14'),('NLP-15'),('NLP-18'),('NLP-19'),('NLP-21'),('NLP-24'),('NLP-27'),('NLP-3'),('NLP-5'),('NLP-6'),('NLP-7'),('NLP-8'),('NLP-9'),('NPR-11'),('TH'),('TPH-1'),('VAChT'),('VGluT'),('VMaT'),('CAT-1'),('CAT-2'),('ChAT'),('EAT-4'),('FLP-1');
UNLOCK TABLES;

--
-- Table structure for table `tblneuronxreceptor`
--

DROP TABLE IF EXISTS `tblneuronxreceptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuronxreceptor` (
  `Neuron` varchar(10) DEFAULT NULL,
  `Receptor` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuronxreceptor`
--

LOCK TABLES `tblneuronxreceptor` WRITE;
INSERT INTO `tblneuronxreceptor` VALUES ('ADEL','ACR-16'),('ADEL','DOP-2'),('ADEL','EXP-1'),('ADEL','TYRA-3'),('ADER','ACR-16'),('ADER','DOP-2'),('ADER','EXP-1'),('ADER','TYRA-3'),('ADFL','MGL-3'),('ADFL','NPR-5'),('ADFL','OCR-2'),('ADFL','OSM-9'),('ADFL','SRB-6'),('ADFL','SRD-1'),('ADFR','MGL-3'),('ADFR','NPR-5'),('ADFR','OCR-2'),('ADFR','OSM-9'),('ADFR','SRB-6'),('ADFR','SRD-1'),('ADLL','GCY-21'),('ADLL','OCR-1'),('ADLL','OCR-2'),('ADLL','OSM-9'),('ADLL','SRB-6'),('ADLL','SRE-1'),('ADLL','SRH-132'),('ADLL','SRH-220'),('ADLL','SRI-51'),('ADLL','SRO-1'),('ADLR','GCY-21'),('ADLR','OCR-1'),('ADLR','OCR-2'),('ADLR','OSM-9'),('ADLR','SRB-6'),('ADLR','SRE-1'),('ADLR','SRH-132'),('ADLR','SRH-220'),('ADLR','SRI-51'),('ADLR','SRO-1'),('AFDL','GCY-18'),('AFDL','GCY-23'),('AFDL','GCY-29'),('AFDL','GCY-8'),('AFDR','GCY-18'),('AFDR','GCY-23'),('AFDR','GCY-29'),('AFDR','GCY-8'),('AIAL','GCY-28'),('AIAL','GLC-3'),('AIAL','GLR-2'),('AIAL','MGL-1'),('AIAL','NPR-11'),('AIAL','NPR-5'),('AIAL','SCD-2'),('AIAL','SRA-11'),('AIAR','GCY-28'),('AIAR','GLC-3'),('AIAR','GLR-2'),('AIAR','MGL-1'),('AIAR','NPR-11'),('AIAR','NPR-5'),('AIAR','SCD-2'),('AIAR','SRA-11'),('AIBL','GGR-1'),('AIBL','GLR-1'),('AIBL','GLR-2'),('AIBL','GLR-5'),('AIBL','MGL-2'),('AIBR','GGR-1'),('AIBR','GLR-1'),('AIBR','GLR-2'),('AIBR','GLR-5'),('AIBR','MGL-2'),('AIML','GCY-18'),('AIMR','GCY-18'),('AIYL','ACR-14'),('AIYL','C50F7.1'),('AIYL','CKR-2'),('AIYL','GAR-2'),('AIYL','GCY-1'),('AIYL','GLC-3'),('AIYL','LGC-38'),('AIYL','MGL-1'),('AIYL','MOD-1'),('AIYL','NPR-11'),('AIYL','NPR-14'),('AIYL','SER-2'),('AIYL','SRA-11'),('AIYR','ACR-14'),('AIYR','C50F7.1'),('AIYR','CKR-2'),('AIYR','GAR-2'),('AIYR','GCY-1'),('AIYR','GLC-3'),('AIYR','LGC-38'),('AIYR','MGL-1'),('AIYR','MOD-1'),('AIYR','NPR-11'),('AIYR','NPR-14'),('AIYR','SER-2'),('AIYR','SRA-11'),('AIZL','SER-2'),('AIZR','SER-2'),('ALA','ACR-13'),('ALA','ACR-14'),('ALA','SRA-10'),('ALNL','SER-2'),('ALNR','SER-2'),('AQR','GCY-32'),('AQR','GCY-35'),('AQR','NPR-1'),('ASEL','GCY-6'),('ASEL','GCY-7'),('ASEL','NPR-1'),('ASEL','OSM-9'),('ASER','GCY-5'),('ASER','GCY-6'),('ASER','GCY-7'),('ASER','NPR-1'),('ASER','OSM-9'),('ASGL','NPR-1'),('ASGL','OSM-9'),('ASHL','NPR-1'),('ASHL','OCR-2'),('ASHL','OSM-9'),('ASHL','SRA-6'),('ASHL','SRB-6'),('ASHL','UNC-8'),('ASHR','NPR-1'),('ASHR','OCR-2'),('ASHR','OSM-9'),('ASHR','SRA-6'),('ASHR','SRB-6'),('ASHR','UNC-8'),('ASIL','DAF-11'),('ASIL','SRD-1'),('ASIL','STR-2'),('ASIL','STR-3'),('ASIR','DAF-11'),('ASIR','SRD-1'),('ASIR','STR-2'),('ASIR','STR-3'),('ASJL','DAF-11'),('ASJL','OSM-9'),('ASJL','SRE-1'),('ASJR','DAF-11'),('ASJR','OSM-9'),('ASJR','SRE-1'),('ASKL','DAF-11'),('ASKL','OSM-9'),('ASKL','SRA-7'),('ASKL','SRA-9'),('ASKL','SRG-2'),('ASKL','SRG-8'),('ASKR','DAF-11'),('ASKR','OSM-9'),('ASKR','SRA-7'),('ASKR','SRA-9'),('ASKR','SRG-2'),('ASKR','SRG-8'),('AUAL','DOP-1'),('AUAL','GLR-4'),('AUAL','NPR-1'),('AUAL','SER-2'),('AUAR','DOP-1'),('AUAR','GLR-4'),('AUAR','NPR-1'),('AUAR','SER-2'),('AVAL','GGR-3'),('AVAL','GLR-1'),('AVAL','GLR-2'),('AVAL','GLR-4'),('AVAL','GLR-5'),('AVAL','NMR-1'),('AVAL','NMR-2'),('AVAL','UNC-8'),('AVAR','GGR-3'),('AVAR','GLR-1'),('AVAR','GLR-2'),('AVAR','GLR-4'),('AVAR','GLR-5'),('AVAR','NMR-1'),('AVAR','NMR-2'),('AVAR','UNC-8'),('AVBL','GGR-3'),('AVBL','GLR-1'),('AVBL','GLR-5'),('AVBL','SRA-11'),('AVBL','UNC-8'),('AVBR','GGR-3'),('AVBR','GLR-1'),('AVBR','GLR-5'),('AVBR','SRA-11'),('AVBR','UNC-8'),('AVDL','GLR-1'),('AVDL','GLR-2'),('AVDL','GLR-5'),('AVDL','NMR-1'),('AVDL','NMR-2'),('AVDL','UNC-8'),('AVDR','GLR-1'),('AVDR','GLR-2'),('AVDR','GLR-5'),('AVDR','NMR-1'),('AVDR','NMR-2'),('AVDR','UNC-8'),('AVEL','GLR-1'),('AVEL','GLR-2'),('AVEL','GLR-5'),('AVEL','NMR-1'),('AVEL','NMR-2'),('AVER','GLR-1'),('AVER','GLR-2'),('AVER','GLR-5'),('AVER','NMR-1'),('AVER','NMR-2'),('AVG','DEG-3'),('AVG','GLR-1'),('AVG','GLR-2'),('AVG','NMR-1'),('AVG','NMR-2'),('AVHL','GGR-1'),('AVHL','GLR-4'),('AVHL','SER-2'),('AVHR','GGR-1'),('AVHR','GLR-4'),('AVHR','SER-2'),('AVJL','GLR-1'),('AVJR','GLR-1'),('AVKL','GLR-5'),('AVKR','GLR-5'),('AWAL','OCR-1'),('AWAL','OCR-2'),('AWAL','ODR-10'),('AWAL','OSM-9'),('AWAR','OCR-1'),('AWAR','OCR-2'),('AWAR','ODR-10'),('AWAR','OSM-9'),('AWBL','AEX-2'),('AWBL','DAF-11'),('AWBL','STR-1'),('AWBR','AEX-2'),('AWBR','DAF-11'),('AWBR','STR-1'),('AWCL','DAF-11'),('AWCL','OSM-9'),('AWCL','STR-2'),('AWCR','DAF-11'),('AWCR','OSM-9'),('AWCR','STR-2'),('BAGL','GCY-33'),('BAGR','GCY-33'),('BDUL','GLR-8'),('BDUL','SER-2'),('BDUR','GLR-8'),('BDUR','SER-2'),('CANL','GGR-2'),('CANL','SER-2'),('CANR','GGR-2'),('CANR','SER-2'),('CEPDL','DOP-2'),('CEPDR','DOP-2'),('CEPVL','DOP-2'),('CEPVR','DOP-2'),('DA1','UNC-8'),('DA2','UNC-8'),('DA3','UNC-8'),('DA4','UNC-8'),('DA5','UNC-8'),('DA6','UNC-8'),('DA7','UNC-8'),('DA8','UNC-8'),('DA9','SER-2'),('DA9','UNC-8'),('DVA','GGR-3'),('DVA','GLR-1'),('DVA','GLR-4'),('DVA','GLR-5'),('DVA','NMR-1'),('DVA','SER-2'),('DVA','SER-4'),('FLPL','DEG-3'),('FLPL','DEL-1'),('FLPL','DES-2'),('FLPL','GLR-4'),('FLPL','MEC-10'),('FLPL','OSM-9'),('FLPL','UNC-8'),('FLPR','DEG-3'),('FLPR','DEL-1'),('FLPR','DES-2'),('FLPR','GLR-4'),('FLPR','MEC-10'),('FLPR','OSM-9'),('FLPR','UNC-8'),('HSNL','GAR-2'),('HSNL','GGR-2'),('HSNL','GLR-5'),('HSNL','MEC-6'),('HSNR','GAR-2'),('HSNR','GGR-2'),('HSNR','GLR-5'),('HSNR','MEC-6'),('I1L','GLR-7'),('I1L','GLR-8'),('I1R','GLR-7'),('I1R','GLR-8'),('I2L','GLR-7'),('I2L','GLR-8'),('I2R','GLR-7'),('I2R','GLR-8'),('I3','GLR-7'),('I3','GLR-8'),('I6','GLR-7'),('I6','GLR-8'),('IL1DL','DEG-3'),('IL1DL','MEC-6'),('IL1DR','DEG-3'),('IL1DR','MEC-6'),('IL1L','DEG-3'),('IL1L','MEC-6'),('IL1R','DEG-3'),('IL1R','MEC-6'),('IL1VL','DEG-3'),('IL1VL','MEC-6'),('IL1VR','DEG-3'),('IL1VR','MEC-6'),('IL2DL','DES-2'),('IL2DL','NPR-1'),('IL2DR','DES-2'),('IL2DR','NPR-1'),('IL2L','DES-2'),('IL2L','NPR-1'),('IL2R','DES-2'),('IL2R','NPR-1'),('IL2VL','DES-2'),('IL2VL','NPR-1'),('IL2VR','DES-2'),('IL2VR','NPR-1'),('LUAL','GLR-5'),('LUAL','SER-2'),('LUAR','GLR-5'),('LUAR','SER-2'),('M1','AVR-14'),('M1','GLR-2'),('M3L','GLR-8'),('M3L','NPR-1'),('M3R','GLR-8'),('M3R','NPR-1'),('M4','GLR-8'),('M4','SER7b'),('M5','GLR-8'),('MCL','GLR-8'),('MCR','GLR-8'),('MI','GLR-2'),('NSML','AEX-2'),('NSML','GLR-7'),('NSML','GLR-8'),('NSML','SER-2'),('NSMR','AEX-2'),('NSMR','GLR-7'),('NSMR','GLR-8'),('NSMR','SER-2'),('OLLL','SER-2'),('OLLR','SER-2'),('OLQDL','NPR-1'),('OLQDL','OCR-4'),('OLQDL','OSM-9'),('OLQDR','NPR-1'),('OLQDR','OCR-4'),('OLQDR','OSM-9'),('OLQVL','NPR-1'),('OLQVL','OCR-4'),('OLQVL','OSM-9'),('OLQVR','NPR-1'),('OLQVR','OCR-4'),('OLQVR','OSM-9'),('PDA','EXP-1'),('PDA','UNC-8'),('PDB','UNC-8'),('PDEL','DOP-2'),('PHAL','GCY-12'),('PHAL','NPR-1'),('PHAL','OCR-2'),('PHAL','OSM-9'),('PHAL','SRB-6'),('PHAL','SRG-13'),('PHAR','GCY-12'),('PHAR','NPR-1'),('PHAR','OCR-2'),('PHAR','OSM-9'),('PHAR','SRB-6'),('PHAR','SRG-13'),('PHBL','NPR-1'),('PHBL','OCR-2'),('PHBL','OSM-9'),('PHBL','SRB-6'),('PHBR','NPR-1'),('PHBR','OCR-2'),('PHBR','OSM-9'),('PHBR','SRB-6'),('PHCL','DOP-1'),('PHCR','DOP-1'),('PLML','DEG-3'),('PLML','DES-2'),('PLML','DOP-1'),('PLML','GLR-8'),('PLML','MEC-2'),('PLML','MEC-4'),('PLML','MEC-6'),('PLML','MEC-9'),('PLMR','DEG-3'),('PLMR','DES-2'),('PLMR','DOP-1'),('PLMR','GLR-8'),('PLMR','MEC-2'),('PLMR','MEC-4'),('PLMR','MEC-6'),('PLMR','MEC-9'),('PLNL','DOP-1'),('PLNR','DOP-1'),('PQR','GCY-32'),('PQR','GCY-35'),('PQR','NPR-1'),('PVDL','DEG-3'),('PVDL','DES-2'),('PVDL','GLR-4'),('PVDL','MEC-10'),('PVDL','MEC-6'),('PVDL','MEC-9'),('PVDL','OSM-9'),('PVDL','SER-2'),('PVDR','DEG-3'),('PVDR','DES-2'),('PVDR','GLR-4'),('PVDR','MEC-10'),('PVDR','MEC-6'),('PVDR','MEC-9'),('PVDR','OSM-9'),('PVDR','SER-2'),('PVM','GAR-1'),('PVM','MEC-10'),('PVM','MEC-2'),('PVM','MEC-4'),('PVM','MEC-6'),('PVM','MEC-9'),('PVM','UNC-8'),('PVQL','DOP-1'),('PVQL','GGR-1'),('PVQL','GLR-1'),('PVQL','GLR-5'),('PVQL','SER-1'),('PVQL','SRA-6'),('PVQR','DOP-1'),('PVQR','GGR-1'),('PVQR','GLR-1'),('PVQR','GLR-5'),('PVQR','SER-1'),('PVQR','SRA-6'),('PVT','SER-1'),('PVT','SER-2'),('PVT','SER-4'),('RIAL','SER-1'),('RIAR','SER-1'),('RICL','SER-1'),('RICR','SER-1'),('RIS','DOP-1'),('RIS','GLR-1'),('RIS','SER-4'),('RMED','AVR-15'),('RMED','SER-2'),('RMEL','GLR-1'),('RMEL','SER-2'),('RMER','GLR-1'),('RMER','SER-2'),('RMEV','AVR-15'),('RMEV','SER-2'),('URXL','GCY-1'),('URXL','GCY-25'),('URXL','GCY-32'),('URXL','GCY-34'),('URXL','GCY-35'),('URXL','GCY-36'),('URXL','GCY-37'),('URXL','NPR-1'),('URXL','SRA-10'),('URXR','GCY-1'),('URXR','GCY-25'),('URXR','GCY-32'),('URXR','GCY-34'),('URXR','GCY-35'),('URXR','GCY-36'),('URXR','GCY-37'),('URXR','NPR-1'),('URXR','SRA-10'),('VC1','GLR-5'),('VC2','GLR-5'),('VC3','GLR-5'),('VC4','GLR-5'),('VC5','GLR-5'),('VC6','GLR-5'),('ADEL','ACR-16'),('ADEL','DOP-2'),('ADEL','EXP-1'),('ADEL','TYRA-3'),('ADER','ACR-16');
UNLOCK TABLES;

--
-- Table structure for table `tblneuronxinnexin`
--

DROP TABLE IF EXISTS `tblneuronxinnexin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuronxinnexin` (
  `Neuron` varchar(10) DEFAULT NULL,
  `Innexin` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuronxinnexin`
--

LOCK TABLES `tblneuronxinnexin` WRITE;
INSERT INTO `tblneuronxinnexin` VALUES ('ADAL','INX-19'),('ADAL','INX-4'),('ADAL','UNC-9'),('ADAR','INX-19'),('ADAR','INX-4'),('ADAR','UNC-9'),('ADEL','INX-4'),('ADEL','INX-7'),('ADEL','UNC-9'),('ADER','INX-4'),('ADER','INX-7'),('ADER','UNC-9'),('ADFL','INX-19'),('ADFL','INX-4'),('ADFR','INX-19'),('ADFR','INX-4'),('ADLL','INX-18'),('ADLL','INX-19'),('ADLL','UNC-9'),('ADLR','INX-18'),('ADLR','INX-19'),('ADLR','UNC-9'),('AFDL','INX-19'),('AFDR','INX-19'),('AIBL','INX-1'),('AIBR','INX-1'),('AIML','INX-19'),('AIMR','INX-19'),('AINL','INX-17'),('AINL','INX-4'),('AINL','INX-8'),('AINL','UNC-7'),('AINL','UNC-9'),('AINR','INX-17'),('AINR','INX-4'),('AINR','INX-8'),('AINR','UNC-7'),('AINR','UNC-9'),('AIYL','INX-1'),('AIYL','INX-19'),('AIYL','INX-7'),('AIYL','UNC-9'),('AIYR','INX-1'),('AIYR','INX-19'),('AIYR','INX-7'),('AIYR','UNC-9'),('ADAL','INX-19'),('ADAL','INX-4'),('ADAL','UNC-9'),('ADAR','INX-19'),('ADAR','INX-4'),('ADAL','INX-19'),('ADAL','INX-4'),('ADAL','UNC-9'),('ADAR','INX-19'),('ADAR','INX-4');
UNLOCK TABLES;

--
-- Table structure for table `tblneurotransmitter`
--

DROP TABLE IF EXISTS `tblneurotransmitter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneurotransmitter` (
  `Neurotransmitter` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneurotransmitter`
--

LOCK TABLES `tblneurotransmitter` WRITE;
INSERT INTO `tblneurotransmitter` VALUES ('Acetylcholine'),('Dopamine'),('GABA'),('Glutamate'),('Monoamine'),('Octopamine'),('Serotonin'),('Acetylcholine'),('Dopamine'),('GABA'),('Glutamate'),('Monoamine');
UNLOCK TABLES;

--
-- Table structure for table `tblreceptor`
--

DROP TABLE IF EXISTS `tblreceptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblreceptor` (
  `Receptor` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblreceptor`
--

LOCK TABLES `tblreceptor` WRITE;
INSERT INTO `tblreceptor` VALUES ('ACR-14'),('ACR-16'),('AEX-2'),('AVR-14'),('AVR-15'),('C50F7.1'),('CKR-2'),('DAF-11'),('DEG-3'),('DEL-1'),('DES-2'),('DOP-1'),('DOP-2'),('EXP-1'),('GAR-2'),('GCY-1'),('GCY-12'),('GCY-18'),('GCY-21'),('GCY-23'),('GCY-25'),('GCY-28'),('GCY-29'),('GCY-32'),('GCY-33'),('GCY-34'),('GCY-35'),('GCY-36'),('GCY-37'),('GCY-5'),('GCY-6'),('GCY-7'),('GCY-8'),('GGR-1'),('GGR-2'),('GGR-3'),('GLC-3'),('GLR-1'),('GLR-2'),('GLR-4'),('GLR-5'),('GLR-7'),('GLR-8'),('LGC-38'),('MEC-10'),('MEC-2'),('MEC-4'),('MEC-6'),('MEC-9'),('MGL-1'),('MGL-3'),('MOD-1'),('NLP-11'),('NMR-1'),('NMR-2'),('NPR-1'),('NPR-11'),('NPR-14'),('NPR-5'),('OCR-1'),('OCR-2'),('ODR-10'),('OSM-9'),('SCD-2'),('SER-2'),('SER-4'),('SER7b'),('SRA-10'),('SRA-11'),('SRA-6'),('SRA-7'),('SRA-9'),('SRB-6'),('SRD-1'),('SRE-1'),('SRG-13'),('SRG-2'),('SRG-8'),('SRH-132'),('SRH-220'),('SRI-51'),('SRO-1'),('STR-1'),('STR-2'),('STR-3'),('TYRA-3'),('UNC-8'),('ACR-14'),('ACR-16'),('AEX-2'),('AVR-14'),('AVR-15');
UNLOCK TABLES;

--
-- Table structure for table `tblinnexin`
--

DROP TABLE IF EXISTS `tblinnexin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblinnexin` (
  `Innexin` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblinnexin`
--

LOCK TABLES `tblinnexin` WRITE;
INSERT INTO `tblinnexin` VALUES ('INX-1'),('INX-17'),('INX-18'),('INX-19'),('INX-4'),('INX-7'),('INX-8'),('UNC-7'),('UNC-9'),('INX-1'),('INX-17'),('INX-18'),('INX-19'),('INX-4');
UNLOCK TABLES;

--
-- Table structure for table `tblneuron`
--

DROP TABLE IF EXISTS `tblneuron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tblneuron` (
  `Neuron` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tblneuron`
--

LOCK TABLES `tblneuron` WRITE;
INSERT INTO `tblneuron` VALUES ('ADAL'),('ADAR'),('ADEL'),('ADER'),('ADFL'),('ADFR'),('ADLL'),('ADLR'),('AFDL'),('AFDR'),('AIAL'),('AIAR'),('AIBL'),('AIBR'),('AIML'),('AIMR'),('AINL'),('AINR'),('AIYL'),('AIYR'),('AIZL'),('AIZR'),('ALA'),('ALML'),('ALMR'),('ALNL'),('ALNR'),('AQR'),('AS1'),('AS10'),('AS11'),('AS2'),('AS3'),('AS4'),('AS5'),('AS6'),('AS7'),('AS8'),('AS9'),('ASEL'),('ASER'),('ASGL'),('ASGR'),('ASHL'),('ASHR'),('ASIL'),('ASIR'),('ASJL'),('ASJR'),('ASKL'),('ASKR'),('AUAL'),('AUAR'),('AVAL'),('AVAR'),('AVBL'),('AVBR'),('AVDL'),('AVDR'),('AVEL'),('AVER'),('AVFL'),('AVFR'),('AVG'),('AVHL'),('AVHR'),('AVJL'),('AVJR'),('AVKL'),('AVKR'),('AVL'),('AVM'),('AWAL'),('AWAR'),('AWBL'),('AWBR'),('AWCL'),('AWCR'),('BAGL'),('BAGR'),('BDUL'),('BDUR'),('CANL'),('CANR'),('CEPDL'),('CEPDR'),('CEPVL'),('CEPVR'),('DA1'),('DA2'),('DA3'),('DA4'),('DA5'),('DA6'),('DA7'),('DA8'),('DA9'),('DB1'),('DB2'),('DB3'),('DB4'),('DB5'),('DB6'),('DB7'),('DD1'),('DD2'),('DD3'),('DD4'),('DD5'),('DD6'),('DVA'),('DVB'),('DVC'),('FLPL'),('FLPR'),('HSNL'),('HSNR'),('I1L'),('I1R'),('I2L'),('I2R'),('I3'),('I4'),('I5'),('I6'),('IL1DL'),('IL1DR'),('IL1L'),('IL1R'),('IL1VL'),('IL1VR'),('IL2DL'),('IL2DR'),('IL2L'),('IL2R'),('IL2VL'),('IL2VR'),('LUAL'),('LUAR'),('M1'),('M2L'),('M2R'),('M3L'),('M3R'),('M4'),('M5'),('MCL'),('MCR'),('MI'),('NSML'),('NSMR'),('OLLL'),('OLLR'),('OLQDL'),('OLQDR'),('OLQVL'),('OLQVR'),('PDA'),('PDB'),('PDEL'),('PDER'),('PHAL'),('PHAR'),('PHBL'),('PHBR'),('PHCL'),('PHCR'),('PLML'),('PLMR'),('PLNL'),('PLNR'),('PQR'),('PVCL'),('PVCR'),('PVDL'),('PVDR'),('PVM'),('PVNL'),('PVNR'),('PVPL'),('PVPR'),('PVQL'),('PVQR'),('PVR'),('PVT'),('PVWL'),('PVWR'),('RIAL'),('RIAR'),('RIBL'),('RIBR'),('RICL'),('RICR'),('RID'),('RIFL'),('RIFR'),('RIGL'),('RIGR'),('RIH'),('RIML'),('RIMR'),('RIPL'),('RIPR'),('RIR'),('RIS'),('RIVL'),('RIVR'),('RMDDL'),('RMDDR'),('RMDL'),('RMDR'),('RMDVL'),('RMDVR'),('RMED'),('RMEL'),('RMER'),('RMEV'),('RMFL'),('RMFR'),('RMGL'),('RMGR'),('RMHL'),('RMHR'),('SAADL'),('SAADR'),('SAAVL'),('SAAVR'),('SABD'),('SABVL'),('SABVR'),('SDQL'),('SDQR'),('SIADL'),('SIADR'),('SIAVL'),('SIAVR'),('SIBDL'),('SIBDR'),('SIBVL'),('SIBVR'),('SMBDL'),('SMBDR'),('SMBVL'),('SMBVR'),('SMDDL'),('SMDDR'),('SMDVL'),('SMDVR'),('URADL'),('URADR'),('URAVL'),('URAVR'),('URBL'),('URBR'),('URXL'),('URXR'),('URYDL'),('URYDR'),('URYVL'),('URYVR'),('VA1'),('VA10'),('VA11'),('VA12'),('VA2'),('VA3'),('VA4'),('VA5'),('VA6'),('VA7'),('VA8'),('VA9'),('VB1'),('VB10'),('VB11'),('VB2'),('VB3'),('VB4'),('VB5'),('VB6'),('VB7'),('VB8'),('VB9'),('VC1'),('VC2'),('VC3'),('VC4'),('VC5'),('VC6'),('VD1'),('VD10'),('VD11'),('VD12'),('VD13'),('VD2'),('VD3'),('VD4'),('VD5'),('VD6'),('VD7'),('VD8'),('VD9'),('ADAL'),('ADAR'),('ADEL'),('ADER'),('ADFL');
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-31 12:04:13
