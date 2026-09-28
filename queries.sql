-- =========================================================
-- 2023 Montgomery County Police Database
-- Analytical Views
-- =========================================================

USE `2023MoCoPoliceDatabase`;

-- ---------------------------------------------------------
-- View 1: Incidents by district
-- Counts the number of incidents associated with each police district.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW v_incidents_by_district AS
SELECT
    d.district_name,
    COUNT(i.incident_id) AS total_incidents
FROM district d
JOIN location l
    ON d.district_id = l.district_id
JOIN incident i
    ON l.location_id = i.location_id
GROUP BY d.district_name
ORDER BY total_incidents DESC;

-- ---------------------------------------------------------
-- View 2: Alcohol-related crimes by ZIP code
-- Shows alcohol-related offenses grouped by ZIP code,
-- crime type, and crime category.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW v_zip_alcohol_crime_breakdown AS
SELECT
    l.zip_code,
    COUNT(o.crime_name) AS number_of_crimes,
    o.crime_against,
    o.crime_category
FROM location l
JOIN incident i
    ON l.location_id = i.location_id
JOIN incidentoffense io
    ON i.incident_id = io.incident_id
JOIN offense o
    ON io.offense_id = o.offense_id
WHERE o.crime_category IN (
    'DRIVING UNDER THE INFLUENCE LIQUOR',
    'LIQUOR (DESCRIBE OFFENSE)',
    'LIQUOR - POSSESS'
)
GROUP BY
    l.zip_code,
    o.crime_against,
    o.crime_category
HAVING number_of_crimes > 0
ORDER BY number_of_crimes DESC;

-- ---------------------------------------------------------
-- View 3: High-crime addresses
-- Identifies addresses with crime counts above the average
-- crime count across all addresses.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW v_high_crime_addresses AS
SELECT
    l.block_address,
    l.zip_code,
    COUNT(o.offense_id) AS address_crime_count
FROM location l
JOIN incident i
    ON l.location_id = i.location_id
JOIN incidentoffense io
    ON i.incident_id = io.incident_id
JOIN offense o
    ON io.offense_id = o.offense_id
GROUP BY
    l.block_address,
    l.zip_code
HAVING address_crime_count > (
    SELECT AVG(crime_total)
    FROM (
        SELECT
            COUNT(o2.offense_id) AS crime_total
        FROM location l2
        JOIN incident i2
            ON l2.location_id = i2.location_id
        JOIN incidentoffense io2
            ON i2.incident_id = io2.incident_id
        JOIN offense o2
            ON io2.offense_id = o2.offense_id
        GROUP BY l2.block_address
    ) AS avg_table
)
ORDER BY address_crime_count DESC;

-- ---------------------------------------------------------
-- View 4: Cases by agency and city
-- Counts the number of incidents handled by each agency
-- within each city.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW v_cases_by_agency_and_city AS
SELECT
    a.agency_name,
    l.city,
    COUNT(i.incident_id) AS total_cases
FROM incident i
JOIN agency a
    USING (agency_id)
JOIN location l
    USING (location_id)
WHERE l.city IS NOT NULL
GROUP BY
    a.agency_name,
    l.city
ORDER BY total_cases DESC;

-- ---------------------------------------------------------
-- View 5: Victims by crime category
-- Summarizes total victims and total incidents for each
-- crime category.
-- ---------------------------------------------------------

CREATE OR REPLACE VIEW v_victims_by_crime_category AS
SELECT
    o.crime_category,
    SUM(i.victims) AS total_victims,
    COUNT(i.incident_id) AS total_incidents
FROM incident i
JOIN incidentoffense io
    USING (incident_id)
JOIN offense o
    USING (offense_id)
WHERE i.victims IS NOT NULL
GROUP BY o.crime_category
ORDER BY total_victims DESC;

-- =========================================================
-- Raw Query 1: Top 10 most common offenses
-- =========================================================

SELECT
    o.crime_name,
    o.crime_category,
    COUNT(*) AS total_occurrences
FROM incidentoffense io
JOIN offense o
    ON io.offense_id = o.offense_id
GROUP BY
    o.crime_name,
    o.crime_category
ORDER BY total_occurrences DESC
LIMIT 10;

-- =========================================================
-- Raw Query 2: Incident trends by month
-- =========================================================

SELECT
    YEAR(i.Start_Date_Time) AS incident_year,
    MONTH(i.Start_Date_Time) AS incident_month,
    COUNT(*) AS total_incidents
FROM incident i
WHERE i.Start_Date_Time IS NOT NULL
GROUP BY
    YEAR(i.Start_Date_Time),
    MONTH(i.Start_Date_Time)
ORDER BY
    incident_year,
    incident_month;