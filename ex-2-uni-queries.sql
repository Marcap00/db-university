/* QUERY CON JOIN */
-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia (68)
SELECT *
FROM `degrees`
INNER JOIN `students`
ON `students`.`degree_id` = `degrees`.`id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze (1)
SELECT *
FROM `departments`
INNER JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze' 
AND `degrees`.`level` = 'Magistrale';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44) (11)
SELECT *
FROM `teachers`
JOIN `course_teacher` 
ON `course_teacher`.`teacher_id` = `teachers`.`id`
JOIN `courses` 
ON `course_teacher`.`course_id` = `courses`.`id`
WHERE `teachers`.`id` = 44;


-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT
`students`.`id` AS `student_id`,
`students`.`name`,
`students`.`surname`,
`students`.`fiscal_code`,
`students`.`enrolment_date`,
`students`.`registration_number`,

`degrees`.`id` AS `degree_id`,
`degrees`.`name` AS `degree_name`,
`degrees`.`level`,

`departments`.`id` AS `department_id`,
`departments`.`name` AS `department_name`

FROM `students`
JOIN `degrees`
ON `students`.`degree_id` = `degrees`.`id`
JOIN `departments`
ON `degrees`.`department_id` = `departments`.`id`
ORDER BY `students`.`surname`, `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti (1317)
SELECT 
`degrees`.`id` AS `degree_id`,
`degrees`.`name` AS `degree_name`,
`degrees`.`level`,

`courses`.`id` AS `course_id`,
`courses`.`name` AS `course_name`,
`courses`.`cfu`,
`courses`.`period`,

`teachers`.`id` AS `teacher_id`,
`teachers`.`name` AS `teacher_name`,
`teachers`.`surname` AS `teacher_surname`,
`teachers`.`office_number`

FROM `degrees`
JOIN `courses`
ON `courses`.`degree_id` = `degrees`.`id`
JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT
`teachers`.`id` AS `teacher_id`,
`teachers`.`name` AS `teacher_name`,
`teachers`.`surname` AS `teacher_surname`,
`teachers`.`office_number`,

`departments`.`id` AS `department_id`,
`departments`.`name` AS `department_name`

FROM `departments`
JOIN `degrees`
ON `degrees`.`department_id`=  `departments`.`id`
JOIN `courses`
ON `courses`.`degree_id`= `degrees`.`id` 
JOIN `course_teacher`
ON `course_teacher`.`course_id` = `courses`.`id`
JOIN `teachers`
ON `course_teacher`.`teacher_id` = `teachers`.`id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';


-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.
SELECT
`students`.`id` AS `student_id`,
`students`.`name`,
`students`.`surname`,

`exams`.`id` AS `exam_id`,
`exams`.`location`,
`exams`.`date`,
`exams`.`hour`,

COUNT(`exam_student`.`exam_id`) AS `attempts`,
MAX(`exam_student`.`vote`) AS `max_vote`

FROM `students`
JOIN `exam_student`
ON `exam_student`.`student_id` = `students`.`id`
JOIN `exams`
ON `exams`.`id` = `exam_student`.`exam_id`
GROUP BY `student_id`, `exam_id`;
-- HAVING MAX(`exam_student`.`vote`) >= 18;  ==> Se vogliamo filtrare i voti >= 18


/* QUERY CON GROUP BY */

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT YEAR(`enrolment_date`) AS `year`, 
COUNT(`id`) AS `number_of_students`
FROM `students`
GROUP BY `year`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT 
`office_address`,
COUNT(`id`) AS `teachers`
FROM `teachers`
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT
`exams`.`id` AS `exam_id`,
`exams`.`location`,
`exams`.`date`,
`exams`.`hour`,
AVG(`exam_student`.`vote`) AS `average_grade`
FROM `exams`
JOIN `exam_student`
ON `exams`.`id` = `exam_student`.`exam_id`
GROUP BY `exam_id`;



-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT
`departments`.`name` AS `department_name`,
COUNT(`degrees`.`id`) AS `number_of_degrees`
FROM `departments`
JOIN `degrees`
ON `degrees`.`department_id` = `departments`.`id`
GROUP BY `department_name`;
