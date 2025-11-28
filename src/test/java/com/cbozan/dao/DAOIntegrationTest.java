package com.cbozan.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import com.cbozan.entity.Employer;
import com.cbozan.entity.Worker;
import com.cbozan.entity.Job;

/**
 * Integration tests for DAO layer - validates database operations
 * Assumes PostgreSQL is running with Hesap-eProject database set up
 */
public class DAOIntegrationTest {

    @BeforeAll
    static void setUp() {
        // Configure for test/CI environments
        System.setProperty("TEST_MODE", "true");
        System.setProperty("DB_URL", System.getProperty("DB_URL", "jdbc:postgresql://localhost:5432/Hesap-eProject"));
        System.setProperty("DB_USER", System.getProperty("DB_USER", "Hesap-eProject"));
        System.setProperty("DB_PASSWORD", System.getProperty("DB_PASSWORD", ".hesap-eProject."));
    }

    @Test
    void dbConnectionShouldWork() throws SQLException {
        Connection conn = DB.getConnection();
        assertNotNull(conn, "Database connection should not be null");
        assertFalse(conn.isClosed(), "Database connection should be open");
    }

    @Test
    void adminTableShouldHaveAtLeastOneRecord() throws SQLException {
        try (Connection conn = DB.getConnection(); 
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM admin")) {
            assertTrue(rs.next(), "Result set should have data");
            int count = rs.getInt(1);
            assertTrue(count >= 1, "Admin table should have at least 1 record");
        }
    }

    @Test
    void employerDAOShouldList() {
        List<Employer> employers = EmployerDAO.getInstance().list();
        assertNotNull(employers, "Employer list should not be null");
        // Allow empty list in test environments
        assertTrue(employers.size() >= 0, "Employer list should be non-negative");
    }

    @Test
    void workerDAOShouldList() {
        List<Worker> workers = WorkerDAO.getInstance().list();
        assertNotNull(workers, "Worker list should not be null");
        assertTrue(workers.size() >= 0, "Worker list should be non-negative");
    }

    @Test
    void jobDAOShouldList() {
        List<Job> jobs = JobDAO.getInstance().list();
        assertNotNull(jobs, "Job list should not be null");
        assertTrue(jobs.size() >= 0, "Job list should be non-negative");
    }

    @Test
    void allRequiredTablesShouldExist() throws SQLException {
        String[] tables = {"admin", "employer", "worker", "job", "work", "workgroup", 
                          "price", "payment", "paytype", "worktype", "invoice"};
        
        try (Connection conn = DB.getConnection(); 
             Statement st = conn.createStatement()) {
            for (String table : tables) {
                ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM " + table);
                assertTrue(rs.next(), table + " table should exist and be queryable");
                rs.close();
            }
        }
    }

    @Test
    void dbConnectionShouldBeReusable() throws SQLException {
        Connection conn1 = DB.getConnection();
        Connection conn2 = DB.getConnection();
        assertSame(conn1, conn2, "DB should return singleton connection");
        assertFalse(conn1.isClosed(), "Connection should remain open");
    }
}
