package com.cbozan.dao;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.swing.JOptionPane;


public class DB {

	public static String ERROR_MESSAGE = "";
	private static boolean errorShown = false; // Track if we already showed error dialog
	
	private DB() {}
	private Connection conn = null;
	private static final Connection NOOP_CONNECTION = createNoopConnection();
	
	private static class DBHelper{
		private static final DB CONNECTION = new DB();
	}
	
	public static Connection getConnection() {
		return DBHelper.CONNECTION.connect();
	}
	
	public static void destroyConnection() {
		DBHelper.CONNECTION.disconnect();
	}

	private Connection connect() {
		
		try {
			// Load PostgreSQL JDBC driver
			Class.forName("org.postgresql.Driver");
			
			if(conn == null || conn.isClosed()) {
				try {
					String url = System.getProperty("DB_URL", "jdbc:postgresql://localhost:5432/Hesap-eProject");
					String user = System.getProperty("DB_USER", "Hesap-eProject");
					String pass = System.getProperty("DB_PASSWORD", ".hesap-eProject.");
					conn = DriverManager.getConnection(url, user, pass);
					// Connection successful - reset error flag
					errorShown = false;
					ERROR_MESSAGE = "";
				} catch (SQLException e) {
					System.err.println("Database connection error: " + e.getMessage());
					ERROR_MESSAGE = "Cannot connect to database. Please ensure PostgreSQL is running and database 'Hesap-eProject' exists.";
					
					// Show error dialog only once
					if (!errorShown) {
						errorShown = true;
						showDatabaseError();
					}
					
					// Provide a non-null fallback Connection so DAOs can gracefully handle via SQLException
					conn = NOOP_CONNECTION;
				}
			}
		} catch (ClassNotFoundException e) {
			System.err.println("PostgreSQL JDBC Driver not found: " + e.getMessage());
			ERROR_MESSAGE = "PostgreSQL JDBC Driver not found in classpath.";
			
			if (!errorShown) {
				errorShown = true;
				showDatabaseError();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	private void disconnect() {
		if(conn != null && conn != NOOP_CONNECTION) {
			try {
				conn.close();
			} catch (SQLException e) {
				System.err.println(e.getMessage());
			}
		}
	}

	private static Connection createNoopConnection() {
		InvocationHandler handler = new InvocationHandler() {
			@Override
			public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
				// Any method call on this connection will behave like a failing DB by throwing SQLException
				throw new SQLException("No database connection available. " + (ERROR_MESSAGE == null ? "" : ERROR_MESSAGE));
			}
		};
		return (Connection) Proxy.newProxyInstance(
				Connection.class.getClassLoader(),
				new Class[] { Connection.class },
				handler
		);
	}
	
	private static void showDatabaseError() {
		// Skip GUI dialog in headless or test environments
		if (Boolean.getBoolean("TEST_MODE") || "true".equalsIgnoreCase(System.getenv("CI")) || java.awt.GraphicsEnvironment.isHeadless()) {
			System.err.println("Database Setup Required: running in headless/CI/test mode, suppressing dialog.");
			return;
		}
		String message = "⚠️ DATABASE NOT CONNECTED ⚠️\n\n" +
				"PostgreSQL database is not available.\n\n" +
				"To set up the database:\n" +
				"1. Open a terminal in the project folder\n" +
				"2. Run: cd database && setup-database.bat\n" +
				"3. Follow the prompts\n\n" +
				"Database: Hesap-eProject\n" +
				"Username: Hesap-eProject\n" +
				"Password: .hesap-eProject.\n\n" +
				"See DATABASE-SETUP-NEW.md for details.\n\n" +
				"The application will run with limited functionality.";
		
		JOptionPane.showMessageDialog(null, message, "Database Setup Required", JOptionPane.WARNING_MESSAGE);
	}
	
}