USE NPRO;

DELIMITER //

DROP PROCEDURE IF EXISTS DeleteUserInfo //
 
CREATE PROCEDURE DeleteUserInfo(
	UserID BIGINT)
BEGIN
	SET @Now = NOW();
	SET @Creator = "LiYang";

	SELECT ActiveID INTO @DeletedStatus
	FROM ActiveStatus a
	WHERE a.ActiveStatusName = "Deleted";

	UPDATE User u
	SET u.ActiveStatus = @DeletedStatus,
	  u.LastModifiedDate = @Now,
	  u.LastModifiedBy = @Creator
	WHERE u.UID = UserID;
END //