# SQL intro 
[on codecademy](https://www.codecademy.com/courses/learn-sql)

## Lesson 1

### types
- `REAL` is a decimal value

### statement
break down this statement:
```sql
CREATE TABLE table_name (
   column_1 data_type, 
   column_2 data_type, 
   column_3 data_type
);
```

- `CREATE TABLE` is a **clause**. can also be referred to as a command
- `table_name` is the table on which the clause is operating
- `(column_1 data_type, column_2 data_type, column_3 data_type)` is a **parameter**. parameter is a list of columns, types, or values


### CREATE
create clause creates a new table

```sql
CREATE TABLE celebs (
   id INTEGER, 
   name TEXT, 
   age INTEGER
);
```

- `CREATE_TABLE` is a clause that creates a new table
- the new table is called `celebs`
- the table has these columns: id (integer), name (text), age (integer)

### INSERT
insert a new row in a table

```sql
 INSERT INTO celebs (id, name, age)
 VALUES (1, 'Justin Bieber', 22); /*  (wow he's not a kid anymore) */
 ```

 - `INSERT INTO` is a clause that adds the specified row(s)
 - `(id, name, age)` is a parameter identifying the columns for the data
 - `VALUES` is the clause to identify the data that is being inserted
 - `(1, 'Justin Bieber', 22)` is a parameter identifying the values being inserted

### SELECT
*
"wildcard"

- `SELECT` statements always return a new table called the **result set**

### ALTER
```sql
ALTER TABLE celebs
ADD COLUMN twitter_handle TEXT;
```
- `ALTER TABLE` - a clause to make a change to a table
- `ADD COLUMN` - a clause to add a new column to a table

`NULL`, in SQL, represents missing or unknown data. with the above alter clause, the existing rows will have `NULL` values for the `twitter_handle` column

### UPDATE
```sql
 UPDATE celebs
 SET twitter_handle = '@taylorswift13'
 WHERE id = 4;
```

- `UPDATE` - a clause to edit a row in a table
- `SET` - a clause to indicate the name of the column to edit
- `WHERE` - a clause to indicate which row to update with the new column value

### DELETE
```sql
 DELETE FROM celebs
 WHERE twitter_handle IS NULL;
 ```
 - `DELETE FROM` - clause to delete rows from a table
 - `WHERE` - clause to select which rows you want to delete
 - `IS NULL` - condition in SQL that returns true when the value is `NULL` or false otherwise

### Constraints
constraints add information about the column. lets you tell the database to reject inserted data that doesn't adhere to the constraint.

```sql
CREATE TABLE celebs (
   id INTEGER PRIMARY KEY, 
   name TEXT UNIQUE,
   date_of_birth TEXT NOT NULL,
   date_of_death TEXT DEFAULT 'Not Applicable'
);
```
- `PRIMARY KEY` - uniquely identify a row
- `UNIQUE` - a column that requires a unique value for every row. kinda like a pk but can be for multiple columns in a row.
- `NOT NULL` - column that must have a value. "Attempts to insert a row without a value for a NOT NULL column will result in a constraint violation and the new row will not be inserted."
- `DEFAULT` - sets that value if the inserted row doesn't have a value for that column

### conclusion
SQL is a programming language  
designed to manipulate and manage  
data stored in relational databases  

relational database is a database that organizes information into one or more tables  
table is a collection of data organized into rows and columns

> A statement is a string of characters that the database recognizes as a valid command.

>     CREATE TABLE creates a new table.
>     INSERT INTO adds a new row to a table.
>     SELECT queries data from a table.
>     ALTER TABLE changes an existing table.
>     UPDATE edits a row in a table.
>     DELETE FROM deletes rows from a table.

> Constraints add information about how a column can be used. 
