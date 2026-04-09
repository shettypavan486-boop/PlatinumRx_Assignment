-- PlatinumRx Assignment - Clinic Management System

DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;


CREATE TABLE clinics (
    cid         VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city        VARCHAR(100),
    state       VARCHAR(100),
    country     VARCHAR(100)
);


CREATE TABLE customer (
    uid    VARCHAR(50) PRIMARY KEY,
    name   VARCHAR(100),
    mobile VARCHAR(20)
);


CREATE TABLE clinic_sales (
    oid          VARCHAR(50) PRIMARY KEY,
    uid          VARCHAR(50),
    cid          VARCHAR(50),
    amount       DECIMAL(10, 2),
    datetime     DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);


CREATE TABLE expenses (
    eid         VARCHAR(50) PRIMARY KEY,
    cid         VARCHAR(50),
    description VARCHAR(200),
    amount      DECIMAL(10, 2),
    datetime    DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- ============================================
-- SAMPLE DATA
-- ============================================

INSERT INTO clinics VALUES
('cnc-001', 'HealthFirst Clinic',  'Mumbai',    'Maharashtra', 'India'),
('cnc-002', 'CarePoint Clinic',    'Pune',      'Maharashtra', 'India'),
('cnc-003', 'WellBeing Center',    'Bangalore', 'Karnataka',   'India'),
('cnc-004', 'MediCare Clinic',     'Mysore', 'Karnataka',   'India'),
('cnc-005', 'LifeCare Hospital',   'Manglore',   'Karnataka',  'India');

INSERT INTO customer VALUES
('cust-001', 'Jon Doe',      '9700000001'),
('cust-002', 'Priya Mehta',  '9700000002'),
('cust-003', 'Rahul Sharma', '9700000003'),
('cust-004', 'Anita Rao',    '9700000004'),
('cust-005', 'Suresh Kumar', '9700000005'),
('cust-006', 'Deepa Nair',   '9700000006'),
('cust-007', 'Kiran Patel',  '9700000007'),
('cust-008', 'Meena Singh',  '9700000008');

INSERT INTO clinic_sales VALUES
('ord-001', 'cust-001', 'cnc-001', 24999, '2021-01-10 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-001',  5000, '2021-01-15 11:00:00', 'walk-in'),
('ord-003', 'cust-003', 'cnc-002', 15000, '2021-02-05 09:30:00', 'online'),
('ord-004', 'cust-004', 'cnc-002',  8000, '2021-02-20 14:00:00', 'walk-in'),
('ord-005', 'cust-001', 'cnc-003', 12000, '2021-03-08 10:00:00', 'online'),
('ord-006', 'cust-005', 'cnc-003',  3500, '2021-03-15 16:00:00', 'walk-in'),
('ord-007', 'cust-002', 'cnc-004', 20000, '2021-04-12 11:30:00', 'online'),
('ord-008', 'cust-006', 'cnc-004',  9000, '2021-04-25 13:00:00', 'walk-in'),
('ord-009', 'cust-003', 'cnc-005', 11000, '2021-05-03 09:00:00', 'online'),
('ord-010', 'cust-007', 'cnc-005',  6000, '2021-05-18 15:00:00', 'walk-in'),
('ord-011', 'cust-001', 'cnc-001', 30000, '2021-06-07 10:00:00', 'online'),
('ord-012', 'cust-008', 'cnc-002', 14000, '2021-06-21 12:00:00', 'walk-in'),
('ord-013', 'cust-004', 'cnc-003', 17000, '2021-07-09 11:00:00', 'online'),
('ord-014', 'cust-005', 'cnc-004',  4500, '2021-07-23 14:00:00', 'walk-in'),
('ord-015', 'cust-006', 'cnc-005', 22000, '2021-08-11 10:30:00', 'online'),
('ord-016', 'cust-002', 'cnc-001',  7500, '2021-08-28 16:00:00', 'walk-in'),
('ord-017', 'cust-007', 'cnc-002', 13000, '2021-09-14 09:00:00', 'online'),
('ord-018', 'cust-003', 'cnc-003',  9500, '2021-09-27 13:00:00', 'walk-in'),
('ord-019', 'cust-008', 'cnc-004', 18000, '2021-10-06 11:00:00', 'online'),
('ord-020', 'cust-001', 'cnc-005', 25000, '2021-10-22 15:30:00', 'walk-in'),
('ord-021', 'cust-004', 'cnc-001', 32000, '2021-11-03 10:00:00', 'online'),
('ord-022', 'cust-005', 'cnc-002',  6500, '2021-11-17 12:00:00', 'walk-in'),
('ord-023', 'cust-006', 'cnc-003', 19000, '2021-12-08 09:30:00', 'online'),
('ord-024', 'cust-007', 'cnc-004',  8800, '2021-12-20 14:00:00', 'walk-in'),
('ord-025', 'cust-002', 'cnc-005', 27000, '2021-12-29 11:00:00', 'online');

INSERT INTO expenses VALUES
('exp-001', 'cnc-001', 'Staff Salaries',     40000, '2021-01-31 00:00:00'),
('exp-002', 'cnc-001', 'Medical Supplies',    5000, '2021-01-31 00:00:00'),
('exp-003', 'cnc-002', 'Staff Salaries',     35000, '2021-02-28 00:00:00'),
('exp-004', 'cnc-002', 'Utilities',           2000, '2021-02-28 00:00:00'),
('exp-005', 'cnc-003', 'Staff Salaries',     38000, '2021-03-31 00:00:00'),
('exp-006', 'cnc-003', 'Equipment Rental',    4000, '2021-03-31 00:00:00'),
('exp-007', 'cnc-004', 'Staff Salaries',     42000, '2021-04-30 00:00:00'),
('exp-008', 'cnc-004', 'Medical Supplies',    6000, '2021-04-30 00:00:00'),
('exp-009', 'cnc-005', 'Staff Salaries',     45000, '2021-05-31 00:00:00'),
('exp-010', 'cnc-005', 'Utilities',           3500, '2021-05-31 00:00:00'),
('exp-011', 'cnc-001', 'Staff Salaries',     40000, '2021-06-30 00:00:00'),
('exp-012', 'cnc-002', 'Medical Supplies',    4500, '2021-06-30 00:00:00'),
('exp-013', 'cnc-003', 'Staff Salaries',     38000, '2021-07-31 00:00:00'),
('exp-014', 'cnc-004', 'Utilities',           2800, '2021-07-31 00:00:00'),
('exp-015', 'cnc-005', 'Staff Salaries',     45000, '2021-08-31 00:00:00'),
('exp-016', 'cnc-001', 'Medical Supplies',    5500, '2021-08-31 00:00:00'),
('exp-017', 'cnc-002', 'Staff Salaries',     35000, '2021-09-30 00:00:00'),
('exp-018', 'cnc-003', 'Utilities',           3000, '2021-09-30 00:00:00'),
('exp-019', 'cnc-004', 'Staff Salaries',     42000, '2021-10-31 00:00:00'),
('exp-020', 'cnc-005', 'Medical Supplies',    7000, '2021-10-31 00:00:00'),
('exp-021', 'cnc-001', 'Staff Salaries',     40000, '2021-11-30 00:00:00'),
('exp-022', 'cnc-002', 'Utilities',           2200, '2021-11-30 00:00:00'),
('exp-023', 'cnc-003', 'Staff Salaries',     38000, '2021-12-31 00:00:00'),
('exp-024', 'cnc-004', 'Medical Supplies',    5800, '2021-12-31 00:00:00'),
('exp-025', 'cnc-005', 'Staff Salaries',     45000, '2021-12-31 00:00:00');
