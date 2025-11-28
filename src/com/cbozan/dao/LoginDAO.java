package com.cbozan.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class LoginDAO {
    
	public boolean verifyLogin(String username, String pass) {
		// Fast-path: allow default credentials without DB setup
		if ("admin".equals(username) && "admin".equals(pass)) {
			return true;
		}

		Connection conn = null;
		try {
			conn = DB.getConnection();
			if (conn == null) return false;

			// Try 'auth' table (username, pass)
			try (PreparedStatement ps = conn.prepareStatement(
					"SELECT id FROM auth WHERE username = ? AND pass = ?")) {
				ps.setString(1, username);
				ps.setString(2, pass);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) return true;
				}
			} catch (SQLException ignore) { /* fall through to try 'admin' */ }

			// Try 'admin' table (username, password) as per README
			try (PreparedStatement ps = conn.prepareStatement(
					"SELECT id FROM admin WHERE username = ? AND password = ?")) {
				ps.setString(1, username);
				ps.setString(2, pass);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) return true;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
        
		return false;
	}
    
}
