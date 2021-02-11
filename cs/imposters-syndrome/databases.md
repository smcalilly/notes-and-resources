# notes from the imposter's handbook

## database normalization
"there is an established way to design a transactional database: following the rules of normalization"
normalization is all about controlling the size of the data, as well as preserving its validity.

### first normal form (1NF): atomic values
1NF says that values in a record need to be atomic and not composed of embedded arrays "or some such"

say you have a food truck and you sell tacos and coke to a customer and then record that transaction, all lumped together. 1NF would seperate the transactions for each item and have an order_id for the single transaction. these records are "atomic"

## second normal form (2NF)
columns depend on a single primary key

from the previous table, need to identify columsn that uniquely define the data in our table. so you'd split the sale and the customer to different tables. it's not quite there, so next

## third normal form (3NF)
non-keys describe the key and nothing else

hard to describe in writing but it's associating the orders with order_items. order items belong to an order and an order has many order items. one to one relationship with customer and orders. one to one between products and orders_items. an order can have many products through an order item (would that be the way to describe?)
- **customers** hold all customer data
- **orders** holds meta data related to a sale (who, when, where, etc)
- **order_items** holds the items bought in an order
- **products** holds the items to be bought

## normalization in the real world
requires some practice. like modeling classes and objects -- what attributes belong to which concept?

however, the rules of normalization are more of guideline. "a well-normalized database may be theoritically sound, but it will also be kind of hard to work with"

don't build a massively complex database with intricate lookups, foreign keys, and constraints. this complexity presents two problems:
- writing querys to read and write data is cumbersome and often error-prone
- the more joins you have, the slower the query is

the bigger the system gets, the more DBAs tend to cut corners and denormalize. shows an example from a stackoverflow table. "so they denormalized it. many businesses do - it just makes things faster and simpler." 

## is this schema correct?
from our example?

no, the `order_items` table is what's known as a "slowly-changing historical table". the data is not transactional, it's a matter of record. so what do you do if don't want to change the past?

## OLAP and OLTP
Online Transaction Processing - this type of system is based on performance -- many reads, writes, and deletes. 

at some point, you're going to want to analyze your data, which is where OLAP comes in: 

Online Analytical Processing - these systems are low-transaction systems that change little, if at all, over time apart from nightly/weekly loads. these systems power data warehouses and support data mining

the structure of each system varies quite a lot. OLTP systems are relational in nature and are structured using the rules of normalization

OLAP systems are heavily denormalized and are structured with dimensional analysis in mind. Building these sytems can take hours and usually happens on a nightly basis

## Extraction, Transformation, and Loading (ETL)
- the first step is to extract the information you want from your OLTP system (and/or other sources) and comb through it for any errors
- then transform as required, like reconciling customer information with your CRM system so you can add history data, account numbers, location information, etc
- finally, you load the data into your system, which is usually another database that has a special layout (like Microsoft SQL Server Analytics Services)

today, you can perform quite complicated ETL tasks efficiently and simply by using a set of simple scripts. these can be as simple as shell scripts or more commonly, complex with Python or Ruby or whatever languge. Python is a popular ETL language

## Data Marts and Warehouses
you might hear these terms used interchangeably, but they're two very different things
- a data warehouse is like a filing cabinet in your office or at home where you keep all of your financial information
- a data mart would be a place that can answer questions about the data. we could use the warehouse but that wouldn't be as efficient

### data mart schema
excel spreadsheet is a good way to think of how data is stored in a data mart: flattened

the fact table, which represents the single fact. a snowflake scehema is the same, but the dimension tables themselves have more dimensions
what?

### dimensions
analytics is difficult. return here when you need to, so you have some things to look up, but "the point is: pick your dimensions with care and make sure you involve the people who are using the reports you'll generate"

## for real
come back here for data analysis. "cross checking" is all a part of ETL. Bad data should never make it into your data warehouse/data mart.

page 329
