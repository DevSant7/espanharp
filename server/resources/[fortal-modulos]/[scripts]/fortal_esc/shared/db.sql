CREATE TABLE IF NOT EXISTS fortal_esc_vehicles (
    user_id INTEGER NOT NULL,
    vehicle VARCHAR(100) NOT NULL,
    vip_expiry INTEGER NOT NULL,
    PRIMARY KEY (user_id, vehicle)
);
