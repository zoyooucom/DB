USE NPRO;

DELIMITER //

DROP PROCEDURE IF EXISTS DeleteUserInfo //
 
-- Stored procedure to delete user info
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

DROP PROCEDURE IF EXISTS DeleteCommunityInfo //

-- Stored procedure to delete community info
CREATE PROCEDURE DeleteCommunityInfo(CommunityID BIGINT)
BEGIN
	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	SELECT ActiveID INTO @DeletedStatus
	FROM ActiveStatus a
	WHERE a.ActiveStatusName = "Deleted";

	UPDATE Community c
	SET c.ActiveStatus = @DeletedStatus,
	  c.LastModifiedDate = @Now,
	  c.LastModifiedBy = @Creator
	WHERE c.CommunityID = CommunityID;
END //

DROP PROCEDURE IF EXISTS DeleteUserCommunityRelationship //

-- Stored procedure to delete user community relationship
CREATE PROCEDURE DeleteUserCommunityRelationship(
	UserID BIGINT,
	CommunityID BIGINT)
BEGIN
	SET @Now = NOW();
	SET @Creator = "LiYang";
	
	SELECT ActiveID INTO @DeletedStatus
	FROM ActiveStatus a
	WHERE a.ActiveStatusName = "Deleted";
	

	UPDATE UserCommunityRelationship ucr
	SET ucr.ActiveStatus = @DeletedStatus,
		ucr.LastModifiedDate = @Now,
		ucr.LastModifiedBy = @Creator
	WHERE ucr.UID = UserID AND ucr.CommunityID = CommunityID;
END //