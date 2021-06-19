


-- select Trip.Departure_time from Trip
-- where Vehicle_id=1 AND Route_id=1 AND Trip_id=1
-- select Route_stop.Arrival_time from Route_stop 
-- where Route_id = 1 AND Serial_number=1

/*SELECT SUM(Sensors__data.Passengers_came_in) FROM Sensors__data
         where vehicle_id=1;
         */
         
         SET
         @dwtime=addtime('2020-05-25 00:00:00', SEC_TO_TIME(FLOOR(5 + (RAND() * 21596)))) ,
         @statusid=0,
         @dwtime2=(IF(@statusid=0, addtime(@dwtime, SEC_TO_TIME( FLOOR(5 + (RAND() * 21596)))),
         addtime(@dwtime, SEC_TO_TIME( FLOOR(600 + (RAND() * 6601))))));
         select @dwtime, @dwtime2;