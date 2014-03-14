USE NPRO;


DELIMITER //

DROP PROCEDURE IF EXISTS InsertContactInfo //
 
-- Stored procedure to insert contact info
CREATE PROCEDURE InsertContactInfo(
	Address1 VARCHAR(100),
	Address2 VARCHAR(100),
	City VARCHAR(100),
	Province VARCHAR(100),
	PostCode VARCHAR(6),
	Email1 VARCHAR(100),
	Email2 VARCHAR(100),
	HomePhone VARCHAR(100),
	WorkPhone VARCHAR(100),
	CellPhone VARCHAR(100),
	OUT ContactID BIGINT)
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	INSERT INTO ContactInfo
	(Address1,
	  Address2,
	  City,
	  Province,
	  PostCode,
	  Email1,
	  Email2,
	  HomePhone,
	  WorkPhone,
	  CellPhone,
	  CreateDate,
	  CreateBy,
	  LastModifiedDate,
	  LastModifiedBy)
	VALUE
	(Address1,
		Address2,
		City,
		Province,
		PostCode,
		Email1,
		Email2,
		HomePhone,
		WorkPhone,
		CellPhone,
		@Now,
		@Creator,
		@Now,
		@Creator
	);

	SELECT LAST_INSERT_ID() INTO ContactID;
END //


DROP PROCEDURE IF EXISTS InsertUserInfo //

-- Stored procedure to insert user info
CREATE PROCEDURE InsertUserInfo(
	UserName VARCHAR(100),
	NickName VARCHAR(100),
	Pwd VARCHAR(100),
	Gender SMALLINT,
	DOB DATE, -- date of birth
	ActiveStatus SMALLINT,
	Address1 VARCHAR(100),
	Address2 VARCHAR(100),
	City VARCHAR(100),
	Province VARCHAR(100),
	PostCode VARCHAR(6),
	Email1 VARCHAR(100),
	Email2 VARCHAR(100),
	HomePhone VARCHAR(100),
	WorkPhone VARCHAR(100),
	CellPhone VARCHAR(100),
    OUT UID BIGINT)
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	CALL InsertContactInfo
	(
	Address1,
	Address2,
	City,
	Province,
	PostCode,
	Email1,
	Email2,
	HomePhone,
	WorkPhone,
	CellPhone,
	@ContactID
	);

	INSERT INTO User
	(UserName,
	  NickName,
	  Pwd,
	  Gender,
	  DOB,
	  ContactID,
	  ActiveStatus,
	  CreateDate,
	  CreateBy,
	  LastModifiedDate,
	  LastModifiedBy)
	VALUE
	(UserName,
		NickName,
		Pwd,
		Gender,
		DOB,
		@ContactID,
		ActiveStatus,
		@Now,
		@Creator,
		@Now,
		@Creator
	);

	SELECT LAST_INSERT_ID() INTO UID;
END //

DROP PROCEDURE IF EXISTS InsertUserCommunityRelationship //

-- Stored procedure to insert user community relationship
CREATE PROCEDURE InsertUserCommunityRelationship(
	UID BIGINT,
	CommunityID BIGINT,
    RoleID SMALLINT,
	OUT UserCommunityRelationshipID BIGINT)
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	INSERT INTO UserCommunityRelationship
	(UID,
	  CommunityID,
	  RoleID,
	  CreateDate,
	  CreateBy,
	  LastModifiedDate,
	  LastModifiedBy)
	VALUE
	(UID,
		CommunityID,
		RoleID,
		@Now,
		@Creator,
		@Now,
		@Creator
	);

	SELECT LAST_INSERT_ID() INTO UserCommunityRelationshipID;
END //

DROP PROCEDURE IF EXISTS InsertCommunityInfo //

-- Stored procedure to insert community info
CREATE PROCEDURE InsertCommunityInfo(
	CommunityName VARCHAR(100),
	ActiveStatus SMALLINT,
	MapID BIGINT,
    OUT CommunityID BIGINT)
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	INSERT INTO Community
	(`Name`,
	  ActiveStatus,
	  MapID)
	VALUE
	(CommunityName,
		ActiveStatus,
		MapID
	);

	SELECT LAST_INSERT_ID() INTO CommunityID;
END //

DROP PROCEDURE IF EXISTS InsertMapInfo //

-- Stored procedure to insert map info
CREATE PROCEDURE InsertMapInfo(
	MapInfo TEXT,
	District VARCHAR(100),
    City VARCHAR(100),
    Province VARCHAR(100), 
    Description VARCHAR(400), 
    OUT MapID BIGINT)
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	INSERT INTO Map
	(MapInfo,
	 District,
     City,
     Province, 
     Description)
	VALUE
	(MapInfo,
		District,
		City,
		Province, 
		Description
	);

	SELECT LAST_INSERT_ID() INTO MapID;
END //