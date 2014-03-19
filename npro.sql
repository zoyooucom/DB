SET NAMES utf8mb4;

-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: NPro
-- Source Schemata: NPro
-- Created: Sat Dec 14 17:56:16 2013
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema NPro
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS `NPro` ;
CREATE DATABASE IF NOT EXISTS `NPro` DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci;

-- ----------------------------------------------------------------------------
-- Table NPro.Group
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Group` (
  `GroupID` BIGINT NOT NULL AUTO_INCREMENT,
  `CommunityID` BIGINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(1600) NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`GroupID`),
  CONSTRAINT `FK_Group_Community`
    FOREIGN KEY (`CommunityID`)
    REFERENCES `NPro`.`Community` (`CommunityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Group_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.UserGroupRelationship
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`UserGroupRelationship` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `UID` BIGINT NOT NULL,
  `RoleID` SMALLINT NOT NULL,
  `GroupID` BIGINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_UserGroupRelationship` (`UID` ASC),
  INDEX `IX_UserGroupRelationship_1` (`GroupID` ASC),
  CONSTRAINT `FK_UserGroupRelationship_Community`
    FOREIGN KEY (`GroupID`)
    REFERENCES `NPro`.`Group` (`GroupID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserGroupRelationship_Role`
    FOREIGN KEY (`RoleID`)
    REFERENCES `NPro`.`Role` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserGroupRelationship_User`
    FOREIGN KEY (`UID`)
    REFERENCES `NPro`.`User` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.PrivateMsg
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`PrivateMsg` (
  `MsgID` BIGINT NOT NULL AUTO_INCREMENT,
  `SenderUID` BIGINT NOT NULL,
  `ReceiverID` BIGINT NOT NULL,
  `ReceiverTypeID` SMALLINT NOT NULL,
  `InfoTypeID` INT NOT NULL,
  `Subject` VARCHAR(100) NOT NULL,
  `Content` VARCHAR(1600) NULL,
  `SendDate` DATETIME NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `Action` SMALLINT NOT NULL,
  `ParentMsgIndex` INT NOT NULL,
  `MsgUUID` VARCHAR(128) NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MsgID`),
  CONSTRAINT `FK_PrivateMsg_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PrivateMsg_MsgAction`
    FOREIGN KEY (`Action`)
    REFERENCES `NPro`.`MsgAction` (`ActionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PrivateMsg_EntityTypeList`
    FOREIGN KEY (`ReceiverTypeID`)
    REFERENCES `NPro`.`EntityTypeList` (`EntityTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_PrivateMsg_User1`
    FOREIGN KEY (`SenderUID`)
    REFERENCES `NPro`.`User` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.SystemLog
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`SystemLog` (
  `LogID` BIGINT NOT NULL AUTO_INCREMENT,
  `ActionID` SMALLINT NOT NULL,
  `LogData` TEXT NOT NULL,
  `RequestedUID` BIGINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`LogID`));

-- ----------------------------------------------------------------------------
-- Table NPro.SystemConfig
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`SystemConfig` (
  `ConfigName` VARCHAR(50) NOT NULL,
  `ConfigValue` VARCHAR(1000) NOT NULL,
  `CreateDate` DATETIME NULL,
  `CreateBy` VARCHAR(100) NULL,
  `LastModifiedDate` DATETIME NULL,
  `LastModifiedBy` VARCHAR(100) NULL,
  PRIMARY KEY (`ConfigName`));

-- ----------------------------------------------------------------------------
-- Table NPro.ActiveStatus
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`ActiveStatus` (
  `ActiveID` SMALLINT NOT NULL,
  `ActiveStatusName` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ActiveID`),
  INDEX `IX_ActiveStatusName` (`ActiveStatusName` ASC));

-- ----------------------------------------------------------------------------
-- Table NPro.Gender
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Gender` (
  `GenderID` SMALLINT NOT NULL,
  `GenderName` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`GenderID`),
  INDEX `IX_GenderName` (`GenderName` ASC));

-- ----------------------------------------------------------------------------
-- Table NPro.MsgAction
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`MsgAction` (
  `ActionID` SMALLINT NOT NULL,
  `ActionStatus` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ActionID`));

-- ----------------------------------------------------------------------------
-- Table NPro.Community
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Community` (
  `CommunityID` BIGINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `MapID` BIGINT NULL,  
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`CommunityID`),
  CONSTRAINT `FK_Community_Map`
    FOREIGN KEY (`MapID`)
    REFERENCES `NPro`.`Map` (`MapID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Community_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.Role
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Role` (
  `RoleID` SMALLINT NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`RoleID`));

-- ----------------------------------------------------------------------------
-- Table NPro.User
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`User` (
  `UID` BIGINT NOT NULL AUTO_INCREMENT,
  `UserName` VARCHAR(100) NOT NULL,
  `NickName` VARCHAR(100) NULL,
  `Pwd` VARCHAR(100) NOT NULL,
  `Gender` SMALLINT NULL,
  `DOB` DATE NULL, -- date of birth
  `ActiveStatus` SMALLINT NOT NULL,
  `ContactID` BIGINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`UID`),
  CONSTRAINT `UX_UserName` 
	UNIQUE (`UserName`),
  CONSTRAINT `FK_User_ContactInfo`
    FOREIGN KEY (`ContactID`)
    REFERENCES `NPro`.`ContactInfo` (`ContactID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_User_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserInfo_ContactInfo`
    FOREIGN KEY (`ContactID`)
    REFERENCES `NPro`.`ContactInfo` (`ContactID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserInfo_Gender`
    FOREIGN KEY (`Gender`)
    REFERENCES `NPro`.`Gender` (`GenderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.UserCommunityRelationship
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`UserCommunityRelationship` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `UID` BIGINT NOT NULL,
  `CommunityID` BIGINT NOT NULL,
  `RoleID` SMALLINT NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_UserCommunityRelationship` (`UID` ASC),
  INDEX `IX_UserCommunityRelationship_1` (`CommunityID` ASC),
  CONSTRAINT `FK_UserCommunityRelationship_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserCommunityRelationship_Role`
    FOREIGN KEY (`RoleID`)
    REFERENCES `NPro`.`Role` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserCommunityRelationship_Community`
    FOREIGN KEY (`CommunityID`)
    REFERENCES `NPro`.`Community` (`CommunityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_UserCommunityRelationship_User`
    FOREIGN KEY (`UID`)
    REFERENCES `NPro`.`User` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.DepartmentCommunityRelationship
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`DepartmentCommunityRelationship` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `DepartmentID` BIGINT NOT NULL,
  `CommunityID` BIGINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_DepartmentCommunityRelationship_Department`
    FOREIGN KEY (`DepartmentID`)
    REFERENCES `NPro`.`Department` (`DepartmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DepartmentCommunityRelationship_Community`
    FOREIGN KEY (`CommunityID`)
    REFERENCES `NPro`.`Community` (`CommunityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.Business
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Business` (
  `BusinessID` BIGINT NOT NULL AUTO_INCREMENT,
  `BusinessName` VARCHAR(100) NOT NULL,
  `AdminUID` BIGINT NOT NULL,
  `ContactID` BIGINT NOT NULL,
  `BusinessTypeID` SMALLINT NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`BusinessID`),
  CONSTRAINT `FK_Business_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Business_BusinessTypeList`
    FOREIGN KEY (`BusinessTypeID`)
    REFERENCES `NPro`.`BusinessTypeList` (`BusinessTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Business_User`
    FOREIGN KEY (`AdminUID`)
    REFERENCES `NPro`.`User` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.BusinessCommunityRelationship
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`BusinessCommunityRelationship` (
  `ID` BIGINT NOT NULL AUTO_INCREMENT,
  `BusinessID` BIGINT NOT NULL,
  `CommunityID` BIGINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `IX_BusinessCommunityRelationship` (`BusinessID` ASC),
  INDEX `IX_BusinessCommunityRelationship_1` (`CommunityID` ASC),
  CONSTRAINT `FK_BusinessCommunityRelationship_Business`
    FOREIGN KEY (`BusinessID`)
    REFERENCES `NPro`.`Business` (`BusinessID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_BusinessCommunityRelationship_Community`
    FOREIGN KEY (`CommunityID`)
    REFERENCES `NPro`.`Community` (`CommunityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.Map
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Map` (
  `MapID` BIGINT NOT NULL AUTO_INCREMENT,
  `MapInfo` TEXT NOT NULL,
  `District` VARCHAR(100) NULL,
  `City` VARCHAR(100) NULL,
  `Province` VARCHAR(100) NULL, 
  `Description` VARCHAR(400) NULL, 
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`MapID`));

-- ----------------------------------------------------------------------------
-- Table NPro.BusinessTypeList
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`BusinessTypeList` (
  `BusinessTypeID` SMALLINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`BusinessTypeID`));

-- ----------------------------------------------------------------------------
-- Table NPro.DepartmentTypeList
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`DepartmentTypeList` (
  `DepartmentTypeID` SMALLINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DepartmentTypeID`));

-- ----------------------------------------------------------------------------
-- Table NPro.GroupTypeList
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`GroupTypeList` (
  `GroupTypeID` SMALLINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`GroupTypeID`));

-- ----------------------------------------------------------------------------
-- Table NPro.EntityTypeList; define community, department, business, group, or person type
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`EntityTypeList` (
  `EntityTypeID` SMALLINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`EntityTypeID`));

-- ----------------------------------------------------------------------------
-- Table NPro.InfoTypeList
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`InfoTypeList` (
  `InfoTypeID` SMALLINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` VARCHAR(400) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`InfoTypeID`));

-- ----------------------------------------------------------------------------
-- Table NPro.Bulletin
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Bulletin` (
  `BulletinID` BIGINT NOT NULL AUTO_INCREMENT,
  `CommunityID` BIGINT NOT NULL,
  `PublisherID` BIGINT NOT NULL,
  `PublisherTypeID` SMALLINT NOT NULL,
  `InfoTypeID` SMALLINT NOT NULL,
  `PublishDate` DATETIME NOT NULL,
  `ExpireDate` DATETIME NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `Title` VARCHAR(100) NOT NULL,
  `Content` VARCHAR(1600) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`BulletinID`),
  CONSTRAINT `FK_Bulletin_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Bulletin_Community`
    FOREIGN KEY (`CommunityID`)
    REFERENCES `NPro`.`Community` (`CommunityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Bulletin_InfoTypeList`
    FOREIGN KEY (`InfoTypeID`)
    REFERENCES `NPro`.`InfoTypeList` (`InfoTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Bulletin_EntityTypeList`
    FOREIGN KEY (`PublisherTypeID`)
    REFERENCES `NPro`.`EntityTypeList` (`EntityTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.Department
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`Department` (
  `DepartmentID` BIGINT NOT NULL AUTO_INCREMENT,
  `DepartmentName` VARCHAR(100) NOT NULL,
  `DepartmentTypeID` SMALLINT NOT NULL,
  `AdminUID` BIGINT NOT NULL,
  `ContactID` BIGINT NOT NULL,
  `ActiveStatus` SMALLINT NOT NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`DepartmentID`),
  CONSTRAINT `FK_Department_ActiveStatus`
    FOREIGN KEY (`ActiveStatus`)
    REFERENCES `NPro`.`ActiveStatus` (`ActiveID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Department_DepartmentTypeList`
    FOREIGN KEY (`DepartmentTypeID`)
    REFERENCES `NPro`.`DepartmentTypeList` (`DepartmentTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Department_User`
    FOREIGN KEY (`AdminUID`)
    REFERENCES `NPro`.`User` (`UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Department_ContactInfo`
    FOREIGN KEY (`ContactID`)
    REFERENCES `NPro`.`ContactInfo` (`ContactID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- ----------------------------------------------------------------------------
-- Table NPro.AddressBook
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`AddressBook` (
  `AddressBookID` SMALLINT NOT NULL AUTO_INCREMENT,
  `OwnerTypeID` SMALLINT NOT NULL,
  `OwnerID` BIGINT NOT NULL,
  `AddressSrcTypeID` SMALLINT NOT NULL, -- decide person, group, department, business or community 
  `AddressSrcID` BIGINT NOT NULL, -- decide person id, group id, department id, business id, or community id
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`AddressBookID`),
  INDEX `IX_AddressBook` (`OwnerTypeID`, `OwnerID` ASC),
  INDEX `IX_AddressBook_1` (`AddressSrcTypeID`, `AddressSrcID` ASC),
  CONSTRAINT `FK_Address_EntityTypeList`
    FOREIGN KEY (`OwnerTypeID`)
    REFERENCES `NPro`.`EntityTypeList` (`EntityTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Address_EntityTypeList_1`
    FOREIGN KEY (`AddressSrcTypeID`)
    REFERENCES `NPro`.`EntityTypeList` (`EntityTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- ----------------------------------------------------------------------------
-- Table NPro.ContactInfo
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `NPro`.`ContactInfo` (
  `ContactID` BIGINT NOT NULL AUTO_INCREMENT,
  `Address1` VARCHAR(100) NULL,
  `Address2` VARCHAR(100) NULL,
  `City` VARCHAR(100) NULL,
  `Province` VARCHAR(100) NULL,
  `PostCode` VARCHAR(6) NULL,
  `Email1` VARCHAR(100) NULL,
  `Email2` VARCHAR(100) NULL,
  `HomePhone` VARCHAR(100) NULL,
  `WorkPhone` VARCHAR(100) NULL,
  `CellPhone` VARCHAR(100) NULL,
  `CreateDate` DATETIME NOT NULL,
  `CreateBy` VARCHAR(100) NOT NULL,
  `LastModifiedDate` DATETIME NOT NULL,
  `LastModifiedBy` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ContactID`));
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- Populate meta data
-- ----------------------------------------------------------------------------

USE NPro;

SET @Now = NOW();
SET @Creator = "LiYang";

-- ----------------------------------------------------------------------------
-- Populate EntityTypeList
-- ----------------------------------------------------------------------------

INSERT INTO EntityTypeList
(
  EntityTypeID,
  `Name`,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  1,
  "User",
  "User",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO EntityTypeList
(
  EntityTypeID,
  `Name`,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  2,
  "Group",
  "Group",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO EntityTypeList
(
  EntityTypeID,
  `Name`,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  3,
  "Department",
  "Department",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO EntityTypeList
(
  EntityTypeID,
  `Name`,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  4,
  "Business",
  "Business",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO EntityTypeList
(
  EntityTypeID,
  `Name`,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  5,
  "Community",
  "Community",
  @Now,
  @Creator,
  @Now,
  @Creator
);

SELECT * FROM EntityTypeList;

-- ----------------------------------------------------------------------------
-- Populate ActiveStatus
-- ----------------------------------------------------------------------------

INSERT INTO ActiveStatus
(
  ActiveID,
  ActiveStatusName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  1,
  "Active",
  "Active",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO ActiveStatus
(
  ActiveID,
  ActiveStatusName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  2,
  "InActive",
  "InActive",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO ActiveStatus
(
  ActiveID,
  ActiveStatusName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  3,
  "Deleted",
  "Deleted",
  @Now,
  @Creator,
  @Now,
  @Creator
);

SELECT * FROM ActiveStatus;

-- ----------------------------------------------------------------------------
-- Populate Gender
-- ----------------------------------------------------------------------------

INSERT INTO Gender
(
  GenderID,
  GenderName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  1,
  "Male",
  "Male",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO Gender
(
  GenderID,
  GenderName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  2,
  "Female",
  "Female",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO Gender
(
  GenderID,
  GenderName,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  3,
  "Unknown",
  "Unknown",
  @Now,
  @Creator,
  @Now,
  @Creator
);

SELECT * FROM Gender;

-- ----------------------------------------------------------------------------
-- Populate Role
-- ----------------------------------------------------------------------------

INSERT INTO Role
(
  RoleID,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  1,
  "Administrator",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO Role
(
  RoleID,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  2,
  "Co-Admin",
  @Now,
  @Creator,
  @Now,
  @Creator
);

INSERT INTO Role
(
  RoleID,
  Description,
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  4,
  "User",
  @Now,
  @Creator,
  @Now,
  @Creator
);

SELECT * FROM Role;

-- ----------------------------------------------------------------------------
-- Populate Community
-- ----------------------------------------------------------------------------

INSERT INTO Community
(
  `Name`,
  ActiveStatus,
  MapID,  
  CreateDate,
  CreateBy,
  LastModifiedDate,
  LastModifiedBy)
VALUE
(
  "Universal",
  1,
  NULL,
  @Now,
  @Creator,
  @Now,
  @Creator
);

SELECT * FROM Community;