package com.cbozan.entity;

import static org.junit.jupiter.api.Assertions.*;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;

import com.cbozan.exception.EntityException;

/**
 * Unit tests for Entity classes - validates core business logic  
 * These tests safeguard against refactoring regressions
 */
public class EntityTest {

    @Test
    void employerShouldBeCreatedWithRequiredFields() throws EntityException {
        List<String> phones = new ArrayList<>();
        phones.add("555-1234");
        
        Employer employer = new Employer.EmployerBuilder()
            .setId(1)
            .setFname("John")
            .setLname("Doe")
            .setTel(phones)
            .setDescription("Test Company")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        assertNotNull(employer);
        assertEquals(1, employer.getId());
        assertEquals("John", employer.getFname());
        assertEquals("Doe", employer.getLname());
        assertEquals(phones, employer.getTel());
        assertEquals("Test Company", employer.getDescription());
    }

    @Test
    void employerShouldBeCloneable() throws EntityException, CloneNotSupportedException {
        List<String> phones = new ArrayList<>();
        phones.add("555-5678");
        
        Employer original = new Employer.EmployerBuilder()
            .setId(2)
            .setFname("Jane")
            .setLname("Smith")
            .setTel(phones)
            .setDescription("Original Company")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        Employer clone = (Employer) original.clone();
        
        assertNotNull(clone);
        assertNotSame(original, clone);
        assertEquals(original.getFname(), clone.getFname());
        assertEquals(original.getLname(), clone.getLname());
        assertEquals(original.getDescription(), clone.getDescription());
    }

    @Test
    void workerShouldBeCreatedWithRequiredFields() throws EntityException {
        List<String> phones = new ArrayList<>();
        phones.add("555-9999");
        
        Worker worker = new Worker.WorkerBuilder()
            .setId(1)
            .setFname("Alice")
            .setLname("Johnson")
            .setTel(phones)
            .setIban("TR123456")
            .setDescription("Worker description")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        assertNotNull(worker);
        assertEquals("Alice", worker.getFname());
        assertEquals("Johnson", worker.getLname());
        assertEquals(phones, worker.getTel());
        assertEquals("TR123456", worker.getIban());
    }

    @Test
    void workerShouldBeCloneable() throws EntityException, CloneNotSupportedException {
        List<String> phones = new ArrayList<>();
        phones.add("555-1111");
        
        Worker original = new Worker.WorkerBuilder()
            .setId(2)
            .setFname("Bob")
            .setLname("Williams")
            .setTel(phones)
            .setIban("TR654321")
            .setDescription("Original worker")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        Worker clone = (Worker) original.clone();
        
        assertNotNull(clone);
        assertNotSame(original, clone);
        assertEquals(original.getFname(), clone.getFname());
        assertEquals(original.getLname(), clone.getLname());
    }

    @Test
    void jobShouldBeCreatedWithRequiredFields() throws EntityException {
        List<String> phones = new ArrayList<>();
        phones.add("555-0000");
        
        Employer employer = new Employer.EmployerBuilder()
            .setId(1)
            .setFname("John")
            .setLname("Doe")
            .setTel(phones)
            .setDescription("ABC Corp")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Price price = new Price.PriceBuilder()
            .setId(1)
            .setFulltime(new java.math.BigDecimal("100.00"))
            .setHalftime(new java.math.BigDecimal("50.00"))
            .setOvertime(new java.math.BigDecimal("150.00"))
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Job job = new Job.JobBuilder()
            .setId(1)
            .setEmployer(employer)
            .setPrice(price)
            .setTitle("Construction Project")
            .setDescription("Building project")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        assertNotNull(job);
        assertEquals("Construction Project", job.getTitle());
        assertEquals(employer, job.getEmployer());
        assertNotNull(job.getDate());
    }

    @Test
    void jobShouldBeCloneable() throws EntityException, CloneNotSupportedException {
        List<String> phones = new ArrayList<>();
        phones.add("555-2222");
        
        Employer employer = new Employer.EmployerBuilder()
            .setId(2)
            .setFname("Jane")
            .setLname("Smith")
            .setTel(phones)
            .setDescription("XYZ Inc")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Price price = new Price.PriceBuilder()
            .setId(2)
            .setFulltime(new java.math.BigDecimal("200.00"))
            .setHalftime(new java.math.BigDecimal("100.00"))
            .setOvertime(new java.math.BigDecimal("300.00"))
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Job original = new Job.JobBuilder()
            .setId(2)
            .setEmployer(employer)
            .setPrice(price)
            .setTitle("Renovation")
            .setDescription("Renovation work")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();
        
        Job clone = (Job) original.clone();
        
        assertNotNull(clone);
        assertNotSame(original, clone);
        assertEquals(original.getTitle(), clone.getTitle());
    }

    @Test
    void entityEqualityShouldWorkCorrectly() throws EntityException {
        List<String> phones1 = new ArrayList<>();
        phones1.add("555-0000");
        List<String> phones2 = new ArrayList<>();
        phones2.add("555-9999");
        List<String> phones3 = new ArrayList<>();
        phones3.add("555-0000");
        
        Employer employer1 = new Employer.EmployerBuilder()
            .setId(1)
            .setFname("Test")
            .setLname("User")
            .setTel(phones1)
            .setDescription("Same Company")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Employer employer2 = new Employer.EmployerBuilder()
            .setId(1)
            .setFname("Other")
            .setLname("Person")
            .setTel(phones2)
            .setDescription("Different Title")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        Employer employer3 = new Employer.EmployerBuilder()
            .setId(2)
            .setFname("Test")
            .setLname("User")
            .setTel(phones3)
            .setDescription("Same Company")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        // Same ID should be equal
        assertEquals(employer1, employer2);
        
        // Different ID should not be equal
        assertNotEquals(employer1, employer3);
    }

    @Test
    void entityHashCodeShouldBeConsistent() throws EntityException {
        List<String> phones = new ArrayList<>();
        phones.add("555-7777");
        
        Worker worker = new Worker.WorkerBuilder()
            .setId(42)
            .setFname("Hash")
            .setLname("Test")
            .setTel(phones)
            .setIban("TR999999")
            .setDescription("Hash test worker")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        int hash1 = worker.hashCode();
        int hash2 = worker.hashCode();
        
        assertEquals(hash1, hash2, "HashCode should be consistent");
    }

    @Test
    void employerValidationShouldRejectInvalidId() {
        List<String> phones = new ArrayList<>();
        phones.add("555-0000");
        
        assertThrows(EntityException.class, () -> {
            new Employer.EmployerBuilder()
                .setId(0)  // Invalid: <= 0
                .setFname("Test")
                .setLname("User")
                .setTel(phones)
                .setDescription("Company")
                .setDate(new Timestamp(System.currentTimeMillis()))
                .build();
        });
    }

    @Test
    void workerValidationShouldRejectInvalidId() {
        List<String> phones = new ArrayList<>();
        phones.add("555-0000");
        
        assertThrows(EntityException.class, () -> {
            new Worker.WorkerBuilder()
                .setId(-1)  // Invalid: <= 0
                .setFname("Test")
                .setLname("User")
                .setTel(phones)
                .setIban("TR000000")
                .setDescription("Worker")
                .setDate(new Timestamp(System.currentTimeMillis()))
                .build();
        });
    }

    @Test
    void jobValidationShouldRejectInvalidId() throws EntityException {
        List<String> phones = new ArrayList<>();
        phones.add("555-0000");
        
        Employer employer = new Employer.EmployerBuilder()
            .setId(1)
            .setFname("Test")
            .setLname("User")
            .setTel(phones)
            .setDescription("Company")
            .setDate(new Timestamp(System.currentTimeMillis()))
            .build();

        assertThrows(EntityException.class, () -> {
            new Job.JobBuilder()
                .setId(0)  // Invalid: <= 0
                .setEmployer(employer)
                .setTitle("Project")
                .setDescription("Description")
                .setDate(new Timestamp(System.currentTimeMillis()))
                .build();
        });
    }
}
