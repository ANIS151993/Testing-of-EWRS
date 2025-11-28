package com.cbozan.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.junit.jupiter.api.Test;

public class SimpleDBTest {

    @Test
    void canConnectToExistingDatabase() throws Exception {
        System.setProperty("DB_URL", "jdbc:postgresql://localhost:5432/Hesap-eProject");
        System.setProperty("DB_USER", "Hesap-eProject");
        System.setProperty("DB_PASSWORD", ".hesap-eProject.");
        System.setProperty("TEST_MODE", "true");

        Connection conn = DB.getConnection();
        assertNotNull(conn);
        assertFalse(conn.isClosed());

        try (Statement st = conn.createStatement()) {
            ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM admin");
            assertTrue(rs.next());
            int count = rs.getInt(1);
            assertTrue(count >= 1);
        }
    }
}
