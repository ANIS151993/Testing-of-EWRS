-- ============================================================
-- Sample Data for Employer-Worker Registration System
-- This file populates the database with realistic test data
-- ============================================================

-- ============================================================
-- Insert admin user (username: admin, password: admin)
-- ============================================================
INSERT INTO admin (username, password) VALUES 
    ('admin', 'admin');

-- ============================================================
-- Insert sample work types
-- ============================================================
INSERT INTO worktype (title, no) VALUES
    ('FULL TIME', 1),
    ('HALF TIME', 2),
    ('OVERTIME', 3),
    ('NIGHT SHIFT', 4),
    ('WEEKEND', 5);

-- ============================================================
-- Insert sample payment types
-- ============================================================
INSERT INTO paytype (title) VALUES
    ('CASH'),
    ('BANK TRANSFER'),
    ('CHECK'),
    ('CREDIT CARD'),
    ('MOBILE PAYMENT');

-- ============================================================
-- Insert sample pricing structures
-- ============================================================
INSERT INTO price (fulltime, halftime, overtime) VALUES
    (100.00, 50.00, 150.00),   -- Standard rate
    (120.00, 60.00, 180.00),   -- Premium rate
    (80.00, 40.00, 120.00),    -- Economy rate
    (150.00, 75.00, 225.00);   -- Specialist rate

-- ============================================================
-- Insert sample employers
-- ============================================================
INSERT INTO employer (fname, lname, tel, description) VALUES
    ('JOHN', 'SMITH', ARRAY['555-0101', '555-0102'], 'Construction company owner'),
    ('SARAH', 'JOHNSON', ARRAY['555-0201'], 'Restaurant manager'),
    ('MICHAEL', 'WILLIAMS', ARRAY['555-0301', '555-0302', '555-0303'], 'IT services provider'),
    ('EMILY', 'BROWN', ARRAY['555-0401'], 'Event planning business'),
    ('DAVID', 'JONES', NULL, 'Landscaping services');

-- ============================================================
-- Insert sample workers
-- ============================================================
INSERT INTO worker (fname, lname, tel, iban, description) VALUES
    ('JAMES', 'ANDERSON', ARRAY['555-1001'], 'TR330006100519786457841326', 'Experienced carpenter'),
    ('MARIA', 'GARCIA', ARRAY['555-1002', '555-1003'], 'TR640006200011102638501947', 'Chef with 10 years experience'),
    ('ROBERT', 'MARTINEZ', ARRAY['555-1004'], 'TR950006400024378529076413', 'Software developer'),
    ('LISA', 'RODRIGUEZ', ARRAY['555-1005'], 'TR120006700056781234098765', 'Event coordinator'),
    ('WILLIAM', 'DAVIS', NULL, 'TR330001500158007726207893', 'General laborer'),
    ('JENNIFER', 'WILSON', ARRAY['555-1006'], 'TR640009800765432198765432', 'Graphic designer'),
    ('THOMAS', 'MOORE', ARRAY['555-1007', '555-1008'], 'TR950001200987654321234567', 'Electrician'),
    ('NANCY', 'TAYLOR', ARRAY['555-1009'], 'TR120004500456789123456789', 'Marketing specialist');

-- ============================================================
-- Insert sample jobs
-- ============================================================
INSERT INTO job (employer_id, price_id, title, description) VALUES
    (1, 1, 'OFFICE BUILDING RENOVATION', 'Complete renovation of 5-story office building'),
    (1, 2, 'RESIDENTIAL CONSTRUCTION', 'New house construction project'),
    (2, 1, 'RESTAURANT KITCHEN STAFF', 'Kitchen staff for new restaurant location'),
    (3, 4, 'WEBSITE DEVELOPMENT', 'E-commerce website development'),
    (3, 3, 'NETWORK INSTALLATION', 'Office network infrastructure setup'),
    (4, 2, 'WEDDING EVENT', 'Wedding planning and coordination'),
    (4, 2, 'CORPORATE EVENT', 'Annual company celebration event'),
    (5, 1, 'GARDEN MAINTENANCE', 'Commercial property landscaping');

-- ============================================================
-- Insert sample workgroups
-- ============================================================
INSERT INTO workgroup (job_id, worktype_id, workcount, description) VALUES
    (1, 1, 120, 'Full-time renovation work'),
    (1, 3, 30, 'Overtime for deadline'),
    (2, 1, 200, 'Construction phase 1'),
    (3, 1, 160, 'Kitchen operations'),
    (3, 2, 40, 'Part-time staff'),
    (4, 1, 80, 'Development sprint'),
    (5, 1, 60, 'Network setup'),
    (6, 1, 50, 'Event preparation'),
    (7, 1, 40, 'Corporate event setup'),
    (8, 1, 100, 'Regular maintenance');

-- ============================================================
-- Insert sample work records
-- ============================================================
INSERT INTO work (job_id, worker_id, worktype_id, workgroup_id, description) VALUES
    (1, 1, 1, 1, 'Carpentry work on floors 1-3'),
    (1, 5, 1, 1, 'General labor support'),
    (1, 7, 1, 1, 'Electrical wiring'),
    (2, 1, 1, 3, 'Foundation carpentry'),
    (2, 5, 1, 3, 'Site preparation'),
    (3, 2, 1, 4, 'Head chef duties'),
    (4, 3, 1, 6, 'Backend development'),
    (4, 6, 1, 6, 'UI/UX design'),
    (5, 3, 1, 7, 'Network configuration'),
    (6, 4, 1, 8, 'Event coordination'),
    (6, 8, 1, 8, 'Marketing materials'),
    (7, 4, 1, 9, 'Corporate event planning'),
    (8, 5, 1, 10, 'Landscaping work');

-- ============================================================
-- Insert sample payments
-- ============================================================
INSERT INTO payment (worker_id, job_id, paytype_id, amount) VALUES
    (1, 1, 2, 5000.00),
    (1, 2, 2, 3500.00),
    (2, 3, 2, 4800.00),
    (3, 4, 2, 6000.00),
    (3, 5, 2, 4200.00),
    (4, 6, 1, 2500.00),
    (4, 7, 1, 2000.00),
    (5, 1, 1, 2000.00),
    (5, 2, 1, 2500.00),
    (5, 8, 1, 3000.00),
    (6, 4, 2, 4500.00),
    (7, 1, 2, 3800.00),
    (8, 6, 2, 2200.00);

-- ============================================================
-- Insert sample invoices
-- ============================================================
INSERT INTO invoice (job_id, amount) VALUES
    (1, 45000.00),
    (2, 65000.00),
    (3, 38000.00),
    (4, 55000.00),
    (5, 42000.00),
    (6, 28000.00),
    (7, 32000.00),
    (8, 35000.00);

-- ============================================================
-- Success message and verification
-- ============================================================
SELECT 'Sample data inserted successfully!' AS status;

-- Verify data counts
SELECT 'admin' AS table_name, COUNT(*) AS record_count FROM admin
UNION ALL
SELECT 'employer', COUNT(*) FROM employer
UNION ALL
SELECT 'worker', COUNT(*) FROM worker
UNION ALL
SELECT 'price', COUNT(*) FROM price
UNION ALL
SELECT 'worktype', COUNT(*) FROM worktype
UNION ALL
SELECT 'paytype', COUNT(*) FROM paytype
UNION ALL
SELECT 'job', COUNT(*) FROM job
UNION ALL
SELECT 'workgroup', COUNT(*) FROM workgroup
UNION ALL
SELECT 'work', COUNT(*) FROM work
UNION ALL
SELECT 'payment', COUNT(*) FROM payment
UNION ALL
SELECT 'invoice', COUNT(*) FROM invoice
ORDER BY table_name;
