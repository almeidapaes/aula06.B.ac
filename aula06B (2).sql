-- =========================================
-- QUESTÃO 01
-- User_B pode selecionar todos os atributos de INSTRUCTOR (menos salary)
-- e de TAKES (menos grade)
-- =========================================

-- Aqui usa-se SELECT por coluna, então lista-se tudo EXCETO o que foi proibido

GRANT SELECT (ID, name, dept_name)
ON INSTRUCTOR
TO User_B;
-- não incluí-se "salary", então ele não terá acesso a esse atributo

GRANT SELECT (ID, course_id, sec_id, semester, year)
ON TAKES
TO User_B;
-- não incluí-se "grade", então ele não poderá visualizar a nota



-- =========================================
-- QUESTÃO 02
-- User_C pode SELECT e UPDATE na tabela SECTION,
-- mas apenas nas colunas: course_id, sec_id, semester, year
-- =========================================

GRANT SELECT (course_id, sec_id, semester, year),
      UPDATE (course_id, sec_id, semester, year)
ON SECTION
TO User_C;
-- aqui limita-se tanto a consulta quanto a modificação
-- apenas às colunas especificadas



-- =========================================
-- QUESTÃO 03
-- User_D pode selecionar todos os atributos de INSTRUCTOR e STUDENT
-- e também pode acessar a VIEW grade_points
-- =========================================

GRANT SELECT
ON INSTRUCTOR
TO User_D;
-- sem especificar colunas = acesso a TODOS os atributos

GRANT SELECT
ON STUDENT
TO User_D;
-- mesma lógica: acesso completo

GRANT SELECT
ON grade_points
TO User_D;
-- grade_points é uma VIEW, mas funciona igual tabela no GRANT



-- =========================================
-- QUESTÃO 04
-- User_E pode ver STUDENT, mas SOMENTE onde dept_name = 'Civil Eng.'
-- =========================================

-- Não dá pra fazer isso direto com GRANT
-- então cria-se uma VIEW com filtro

CREATE VIEW student_civil_eng AS
SELECT *
FROM STUDENT
WHERE dept_name = 'Civil Eng.';
-- essa view já filtra apenas os alunos de Engenharia Civil

GRANT SELECT
ON student_civil_eng
TO User_E;
-- o usuário só terá acesso a essa visão filtrada



-- =========================================
-- QUESTÃO 05
-- Revogar os privilégios do User_E
-- =========================================

REVOKE SELECT
ON student_civil_eng
FROM User_E;
-- remove o acesso que foi concedido anteriormente



-- =========================================
-- QUESTÃO 06
-- Mostrar os privilégios dos usuários
-- (SQL Server / Azure)
-- =========================================

SELECT 
    dp.name AS UserName,              -- nome do usuário
    dp.type_desc AS UserType,         -- tipo do usuário
    o.name AS ObjectName,             -- tabela ou view
    p.permission_name AS Permission,  -- tipo de permissão (SELECT, UPDATE, etc)
    p.state_desc AS PermissionState   -- estado (GRANT ou DENY)
FROM sys.database_permissions p
JOIN sys.objects o ON p.major_id = o.object_id
JOIN sys.database_principals dp ON p.grantee_principal_id = dp.principal_id
WHERE dp.name IN ('User_A', 'User_B', 'User_C', 'User_D', 'User_E');
-- esse SELECT mostra tudo que foi concedido para esses usuários
