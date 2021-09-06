-- find duplicate records in a table
SELECT DISTINCT DepartmentName, BaseRate, Count(*) as CNT
FROM dbo.DimEmployee
GROUP BY DepartmentName, BaseRate
HAVING count(*) > 1
ORDER BY BaseRate;

-- delete all the duplicate records in a table
WITH dup_count AS (
	SELECT DepartmentName,BaseRate,
		ROW_NUMBER() OVER (
		PARTITION BY
			DepartmentName, BaseRate
		ORDER BY 
			DepartmentName, BaseRate
		) row_num
	FROM dbo.DimEmployee
)
DELETE FROM dup_count WHERE row_num > 1 --This can be another way to find duplicate records in a table
										-- By using a SELECT statement;

-- find the manager name for the emplpyee
	--where the empid and manager id are on the same table
SELECT a.EmployeeKey, a.FirstName, a.Lastname, m.ParentEmployeeKey
FROM dbo.DimEmployee a
LEFT JOIN dbo.DimEmployee m
	ON a.EmployeeKey = m.EmployeeKey;

-- find the second highest BaseRate
SELECT * FROM dbo.DimEmployee where BaseRate in 
(SELECT max(BaseRate) as Base_rate
FROM dbo.DimEmployee
WHERE BaseRate < (Select max(BaseRate) from dbo.DimEmployee) );

-- find 3rd and Nth highest BaseRate
SELECT MIN(BaseRate) FROM -- OUTER QUERY
( SELECT DISTINCT TOP 3 BaseRate --INNER QUERY
	FROM dbo.DimEmployee
	ORDER BY BaseRate DESC
) AS O;
-- Here 3 van be changed to N; can be applied for any nuumber.
--1. Inner query -- Get the highest 3 base rates.
--2. Outer query -- Get the minimum base rate from those salaries.

--Find maximum salary from each department
SELECT DepartmentName, MAX(BaseRate) as BaseRate
FROM dbo.DimEmployee
GROUP BY DepartmentName;

-- Alternative for TOP clause in SQL
SELECT TOP 3 * FROM dbo.DimEmployee
--Alternative
SET ROWCOUNT 3
SELECT * from dbo.DimEmployee
SET ROWCOUNT 0


-- show single or same row from a tabel in results
SELECT DepartmentName FROM dbo.DimEmployee d WHERE d.DepartmentName = 'Engineering'
UNION ALL
SELECT DepartmentName FROM dbo.DimEmployee d WHERE d.DepartmentName = 'Engineering'

-- find a sales territory that have less than 3 sales reps
SELECT e.DepartmentName, s.SalesTerritoryRegion
FROM dbo.DimEmployee e
JOIN dbo.DimSalesTerritory s ON e.SalesTerritoryKey = s.SalesTerritoryKey
GROUP BY e.DepartmentName, s.SalesTerritoryRegion HAVING COUNT(EmployeeKey) < 3