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

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.