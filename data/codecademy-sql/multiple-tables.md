# Multiple Tables
relational database, split the table for efficiency and to reduce repetition, more manageable

## JOIN
combine tables with `JOIN`.

combine an `orders` and `customers` table:
```sql
SELECT * 
FROM orders 
JOIN customers 
ON orders.customer_id 
= customers.customer_id;
```
- first line selects all columns from the combined table.
- second line specifies the first table that we want to look in, `orders`
- third line uses `JOIN` to say that we want to combine information from `orders` with `customers`
- fourth line tells us how to combine the two tables. we want to match `orders` table's `customer_id` column with `customers` table's `customer_id` column.

they told me to do this:
```sql
SELECT * FROM orders JOIN subscriptions ON orders.subscription_id = subscriptions.subscription_id;
```

in my own words, i'm joining orders and subscriptions, where the subscription_id is the same in both tables, selecting all columns.

> Add a second query after your first one that only selects rows from the join where description is equal to ‘Fashion Magazine’.
```sql
SELECT * FROM orders JOIN subscriptions ON orders.subscription_id = subscriptions.subscription_id WHERE subscriptions.description = 'Fashion Magazine';
```

## INNER JOINS
```sql
SELECT COUNT(*) FROM newspaper JOIN online ON newspaper.id = online.id;
```

## LEFT JOINS
what if we want to combine two tables and keep some of the un-matched rows?

left join!

a left join will keep all rows from the first table, regardless whether there is a matching row in the second table.
```sql
SELECT *
FROM table1
LEFT JOIN table2
  ON table1.c2 = table2.c2;
```

```SQL
SELECT * FROM newspaper LEFT JOIN online ON newspaper.id = online.id;

SELECT * FROM newspaper LEFT JOIN online ON newspaper.id = online.id WHERE online.id IS NULL;
```

## Primary Key vs Foreign Key
primary key:
- none of the values can be null
- each value must be unique
- a table cannot have more than one primary key column

when a primary key for one table appears in another table, it's called a **foreign key**.

> why is this important? the most common types of joins will be joining a foreign key from one table with the primary key from another table.

a typical relational database lookup:
```sql
SELECT * FROM classes INNER JOIN students ON classes.id = students.class_id;
```

## CROSS JOIN
sometimes, we just want to combin all rows of one table with all rows of another table.

```sql
SELECT COUNT(*) FROM newspaper WHERE start_month <= 3 AND end_month >= 3;

SELECT * FROM newspaper CROSS JOIN months;

SELECT * FROM newspaper CROSS JOIN months WHERE start_month <= month AND end_month >= month;

SELECT month, COUNT(*)
FROM newspaper
CROSS JOIN months
WHERE start_month <= month AND end_month >= month
GROUP BY month;
```

## UNION
> sometimes we want to stack one dataset on top of the other.
> SQL has strict rules for appending data:

   > Tables must have the same number of columns.
   > The columns must have the same data types in the same order as the first table.

```sql
SELECT * 
FROM newspaper 
UNION 
SELECT * 
FROM online;
```

## WITH
often, we want to combine two tables, but one of the tables is the result of another calculation.

how many magazines does each customer subscribe to?
```sql
SELECT customer_id COUNT(subscription_id) AS 'subscriptions'
FROM orders
GROUP BY customer_id;
```

customer_id isn't useful for the marketing department, so use that to find the customer's name.

> We want to be able to join the results of this query with our customers table, which will tell us the name of each customer. We can do this by using a WITH clause.
```sql
WITH previous_results AS (
   SELECT ...
   ...
   ...
   ...
)
SELECT *
FROM previous_results
JOIN customers
  ON _____ = _____;
```
- `WITH` statement allows us to perform a separate query (such as aggregating customer's subscriptions)
- `previous_results` is the alias that we will use to reference any columns from the query inside of the `WITH` clause.
- > We can then go on to do whatever we want with this temporary table (such as join the temporary table with another table)

> Essentially, we are putting a whole first query inside the parentheses () and giving it a name. After that, we can use this name as if it’s a table and write a new query using the first query.

amazing! (Q: performance?)

```sql
WITH previous_results AS (
  SELECT customer_id, COUNT(subscription_id) AS 'subscriptions' FROM orders GROUP BY customer_id
) 
SELECT customers.customer_name, previous_results.subscriptions 
FROM previous_results
JOIN customers
ON previous_results.customer_id = customers.customer_id;
```

> JOIN will combine rows from different tables if the join condition is true.
> LEFT JOIN will return every row in the left table, and if the join condition is not met, NULL values are used to fill in the columns from the right table.
> Primary key is a column that serves a unique identifier for the rows in the table.
> Foreign key is a column that contains the primary key to another table.
> CROSS JOIN lets us combine all rows of one table with all rows of another table.
> UNION stacks one dataset on top of another.
> WITH allows us to define one or more temporary tables that can be used in the final query.

