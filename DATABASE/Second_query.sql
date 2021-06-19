use citytransportweb;
select p.id_parking, p.parking_address, p.capacity,
tt.transport_type_id, tt.transport_type_name
from parking p, transport_type tt
where p.transport_type_id=tt.transport_type_id
group by tt.transport_type_id
order by p.capacity desc 
limit 3