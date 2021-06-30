# Aggregate Functions
calculations performed on multiple rows of a table are called **aggregates**.

a quick look at some important aggregates:
- `COUNT()`: count the number of rows
- `SUM()`: the sum of the values in a column
- `MAX()`/`MIN()`: the largest/smallest value
- `AVG()`: the average values in a column
- `ROUND()`: round the values in the column

## COUNT
fastest way to calculate how many rows are in a table.

`COUNT()` takes the name of the column as an argument and counts the number of non-empty values in that column.

```sql
SELECT COUNT(*) FROM fake_apps;

SELECT COUNT(*) FROM fake_apps WHERE price = 0.0;
```

## SUM
SQL makes it easy to add all vaues in a column with `SUM()`.

`SUM()` takes the name of a column as an argument and returns the sum of all the values in that column.

```sql
SELECT SUM(downloads) FROM fake_apps;
```

## MAX / MIN
return the highest and lowest values in a column.

```sql
SELECT MAX(price) FROM fake_apps;
```

## AVERAGE
quickly calculate the average value of a particular column. 

```sql
SELECT AVG(downloads) FROM fake_apps;
```

## ROUND
SQL tries to be as precise as possible without rounding. we can make the result table easier to read using the `ROUND()` function.

it takes two arguments inside the parenthesis:
1. column name
2. integer. it rounds the values in the column to the number of decimal places specified by the integer.

round the results of an average:
```sql
SELECT ROUND(AVG(price), 2) FROM fake_apps;
```

## GROUP BY, pt. 1
lets us aggregate multiple results. say you want to find the average imdb rating for each year, you can use group by.

- `GROUP BY` is a clause that is used with aggregate functions. used in collaboration with the `SELECT` statement to arrange identical data into groups.
- `GROUP BY` statement comes after any `WHERE` statements, but before `ORDER BY` or `LIMIT`.

this selects price and counts how many rows in which the price exists, and then groups by price.
```sql
SELECT price, COUNT(*) FROM fake_apps GROUP BY price;
```

> write a new query that calculates the total number of downloads for each category
```sql
SELECT category, SUM(downloads) FROM fake_apps GROUP BY category;
```

## GROUP BY, pt. 2
> Sometimes, we want to `GROUP BY` a calculation done on a column. 

we can use column reference(s) in our `GROUP BY`:
- `1` is the first column selected
- `2` is the second column selected
- `3` is the third column selected

```SQL
SELECT category, price, AVG(downloads) FROM fake_apps GROUP BY 1, 2;
```
1 = `category` and 2 = `price`.

## HAVING
lets us filter the groups. see:
```sql
SELECT year,
   genre,
   COUNT(name)
FROM movies
GROUP BY 1, 2
HAVING COUNT(name) > 10;
```
> When we want to limit the results of a query based on values of the individual rows, use WHERE.
> When we want to limit the results of a query based on an aggregate property, use HAVING. 
> HAVING statement always comes after GROUP BY, but before ORDER BY and LIMIT.

```sql
SELECT price, 
   ROUND(AVG(downloads)),
   COUNT(*)
FROM fake_apps
GROUP BY price HAVING COUNT(price) > 10;
```
