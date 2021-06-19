USE citytransportweb;

SELECT T2.* FROM (SELECT T.Transport_type_id FROM transport T
GROUP BY T.transport_type_id) AS T1,
LATERAL (SELECT X.*, T.Transport_type_id FROM transport T, 
(SELECT V.Vehicle_id, COUNT(V.Transaction_id) AS VCOUNT FROM validator_s_data V 
GROUP BY V.Vehicle_id) AS X
WHERE T1.Transport_type_id=T.Transport_type_id AND X.Vehicle_id=T.Vehicle_id
ORDER BY X.VCOUNT DESC LIMIT 3) AS T2;