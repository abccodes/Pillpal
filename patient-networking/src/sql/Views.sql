CREATE VIEW `PDMView` AS
SELECT UnitID, UnitOwnerUID, UnitNickname, UnitType, UnitStatus
FROM `PillPal.Units`;

CREATE VIEW `SensorView` AS
SELECT SensorID, SensorNickname, SensorType, SensorStatus, SensorLastUpdate, SensorUnitID
FROM `PillPal.Sensors`;
