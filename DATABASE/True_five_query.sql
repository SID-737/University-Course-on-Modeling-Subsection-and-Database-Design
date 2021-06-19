USE citytransportweb;
SELECT DISTINCT PS.Stop_id, PS.Name, PS.Part_of_day
FROM(
-- Среднее число входяищих на каждой остановке
SELECT R.Route_id, S.Stop_id, S.Name, SD.Vehicle_id, part_of_day(SD.Door_opening_time) AS Part_of_day, AVG(SD.Passengers_came_in) as Passengers
FROM a_stop AS S, sensors__data AS SD, Route_stop R
WHERE (geodist(S.Geolocation_coordinates_X, S.Geolocation_coordinates_Y, 
SD.Geolocation_coordinates_X, SD.Geolocation_coordinates_Y) <=5) AND R.Stop_id=S.Stop_id
GROUP BY  S.Stop_id, Part_of_day
) AS PS,
(
-- Среднее число вошдших по маршруту
SELECT PASSEN_STOP.Route_id, PASSEN_STOP.Part_of_day, AVG(PASSEN_STOP.Passengers) AS Passengers
FROM 
(
SELECT R.Route_id, S.Stop_id, S.Name, SD.Vehicle_id, part_of_day(SD.Door_opening_time) AS Part_of_day, AVG(SD.Passengers_came_in) as Passengers
FROM a_stop AS S, sensors__data AS SD, Route_stop R
WHERE (geodist(S.Geolocation_coordinates_X, S.Geolocation_coordinates_Y, 
SD.Geolocation_coordinates_X, SD.Geolocation_coordinates_Y) <=5) AND R.Stop_id=S.Stop_id
GROUP BY  S.Stop_id, Part_of_day
) AS PASSEN_STOP
GROUP BY PASSEN_STOP.Route_id, PASSEN_STOP.Part_of_day
) AS PR,
(
-- Среднее время открытых дверей для остановки
SELECT R.Route_id, S.Stop_id, S.Name, SD.Vehicle_id, part_of_day(SD.Door_opening_time) AS Part_of_day, AVG(UNIX_TIMESTAMP(SD.Door_closing_time)-UNIX_TIMESTAMP(SD.Door_opening_time)) as Time
FROM a_stop AS S, sensors__data AS SD, Route_stop R
WHERE (geodist(S.Geolocation_coordinates_X, S.Geolocation_coordinates_Y, 
SD.Geolocation_coordinates_X, SD.Geolocation_coordinates_Y) <=5) AND R.Stop_id=S.Stop_id
GROUP BY  S.Stop_id, Part_of_day
) AS TS,
(
-- Среднее время открытых дверей на маршруте
SELECT TIME_STOP.Route_id, TIME_STOP.Part_of_day, AVG(TIME_STOP.Time) AS Time
FROM 
(
SELECT R.Route_id, S.Stop_id, S.Name, SD.Vehicle_id, part_of_day(SD.Door_opening_time) AS Part_of_day, AVG(UNIX_TIMESTAMP(SD.Door_closing_time)-UNIX_TIMESTAMP(SD.Door_opening_time)) as Time
FROM a_stop AS S, sensors__data AS SD, Route_stop R
WHERE (geodist(S.Geolocation_coordinates_X, S.Geolocation_coordinates_Y, 
SD.Geolocation_coordinates_X, SD.Geolocation_coordinates_Y) <=5) AND R.Stop_id=S.Stop_id
GROUP BY  S.Stop_id, Part_of_day
) AS TIME_STOP
GROUP BY TIME_STOP.Route_id, TIME_STOP.Part_of_day
) AS TR
WHERE PS.Route_id=PR.Route_id AND PS.Passengers > PR.Passengers AND
TS.Route_id=TR.Route_id AND TS.Time > TR.Time
 GROUP BY Name




