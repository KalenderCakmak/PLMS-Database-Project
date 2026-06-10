# Private Lesson Management System (PLMS)

A relational database application built with SQLite for managing private tutoring operations — students, tutors, lessons, appointments, payments, and progress tracking.

---

## Problem Statement

Private tutors and small tutoring centers often rely on manual methods (paper logs, spreadsheets) to manage their operations. This leads to scheduling conflicts, financial errors, and lack of progress tracking. PLMS solves these problems with a structured, centralized database.

---

## Database Schema

The database consists of 6 tables:

| Table | Description |
|-------|-------------|
| `Students` | Student profiles (name, contact, grade level) |
| `Tutors` | Tutor profiles (name, specialization, phone) |
| `Lessons` | Lesson types and hourly rates |
| `Appointments` | Scheduled sessions linking students, tutors, and lessons |
| `Payments` | Financial transactions with status tracking |
| `Progress_Notes` | Session notes recording student development |

### Relationships

- `Appointments` references `Students`, `Tutors`, and `Lessons`
- `Payments` references `Students`
- `Progress_Notes` references `Appointments`

### Constraints

- `NOT NULL` — all critical fields (names, dates, amounts)
- `UNIQUE` — contact info, phone numbers, subject names
- `CHECK` — `Amount > 0`, `Status IN ('Paid', 'Pending')`, `Hourly_Rate > 0`
- `FOREIGN KEY` — referential integrity across all related tables

---

## SQL Features Used

- `CREATE TABLE` with `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, `CHECK`
- `INSERT INTO` with realistic sample data (10+ rows per table)
- `INNER JOIN` and `LEFT JOIN` for multi-table queries
- `CREATE VIEW` for reusable reporting queries
- `SUM()`, `COUNT()`, `AVG()` aggregation functions
- `GROUP BY` and `HAVING` for grouped analysis
- Subqueries for nested filtering
- `CREATE INDEX` for query performance optimization

---

## Views

| View | Description |
|------|-------------|
| `Daily_Schedule` | Lists all appointments with student, tutor, subject, date, and time |
| `Payment_Summary` | Shows payment status per student |
| `Student_Progress` | Displays progress notes per student per subject |

---

## Sample Queries

**Daily lesson schedule for a specific date:**
```sql
SELECT * FROM Daily_Schedule WHERE Date = '2026-05-01';
```

**Monthly revenue:**
```sql
SELECT SUM(Amount) AS Total_Revenue
FROM Payments
WHERE Status = 'Paid' AND Payment_Date LIKE '2026-05%';
```

**Tutors with more than 2 lessons:**
```sql
SELECT T.Name || ' ' || T.Surname AS Tutor, COUNT(*) AS Lesson_Count
FROM Appointments A
INNER JOIN Tutors T ON A.Tutor_ID = T.Tutor_ID
GROUP BY T.Tutor_ID
HAVING COUNT(*) > 2;
```

**Student with the most lessons:**
```sql
SELECT Name || ' ' || Surname AS Student,
    (SELECT COUNT(*) FROM Appointments WHERE Student_ID = S.Student_ID) AS Total_Lessons
FROM Students S
ORDER BY Total_Lessons DESC
LIMIT 1;
```

---

## Performance Optimization

Indexes were created on frequently queried columns:

```sql
CREATE INDEX idx_appointments_student ON Appointments(Student_ID);
CREATE INDEX idx_appointments_date ON Appointments(Date);
CREATE INDEX idx_payments_student ON Payments(Student_ID);
CREATE INDEX idx_payments_status ON Payments(Status);
```

---

## Constraint Violation Tests

The following invalid inserts were tested and correctly rejected by the database:

| Test | Error |
|------|-------|
| `Amount = -100` | `CHECK constraint failed: Amount > 0` |
| `Status = 'Cancelled'` | `CHECK constraint failed: Status IN ('Paid', 'Pending')` |
| Duplicate `Contact_Info` | `UNIQUE constraint failed: Students.Contact_Info` |

---

## How to Run

1. Download and install [DB Browser for SQLite](https://sqlitebrowser.org/dl/)
2. Clone this repository
3. Open `plms.db` in DB Browser for SQLite
4. Go to **Execute SQL** tab to run any query
5. Go to **Browse Data** tab to view table contents

---

Video Link:
https://drive.google.com/file/d/1LYUrNpjLOEGZw8U6rOqCdqY0uEBT8bfD/view?usp=drive_link

## Project Info

- **Course:** MTM4692
- **Tool:** SQLite via DB Browser for SQLite
- **Team size:** 5 members
- Group 21:
Kalender ÇAKMAK
Mert Can DOĞAN
Nazakat Mammadova
Öykü YAMANTÜRK
Elifgül EYİGÜN
