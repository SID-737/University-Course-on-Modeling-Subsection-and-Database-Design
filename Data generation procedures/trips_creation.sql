CREATE DEFINER=`root`@`localhost` PROCEDURE `trips_creation`()
BEGIN
-- ------------------------------------------------------------------------------------------
	SET 
    @daycount=1,
    @subcount=1,
    @timeint=20200525080000,
    @count=1;
    WHILE @daycount<=6 DO
		WHILE @subcount<=8 DO
			INSERT INTO trip
			(Trip_id, Departure_time, Public_vehicle_id, Vehicle_id, Trip_type_id, Route_id, id_Parking)
			VALUES
			(@count,@timeint,1,1,3,1,21);
            SET 
            @subcount=@subcount+1,
            @timeint=@timeint+10000,
            @count=@count+1;
		END WHILE;
        SET
		@subcount=1,
		@timeint=@timeint-80000+1000000,
        @daycount=@daycount+1;
    END WHILE;
    -- --------------------------------------------------------------------------
    SET 
    @daycount=1,
    @subcount=1,
    @timeint=20200525080000;
    WHILE @daycount<=6 DO
		WHILE @subcount<=8 DO
			INSERT INTO trip
			(Trip_id, Departure_time, Public_vehicle_id, Vehicle_id, Trip_type_id, Route_id, id_Parking)
			VALUES
			(@count,@timeint,3,3,3,2,21);
            SET 
            @subcount=@subcount+1,
            @timeint=@timeint+10000,
            @count=@count+1;
		END WHILE;
        SET
		@subcount=1,
		@timeint=@timeint-80000+1000000,
        @daycount=@daycount+1;
    END WHILE;
    -- ------------------------------------------------------------------------------------------
	SET 
    @daycount=1,
    @subcount=1,
    @timeint=20200525160000;
    WHILE @daycount<=6 DO
		WHILE @subcount<=8 DO
			INSERT INTO trip
			(Trip_id, Departure_time, Public_vehicle_id, Vehicle_id, Trip_type_id, Route_id, id_Parking)
			VALUES
			(@count,@timeint,2,2,3,1,21);
            SET 
            @subcount=@subcount+1,
            @timeint=@timeint+10000,
            @count=@count+1;
		END WHILE;
        SET
		@subcount=1,
		@timeint=@timeint-80000+1000000,
        @daycount=@daycount+1;
    END WHILE;
    -- --------------------------------------------------------------------------
    SET 
    @daycount=1,
    @subcount=1,
    @timeint=20200525160000;
    WHILE @daycount<=6 DO
		WHILE @subcount<=8 DO
			INSERT INTO trip
			(Trip_id, Departure_time, Public_vehicle_id, Vehicle_id, Trip_type_id, Route_id, id_Parking)
			VALUES
			(@count,@timeint,4,4,3,2,21);
            SET 
            @subcount=@subcount+1,
            @timeint=@timeint+10000,
            @count=@count+1;
		END WHILE;
        SET
		@subcount=1,
		@timeint=@timeint-80000+1000000,
        @daycount=@daycount+1;
    END WHILE;
        
END