package com.cbozan.test.containers;

import org.junit.jupiter.api.extension.AfterAllCallback;
import org.junit.jupiter.api.extension.BeforeAllCallback;
import org.junit.jupiter.api.extension.ExtensionContext;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

public class PostgresTestContainerExtension implements BeforeAllCallback, AfterAllCallback {
    private static PostgreSQLContainer<?> container;
    private static boolean started = false;

    @Override
    public void beforeAll(ExtensionContext context) throws Exception {
        // Respect externally provided DB settings (e.g., real DB in CI)
        if (System.getProperty("DB_URL") != null) {
            return;
        }

        if (!started) {
            container = new PostgreSQLContainer<>(DockerImageName.parse("postgres:16-alpine"))
                    .withDatabaseName("testdb")
                    .withUsername("test")
                    .withPassword("test");
            container.start();
            started = true;

            System.setProperty("DB_URL", container.getJdbcUrl());
            System.setProperty("DB_USER", container.getUsername());
            System.setProperty("DB_PASSWORD", container.getPassword());
            System.setProperty("TEST_MODE", "true");
            System.setProperty("java.awt.headless", "true");
        }
    }

    @Override
    public void afterAll(ExtensionContext context) throws Exception {
        if (started && container != null) {
            container.stop();
            started = false;
        }
    }
}
