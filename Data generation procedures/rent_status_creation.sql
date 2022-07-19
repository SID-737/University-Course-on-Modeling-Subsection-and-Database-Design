CREATE DEFINER=`root`@`localhost` PROCEDURE `rent_status_creation`()
BEGIN
-- ----------------------------------------------------------------------------------------------------
-- CAR ------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
SET 
	@VEHICLE=5,
    @dwtime=addtime('2020-05-25 00:00:00', SEC_TO_TIME(FLOOR(5 + (RAND() * 21596)))),
    @statusid=0,
    @speed=(IF(@statusid=0,0,(FLOOR(60 + (RAND() * 31))))),
    @card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000))))),
    @RVEHICLE=@VEHICLE-4,
    @rparking=(SELECT FLOOR(1 + (RAND() * 9))),
    @parking=@rparking;
    
    WHILE @VEHICLE<=15 DO
		WHILE @dwtime<='2020-05-31 00:00:00' DO
			INSERT INTO Vehicle_rent_status_data
			(Departure_waiting_time, Average_speed, Card_id, Rented_vehicle_id, id_Parking, Status_id, Vehicle_id)
			VALUES
			(@dwtime,@speed,@card,@RVEHICLE,@parking,@statusid,@VEHICLE);
            SET
            @statusid=(IF(@statusid=0,1,0)),
            @dwtime=(IF(@statusid=0, addtime(@dwtime, SEC_TO_TIME( FLOOR(5 + (RAND() * 21596)))),
            addtime(@dwtime, SEC_TO_TIME( FLOOR(600 + (RAND() * 6601)))))),
            @speed=(IF(@statusid=0,0,(FLOOR(60 + (RAND() * 31))))),
            @card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000)))));
            WHILE @parking=@rparking DO
            SET @rparking=(FLOOR(1 + (RAND() * 9)));
            END WHILE;
            SET @parking=@rparking;
		END WHILE;
        SET
        @dwtime=addtime('2020-05-25 00:00:00', SEC_TO_TIME(FLOOR(5 + (RAND() * 21596)))),
        @VEHICLE=@VEHICLE+1,
        @statusid=0,
		@speed=(IF(@statusid=0,0,(FLOOR(60 + (RAND() * 31))))),
		@card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000))))),
		@RVEHICLE=@VEHICLE-4,
		@rparking=(FLOOR(1 + (RAND() * 9))),
		@parking=@rparking;
    END WHILE;
    
-- ----------------------------------------------------------------------------------------------------
-- BICYCLE --------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------
SET 
	@VEHICLE=16,
    @dwtime = addtime('2020-05-25 00:00:00', (SEC_TO_TIME(FLOOR(5 + (RAND() * 21596))))),
    @statusid=0,
    @speed=(IF(@statusid=0,0,(FLOOR(5 + (RAND() * 26))))),
    @card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000))))),
    @RVEHICLE=@VEHICLE-4,
    @rparking=(FLOOR(11 + (RAND() * 5))),
    @parking=@rparking;
    
    WHILE @VEHICLE<=27 DO
		WHILE @dwtime<='2020-05-31 00:00:00' DO
			INSERT INTO Vehicle_rent_status_data
			(Departure_waiting_time, Average_speed, Card_id, Rented_vehicle_id, id_Parking, Status_id, Vehicle_id)
			VALUES
			(@dwtime,@speed,@card,@RVEHICLE,@parking,@statusid,@VEHICLE);
            SET
            @statusid=(IF(@statusid=0,1,0)),
            @dwtime=(IF(@statusid=0, addtime(@dwtime, SEC_TO_TIME(FLOOR(5 + (RAND() * 21596)))),
            addtime(@dwtime, SEC_TO_TIME(FLOOR(600 + (RAND() * 6601)))))),
            @speed=(IF(@statusid=0,0,(FLOOR(5 + (RAND() * 26))))),
            @card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000)))));
            WHILE @parking=@rparking DO
            SET @rparking=(FLOOR(11 + (RAND() * 5)));
            END WHILE;
            SET @parking=@rparking;
		END WHILE;
        SET
        @dwtime=addtime('2020-05-25 00:00:00', SEC_TO_TIME(FLOOR(5 + (RAND() * 21596)))),
        @VEHICLE=@VEHICLE+1,
		@statusid=0,
		@speed=(IF(@statusid=0,0,(FLOOR(5 + (RAND() * 26))))),
		@card=(IF(@statusid=0,NULL,(FLOOR(1000000000000000 + (RAND() * 9000000000000000))))),
		@RVEHICLE=@VEHICLE-4,
		@rparking=(FLOOR(11 + (RAND() * 5))),
		@parking=@rparking;
    END WHILE;
END