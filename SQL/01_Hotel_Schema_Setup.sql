-- PlatinumRx Assignment - Hotel Management System

DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    user_id         VARCHAR(50) PRIMARY KEY,
    name            VARCHAR(100),
    phone_number    VARCHAR(20),
    mail_id         VARCHAR(100),
    billing_address VARCHAR(200)
);


CREATE TABLE bookings (
    booking_id   VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no      VARCHAR(50),
    user_id      VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


CREATE TABLE items (
    item_id   VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);


CREATE TABLE booking_commercials (
    id            VARCHAR(50) PRIMARY KEY,
    booking_id    VARCHAR(50),
    bill_id       VARCHAR(50),
    bill_date     DATETIME,
    item_id       VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id)    REFERENCES items(item_id)
);

-- ============================================
-- SAMPLE DATA
-- ============================================

INSERT INTO users VALUES
('usr-001', 'John Doe',     '9711111111', 'john@example.com',   '10, Street A, Mumbai'),
('usr-002', 'Jane Smith',   '9722222222', 'jane@example.com',   '20, Street B, Delhi'),
('usr-003', 'Arjun Nair',   '9733333333', 'arjun@example.com',  '30, Street C, Pune'),
('usr-004', 'Sneha Reddy',  '9744444444', 'sneha@example.com',  '40, Street D, Hyderabad'),
('usr-005', 'Vikram Singh', '9755555555', 'vikram@example.com', '50, Street E, Chennai');

INSERT INTO items VALUES
('itm-001', 'Tawa Paratha',         18.00),
('itm-002', 'Mix Veg',              89.00),
('itm-003', 'Dal Fry',              75.00),
('itm-004', 'Paneer Butter Masala',150.00),
('itm-005', 'Biryani',             180.00),
('itm-006', 'Cold Coffee',          60.00);

INSERT INTO bookings VALUES
('bk-001', '2021-09-10 10:00:00', 'rm-101', 'usr-001'),
('bk-002', '2021-10-05 11:30:00', 'rm-102', 'usr-002'),
('bk-003', '2021-10-15 09:00:00', 'rm-103', 'usr-003'),
('bk-004', '2021-11-01 14:00:00', 'rm-101', 'usr-004'),
('bk-005', '2021-11-10 08:00:00', 'rm-104', 'usr-001'),
('bk-006', '2021-11-20 16:00:00', 'rm-105', 'usr-002'),
('bk-007', '2021-12-01 12:00:00', 'rm-102', 'usr-003'),
('bk-008', '2021-12-15 10:00:00', 'rm-103', 'usr-005');

-- bill amounts: qty * item_rate
INSERT INTO booking_commercials VALUES
('bc-001', 'bk-002', 'bl-001', '2021-10-05 12:00:00', 'itm-001', 3),
('bc-002', 'bk-002', 'bl-001', '2021-10-05 12:00:00', 'itm-002', 1),
('bc-003', 'bk-002', 'bl-002', '2021-10-06 12:00:00', 'itm-004', 2),
('bc-004', 'bk-003', 'bl-003', '2021-10-15 13:00:00', 'itm-005', 3),
('bc-005', 'bk-003', 'bl-003', '2021-10-15 13:00:00', 'itm-006', 4),
('bc-006', 'bk-003', 'bl-004', '2021-10-16 13:00:00', 'itm-004', 5),
('bc-007', 'bk-004', 'bl-005', '2021-11-01 15:00:00', 'itm-001', 2),
('bc-008', 'bk-004', 'bl-005', '2021-11-01 15:00:00', 'itm-003', 3),
('bc-009', 'bk-005', 'bl-006', '2021-11-10 09:00:00', 'itm-004', 4),
('bc-010', 'bk-005', 'bl-006', '2021-11-10 09:00:00', 'itm-005', 2),
('bc-011', 'bk-006', 'bl-007', '2021-11-20 17:00:00', 'itm-002', 5),
('bc-012', 'bk-006', 'bl-007', '2021-11-20 17:00:00', 'itm-006', 3),
('bc-013', 'bk-007', 'bl-008', '2021-12-01 13:00:00', 'itm-005', 4),
('bc-014', 'bk-007', 'bl-008', '2021-12-01 13:00:00', 'itm-004', 3),
('bc-015', 'bk-008', 'bl-009', '2021-12-15 11:00:00', 'itm-001', 6),
('bc-016', 'bk-008', 'bl-009', '2021-12-15 11:00:00', 'itm-003', 2);