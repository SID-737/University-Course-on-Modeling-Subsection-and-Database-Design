CREATE DEFINER=`root`@`localhost` PROCEDURE `sensors_data_creation`()
BEGIN
-- -------------------------------------------------------------------------------------------
-- 1 route 1 vehicle -------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------
SET @ROUTE=1,
	@VEHICLE=1,
    @PVEHICLE=1,
    @MAXP=(SELECT Transport.Capacity FROM Transport WHERE Vehicle_id=@VEHICLE);
-- ------------------------------------------------------------------------------------------
	SET 
    @tripcount=1,
    @stopcount=1,
    @count=1,
    @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @opent = (SELECT addtime(
	(SELECT Trip.Departure_time FROM Trip
	WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
	(SELECT Route_stop.Arrival_time FROM Route_stop 
	WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
    ),
    @closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
    -- (SELECT FLOOR(5 + (RAND() * 26))),
    @inp=(SELECT FLOOR(0 + (RAND() * 16))),
    @outp=0,
    -- (SELECT FLOOR(0 + (RAND() * 16))),
    @accuracy=1,
    @intop=@inp;
    WHILE @count <= 528  DO
		WHILE @tripcount<=48 DO
			WHILE @stopcount <= 11 DO
				INSERT INTO sensors__data
				(Record_id, Geolocation_coordinates_X, Passengers_came_in, Passengers_got_off, Door_opening_time, Door_closing_time, Data_accuracy, Geolocation_coordinates_Y, Public_vehicle_id, Vehicle_id)
				VALUES
				(@count,@geoX,@inp,@outp,@opent,@closet,@accuracy,@geoY,@PVEHICLE,@VEHICLE);
				SET 
					@stopcount=@stopcount+1,
                    @count=@count+1,
					@geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
			END WHILE;
			SET
			@stopcount=1,
            @tripcount=@tripcount+1,
            @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
                    @outp=(IF(@stopcount=1, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
		END WHILE;
    END WHILE;
-- -------------------------------------------------------------------------------------------
-- 1 route 2 vehicle -------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------
SET @ROUTE=1,
	@VEHICLE=2,
    @PVEHICLE=2,
    @MAXP=(SELECT Transport.Capacity FROM Transport WHERE Vehicle_id=@VEHICLE);
-- ------------------------------------------------------------------------------------------
	SET 
    @tripcount=97,
    @stopcount=1,
    @count=529,
    @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @opent = (SELECT addtime(
	(SELECT Trip.Departure_time FROM Trip
	WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
	(SELECT Route_stop.Arrival_time FROM Route_stop 
	WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
    ),
    @closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
    -- (SELECT FLOOR(5 + (RAND() * 26))),
    @inp=(SELECT FLOOR(0 + (RAND() * 16))),
    @outp=0,
    -- (SELECT FLOOR(0 + (RAND() * 16))),
    @accuracy=1,
    @intop=@inp;
    WHILE @count <= 1056  DO
		WHILE @tripcount<=144 DO
			WHILE @stopcount <= 11 DO
				INSERT INTO sensors__data
				(Record_id, Geolocation_coordinates_X, Passengers_came_in, Passengers_got_off, Door_opening_time, Door_closing_time, Data_accuracy, Geolocation_coordinates_Y, Public_vehicle_id, Vehicle_id)
				VALUES
				(@count,@geoX,@inp,@outp,@opent,@closet,@accuracy,@geoY,@PVEHICLE,@VEHICLE);
				SET 
					@stopcount=@stopcount+1,
                    @count=@count+1,
					@geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
			END WHILE;
			SET
			@stopcount=1,
            @tripcount=@tripcount+1,
            @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
                    @outp=(IF(@stopcount=1, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
		END WHILE;
    END WHILE;
-- -------------------------------------------------------------------------------------------
-- 2 route 3 vehicle -------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------
SET @ROUTE=2,
	@VEHICLE=3,
    @PVEHICLE=3,
    @MAXP=(SELECT Transport.Capacity FROM Transport WHERE Vehicle_id=@VEHICLE);
-- ------------------------------------------------------------------------------------------
	SET 
    @tripcount=49,
    @stopcount=1,
    @count=1057,
    @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @opent = (SELECT addtime(
	(SELECT Trip.Departure_time FROM Trip
	WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
	(SELECT Route_stop.Arrival_time FROM Route_stop 
	WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
    ),
    @closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
    -- (SELECT FLOOR(5 + (RAND() * 26))),
    @inp=(SELECT FLOOR(0 + (RAND() * 16))),
    @outp=0,
    -- (SELECT FLOOR(0 + (RAND() * 16))),
    @accuracy=1,
    @intop=@inp;
    WHILE @count <= 1584  DO
		WHILE @tripcount<=96 DO
			WHILE @stopcount <= 11 DO
				INSERT INTO sensors__data
				(Record_id, Geolocation_coordinates_X, Passengers_came_in, Passengers_got_off, Door_opening_time, Door_closing_time, Data_accuracy, Geolocation_coordinates_Y, Public_vehicle_id, Vehicle_id)
				VALUES
				(@count,@geoX,@inp,@outp,@opent,@closet,@accuracy,@geoY,@PVEHICLE,@VEHICLE);
				SET 
					@stopcount=@stopcount+1,
                    @count=@count+1,
					@geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
			END WHILE;
			SET
			@stopcount=1,
            @tripcount=@tripcount+1,
            @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
                    @outp=(IF(@stopcount=1, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
		END WHILE;
    END WHILE;
-- -------------------------------------------------------------------------------------------
-- 2 route 4 vehicle -------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------
SET @ROUTE=2,
	@VEHICLE=4,
    @PVEHICLE=4,
    @MAXP=(SELECT Transport.Capacity FROM Transport WHERE Vehicle_id=@VEHICLE);
-- ------------------------------------------------------------------------------------------
	SET 
    @tripcount=145,
    @stopcount=1,
    @count=1585,
    @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
    WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
    ) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
    @opent = (SELECT addtime(
	(SELECT Trip.Departure_time FROM Trip
	WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
	(SELECT Route_stop.Arrival_time FROM Route_stop 
	WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
    ),
    @closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
    -- (SELECT FLOOR(5 + (RAND() * 26))),
    @inp=(SELECT FLOOR(0 + (RAND() * 16))),
    @outp=0,
    -- (SELECT FLOOR(0 + (RAND() * 16))),
    @accuracy=1,
    @intop=@inp;
    WHILE @count <= 2112  DO
		WHILE @tripcount<=192 DO
			WHILE @stopcount <= 11 DO
				INSERT INTO sensors__data
				(Record_id, Geolocation_coordinates_X, Passengers_came_in, Passengers_got_off, Door_opening_time, Door_closing_time, Data_accuracy, Geolocation_coordinates_Y, Public_vehicle_id, Vehicle_id)
				VALUES
				(@count,@geoX,@inp,@outp,@opent,@closet,@accuracy,@geoY,@PVEHICLE,@VEHICLE);
				SET 
					@stopcount=@stopcount+1,
                    @count=@count+1,
					@geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
			END WHILE;
			SET
			@stopcount=1,
            @tripcount=@tripcount+1,
            @geoX = ((SELECT Geolocation_coordinates_X FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@geoY = ((SELECT Geolocation_coordinates_Y FROM A_stop 
					INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
					WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount
					) + (SELECT FLOOR(0 + (RAND() * 2))*0.000001)),
					@opent = (SELECT addtime(
					(SELECT Trip.Departure_time FROM Trip
					WHERE Vehicle_id=@VEHICLE AND Route_id=@ROUTE AND Trip_id=@tripcount),
					(SELECT Route_stop.Arrival_time FROM Route_stop 
					WHERE Route_id = @ROUTE AND Serial_number=@stopcount))
					),
					@closet = addtime(@opent, CONVERT((SELECT FLOOR(5 + (RAND() * 21))),TIME)),
					-- (SELECT FLOOR(5 + (RAND() * 26))),
					@inp=(IF(@stopcount=11, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@outp=(IF(@stopcount=11, @intop, (SELECT FLOOR(5 + (RAND() * 26))))),
                    @outp=(IF(@intop<@outp,@intop,@outp)),
                    @outp=(IF(@stopcount=1, 0, (SELECT FLOOR(5 + (RAND() * 26))))),
					@intop=@intop+@inp-@outp,
                    @inp=(IF(@intop>@MAXP, (@inp-(@intop-@MAXP)), @inp)),
					@intop=(IF(@intop>@MAXP, @MAXP, @intop));
		END WHILE;
    END WHILE;
END