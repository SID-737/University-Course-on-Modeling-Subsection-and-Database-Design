
CREATE TABLE A_stop
(
	Stop_id              SMALLINT NOT NULL,
	Geolocation_coordinates_X DECIMAL(9,6) NOT NULL,
	Name                 VARCHAR(50) NOT NULL,
	Geolocation_coordinates_Y DECIMAL(9,6) NOT NULL,
	Stop_type_id         TINYINT NOT NULL
);

ALTER TABLE A_stop
ADD CONSTRAINT XPKA_stop PRIMARY KEY (Stop_id);

CREATE TABLE Parking
(
	id_Parking           INTEGER NOT NULL,
	Parking_address      VARCHAR(100) NOT NULL,
	Capacity             SMALLINT NOT NULL,
	Comment              VARCHAR(100) NULL,
	Geolocation_coordinates_X DECIMAL(9,6) NOT NULL,
	Geolocation_coordinates_Y DECIMAL(9,6) NOT NULL,
	Parking_type_id      TINYINT NOT NULL,
	Transport_type_id    SMALLINT NOT NULL
);

ALTER TABLE Parking
ADD CONSTRAINT XPKParking PRIMARY KEY (id_Parking);

CREATE TABLE Parking_type
(
	Parking_type_id      TINYINT NOT NULL,
	Parking_type_name    VARCHAR(50) NOT NULL
);

ALTER TABLE Parking_type
ADD CONSTRAINT XPKParking_type PRIMARY KEY (Parking_type_id);

CREATE TABLE Public_vehicle
(
	Public_vehicle_id    INTEGER NOT NULL,
	Vehicle_id           INTEGER NOT NULL
);

ALTER TABLE Public_vehicle
ADD CONSTRAINT XPKPublic_vehicle PRIMARY KEY (Public_vehicle_id,Vehicle_id);

CREATE TABLE Rented_vehicle
(
	Rented_vehicle_id    INTEGER NOT NULL,
	Vehicle_id           INTEGER NOT NULL
);

ALTER TABLE Rented_vehicle
ADD CONSTRAINT XPKRented_vehicle PRIMARY KEY (Rented_vehicle_id,Vehicle_id);

CREATE TABLE Route
(
	Route_id             SMALLINT NOT NULL,
	Name_of_route        VARCHAR(50) NOT NULL,
	Comment              VARCHAR(100) NULL
);

ALTER TABLE Route
ADD CONSTRAINT XPKRoute PRIMARY KEY (Route_id);

CREATE TABLE Route_stop
(
	Serial_number        SMALLINT NOT NULL,
	Arrival_time         DATETIME NOT NULL,
	Route_id             SMALLINT NOT NULL,
	Stop_id              SMALLINT NOT NULL
);

ALTER TABLE Route_stop
ADD CONSTRAINT XPKRoute_stop PRIMARY KEY (Serial_number,Route_id,Stop_id);

CREATE TABLE Sensors__data
(
	Record_id            BIGINT NOT NULL,
	Geolocation_coordinates_X DECIMAL(9,6) NOT NULL,
	Passengers_came_in   MEDIUMINT NOT NULL,
	Passengers_got_off   MEDIUMINT NOT NULL,
	Door_opening_time    DATETIME NOT NULL,
	Door_closing_time    DATETIME NOT NULL,
	Data_accuracy        TINYINT NOT NULL,
	Geolocation_coordinates_Y DECIMAL(9,6) NOT NULL,
	Public_vehicle_id    INTEGER NOT NULL,
	Vehicle_id           INTEGER NOT NULL
);

ALTER TABLE Sensors__data
ADD CONSTRAINT XPKSensors__data PRIMARY KEY (Record_id);

CREATE TABLE Status
(
	Status_id            BINARY NOT NULL,
	Status_Name          VARCHAR(20) NOT NULL
);

ALTER TABLE Status
ADD CONSTRAINT XPKStatus PRIMARY KEY (Status_id);

CREATE TABLE Stop_type
(
	Stop_type_id         TINYINT NOT NULL,
	Stop_type_name       VARCHAR(50) NOT NULL
);

ALTER TABLE Stop_type
ADD CONSTRAINT XPKStop_type PRIMARY KEY (Stop_type_id);

CREATE TABLE Transport
(
	Vehicle_id           INTEGER NOT NULL,
	Capacity             SMALLINT NOT NULL,
	Transport_type_id    SMALLINT NOT NULL
);

ALTER TABLE Transport
ADD CONSTRAINT XPKTransport PRIMARY KEY (Vehicle_id);

CREATE TABLE Transport_type
(
	Transport_type_id    SMALLINT NOT NULL,
	Transport_type_name  VARCHAR(100) NOT NULL
);

ALTER TABLE Transport_type
ADD CONSTRAINT XPKTransport_type PRIMARY KEY (Transport_type_id);

CREATE TABLE Trip
(
	Trip_id              BIGINT NOT NULL,
	Departure_time       DATETIME NOT NULL,
	Public_vehicle_id    INTEGER NOT NULL,
	Vehicle_id           INTEGER NOT NULL,
	Trip_type_id         TINYINT NOT NULL,
	Route_id             SMALLINT NOT NULL,
	id_Parking           INTEGER NOT NULL
);

ALTER TABLE Trip
ADD CONSTRAINT XPKTrip PRIMARY KEY (Trip_id,Public_vehicle_id,Vehicle_id);

CREATE TABLE Trip_type
(
	Trip_type_id         TINYINT NOT NULL,
	Trip_type_name       VARCHAR(20) NOT NULL
);

ALTER TABLE Trip_type
ADD CONSTRAINT XPKTrip_type PRIMARY KEY (Trip_type_id);

CREATE TABLE Validator_s_data
(
	Transaction_id       BIGINT NOT NULL,
	Card_id              BIGINT NOT NULL,
	Payment_time         DATETIME NOT NULL,
	Public_vehicle_id    INTEGER NOT NULL,
	Vehicle_id           INTEGER NOT NULL
);

ALTER TABLE Validator_s_data
ADD CONSTRAINT XPKValidator_s_data PRIMARY KEY (Transaction_id);

CREATE TABLE Vehicle_rent_status_data
(
	Departure_waiting_time DATETIME NOT NULL,
	Average_speed        SMALLINT NOT NULL,
	Card_id              BIGINT NULL,
	Rented_vehicle_id    INTEGER NOT NULL,
	id_Parking           INTEGER NOT NULL,
	Status_id            BINARY NOT NULL,
	Vehicle_id           INTEGER NOT NULL
);

ALTER TABLE Vehicle_rent_status_data
ADD CONSTRAINT XPKVehicle_rent_status_data PRIMARY KEY (Departure_waiting_time,Rented_vehicle_id,Vehicle_id);

ALTER TABLE A_stop
ADD CONSTRAINT R_19 FOREIGN KEY (Stop_type_id) REFERENCES Stop_type (Stop_type_id);

ALTER TABLE Parking
ADD CONSTRAINT R_7 FOREIGN KEY (Parking_type_id) REFERENCES Parking_type (Parking_type_id);

ALTER TABLE Parking
ADD CONSTRAINT R_11 FOREIGN KEY (Transport_type_id) REFERENCES Transport_type (Transport_type_id);

ALTER TABLE Public_vehicle
ADD CONSTRAINT R_8 FOREIGN KEY (Vehicle_id) REFERENCES Transport (Vehicle_id)
		ON DELETE CASCADE;

ALTER TABLE Rented_vehicle
ADD CONSTRAINT R_9 FOREIGN KEY (Vehicle_id) REFERENCES Transport (Vehicle_id)
		ON DELETE CASCADE;

ALTER TABLE Route_stop
ADD CONSTRAINT R_15 FOREIGN KEY (Route_id) REFERENCES Route (Route_id);

ALTER TABLE Route_stop
ADD CONSTRAINT R_18 FOREIGN KEY (Stop_id) REFERENCES A_stop (Stop_id);

ALTER TABLE Sensors__data
ADD CONSTRAINT R_1 FOREIGN KEY (Public_vehicle_id, Vehicle_id) REFERENCES Public_vehicle (Public_vehicle_id, Vehicle_id);

ALTER TABLE Transport
ADD CONSTRAINT R_10 FOREIGN KEY (Transport_type_id) REFERENCES Transport_type (Transport_type_id);

ALTER TABLE Trip
ADD CONSTRAINT R_12 FOREIGN KEY (Public_vehicle_id, Vehicle_id) REFERENCES Public_vehicle (Public_vehicle_id, Vehicle_id);

ALTER TABLE Trip
ADD CONSTRAINT R_13 FOREIGN KEY (Trip_type_id) REFERENCES Trip_type (Trip_type_id);

ALTER TABLE Trip
ADD CONSTRAINT R_14 FOREIGN KEY (Route_id) REFERENCES Route (Route_id);

ALTER TABLE Trip
ADD CONSTRAINT R_16 FOREIGN KEY (id_Parking) REFERENCES Parking (id_Parking);

ALTER TABLE Trip
ADD CONSTRAINT R_17 FOREIGN KEY (id_Parking) REFERENCES Parking (id_Parking);

ALTER TABLE Validator_s_data
ADD CONSTRAINT R_2 FOREIGN KEY (Public_vehicle_id, Vehicle_id) REFERENCES Public_vehicle (Public_vehicle_id, Vehicle_id);

ALTER TABLE Vehicle_rent_status_data
ADD CONSTRAINT R_3 FOREIGN KEY (Rented_vehicle_id, Vehicle_id) REFERENCES Rented_vehicle (Rented_vehicle_id, Vehicle_id);

ALTER TABLE Vehicle_rent_status_data
ADD CONSTRAINT R_5 FOREIGN KEY (id_Parking) REFERENCES Parking (id_Parking);

ALTER TABLE Vehicle_rent_status_data
ADD CONSTRAINT R_6 FOREIGN KEY (Status_id) REFERENCES Status (Status_id);
