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

