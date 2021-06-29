# SQL Queries
asking the table for things

## SELECT
```sql
SELECT column1, column2 FROM table_name;
```

## AS
```sql
SELECT name AS 'Titles' FROM movies;
```
- `AS` keyword allows you to rename a column or table using an alias
- doesn't rename the column, it's only the column's alias in the result

## DISTINCT
it can be helpful to know what *distinct* values exist, so `DISTINCT` is used to return unique values in the output.
```sql
SELECT DISTINCT genre FROM movies;
```
- the movies table has a ton of rows of unique movies, but only a certain amount of genres, which might be duplicated across rows. so you want a list of genres by selecting the distinct genre from the table

## WHERE
restrict the query results with `WHERE` clause
```sql
SELECT *
FROM movies
WHERE imdb_rating > 8;
```
> The > is an operator. Operators create a condition that can be evaluated as either true or false.
> Comparison operators used with the WHERE clause are:
>   - `=` equal to
>   - `!=` not equal to
>   - `>` greater than
>   - `<` less than
>   - `>=` greater than or equal to
>   - `<=` less than or equal to


## LIKE, pt. 1
```sql
SELECT * FROM movies
WHERE name LIKE 'Se_en';
```
> The _ means you can substitute any individual character here without breaking the pattern. The names Seven and Se7en both match this pattern.

## LIKE, pt. 2
percentage sign `%` is another wildcard character to use with `LIKE`
```sql
SELECT * FROM movies WHERE name LIKE 'A%';
```
- that will find all movies where the name starts with an A
- you can use it at the front or end of the pattern, or both, like `%man%`
- it's not case sensitive

this finds all the movies that have the word `man`:
```sql
SELECT * FROM movies WHERE name LIKE '%man%';
```

this finds all the movies that start with `The`:
```sql
SELECT * FROM movies WHERE name LIKE 'The %';
```

## IS NULL
can't test for `NULL` with `=` or `!=`, instead use:
- `IS NULL`
- `IS NOT NULL`

```sql
SELECT name FROM movies WHERE imdb_rating IS NULL;
```

## BETWEEN
`BETWEEN` operator is used in a `WHERE` clause to filter the results within a certain range. it accepts two values that are either numbers, text, or dates.
```sql
SELECT * FROM movies WHERE year BETWEEN 1990 AND 1999;
```
- when the values are text, `WHERE` filters the result within the alphabetical range. this is kinda confusing:
> When the values are text, BETWEEN filters the result set for within the alphabetical range.

> In this statement, BETWEEN filters the result set to only include movies with names that begin with the letter ‘A’ up to, but not including ones that begin with ‘J’.

> `SELECT * FROM movies WHERE name BETWEEN 'A' AND 'J';`

> However, if a movie has a name of simply ‘J’, it would actually match. This is because BETWEEN goes up to the second value — up to ‘J’. So the movie named ‘J’ would be included in the result set but not ‘Jaws’.

## AND
lets you combine multiple conditions within a `WHERE` clause
```sql
SELECT * 
FROM movies
WHERE year BETWEEN 1990 AND 1999
   AND genre = 'romance';
```

## OR
kinda like `AND` but different:
- `AND` displays a row if all the conditions are true
- `OR` displays a row if any of the conditions are true
```sql
SELECT * FROM movies WHERE genre = 'romance' OR genre = 'comedy';
```
that's it for the `WHERE` operators

## ORDER BY
it's useful to return the results in a specific order. `ORDER BY` lets us sort alphabetically or numerically
```sql
SELECT *
FROM movies
ORDER BY name;
```

sometimes you want it in decreasing order
```sql
SELECT name, year, imdb_rating FROM movies ORDER BY imdb_rating DESC;
```
- `DESC` after the column lets you order by desc

> DESC is a keyword used in ORDER BY to sort the results in descending order (high to low or Z-A).
> ASC is a keyword used in ORDER BY to sort the results in ascending order (low to high or A-Z).

> Note: ORDER BY always goes after WHERE (if WHERE is present).

## LIMIT
lets you specify how many rows to return. always goes at the end of the query. not supported in all sql databases.
```SQL
SELECT * FROM movies ORDER BY imdb_rating DESC LIMIT 3;
```

## CASE
allows us to create different outputs. SQL's way of doing if/then. for example:
```sql
SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END
FROM movies;
```

that query creates a long column name. shorten it using `AS`:
```SQL
SELECT name,
 CASE
  WHEN imdb_rating > 8 THEN 'Fantastic'
  WHEN imdb_rating > 6 THEN 'Poorly Received'
  ELSE 'Avoid at All Costs'
 END AS 'Review'
FROM movies;
```

## conclusion
Let’s summarize:

    > SELECT is the clause we use every time we want to query information from a database.
    > AS renames a column or table.
    > DISTINCT return unique values.
    > WHERE is a popular command that lets you filter the results of the query based on conditions that you specify.
    > LIKE and BETWEEN are special operators.
    > AND and OR combines multiple conditions.
    > ORDER BY sorts the result.
    > LIMIT specifies the maximum number of rows that the query will return.
    > CASE creates different outputs.

