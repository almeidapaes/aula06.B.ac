-- 1

GRANT SELECT (ID, name, dept_name) 
ON INSTRUCTOR 
TO User_B;

GRANT SELECT (ID, course_id, sec_id, semester, year) 
ON TAKES 
TO User_B;

-- 2

GRANT SELECT (course_id, sec_id, semester, year),
      UPDATE (course_id, sec_id, semester, year)
ON SECTION
TO User_C;

-- 3

GRANT SELECT 
ON INSTRUCTOR 
TO User_D;

GRANT SELECT 
ON STUDENT 
TO User_D;

GRANT SELECT 
ON grade_points 
TO User_D;

-- 4

CREATE VIEW student_civil_eng AS
SELECT *
FROM STUDENT
WHERE dept_name = 'Civil Eng.';

GRANT SELECT 
ON student_civil_eng 
TO User_E;

-- 5

REVOKE SELECT 
ON student_civil_eng 
FROM User_E;


-- 6

SELECT 
    dp.name AS UserName,
    dp.type_desc,
    o.name AS ObjectName,
    p.permission_name,
    p.state_desc
FROM sys.database_permissions p
JOIN sys.objects o ON p.major_id = o.object_id
JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
WHERE dp.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E');