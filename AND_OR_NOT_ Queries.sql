
/*
Exercise 4.1
Get a list of products with at least ten but less than twenty units in stock. Show the stock
levels in your results.

Filtering results on a range is just one use for “AND”. You can also use it to filter results
on separate fields, as in the next exercises.

*/

SELECT ProductName, UnitsInStock
FROM dbo.Products
WHERE UnitsInStock >=10 AND UnitsInStock <=20;


/*
Exercise 4.2
Get the records for orders shipped to Brazil from 1997 onwards.
*/

SELECT *
FROM Orders
WHERE ShipCountry = 'Brazil' 
AND OrderDate >= '1997-01-01';

/* 
Exercise 4.3
Get the orders shipped to Brazil in 1997 (you can use “AND” as many times as you like,
just keep adding the operator followed by its condition to the end of your “WHERE”
clause).
*/

SELECT *
FROM dbo.Orders
WHERE ShipCountry = 'Brazil'
AND OrderDate >= '1997-01-01'
AND OrderDate < '1998-01-01';