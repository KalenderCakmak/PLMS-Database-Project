-- Generating a Daily Lesson Schedule
-- This query will list all students and their respective tutors for a specific date[cite: 640, 646].
SELECT Students.Name, Tutors.Name, Appointments.Time [cite: 641]
FROM Appointments [cite: 642]
JOIN Students ON Appointments.Student_ID = Students.Student_ID [cite: 643]
JOIN Tutors ON Appointments.Tutor_ID = Tutors.Tutor_ID [cite: 644]
WHERE Appointments.Date = '2026-05-20'; [cite: 645]

-- Calculating Monthly Revenue
-- This query will sum up all successful payments to show the total income for the current month[cite: 647, 651].
SELECT SUM(Amount) AS Total_Monthly_Revenue [cite: 648]
FROM Payments [cite: 649]
WHERE Status = 'Paid' AND Payment_Date LIKE '2026-05%'; [cite: 650]

-- Tracking Student Progress Reports
-- This query will retrieve the progress notes for a specific student to see their historical development[cite: 652, 656].
SELECT Appointments.Date, Progress_Notes.Description [cite: 653]
FROM Progress_Notes [cite: 654]
JOIN Appointments ON Progress_Notes.Appointment_ID = Appointments.Appointment_ID [cite: 655]
WHERE Appointments.Student_ID = 101; [cite: 655]
