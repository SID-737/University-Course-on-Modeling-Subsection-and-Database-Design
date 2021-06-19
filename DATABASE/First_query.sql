USE citytransportweb;
SELECT p.id_parking, p.parking_address, p.capacity,
tt.transport_type_id, tt.transport_type_name
FROM parking p, transport_type tt
WHERE p.transport_type_id=tt.transport_type_id
GROUP BY tt.transport_type_id
ORDER BY p.capacity DESC 
LIMIT 3