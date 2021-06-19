-- SELECT Transport.Capacity FROM Transport WHERE Vehicle_id=4

-- SELECT Geolocation_coordinates_X FROM A_stop 
--    INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
--   WHERE Route_stop.Route_id=1 AND Route_stop.Serial_number=1

/* SELECT addtime(Trip.Departure_time, Route_stop.Arrival_time), Route_stop.Route_id, Route_stop.Serial_number FROM Route_stop
    INNER JOIN Trip ON Route_stop.Route_id=Trip.Route_id
    WHERE Route_stop.Route_id=1 AND Trip.Vehicle_id=1 AND Route_stop.Serial_number=1
 */   
Set @nowtrip=1;
-- while @nowtrip<=48 do
    
/* select addtime(
(select Trip.Depaparture_time from Trip
where Vehicle_id=1 AND Route_id=1 AND Trip_id=@nowtrip),
(select Route_stop.Arrival_time from Route_stop 
where Route_id = 1 AND Serial_number=@serial))
*/

/*
SELECT addtime(
 (SELECT addtime(
	(SELECT Trip.Departure_time FROM Trip
	WHERE Vehicle_id=1 AND Route_id=1 AND Trip_id=1),
	(SELECT Route_stop.Arrival_time FROM Route_stop 
	WHERE Route_id = 1 AND Serial_number=3))),
    CONVERT((SELECT FLOOR(5 + (RAND() * 26))),TIME) )
 */
 
   SELECT 
   ((SELECT Geolocation_coordinates_X FROM A_stop 
	INNER JOIN Route_stop ON A_stop.Stop_id=Route_stop.Stop_id
	WHERE Route_stop.Route_id=@ROUTE AND Route_stop.Serial_number=@stopcount) + 
    (SELECT FLOOR(0 + (RAND() * 2))*0.000001))