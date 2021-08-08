DROP DATABASE IF EXISTS progmatic;

CREATE DATABASE IF NOT EXISTS progmatic;

USE progmatic;

CREATE TABLE IF NOT EXISTS members (
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    state ENUM ('student', 'teacher', 'staff', 'unknown') DEFAULT 'unknown',
    emil VARCHAR(50) NOT NULL,
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
		('Csaba', 'student', 'csaba@progmatic.hu'),
		('Kata', 'student', 'kata@progmatic.hu'),
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