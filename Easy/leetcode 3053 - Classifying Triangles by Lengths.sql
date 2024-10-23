WITH cte AS
(SELECT *, CASE WHEN a+b>c AND b+c>a AND a+c>b THEN 'Yes' ELSE 'No' END AS is_triangle
FROM Triangles)

SELECT CASE WHEN is_triangle='Yes' AND a=b AND b=c THEN 'Equilateral'
WHEN is_triangle='Yes' AND a<>b AND b<>c AND a<>c THEN 'Scalene'
WHEN is_triangle='Yes' AND ((a=b AND b<>c) OR (b=c AND c<>a) OR (a=c AND a<>b)) THEN 'Isosceles'
WHEN is_triangle='No' THEN 'Not A Triangle'
END AS triangle_type
FROM cte 