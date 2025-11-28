-- ============================================================
-- PostgreSQL Database Schema for Employer-Worker Registration System
-- Database: Hesap-eProject
-- User: Hesap-eProject
-- Password: .hesap-eProject.
-- ============================================================

-- Drop existing tables if they exist (careful in production!)
DROP TABLE IF EXISTS work CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS invoice CASCADE;
DROP TABLE IF EXISTS workgroup CASCADE;
DROP TABLE IF EXISTS job CASCADE;
DROP TABLE IF EXISTS employer CASCADE;
DROP TABLE IF EXISTS worker CASCADE;
DROP TABLE IF EXISTS price CASCADE;
DROP TABLE IF EXISTS worktype CASCADE;
DROP TABLE IF EXISTS paytype CASCADE;
DROP TABLE IF EXISTS admin CASCADE;

-- ============================================================
-- Table: admin (for login authentication)
-- ============================================================
CREATE TABLE admin (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: employer (Employers who hire workers)
-- ============================================================
CREATE TABLE employer (
    id SERIAL PRIMARY KEY,
    fname VARCHAR(100) NOT NULL,
    lname VARCHAR(100) NOT NULL,
    tel VARCHAR[] DEFAULT NULL,  -- Array of phone numbers
    description TEXT DEFAULT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: worker (Workers who perform jobs)
-- ============================================================
CREATE TABLE worker (
    id SERIAL PRIMARY KEY,
    fname VARCHAR(100) NOT NULL,
    lname VARCHAR(100) NOT NULL,
    tel VARCHAR[] DEFAULT NULL,  -- Array of phone numbers
    iban VARCHAR(34) DEFAULT NULL,  -- International Bank Account Number
    description TEXT DEFAULT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: price (Pricing structure for different work types)
-- ============================================================
CREATE TABLE price (
    id SERIAL PRIMARY KEY,
    fulltime DECIMAL(10,2) NOT NULL,  -- Full-time rate
    halftime DECIMAL(10,2) NOT NULL,  -- Half-time rate
    overtime DECIMAL(10,2) NOT NULL,  -- Overtime rate
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: worktype (Types of work that can be performed)
-- ============================================================
CREATE TABLE worktype (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    no INTEGER NOT NULL,  -- Work type number/code
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: paytype (Payment methods)
-- ============================================================
CREATE TABLE paytype (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: job (Jobs posted by employers)
-- ============================================================
CREATE TABLE job (
    id SERIAL PRIMARY KEY,
    employer_id INTEGER NOT NULL REFERENCES employer(id) ON DELETE CASCADE,
    price_id INTEGER NOT NULL REFERENCES price(id) ON DELETE RESTRICT,
    title VARCHAR(200) NOT NULL,
    description TEXT DEFAULT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: workgroup (Work groups for jobs)
-- ============================================================
CREATE TABLE workgroup (
    id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES job(id) ON DELETE CASCADE,
    worktype_id INTEGER NOT NULL REFERENCES worktype(id) ON DELETE RESTRICT,
    workcount INTEGER NOT NULL DEFAULT 0,  -- Number of work units
    description TEXT DEFAULT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: work (Individual work records by workers)
-- ============================================================
CREATE TABLE work (
    id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES job(id) ON DELETE CASCADE,
    worker_id INTEGER NOT NULL REFERENCES worker(id) ON DELETE CASCADE,
    worktype_id INTEGER NOT NULL REFERENCES worktype(id) ON DELETE RESTRICT,
    workgroup_id INTEGER NOT NULL REFERENCES workgroup(id) ON DELETE CASCADE,
    description TEXT DEFAULT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: payment (Payments to workers)
-- ============================================================
CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    worker_id INTEGER NOT NULL REFERENCES worker(id) ON DELETE CASCADE,
    job_id INTEGER NOT NULL REFERENCES job(id) ON DELETE CASCADE,
    paytype_id INTEGER NOT NULL REFERENCES paytype(id) ON DELETE RESTRICT,
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Table: invoice (Invoices for jobs)
-- ============================================================
CREATE TABLE invoice (
    id SERIAL PRIMARY KEY,
    job_id INTEGER NOT NULL REFERENCES job(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Create indexes for better query performance
-- ============================================================
CREATE INDEX idx_job_employer ON job(employer_id);
CREATE INDEX idx_job_price ON job(price_id);
CREATE INDEX idx_workgroup_job ON workgroup(job_id);
CREATE INDEX idx_work_job ON work(job_id);
CREATE INDEX idx_work_worker ON work(worker_id);
CREATE INDEX idx_work_workgroup ON work(workgroup_id);
CREATE INDEX idx_payment_worker ON payment(worker_id);
CREATE INDEX idx_payment_job ON payment(job_id);
CREATE INDEX idx_invoice_job ON invoice(job_id);

-- ============================================================
-- Success message
-- ============================================================
SELECT 'Database schema created successfully!' AS status;
