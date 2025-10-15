-- Create Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255)
);

-- Insert values to the user table
INSERT INTO users (name, email, password) VALUES
('Alice Smith', 'alice.smith@example.com', 'password123'),
('Bob Johnson', 'bob.johnson@example.com', 'securepass'),
('Carol Williams', 'carol.williams@example.com', 'hash12345'),
('David Brown', 'david.brown@example.com', 'mypassword'),
('Eve Davis', 'eve.davis@example.com', '123secure'),
('Frank Miller', 'frank.miller@example.com', 'pass@word1'),
('Grace Wilson', 'grace.wilson@example.com', 'hello1234'),
('Hank Moore', 'hank.moore@example.com', 'keypass78'),
('Ivy Taylor', 'ivy.taylor@example.com', 'secureme'),
('Jack Anderson', 'jack.anderson@example.com', 'passkey89');


-- Create Appointments Table
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    appointment_date DATE,
    appointment_time TIME,
    reason TEXT,
    name VARCHAR(255),
    email VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert values to the appointments table
INSERT INTO appointments (user_id, appointment_date, appointment_time, reason, name, email) VALUES
(1, '2024-12-01', '10:00:00', 'General checkup', 'Alice Smith', 'alice.smith@example.com'),
(2, '2024-12-02', '11:00:00', 'Follow-up for medication', 'Bob Johnson', 'bob.johnson@example.com'),
(3, '2024-12-03', '12:30:00', 'Dental cleaning', 'Carol Williams', 'carol.williams@example.com'),
(4, '2024-12-04', '14:00:00', 'Routine blood test', 'David Brown', 'david.brown@example.com'),
(5, '2024-12-05', '15:30:00', 'Skin allergy consultation', 'Eve Davis', 'eve.davis@example.com'),
(6, '2024-12-06', '09:00:00', 'Orthopedic consultation', 'Frank Miller', 'frank.miller@example.com'),
(7, '2024-12-07', '10:45:00', 'Pediatric vaccination', 'Grace Wilson', 'grace.wilson@example.com'),
(8, '2024-12-08', '11:15:00', 'Eye checkup', 'Hank Moore', 'hank.moore@example.com'),
(9, '2024-12-09', '13:00:00', 'Nutrition counseling', 'Ivy Taylor', 'ivy.taylor@example.com'),
(10, '2024-12-10', '14:45:00', 'ENT consultation', 'Jack Anderson', 'jack.anderson@example.com');

-- Create doctor table with JSON data
CREATE TABLE doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    details JSON
);

-- Insert doctor details in JSON format
INSERT INTO doctors (details) VALUES
('{
    "name": "Dr. John Doe",
    "specialization": "Cardiologist",
    "gender": "Male",
    "contact": "123-456-7890",
    "experience": 15,
    "fee": 150.00
}'),
('{
    "name": "Dr. Jane Smith",
    "specialization": "Neurologist",
    "gender": "Female",
    "contact": "987-654-3210",
    "experience": 12,
    "fee": 200.00
}'),
('{
    "name": "Dr. Robert Brown",
    "specialization": "Orthopedist",
    "gender": "Male",
    "contact": "555-123-4567",
    "experience": 20,
    "fee": 180.00
}'),
('{
    "name": "Dr. Emily Clark",
    "specialization": "Dermatologist",
    "gender": "Female",
    "contact": "333-444-5555",
    "experience": 8,
    "fee": 120.00
}'),
('{
    "name": "Dr. Michael Johnson",
    "specialization": "Pediatrician",
    "gender": "Male",
    "contact": "444-555-6666",
    "experience": 10,
    "fee": 130.00
}'),
('{
    "name": "Dr. Sarah Williams",
    "specialization": "Gynecologist",
    "gender": "Female",
    "contact": "555-666-7777",
    "experience": 18,
    "fee": 220.00
}'),
('{
    "name": "Dr. William Davis",
    "specialization": "Psychiatrist",
    "gender": "Male",
    "contact": "666-777-8888",
    "experience": 25,
    "fee": 250.00
}'),
('{
    "name": "Dr. Olivia Moore",
    "specialization": "Surgeon",
    "gender": "Female",
    "contact": "777-888-9999",
    "experience": 30,
    "fee": 300.00
}'),
('{
    "name": "Dr. James Taylor",
    "specialization": "Endocrinologist",
    "gender": "Male",
    "contact": "888-999-0000",
    "experience": 5,
    "fee": 140.00
}'),
('{
    "name": "Dr. Ava Harris",
    "specialization": "Gastroenterologist",
    "gender": "Female",
    "contact": "999-000-1111",
    "experience": 22,
    "fee": 210.00
}');

-- Create Treatments Table
CREATE TABLE treatments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    treatment_name VARCHAR(255),
    medication VARCHAR(255),
    cost DECIMAL(10, 2),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- -- Insert values to the treatments table
INSERT INTO treatments (user_id, treatment_name, medication, cost, date) VALUES
(1, 'Physical Therapy', 'Pain Relievers', 200.00, '2024-11-25'),
(1, 'Surgery', 'Anesthesia', 5000.00, '2024-11-27'),
(2, 'Cardiology Checkup', 'Blood Pressure Meds', 300.00, '2024-11-20'),
(2, 'Heart Surgery', 'Anticoagulants', 7000.00, '2024-11-21'),
(3, 'Orthopedic Treatment', 'Calcium Supplements', 150.00, '2024-11-15'),
(3, 'Bone Fracture Surgery', 'Sedatives', 3500.00, '2024-11-17'),
(4, 'Dermatology', 'Antibiotics', 100.00, '2024-11-05'),
(4, 'Skin Treatment', 'Steroids', 200.00, '2024-11-07'),
(5, 'Diabetes Management', 'Insulin', 500.00, '2024-11-02'),
(5, 'Follow-up Checkup', 'Vitamins', 100.00, '2024-11-04');

-- SUBQUERIES
--Find users with the most expensive treatment
SELECT user_id, treatment_name, cost FROM treatments WHERE cost = (SELECT MAX(cost) FROM treatments);

-- Find users who do not have any treatments
SELECT name, email FROM appointments WHERE user_id NOT IN (SELECT DISTINCT user_id FROM treatments);

-- Find the total cost of treatments for each user.
SELECT u.name, (SELECT SUM(t.cost) FROM treatments t WHERE t.user_id = u.id) AS total_cost FROM users u;

-- Fetch the latest treatment details for each user.
SELECT t.* FROM treatments t WHERE t.date = (SELECT MAX(t2.date) FROM treatments t2 WHERE t2.user_id = t.user_id);



-- JOINS
-- Fetch user details along with their appointment details.
SELECT u.name, u.email, a.appointment_date, a.appointment_time, a.reason FROM users u JOIN appointments a ON u.id = a.user_id;

-- List all users and their total treatment costs.
SELECT u.name, u.email, COALESCE(SUM(t.cost), 0) AS total_cost FROM users u LEFT JOIN treatments t ON u.id = t.user_id GROUP BY u.id;

-- Fetch treatment details along with the corresponding user names.
SELECT t.treatment_name, t.medication, t.cost, u.name FROM treatments t JOIN users u ON t.user_id = u.id;

-- Fetch appointment details along with the latest treatment date for each user.
SELECT a.name, a.email, a.appointment_date, a.appointment_time, MAX(t.date) AS latest_treatment_date FROM appointments a 
LEFT JOIN treatments t ON a.user_id = t.user_id GROUP BY a.id;

-- Find users with no appointments but with treatments.
SELECT u.name, u.email FROM users u LEFT JOIN appointments a ON u.id = a.user_id WHERE a.id IS NULL AND u.id IN (SELECT user_id FROM treatments);



-- WITH CLAUSE
-- Calculate the average treatment cost for all users.
WITH avg_cost AS (
    SELECT AVG(cost) AS average_cost
    FROM treatments
)
SELECT * FROM avg_cost;

--List users with their earliest appointment date.
WITH earliest_appointments AS (
    SELECT user_id, MIN(appointment_date) AS first_appointment
    FROM appointments
    GROUP BY user_id
)
SELECT u.name, ea.first_appointment
FROM users u
JOIN earliest_appointments ea ON u.id = ea.user_id;

-- Fetch treatments exceeding the average cost.
WITH avg_cost AS (
    SELECT AVG(cost) AS average_cost
    FROM treatments
)
SELECT t.*
FROM treatments t
JOIN avg_cost ac ON t.cost > ac.average_cost;

-- Calculate the total appointment count and treatment cost per user.
WITH user_data AS (
    SELECT u.id, u.name, COUNT(a.id) AS appointment_count, SUM(t.cost) AS total_cost
    FROM users u
    LEFT JOIN appointments a ON u.id = a.user_id
    LEFT JOIN treatments t ON u.id = t.user_id
    GROUP BY u.id
)
SELECT * FROM user_data;



-- WITH RECURSIVE
-- Generate a sequence of dates for the next 7 days.
WITH RECURSIVE date_sequence AS (
    SELECT CURDATE() AS date
    UNION ALL
    SELECT DATE_ADD(date, INTERVAL 1 DAY)
    FROM date_sequence
    WHERE date < CURDATE() + INTERVAL 6 DAY
)
SELECT * FROM date_sequence;

-- Calculate cumulative treatment costs per user.
WITH RECURSIVE cumulative_costs AS (
    SELECT user_id, cost, cost AS cumulative_cost
    FROM treatments
    WHERE id = 1
    UNION ALL
    SELECT t.user_id, t.cost, cc.cumulative_cost + t.cost
    FROM treatments t
    JOIN cumulative_costs cc ON t.user_id = cc.user_id AND t.id = cc.user_id + 1
)
SELECT * FROM cumulative_costs;

-- Compute appointment levels recursively.
WITH RECURSIVE appointment_levels AS (
    SELECT id, user_id, 1 AS level
    FROM appointments
    WHERE id = 1
    UNION ALL
    SELECT a.id, a.user_id, al.level + 1
    FROM appointments a
    JOIN appointment_levels al ON a.user_id = al.user_id AND a.id > al.id
)
SELECT * FROM appointment_levels;

--plsql 
DELIMITER //

CREATE PROCEDURE GetTreatmentDetails()
BEGIN
    SELECT treatment_name, cost 
    FROM treatments;
END //

DELIMITER ;


-- create triggers 
DELIMITER $$

CREATE TRIGGER update_treatment_cost
BEFORE UPDATE ON treatments
FOR EACH ROW
BEGIN
    -- Check if the treatment name is being changed
    IF NEW.treatment_name != OLD.treatment_name THEN
        -- Update the cost based on the new treatment name
        CASE 
            WHEN NEW.treatment_name = 'Physical Therapy' THEN
                SET NEW.cost = 200.00;
            WHEN NEW.treatment_name = 'Surgery' THEN
                SET NEW.cost = 5000.00;
            WHEN NEW.treatment_name = 'Radiology' THEN
                SET NEW.cost = 1000.00;
            WHEN NEW.treatment_name = 'Chemotherapy' THEN
                SET NEW.cost = 8000.00;
            ELSE
                SET NEW.cost = 500.00; -- Default cost
        END CASE;
    END IF;
END$$

DELIMITER ;

--update 
UPDATE treatments
SET treatment_name = 'Chemotheraphy'
WHERE id = 1;




