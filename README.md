# Zoo Operation Database

## Project Overview
The **Zoo Operation Database** project is designed to manage data related to zoos in Romania, their employees, sponsors, animals, and visitors. The database enables efficient tracking of zoo operations, including animal management, employee job assignments, sponsorships, and visitor transactions.

## Features
- **Zoo Management**: Stores information about multiple zoos and their locations.
- **Employee Management**: Tracks employees, their roles, and assignments.
- **Sponsorship System**: Records sponsorship details for zoos.
- **Animal Tracking**: Maintains records of animals in various habitats and aquariums.
- **Visitor Access Control**: Manages visitor ticket purchases and access to zoo attractions.
- **Data Integrity**: Implements normalization up to BCNF and supports advanced SQL queries.

## Database Schema
### Entities & Relationships
The database consists of the following entities:
- **Zoos (`GRADINI_ZOOLOGICE`)**: Stores information about zoos.
- **Locations (`LOCATII`)**: Each zoo is associated with a specific location.
- **Employees (`ANGAJATI`)**: Tracks personnel and their job roles.
- **Jobs (`JOBURI`)**: Defines different positions available at the zoos.
- **Sponsors (`SPONSORI`)**: Entities that fund zoos.
- **Habitats (`HABITATE`)**: Zones where land-based animals are housed.
- **Aquariums (`ACVARII`)**: Water-based animal enclosures.
- **Terrestrial Animals (`ANIMALE_SUPRATERANE`)**: Animals living in habitats.
- **Aquatic Animals (`ANIMALE_ACVATICE`)**: Animals living in aquariums.
- **Visitors (`VIZITATORI`)**: Individuals purchasing tickets for entry.
- **Transaction Records (`CUMPARA_ACCES_LA`)**: Logs visitor purchases.

### Key Constraints
- Each zoo must have at least one habitat and one aquarium.
- A visitor can only purchase access to one habitat and one aquarium per transaction.
- An employee can only have one job per zoo.
- A sponsor must sponsor at least one zoo.

## Database Implementation
### SQL Scripts
The project includes SQL scripts for:
- **Creating and inserting data into tables** (`Creare & Inserare.sql`)
- **Querying data** (`cereri.sql`)
- **Updating and deleting records** (`cereri.sql`)

### Sample Queries
1. **Retrieve all zoos that have sponsors and the number of terrestrial animals they house:**
   ```sql
   SELECT G.NUME_ZOO, L.ORAS, COUNT(DISTINCT A.COD_ANIMAL_ST) AS NUMAR_ANIMALE
   FROM GRADINI_ZOOLOGICE G
   JOIN LOCATII L ON G.COD_LOCATIE = L.COD_LOCATIE
   JOIN HABITATE H ON G.COD_ZOO = H.COD_ZOO
   JOIN ANIMALE_SUPRATERANE A ON H.COD_HABITAT = A.COD_HABITAT
   WHERE G.COD_ZOO IN (SELECT DISTINCT COD_ZOO FROM GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI)
   GROUP BY G.NUME_ZOO, L.ORAS
   ORDER BY NUMAR_ANIMALE DESC;
   ```

2. **List zoos that have more than 3 employees with jobs requiring over 1 year of experience:**
   ```sql
   SELECT G.NUME_ZOO, COUNT(A.COD_ANGAJAT) AS NUMAR_ANGAJATI
   FROM GRADINI_ZOOLOGICE G
   JOIN GRADINI_ZOOLOGICE_AU_JOBURI J ON G.COD_ZOO = J.COD_ZOO
   JOIN ANGAJATI A ON J.COD_JOB = A.COD_JOB
   WHERE J.COD_JOB IN (SELECT COD_JOB FROM JOBURI WHERE EXPERIENTA_MINIMA > 1)
   GROUP BY G.NUME_ZOO
   HAVING COUNT(A.COD_ANGAJAT) >= 3;
   ```

## Normalization
The database follows strict normalization principles up to BCNF:
- **First Normal Form (1NF)**: Ensures atomicity of data.
- **Second Normal Form (2NF)**: Eliminates partial dependencies.
- **Third Normal Form (3NF)**: Removes transitive dependencies.
- **Boyce-Codd Normal Form (BCNF)**: Further eliminates redundancy.

### Example of Denormalization for Performance Optimization
Combining `LOCATII` and `GRADINI_ZOOLOGICE` to reduce joins:
```sql
ALTER TABLE GRADINI_ZOOLOGICE ADD (
    ORAS VARCHAR2(50),
    STRADA VARCHAR2(50)
);
UPDATE GRADINI_ZOOLOGICE G
SET (G.ORAS, G.STRADA) = (
    SELECT L.ORAS, L.STRADA
    FROM LOCATII L
    WHERE L.COD_LOCATIE = G.COD_LOCATIE
);
```

## Views & Optimized Queries
To enhance performance, the database includes indexed views:
```sql
CREATE OR REPLACE VIEW ACVARII_BUGET AS
SELECT A.COD_ACVARIU, A.NUME_ACVARIU, G.COD_ZOO, SUM(S.SUMA) AS SPONSORIZARI_ZOO
FROM ACVARII A
JOIN GRADINI_ZOOLOGICE G ON A.COD_ZOO = G.COD_ZOO
JOIN GRADINI_ZOOLOGICE_SUNT_SPONSORIZATE_DE_SPONSORI S ON G.COD_ZOO = S.COD_ZOO
GROUP BY A.COD_ACVARIU, A.NUME_ACVARIU, G.COD_ZOO;
```

## How to Use
### Prerequisites
- **Database Management System**: Oracle, MySQL, or PostgreSQL.
- **SQL Client**: Any SQL execution tool such as SQL Developer, MySQL Workbench.

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/Matei5/Zoo-Operation-Database.git
   ```
2. Import SQL scripts into your database.
3. Execute the schema creation script (`Creare & Inserare.sql`).
4. Run sample queries to verify data integrity (`cereri.sql`).

### Running Queries
- Open an SQL client.
- Load the required script (`cereri.sql`).
- Execute specific queries based on your analysis needs.

## Future Enhancements
- **Automated Report Generation**: Generate periodic reports for zoo revenue and sponsorships.
- **API Integration**: Connect the database to a web application for real-time data retrieval.
- **Machine Learning Analysis**: Predict visitor trends based on past transactions.

## License
This project is licensed under the MIT License.

