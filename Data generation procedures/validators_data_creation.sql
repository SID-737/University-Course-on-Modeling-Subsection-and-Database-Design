CREATE DEFINER=`root`@`localhost` PROCEDURE `validator_s_data_creation`()
BEGIN
-- ------------------------------------------------------------------------------------------
	SET 
    @count=1,
    @sensorcount=1,
    @VEHICLE=1,
    @PVEHICLE=1,
    @MINUS=POW((SELECT FLOOR(0 + (RAND() * 2))),8)+POW((SELECT FLOOR(0 + (RAND() * 2))),8);
    WHILE @sensorcount <= 2112 DO
		WHILE @transactioncount <= 
        (SELECT Sensors__data.Passengers_came_in FROM Sensors__data
        WHERE Sensors__data.Record_id=@sensorcount)-@MINUS 
        
        DO
			SET
            @ptime = addtime(
            (SELECT Sensors__data.Door_opening_time FROM Sensors__data
            WHERE Sensors__data.Record_id=@sensorcount)
            , CONVERT((SELECT FLOOR(1 + (RAND() * 40))),TIME)),
            @card = (SELECT FLOOR(1000000000000000 + (RAND() * 9000000000000000)));
            
			INSERT INTO Validator_s_data
			(Transaction_id, Card_id, Payment_time, Public_vehicle_id, Vehicle_id)
			VALUES
			(@count,@card,@ptime,@VEHICLE,@PVEHICLE);
            SET 
            @count=@count+1,
            @transactioncount=@transactioncount+1;
		END WHILE;
        SET
        @sensorcount=@sensorcount+1,
		@transactioncount=1,
        @VEHICLE = (IF (@sensorcount>=529,2,@VEHICLE)),
        @VEHICLE=(IF (@sensorcount>=1057,3,@VEHICLE)),
        @VEHICLE=(IF (@sensorcount>=1585,4,@VEHICLE)),
        @PVEHICLE=@VEHICLE,
        @MINUS=POW((SELECT FLOOR(0 + (RAND() * 2))),8)+POW((SELECT FLOOR(0 + (RAND() * 2))),8);
    END WHILE;
END