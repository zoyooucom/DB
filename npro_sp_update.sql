USE NPRO;

DELIMITER //

DROP PROCEDURE IF EXISTS UpdateContactInfo //
 
-- Stored procedure to update contact info
CREATE PROCEDURE UpdateContactInfo(
	ContactID BIGINT,
	Address1 VARCHAR(100),
	Address2 VARCHAR(100),
	City VARCHAR(100),
	Province VARCHAR(100),
	PostCode VARCHAR(6),
	Email1 VARCHAR(100),
	Email2 VARCHAR(100),
	HomePhone VARCHAR(100),
	WorkPhone VARCHAR(100),
	CellPhone VARCHAR(100))
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	UPDATE ContactInfo c
	SET c.Address1 = Address1,
	  c.Address2 = Address2,
	  c.City = City,
	  c.Province = Province,
	  c.PostCode = PostCode,
	  c.Email1 = Email1,
	  c.Email2 = Email2,
	  c.HomePhone = HomePhone,
	  c.WorkPhone = WorkPhone,
	  c.CellPhone = CellPhone,
	  c.LastModifiedDate = @Now,
	  c.LastModifiedBy = @Creator
	WHERE c.ContactID = ContactID;
END //


DROP PROCEDURE IF EXISTS UpdateUserInfo //

-- Stored procedure to update user info
CREATE PROCEDURE UpdateUserInfo(
	UserID BIGINT,
	UserName VARCHAR(100),
	Pwd VARCHAR(100),
	ActiveStatus SMALLINT,
	NickName VARCHAR(100),
	Gender SMALLINT,
	DOB DATE, -- date of birth
	Address1 VARCHAR(100),
	Address2 VARCHAR(100),
	City VARCHAR(100),
	Province VARCHAR(100),
	PostCode VARCHAR(6),
	Email1 VARCHAR(100),
	Email2 VARCHAR(100),
	HomePhone VARCHAR(100),
	WorkPhone VARCHAR(100),
	CellPhone VARCHAR(100))
BEGIN

	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	SELECT u.ContactID INTO @ContactID
	FROM User u
	WHERE u.UID = UserID;

	CALL UpdateContactInfo
	(
	@ContactID,
	Address1,
	Address2,
	City,
	Province,
	PostCode,
	Email1,
	Email2,
	HomePhone,
	WorkPhone,
	CellPhone
	);

	UPDATE User u
	SET 
		u.UserName = UserName,
		u.Pwd = Pwd,
		u.ActiveStatus = ActiveStatus,
		u.NickName = NickName,
		u.Gender = Gender,
		u.DOB = DOB,
		u.LastModifiedDate = @Now,
		u.LastModifiedBy = @Creator
	WHERE u.UID = UserID;
END //