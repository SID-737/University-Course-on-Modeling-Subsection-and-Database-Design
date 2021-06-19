USE citytransportweb;

SELECT t2.* from (SELECT P.transport_type_id
FROM parking p
GROUP BY p.transport_type_id) AS t1,
LATERAL (SELECT p.id_parking, p.parking_address, p.capacity, p.transport_type_id 
FROM parking p WHERE t1.transport_type_id=p.transport_type_id ORDER BY p.capacity DESC LIMIT 3) AS t2;
