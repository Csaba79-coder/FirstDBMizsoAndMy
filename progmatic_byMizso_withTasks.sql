DROP DATABASE IF EXISTS progmatic;

CREATE DATABASE IF NOT EXISTS progmatic;

USE progmatic;

CREATE TABLE IF NOT EXISTS members (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    state ENUM ('student', 'teacher', 'staff', 'unknown') DEFAULT 'unknown',
    emil VARCHAR(50) NOT NULL,
    profil_picture LONGBLOB,
    reg_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS courses (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    course_name VARCHAR(50), 
    is_daytime BOOL,
    length_week INT UNSIGNED,
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS subjects (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    subject_name VARCHAR(50) NOT NULL,
    credit INT,
    length_hour INT UNSIGNED,
-- not perfect, need to specify teachers to subjects
    PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS member2courses (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    member_id INT UNSIGNED NOT NULL,
    course_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES members(id), -- teszt féjld vid membörz.ájdí
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE IF NOT EXISTS subjects2courses (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    subject_id INT UNSIGNED NOT NULL,
    course_id INT UNSIGNED NOT NULL,
    schedule_day ENUM ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday') NOT NULL, -- not perfect, could be in its own table
    schedule_hour INT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

INSERT INTO members(name, state, emil)
	VALUES 
		('Csaba', 'student', "csaba@progmatic.hu"),
		('Kata', 'student', "kata@progmatic.hu"),
		('Ria', 'teacher', 'ria@progmatic.hu'),
		('Szabina', 'staff', 'szabina@progmatic.hu');

INSERT INTO courses (course_name, is_daytime, length_week)
	VALUES
		('Backend', FALSE, 28),
		('Backend', TRUE, 28),
        ('Frontend', TRUE, 24),
        ('Fullstack', 0, 34);

INSERT INTO subjects (subject_name, credit, length_hour)
	VALUES 
		('OOP', 10, 40),
        ('Basics', 4, 15),
        ('SQL', 2, 5),
        ('JS', 8, 20),
        ('Bootstrap', 10, 25);

SELECT * FROM members WHERE state = 'student';

SELECT COUNT(*) AS "Nappali képzések száma" FROM courses WHERE is_daytime = TRUE;

SELECT is_daytime, COUNT(*) FROM courses GROUP BY is_daytime;

SELECT 
	CASE 
		WHEN is_daytime THEN "Nappali"
        ELSE "Esti"
	END AS "Képzés formája",
    COUNT(*) AS "Képzések száma" FROM courses GROUP BY is_daytime ORDER BY is_daytime DESC;
    
SELECT * FROM member2courses WHERE member_id = 1;

SELECT course_name
	FROM courses
		JOIN member2courses
        ON courses.id = member2courses.course_id
	WHERE member2courses.member_id = 1;

SELECT credit FROM subjects ORDER BY credit ASC LIMIT 1;

SELECT MIN(credit) FROM subjects;

SELECT course_name, is_daytime, SUM(credit)
	FROM subjects
		JOIN subjects2courses
			ON subjects.id = subjects2courses.subject_id
		JOIN courses
			ON courses.id = subjects2courses.course_id
	GROUP BY course_id;