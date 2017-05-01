-- --Вставка в EMP
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7369, 'SMITH',    'CLERK', 7902, '12-17-1980',  800, NULL, 20);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '02-20-1981', 1600,  300, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7521,  'WARD', 'SALESMAN', 7698, '02-22-1981', 1250,  500, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7566, 'JONES',  'MANAGER', 7839, '03-02-1981', 2975, NULL, 20);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7654,'MARTIN', 'SALESMAN', 7698, '09-28-1981', 1250, 1400, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7698, 'BLAKE',  'MANAGER', 7839, '05-01-1981', 2850, NULL, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7782, 'CLARK',  'MANAGER', 7839, '06-09-1981', 2450, NULL, 10);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7788, 'SCOTT',  'ANALYST', 7566, '12-01-1982', 3000, NULL, 20);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7839,  'KING','PRESIDENT', NULL, '11-17-1981', 5000, NULL, 10);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7844,'TURNER', 'SALESMAN', 7698, '09-08-1981', 1500,    0, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7876, 'ADAMS',    'CLERK', 7788, '01-12-1983', 1100, NULL, 20);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7900, 'JAMES',    'CLERK', 7698, '12-03-1981',  950, NULL, 30);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7902,  'FORD',  'ANALYST', 7566, '12-03-1981', 3000, NULL, 20);
-- INSERT INTO "EMP" ("EMPNO", "ENAME", "JOB", "MGR", "HIREDATE", "SAL", "COMM", "DEPTNO") VALUES (7934,'MILLER',    'CLERK', 7782, '01-23-1983', 1300, NULL, 10);
--
-- --Вставка в DEPT
-- INSERT INTO "DEPT" ("DEPTNO", "DNAME", "LOC") VALUES (10, 'ACCOUNTING', 'NEW YORK');
-- INSERT INTO "DEPT" ("DEPTNO", "DNAME", "LOC") VALUES (20, 'RESEARCH', 'DALLAS');
-- INSERT INTO "DEPT" ("DEPTNO", "DNAME", "LOC") VALUES (30, 'SALES', 'CHICAGO');
-- INSERT INTO "DEPT" ("DEPTNO", "DNAME", "LOC") VALUES (40, 'OPERATIONS', 'BOSTON');
--
-- --Вставка в SALGRADE
-- INSERT INTO "SALGRADE" ("GRADE", "LOSAL", "HISAL") VALUES (1,  700, 1200);
-- INSERT INTO "SALGRADE" ("GRADE", "LOSAL", "HISAL") VALUES (2, 1201, 1400);
-- INSERT INTO "SALGRADE" ("GRADE", "LOSAL", "HISAL") VALUES (3, 1401, 2000);
-- INSERT INTO "SALGRADE" ("GRADE", "LOSAL", "HISAL") VALUES (4, 2001, 3000);
-- INSERT INTO "SALGRADE" ("GRADE", "LOSAL", "HISAL") VALUES (5, 3001, 9999);

--1.Вывести фамилии всех сотрудников и отделы в которых они работают.
-- SELECT "EMP"."ENAME", "DEPT"."DNAME"
-- FROM "EMP","DEPT"
-- WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"

--2.Вывести фамилии, должности и зарплаты сотрудников, которым не положены комисcионные.
-- SELECT "ENAME", "JOB", "SAL"
-- FROM "EMP"
-- WHERE "COMM" IS NULL

--3.Вывести количество сотрудников и среднюю зарплату в 20 отделе.
-- SELECT count("ENAME") as "EMP_COUNT", avg("SAL") as "SAL_AVG"
-- FROM "EMP"
-- WHERE "DEPTNO"=20

--4.Вывести отделы в которых больше 3-х сотрудников. Посчитать количество сотрудников в таких отделах.
-- SELECT "DEPT"."DNAME", count("EMP"."DEPTNO") as "DNAME_COUNT"
-- FROM "EMP","DEPT"
-- WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
-- GROUP BY "DEPT"."DNAME"
-- HAVING count("EMP"."DEPTNO")>3

--5.Выведите фамилии сотрудников, название их отделов, города расположения отделов, зарплату сотрудников и уровень их зарплаты.
--Отсортировать результат в порядке возрастания уровня зарплаты, если уровень зарплаты совпадает, то по зарплате.
-- SELECT "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL"
-- FROM "EMP","DEPT","SALGRADE"
--
-- SELECT "SALGRADE"."GRADE"
-- FROM "EMP","SALGRADE"
-- WHERE "SALGRADE"."LOSAL">="EMP"."SAL" OR "SALGRADE"."HISAL"<="EMP"."SAL"


-- SELECT * FROM
-- (SELECT "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC"
-- FROM "EMP","DEPT","SALGRADE"
-- WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
--
-- UNION
--
-- SELECT "EMP"."SAL","SALGRADE"."GRADE"
-- FROM "EMP","SALGRADE"
-- WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as alias
-- GROUP BY "EMP"."ENAME"

-- Select * from (SELECT "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL" as sal
--                FROM "EMP","DEPT","SALGRADE"
--                WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
--                GROUP BY "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL") as t1
--   LEFT JOIN (SELECT "EMP"."SAL" as sal,"SALGRADE"."GRADE"
--              FROM "EMP","SALGRADE"
--              WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as t2 ON t1.sal=t2.sal


-- Select * from (SELECT "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL" as sal
--                FROM "EMP","DEPT","SALGRADE"
--                WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
--                GROUP BY "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL") as t1
--   LEFT JOIN (SELECT "EMP"."SAL" as sal,"SALGRADE"."GRADE"
--              FROM "EMP","SALGRADE"
--              WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as t2 ON t1.sal=t2.sal
--
--


--
--
-- Select * from (SELECT "EMP"."ENAME" as ename,"DEPT"."DNAME" as dname,"DEPT"."LOC" as loc,"EMP"."SAL" as sal
--                FROM "EMP","DEPT","SALGRADE"
--                WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
--                GROUP BY "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL") as t1
--   LEFT JOIN (SELECT "EMP"."SAL" as sal,"SALGRADE"."GRADE" as grade
--              FROM "EMP","SALGRADE"
--              WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as t2 ON t1.sal=t2.sal
-- GROUP BY t1.ename, t1.dname, t1.loc, t1.sal, t2.sal, t2.grade
--

--
-- Select t1.ename,t1.dname, t1.loc, t1.sal, t2.grade from (SELECT "EMP"."ENAME" as ename,"DEPT"."DNAME" as dname,"DEPT"."LOC" as loc,"EMP"."SAL" as sal
--               FROM "EMP","DEPT","SALGRADE"
--               WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
--               GROUP BY "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL") as t1,
--   (SELECT "EMP"."SAL" as sal,"SALGRADE"."GRADE" as grade
--    FROM "EMP","SALGRADE"
--    WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as t2
-- GROUP BY t1.ename,t1.dname, t1.loc, t1.sal, t2.grade
--
--


SELECT t1.ename,t1.dname, t1.loc, t1.sal, t2.grade
FROM
  (SELECT "EMP"."ENAME" as ename,"DEPT"."DNAME" as dname,"DEPT"."LOC" as loc, "EMP"."SAL" as sal
   FROM "EMP","DEPT","SALGRADE"
   WHERE "EMP"."DEPTNO"="DEPT"."DEPTNO"
   GROUP BY "EMP"."ENAME","DEPT"."DNAME","DEPT"."LOC","EMP"."SAL") as t1,
  (SELECT "SALGRADE"."GRADE" as grade
   FROM "EMP","SALGRADE"
   WHERE "EMP"."SAL" BETWEEN "SALGRADE"."LOSAL" AND "SALGRADE"."HISAL") as t2
GROUP BY t1.ename,t1.dname, t1.loc, t1.sal, t2.grade

