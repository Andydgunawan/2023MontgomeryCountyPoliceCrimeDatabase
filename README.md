# 2023 Montgomery County Police Database

A relational database project built with MySQL to organize and analyze Montgomery County police incident data.

## Overview

This project was originally developed for INST327: Database Design and Modeling at the University of Maryland.

The goal of the project was to transform a large police incident dataset into a normalized relational database that supports efficient querying and analysis.

The database contains more than 300,000 incident records and models relationships between incidents, offenses, locations, police districts, agencies, and place types.

## Technologies

- MySQL
- SQL
- MySQL Workbench
- Relational Database Design
- Database Normalization
- Entity Relationship Modeling

## Database Structure

The database is organized into the following main tables:

- `incident` - stores individual police incidents
- `offense` - stores offense information
- `incidentoffense` - junction table connecting incidents and offenses
- `location` - stores incident location information
- `district` - stores police district information
- `agency` - stores law enforcement agency information
- `place` - stores place and location-type information

The `incidentoffense` table supports the many-to-many relationship between incidents and offenses.

## Database Normalization

The original dataset stored incident, offense, location, agency, district, and place information together in a largely denormalized format. This resulted in repeated values across records and made the data more difficult to maintain.

The schema was progressively normalized to reduce redundancy and improve data integrity.

### First Normal Form (1NF)

The data was reorganized so that attributes contained atomic values and individual incidents could be uniquely identified. Offense information was separated from the main incident record.

### Second Normal Form (2NF)

Repeated location and offense information was moved into separate tables. The `incident` table began referencing related records using foreign keys instead of storing repeated descriptive values.

### Third Normal Form (3NF)

Additional entities such as agencies, police districts, and place types were separated into their own tables. This reduced transitive dependencies and created the final normalized relational structure.

The final design uses:

- Primary keys to uniquely identify records
- Foreign keys to connect related tables
- A junction table to represent the many-to-many relationship between incidents and offenses
- Separate entity tables for agencies, districts, locations, offenses, and place types

### Normalization Process

![Database Normalization Process](docs/normalization.png))

A more detailed explanation of the normalization process can be found in:

[`docs/normalization.md`](docs/normalization.md)

## ER Diagram

![ER Diagram](ERD.png)

## SQL Analysis

The project includes several analytical SQL views that demonstrate joins, aggregation, grouping, filtering, and subqueries.

Examples include:

- Incidents by police district
- Alcohol-related offenses by ZIP code
- Addresses with above-average crime counts
- Cases handled by agency and city
- Victims by crime category
- Most common offense types
- Incident trends over time

These queries can be found in:

[`queries.sql`](queries.sql)

## Repository Structure

```text
2023MontgomeryCountyPoliceCrimeDatabase/
│
├── README.md
├── schema.sql
├── queries.sql
├── ERD.png
│
└── docs/
    ├── normalization.md
    └── normalization-process.png
