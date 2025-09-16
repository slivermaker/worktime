select s.* from Student s where s.student_id in (select student_id from studentcourse sc where sc.course_id = 0 and sc.score = 100 ) 
