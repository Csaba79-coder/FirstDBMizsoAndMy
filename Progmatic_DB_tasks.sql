USE progmatic_own;

SELECT * FROM members WHERE state = 'student';

-- hány nappali képzés van
SELECT COUNT(*) AS 'Nappali képzések száma' FROM courses WHERE is_daytime = true;

SELECT is_daytime, COUNT(is_daytime) FROM courses GROUP BY is_daytime;

SELECT is_daytime, 
CASE 
WHEN is_daytime = true THEN 'Nappali'
ELSE 'Esti'
END,
COUNT(is_daytime) FROM courses GROUP BY is_daytime;

SELECT is_daytime AS "Száma", 
CASE 
WHEN is_daytime = true THEN 'Nappali'
ELSE 'Esti'
END AS "Típusa", -- "Képzés formája"
COUNT(is_daytime) AS "Darab" FROM courses GROUP BY is_daytime;

SELECT
CASE 
WHEN is_daytime = true THEN 'Nappali'
ELSE 'Esti'
END AS "Képzés formája",
COUNT(is_daytime) AS "Darab" FROM courses GROUP BY is_daytime;

SELECT
CASE 
WHEN is_daytime = true THEN 'Nappali'
ELSE 'Esti'
END AS "Képzés formája",
COUNT(is_daytime) AS "Darab" FROM courses GROUP BY is_daytime ORDER BY is_daytime DESC;

SELECT * FROM memberstocourses WHERE member_ID = 1; -- kihez milyen kurzus tartozik (adattábla üres!!!)

-- kurzus nevét szeretnénk visszakapni, amire adott diák jár: adattábla üres!!!
SELECT course_name FROM courses JOIN memberstocourses ON courses.ID = memberstocourses.course_ID WHERE member_ID = 1; -- memberstocourses_member_ID

SELECT credit FROM subjects ORDER BY credit;
SELECT credit FROM subjects ORDER BY credit limit 1;
SELECT MIN(credit) FROM subjects;

-- név képzési forma össz kredit szám
SELECT SUM(credit) FROM subjects;
SELECT SUM(credit) FROM subjects WHERE ID = 1;
SELECT SUM(credit) FROM subjects JOIN subjectstocourses ON subject_ID = subjectstocourses.subject_ID WHERE course_ID = 1;

-- join 3 table!
SELECT course_name, is_daytime, SUM(credit) 
	FROM subjects JOIN subjectstocourses 
    ON subject_ID = subjectstocourses.subject_ID 
    JOIN courses ON course_ID = subjectstocourses.course_ID
    WHERE course_ID = 1;
    
-- kurzusonként:

SELECT course_name, is_daytime, SUM(credit) 
	FROM subjects JOIN subjectstocourses 
    ON subject_ID = subjectstocourses.subject_ID 
    JOIN courses ON course_ID = subjectstocourses.course_ID
    GROUP BY course_ID;