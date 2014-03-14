USE NPRO;

DELIMITER //

DROP PROCEDURE IF EXISTS GetUserLoginInfo //

-- Stored procedure to get user info
CREATE PROCEDURE GetUserLoginInfo(UserName VARCHAR(100))
BEGIN
	SELECT 
		u.UID,
		u.UserName,
		u.Pwd,
		u.ActiveStatus
	FROM User u
	WHERE u.UserName = UserName;
END //


DROP PROCEDURE IF EXISTS GetUserInfo //

-- Stored procedure to get user info
CREATE PROCEDURE GetUserInfo(UserID BIGINT)
BEGIN
	SELECT 
		u.UID,
		u.UserName,
		u.Pwd,
		u.ActiveStatus,
		u.NickName,
		u.Gender,
		u.DOB,
		c.ContactID,
		c.Address1,
		c.Address2,
		c.City,
		c.Province,
		c.PostCode,
		c.Email1,
		c.Email2,
		c.HomePhone,
		c.WorkPhone,
		c.CellPhone
	FROM User u
	INNER JOIN ContactInfo c ON u.ContactID = c.ContactID
	WHERE u.UID = UserID;
END //


DROP PROCEDURE IF EXISTS GetCommunityInfo //

-- Stored procedure to get community info
CREATE PROCEDURE GetCommunityInfo(CommunityID BIGINT)
BEGIN
	SELECT 
		c.`Name`,
		c.ActiveStatus,
		c.MapID
	FROM Community c
	WHERE c.CommunityID = CommunityID;
END //

DROP PROCEDURE IF EXISTS GetUserInfoByCommunityID //

-- Stored procedure to get user info based on community id
CREATE PROCEDURE GetUserInfoByCommunityID(CommunityID BIGINT)
BEGIN
	SELECT 
		u.UID,
		u.UserName,
		u.Pwd,
		u.ActiveStatus,
		u.NickName,
		u.Gender,
		u.DOB,
		c.ContactID,
		c.Address1,
		c.Address2,
		c.City,
		c.Province,
		c.PostCode,
		c.Email1,
		c.Email2,
		c.HomePhone,
		c.WorkPhone,
		c.CellPhone
	FROM User u
	INNER JOIN ContactInfo c ON u.ContactID = c.ContactID
	INNER JOIN UserCommunityRelationship uc ON uc.UID = u.UID
	WHERE uc.CommunityID = CommunityID;
END //