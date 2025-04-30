SELECT student_id
FROM students
JOIN courses USING (major)
LEFT JOIN enrollments USING (student_id, course_id)
GROUP BY student_id
HAVING SUM(grade='A') = COUNT(major)
ORDER BY student_id
