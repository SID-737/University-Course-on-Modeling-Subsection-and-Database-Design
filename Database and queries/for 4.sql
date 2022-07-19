/*
1

SELECT SD.Vehicle_id, dayname(SD.Door_opening_time) as dayofweek, sum(SD.Passengers_came_in) as Passengers_S
FROM sensors__data AS SD
group by  SD.Vehicle_id, dayname(SD.Door_opening_time)

2

SELECT SD.Vehicle_id, dayname(SD.Door_opening_time) as dayofweek, count(V.Transaction_id) Passengers_V
FROM sensors__data AS SD, validator_s_data AS V
WHERE SD.Vehicle_id=V.Vehicle_id AND (SD.Door_opening_time < V.Payment_time AND
addtime(SD.Door_closing_time, sec_to_time(60)) > V.Payment_time)
group by  SD.Vehicle_id, dayname(SD.Door_opening_time)
*/

SELECT S.Vehicle_id, S.dayofweek, (S.Passengers_S-V.Passengers_V) AS Tiketless
FROM(
SELECT SD.Vehicle_id, dayname(SD.Door_opening_time) as dayofweek, count(V.Transaction_id) Passengers_V
FROM sensors__data AS SD, validator_s_data AS V
WHERE SD.Vehicle_id=V.Vehicle_id AND (SD.Door_opening_time < V.Payment_time AND
addtime(SD.Door_closing_time, sec_to_time(60)) > V.Payment_time)
group by  SD.Vehicle_id, dayname(SD.Door_opening_time)
) AS V,
(SELECT SD.Vehicle_id, dayname(SD.Door_opening_time) as dayofweek, sum(SD.Passengers_came_in) as Passengers_S
FROM sensors__data AS SD
group by  SD.Vehicle_id, dayname(SD.Door_opening_time)
) AS S
WHERE V.Vehicle_id=S.Vehicle_id AND V.dayofweek=S.dayofweek
