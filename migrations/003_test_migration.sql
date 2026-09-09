-- Hot-path indexes: time-series reads per sensor, open alerts, equipment lookups
CREATE INDEX IF NOT EXISTS ix_telemetry_readings_sensor_time
    ON telemetry_readings (sensor_id, reading_time DESC);
CREATE INDEX IF NOT EXISTS ix_alerts_sensor_time
    ON alerts (sensor_id, alert_time DESC);
CREATE INDEX IF NOT EXISTS ix_work_orders_equipment
    ON work_orders (equipment_id);
CREATE INDEX IF NOT EXISTS ix_equipment_line
    ON equipment (line_id);
CREATE INDEX IF NOT EXISTS ix_sensors_equipment
    ON sensors (equipment_id);
CREATE INDEX IF NOT EXISTS ix_alerts_unresolved_time
    ON alerts (alert_time DESC)
    WHERE resolved_at IS NULL;

ALTER TABLE equipment
    DROP COLUMN IF EXISTS model_number;

ALTER TABLE sensors
    ADD COLUMN IF NOT EXISTS last_calibrated_at TIMESTAMP;

ALTER TABLE work_orders
    ALTER COLUMN priority TYPE TEXT;
