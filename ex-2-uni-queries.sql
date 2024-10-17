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

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
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
-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.