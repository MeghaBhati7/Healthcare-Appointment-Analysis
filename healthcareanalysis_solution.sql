
CREATE schema clinic_data;
USE clinic_data;

DROP TABLE IF EXISTS appointments; -- Appointments depends on clinics, doctors, patients
DROP TABLE IF EXISTS funds;        -- Funds doesn't depend on others, can be dropped any time
DROP TABLE IF EXISTS clinics;      -- Clinics is a parent table
DROP TABLE IF EXISTS doctors;      -- Doctors is a parent table
DROP TABLE IF EXISTS patients;     -- Patients is a parent table
SHOW tables;

CREATE TABLE IF NOT EXISTS clinics
(
   clinic_id INT NOT NULL AUTO_INCREMENT,                                         
   clinic_name VARCHAR(25),
   CONSTRAINT clinic_pkey PRIMARY KEY(clinic_id)
);

-- Table: doctors (Parent Table)
-- Stores information about doctors.
-- Unique ID for each doctor, automatically generated.
-- Doctor's first name, cannot be empty.
-- Doctor's last name, cannot be empty.
-- Sets 'doctor_id' as the primary key.

CREATE TABLE IF NOT EXISTS doctors
(
    doctor_id INT NOT NULL AUTO_INCREMENT, 
    first_name VARCHAR(50) NOT NULL,       
    last_name VARCHAR(50) NOT NULL,        
    CONSTRAINT doctors_pkey PRIMARY KEY (doctor_id) 
    );

-- Table: patients (Parent Table)
-- Stores information about patients.
-- Unique ID for each patient, automatically generated.
              -- Patient's first name.
     -- Patient's last name, cannot be empty.
                -- Patient's phone number.
                      -- Patient's gender.


CREATE TABLE IF NOT EXISTS patients
(
    patient_id INT NOT NULL AUTO_INCREMENT, 
    patient_first_name VARCHAR(20),          
    patient_last_name VARCHAR(25) NOT NULL,  -- Patient's last name, cannot be empty.
    phone_number VARCHAR(20),                -- Patient's phone number.
    gender VARCHAR(20),                      -- Patient's gender.
    CONSTRAINT patients_pkey PRIMARY KEY (patient_id) -- Sets 'patient_id' as the primary key.
);

-- Table: funds (Independent Table)
-- Stores financial data (e.g., specific fund amounts).
-- This table doesn't link to others, so its creation order isn't critical, but it's good to keep it with other parent-like tables.
CREATE TABLE IF NOT EXISTS funds (
    fd_id INT NOT NULL,                     -- Unique ID for the fund entry.
    amount INT NOT NULL,                    -- The amount of funds, cannot be empty.
    CONSTRAINT funds_pkey PRIMARY KEY (fd_id) -- Sets 'fd_id' as the primary key.
);


-- Table: appointments (Child Table)
-- Stores details about patient appointments.
-- This table is a 'child' because it links to 'clinics', 'doctors', and 'patients'.
-- Therefore, it must be created AFTER those tables.
CREATE TABLE IF NOT EXISTS appointments
(
    appointment_id INT NOT NULL AUTO_INCREMENT, -- Unique ID for each appointment, automatically generated.
    appointment_date DATE NOT NULL,             -- The date of the appointment.
    appointment_time TIME NOT NULL,             -- The scheduled time of the appointment.
    arrival_time TIME NOT NULL,                 -- The actual arrival time of the patient.
    completed_time TIME NOT NULL,               -- The time the appointment was completed.
    clinic_id INT,                              -- Links to 'clinics.clinic_id' (Foreign Key)
    doctor_id INT,                              -- Links to 'doctors.doctor_id' (Foreign Key)
    patient_id INT,                             -- Links to 'patients.patient_id' (Foreign Key)
    CONSTRAINT appointments_pkey PRIMARY KEY (appointment_id), -- Sets 'appointment_id' as the primary key.

    -- FOREIGN KEY CONSTRAINTS: These are the "links" that connect this table to others.
    -- They ensure that 'clinic_id' here actually points to an existing clinic, and so on.
    CONSTRAINT appointments_clinic_id_fkey FOREIGN KEY (clinic_id)
        REFERENCES clinics (clinic_id)       -- This means 'clinic_id' in THIS table must match an 'clinic_id' in the 'clinics' table.
        ON UPDATE CASCADE                    -- If a clinic's ID changes in 'clinics', it automatically updates here too.
        ON DELETE CASCADE,                   -- If a clinic is deleted from 'clinics', all its appointments here are also deleted.

    CONSTRAINT appointments_doctor_id_fkey FOREIGN KEY (doctor_id)
        REFERENCES doctors (doctor_id)       -- Links to the 'doctors' table.
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT appointments_patient_id_fkey FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)     -- Links to the 'patients' table.
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- =================================================================================================
-- STEP 3: INSERT DATA (Filling your tables with information)
-- Just like creating tables, inserting data into parent tables must happen BEFORE child tables.
-- This ensures that when you insert an appointment, the clinic, doctor, and patient it refers to already exist.
-- =================================================================================================

-- ---------------------------------------- ClinicsData------------------------------------------

INSERT INTO clinics (clinic_id, clinic_name) VALUES
(1, 'Dental Care'),
(2, 'Dermatology care'),
(3, 'Women health and care'),
(4, 'Mental health centre'),
(5, 'Orthopedic solutions'),
(6, 'Rehabilitation'),
(7, 'Gastroenterology'),
(8, 'Pediatric Wellness'),
(9, 'Eye centre'),
(10, 'Hair care solutions'); -- No comma after the last set of values

SELECT * FROM doctors;

-- --------------------------------Doctors Data--------------------------------------------

INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (100, 'Steven', 'King');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (200, 'Simon', 'Pol');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (300, 'Neel', 'Singh');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (400, 'Chris', 'Kem');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (500, 'Robert', 'Hens');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (600, 'Kian', 'Oman');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (700, 'Serro', 'Lee');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (800, 'Brandon', 'SEE');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (900, 'Mick', 'Seelon');
INSERT INTO doctors (doctor_id, first_name, last_name) VALUES (1000, 'Nick', 'Perry');

-- ---------------------------------Patients Data--------------------------------------------
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (1, 'Mack', 'Heero', '413-561-335', 'MALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (2, 'Sirro', 'Obama', '413-522-485', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (3, 'Makky', 'Hill', '413-961-335', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (4, 'Slzzaro', 'Amat', '413-529-485', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (5, 'Marria', 'Heo', '413-561-375', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (6, 'Lavi', 'Boraco', '413-782-485', 'MALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (7, 'Catty', 'Zoeo', '413-597-335', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (8, 'Helly', 'Omni', '413-522-265', 'FEMALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (9, 'Dan', 'Hesto', '413-561-115', 'MALE');
INSERT INTO patients (patient_id, patient_first_name, patient_last_name, phone_number, gender) VALUES (10, 'Vank', 'Ollo', '413-329-485', 'MALE');

-- ----------------------------------Funds Data----------------------------------------------
-- IMPORTANT: Corrected 'financial_data' to 'funds' to match your CREATE TABLE name.
INSERT INTO funds (fd_id, amount) VALUES (11, 2000);
INSERT INTO funds (fd_id, amount) VALUES (22, 6000);

-- -------------------Appointments Data-----------------------------------
-- This data can be inserted last, as all its referenced IDs (clinic, doctor, patient) now exist.
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (511, '2024-01-01', '08:00:00', '08:00:00', '09:00:00', 2, 200, 1);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (512, '2024-01-01', '09:00:00', '09:30:00', '10:00:00', 3, 400, 2);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (513, '2024-01-01', '08:00:00', '08:00:00', '09:00:00', 2, 200, 4);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (514, '2024-01-02', '12:00:00', '12:15:00', '13:00:00', 1, 500, 9);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (515, '2024-01-03', '09:00:00', '09:30:00', '10:30:00', 1, 100, 1);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (516, '2024-01-05', '10:30:00', '11:00:00', '12:00:00', 2, 200, 10);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (517, '2024-01-08', '11:00:00', '11:30:00', '12:30:00', 3, 300, 9);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (518, '2024-01-10', '13:00:00', '13:30:00', '14:30:00', 9, 400, 8);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (519, '2024-01-12', '14:30:00', '15:00:00', '16:00:00', 5, 500, 7);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (520, '2024-01-15', '15:00:00', '15:30:00', '16:30:00', 4, 600, 9);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (521, '2024-01-17', '10:00:00', '10:30:00', '11:30:00', 1, 200, 8);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (522, '2024-01-20', '11:30:00', '12:00:00', '13:00:00', 2, 300, 3);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (523, '2024-01-22', '13:30:00', '14:00:00', '15:00:00', 8, 900, 4);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (524, '2024-01-25', '16:00:00', '16:00:00', '17:00:00', 5, 500, 5);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (525, '2024-01-27', '09:30:00', '10:00:00', '11:00:00', 1, 800, 3);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (526, '2024-01-29', '10:00:00', '10:30:00', '11:30:00', 2, 200, 2);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (527, '2024-01-31', '13:00:00', '13:30:00', '14:30:00', 3, 700, 3);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (528, '2024-01-31', '13:00:00', '13:30:00', '14:30:00', 7, 300, 3);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (529, '2024-01-28', '14:30:00', '15:00:00', '16:00:00', 4, 400, 4);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (530, '2024-01-24', '15:00:00', '15:30:00', '16:30:00', 5, 500, 5);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (531, '2024-01-23', '10:00:00', '10:30:00', '11:00:00', 4, 600, 1);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (532, '2024-01-21', '00:11:00', '11:00:00', '12:00:00', 1, 200, 7);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (533, '2024-01-19', '00:13:00', '13:00:00', '14:00:00', 2, 300, 2);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (534, '2024-01-18', '14:00:00', '14:00:00', '15:00:00', 3, 400, 4);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (535, '2024-01-16', '16:00:00', '16:00:00', '17:00:00', 4, 500, 5);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (536, '2024-01-14', '09:00:00', '09:00:00', '10:00:00', 10, 600, 1);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (537, '2024-01-13', '00:10:30', '11:00:00', '12:00:00', 4, 100, 2);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (538, '2024-01-11', '00:12:30', '13:00:00', '14:00:00', 1, 1000, 3);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (539, '2024-01-09', '00:14:30', '15:00:00', '16:00:00', 2, 300, 4);
INSERT INTO appointments (appointment_id, appointment_date, appointment_time, arrival_time, completed_time, clinic_id, doctor_id, patient_id) VALUES (540, '2024-01-07', '00:16:30', '17:00:00', '18:00:00', 3, 400, 5);

SELECT * FROM appointments;


-- 1. Appointment Delay Analysis 
-- Question:
-- Calculate the average delay (in minutes) between the scheduled appointment time and the actual arrival time for each clinic, and rank the clinics based on the highest average delay.
SELECT
    c.clinic_id,
    c.clinic_name,
    -- Calculate the average delay in minutes
    -- TIMEDIFF gets the difference as a TIME value
    -- TIME_TO_SEC converts that TIME value to seconds
    -- Dividing by 60 converts seconds to minutes
    ROUND(AVG(TIME_TO_SEC(TIMEDIFF(a.arrival_time, a.appointment_time)) / 60), 2) AS average_delay,
    -- Rank clinics based on their average delay
    RANK() OVER(ORDER BY AVG(TIME_TO_SEC(TIMEDIFF(a.arrival_time, a.appointment_time)) / 60) DESC) AS rank_by_delay
    -- Note: I changed ORDER BY to DESC for ranking "highest" average delay.
    -- If you want lowest delay to be rank 1, keep it as ASC.
FROM
    clinics c
JOIN
    appointments a ON c.clinic_id = a.clinic_id
GROUP BY
    c.clinic_id, c.clinic_name
ORDER BY
    average_delay DESC; 
    
    
-- Question: Identify patients who have arrived more than 15 minutes late or whose appointments were not completed within 30 minutes after the scheduled time.
-- List their names, number of such occurrences, and percentage over their total appointments.

WITH AppointmentFlags AS (
    SELECT
        p.patient_id,
        p.patient_first_name,
        p.patient_last_name,
        -- Calculate delay time in minutes (arrival_time - appointment_time)
        ROUND(TIME_TO_SEC(TIMEDIFF(a.arrival_time, a.appointment_time)) / 60, 2) AS delay_minutes,
        -- Calculate completion duration in minutes (completed_time - arrival_time)
        ROUND(TIME_TO_SEC(TIMEDIFF(a.completed_time, a.arrival_time)) / 60, 2) AS completion_duration_minutes,
        -- Flag this appointment as a 'problem' if it meets either condition
        CASE
            -- Condition 1: Arrived more than 15 minutes late
            WHEN (TIME_TO_SEC(TIMEDIFF(a.arrival_time, a.appointment_time)) / 60) > 15 THEN 1
            -- Condition 2: Appointment completed more than 30 minutes after arrival
            WHEN (TIME_TO_SEC(TIMEDIFF(a.completed_time, a.arrival_time)) / 60) > 30 THEN 1
            ELSE 0
        END AS is_problem_appointment_flag
    FROM
        patients p
    JOIN
        appointments a ON p.patient_id = a.patient_id -- Corrected JOIN condition
),
PatientSummary AS (
    SELECT
        patient_id,
        patient_first_name,
        patient_last_name,
        COUNT(*) AS total_appointments, -- Count all appointments for the patient
        SUM(is_problem_appointment_flag) AS number_of_late_or_long_appointments -- Sum of problem flags
    FROM
        AppointmentFlags
    GROUP BY
        patient_id, patient_first_name, patient_last_name
)
SELECT
    ps.patient_first_name,
    ps.patient_last_name,
    ps.number_of_late_or_long_appointments,
    -- Calculate percentage, handling cases where total_appointments might be zero
    -- (though with COUNT(*), it won't be zero if the patient is in the summary)
    ROUND((ps.number_of_late_or_long_appointments / ps.total_appointments) * 100, 2) AS percentage_of_problem_appointments
FROM
    PatientSummary ps
WHERE
    ps.number_of_late_or_long_appointments > 0 -- Only show patients who had at least one problem appointment
ORDER BY
    percentage_of_problem_appointments DESC, -- Rank by highest percentage first
    number_of_late_or_long_appointments DESC; -- Then by number of occurrences if percentages are equal    
    
    
   -- 3. Doctor Performance Report (MySQL Version - Corrected for ONLY_FULL_GROUP_BY)
-- Question: For each doctor, calculate:
--   - Total number of appointments
--   - Average appointment duration (from arrival to completed time)
--   - Count of patients they’ve seen more than once
-- Return results sorted by doctor with the most patients seen more than once.

WITH DoctorPatientVisits AS (
    -- CTE 1: Identify doctor-patient pairs where the patient has been seen more than once by that specific doctor.
    SELECT
        doctor_id,
        patient_id
    FROM
        appointments
    GROUP BY
        doctor_id,
        patient_id
    HAVING
        COUNT(appointment_id) > 1
),
DoctorRepeatPatients AS (
    -- CTE 2: Count the number of *unique* patients each doctor has seen more than once.
    SELECT
        doctor_id,
        COUNT(DISTINCT patient_id) AS regular_patients_count
    FROM
        DoctorPatientVisits
    GROUP BY
        doctor_id
)
SELECT
    d.first_name,
    d.last_name,
    COUNT(a.appointment_id) AS total_appointments,
    ROUND(AVG(TIME_TO_SEC(TIMEDIFF(a.completed_time, a.arrival_time)) / 60), 2) AS average_appointment_duration_minutes,
    -- FIX: Wrap drp.regular_patients_count in an aggregate function (e.g., MAX)
    COALESCE(MAX(drp.regular_patients_count), 0) AS patients_seen_more_than_once
FROM
    appointments a
JOIN
    doctors d ON a.doctor_id = d.doctor_id
LEFT JOIN
    DoctorRepeatPatients drp ON a.doctor_id = drp.doctor_id
GROUP BY
    d.doctor_id, d.first_name, d.last_name
ORDER BY
    patients_seen_more_than_once DESC,
    total_appointments DESC;
    
    -- 4. Clinic Load by Weekday (MySQL Version)
-- Question: Find out which weekday (Monday–Sunday) is the busiest for each clinic in terms of number of appointments.
-- Return clinic name, weekday, and appointment count.

WITH ClinicWeekdayAppointments AS (
    -- CTE 1: Count appointments per clinic per weekday.
    SELECT
        clinic_id,
        DAYNAME(appointment_date) AS weekday_name, -- MySQL function to get the full weekday name (e.g., 'Monday', 'Tuesday').
        COUNT(appointment_id) AS appointment_count -- Count appointments for each clinic on each weekday.
    FROM
        appointments
    GROUP BY
        clinic_id,
        DAYNAME(appointment_date) -- Group by clinic and weekday to get distinct counts.
),
BusiestWeekdayPerClinic AS (
    -- CTE 2: Find the maximum appointment count for each clinic across all weekdays.
    SELECT
        clinic_id,
        MAX(appointment_count) AS max_appointment_count
    FROM
        ClinicWeekdayAppointments
    GROUP BY
        clinic_id
)
SELECT
    c.clinic_name, -- Clinic name from the 'clinics' table.
    cwa.weekday_name, -- The name of the busiest weekday.
    bwpc.max_appointment_count AS busiest_appointment_count -- The highest number of appointments for that clinic.
FROM
    ClinicWeekdayAppointments cwa
JOIN
    BusiestWeekdayPerClinic bwpc
    ON cwa.clinic_id = bwpc.clinic_id
    AND cwa.appointment_count = bwpc.max_appointment_count -- This crucial condition ensures we only pick the row(s) that match the maximum count for that clinic.
JOIN
    clinics c ON c.clinic_id = cwa.clinic_id -- Join to get the actual clinic name from its ID.
ORDER BY
    c.clinic_name, -- Order results by clinic name for easy reading.
    busiest_appointment_count DESC; -- Then by the busiest count (in case a clinic has multiple weekdays with the same max count).
    
    
    -- 5. Repeat Patient Frequency (MySQL Version)
-- Question: Find the top 5 patients with the highest number of appointments and display their full name and total appointment count.
-- Include a column to indicate if they are “Frequent” (more than 10 appointments) or “Occasional” (10 or fewer).

WITH PatientAppointmentCounts AS (
    -- CTE: Calculate the total appointment count for each patient.
    SELECT
        p.patient_id, -- It's good practice to include the primary key in GROUP BY for unique patients,
                      -- even if CONCAT(first_name, last_name) might seem unique.
        CONCAT(p.patient_first_name, ' ', p.patient_last_name) AS full_name, -- MySQL uses CONCAT() for string concatenation.
        COUNT(a.appointment_id) AS total_appointment_count -- Count all appointments for each patient.
    FROM
        appointments a
    JOIN
        patients p ON a.patient_id = p.patient_id -- Join to link appointments to patient details.
    GROUP BY
        p.patient_id, p.patient_first_name, p.patient_last_name -- Group by patient to aggregate their appointments.
)
SELECT
    full_name,
    total_appointment_count,
    -- Use a CASE statement to categorize patients based on their total appointment count.
    CASE
        WHEN total_appointment_count > 10 THEN 'Frequent'
        ELSE 'Occasional'
    END AS status
FROM
    PatientAppointmentCounts
ORDER BY
    total_appointment_count DESC -- Order by the highest appointment count first.
LIMIT 5; -- Restrict the results to only the top 5 patients.

-- 6. Time Window Utilization (MySQL Version)
-- Question: Group appointments into 3 time windows:
--   Morning (before 12:00 PM)
--   Afternoon (12:00 PM–5:00 PM)
--   Evening (after 5:00 PM)
-- Count the number of appointments in each window for each clinic.

WITH AppointmentTimeWindows AS (
    -- CTE: Assign a time window to each appointment based on its scheduled time.
    SELECT
        clinic_id,
        appointment_id, -- Keep this column to count appointments later.
        -- Corrected CASE statement logic for time windows:
        CASE
            WHEN appointment_time < '12:00:00' THEN 'Morning' -- Appointments before 12:00 PM (noon).
            WHEN appointment_time >= '12:00:00' AND appointment_time <= '17:00:00' THEN 'Afternoon' -- Appointments from 12:00 PM (noon) up to and including 5:00 PM (17:00:00).
            ELSE 'Evening' -- Appointments after 5:00 PM (17:00:00).
        END AS time_window
    FROM
        appointments
)
SELECT
    atw.clinic_id,
    c.clinic_name, -- Join to the clinics table to get the clinic's name.
    atw.time_window,
    COUNT(atw.appointment_id) AS number_of_appointments -- Count the number of appointments within each time window for each clinic.
FROM
    AppointmentTimeWindows atw
JOIN
    clinics c ON atw.clinic_id = c.clinic_id -- Link appointments data with clinic names.
GROUP BY
    atw.clinic_id, c.clinic_name, atw.time_window -- Group by clinic ID, clinic name, and the assigned time window to get correct counts.
ORDER BY
    atw.clinic_id, -- First, order by clinic ID to group results by clinic.
    FIELD(atw.time_window, 'Morning', 'Afternoon', 'Evening'); -- Then, order the time windows logically (Morning, Afternoon, Evening)
    -- FIELD() is a MySQL-specific function that allows you to sort by a custom list of string values.
    
   -- 7. Monthly Trends by Clinic (MySQL Version - Meticulously Cleaned)
-- Question: Using a CTE, show the monthly appointment count trend for each clinic for the past year.
-- Return columns: clinic_name, year_month, appointment_count.

WITH ClinicAppointmentsData AS (
    SELECT
        a.clinic_id,
        c.clinic_name,
        a.appointment_date,
        a.appointment_id
    FROM
        appointments a
    LEFT JOIN
        clinics c ON a.clinic_id = c.clinic_id
    -- Optional: Add a WHERE clause here if you need to filter for a specific "past year".
)
SELECT
    clinic_name,
    DATE_FORMAT(appointment_date, '%Y-%m') AS y_m, -- Directly using the function, no alias
    COUNT(appointment_id) AS appointment_count
FROM
    ClinicAppointmentsData
GROUP BY
    clinic_name,
    DATE_FORMAT(appointment_date, '%Y-%m')
ORDER BY
    clinic_name,
    y_m;

-- 8. Early vs Late Arrival Ratio
-- Question:
-- For each doctor, calculate the ratio of: Appointments where patients arrived on time or early, Appointments where patients arrived late. Return doctor’s full name and the ratio (early_or_on_time : late).


WITH AppointmentArrivalStatus AS (
    -- CTE: Determine the arrival status (early/on-time vs. late) for each appointment.
    SELECT
        doctor_id,
        -- Flag for appointments where the patient arrived on time or early.
        -- TIMEDIFF(arrival_time, appointment_time) will be 0 or negative if arrived on time or early.
        CASE
            WHEN TIME_TO_SEC(TIMEDIFF(arrival_time, appointment_time)) <= 0 THEN 1
            ELSE 0
        END AS is_early_or_on_time,
        -- Flag for appointments where the patient arrived late.
        -- TIMEDIFF(arrival_time, appointment_time) will be positive if arrived late.
        CASE
            WHEN TIME_TO_SEC(TIMEDIFF(arrival_time, appointment_time)) > 0 THEN 1
            ELSE 0
        END AS is_late
    FROM
        appointments
)
SELECT
    -- Get the doctor's full name.
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
    -- Calculate the total count of early/on-time appointments for each doctor.
    SUM(aas.is_early_or_on_time) AS early_or_on_time_count,
    -- Calculate the total count of late appointments for each doctor.
    SUM(aas.is_late) AS late_count,
    -- Concatenate the counts into the requested ratio string format (e.g., "5:2").
    CONCAT(
        SUM(aas.is_early_or_on_time),
        ':',
        SUM(aas.is_late)
    ) AS early_on_time_to_late_ratio
FROM
    AppointmentArrivalStatus aas
JOIN
    doctors d ON aas.doctor_id = d.doctor_id -- Join to get doctor names.
GROUP BY
    d.doctor_id, d.first_name, d.last_name -- Group by doctor to aggregate counts for each.
ORDER BY
    doctor_full_name;