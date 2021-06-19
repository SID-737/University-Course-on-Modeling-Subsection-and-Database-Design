SELECT S.Stop_id, S.Name, sum(SD.Passengers_came_in) AS Passengers FROM a_stop AS S, sensors__data AS SD
WHERE (geodist(S.Geolocation_coordinates_X, S.Geolocation_coordinates_Y, 
SD.Geolocation_coordinates_X, SD.Geolocation_coordinates_Y) <=5)
GROUP BY S.Stop_id
ORDER BY Passengers DESC
LIMIT 5
