# two scoops of django

## models

### break up apps with too many models
if there are 20+ models in a single app, think about ways to break it down into smaller apps

as a practice, we like to lower this number to no more than 5-10 models per app

### be careful with model inheritance
django has three ways to do model inheritance

1. abstract base classes
  tables are only created for derived models. having common fields in an abstract parent class saves us from typing them more than once. we don't get the overhead of extra tables and joins that are incurred from multi-table inheritance. cons: we can't use the parent class in isolation
2. multi-table inheritance
  tables are created for both parent and child. an implied onetoonefield links parent and child. pros: gives each model its own table, so that we can query either parent or child model. also gives us the ability to get a child object from a parent object: `parent.child`. cons: adds substantial overhead since each query on a child table requires a join with the parent table. **authors strongly recommend against using multi-table inheritance**
3. proxy models: a table is only created for the original model
  - pros: allows us to have an alias of a model with different python behavior
  - cons: cannot change the model's fields
4. no model inheritance: if models have a common field, give both models that field.
  - pros: makes it easier to understand at a glance how django models map to database tables
  - cons: if there are a lot of fields duplicated across models, this can be hard to maintain

**WARNING: avoid multi-table inheritance**. see page 65 for details, plus more guidance on when to use model inheritance.

### 6.2 database migrations

#### tips & tricks
- create the initial migration as soon as a new app or model is created
- examine the generated migration code before you run it, especially when complex changes are involved. also, review the SQL that will be used with the `sqlmigrate` command
- use the `MIGRATION_MODULES` setting to manage writing migrations for third-party apps that don't have their own `django.db.migrations`-styl migrations
- don't worry about how many migrations are created. if the number of migrations becomes unwieldy, use `squashmigrations` to bring them to heel.
- always back up your data before running a migration!

#### adding python functions and custom SQL to migrations
good to know in case of complex migrations. p. 67.

#### deployment and management of migrations
- **always back up your data before running a migration**
- before deployment, check that you can rollback migrations!
- if a table has millions of row, do extensive tests against data of that size on staging servers before running a migration on a production server. migrations can take a long time on real data.
- if you are running mysql, see the points in p70

Always put data migration code into source control!
(duh?)

### django model design
- start normalized. take the time to make sure that no model should contain data already stored in another model. use relationship fields liberally. don't denormalize prematurely. you want to have a good sense of the shape of your data.

denormalize only if absolutely necessary! explore cacheing before denormalization.

#### when to use null and blank
by default, they are False
see a good table on p73

#### when to use BinaryField
this field allows for the storage of raw binary data or bytes. we can't perform filters, excludes, or other sql on the field, but there are some use cases for it:
- MessagePack-formatted content (?)
- Raw sensor data
- compressed data, e.g. the type of data sentry stores as a BLOB, but is required to base64-encode due to legacy issues

possibilities are endless, but remember that binary data can come in huge chunks which can slow down databases. if this occurs and becomes a bottleneck, the solution might be to save the binary data in a file and reference it with a `FileField`

warning! don't serve files from BinaryField
storing files in a database field should never happen.
using a db as a file store has these problems:
- read/write to a DB is always slower than a filesystem
- you DB backups grow to be huge and more time consuming
- access to the files now requires going through your app and DB layers

#### try to avoid using generic relations
authors advocate against generic relations and use of `models.field.GenericForeignKey`. usually more trouble than the worth. using them is a code smell.

#### make choices and sub-choices model constants
these are constants tied to your model and they're easy to access where needed
because they're an attribute on the model class

#### using enumeration types for choices
see p76 for code example
