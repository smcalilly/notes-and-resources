- what is the difference between reverse and reverse_lazy ?
- why does a invalid form response return a 200? shouldn't that be a 400? confusing as
- i read in two scoops of django to always backup your database before migration. how to do that with django + heroku?
- is there a way to debug the orm? how can i look at all the db queries that happen? i only ever see them when there's db error. is there a way to make sure my models/views aren't making a ton of requests at once...how do you diagnosis something like that?


## todo
- define tuple unpacking, how it raises an exception, and show the example code

save example of overriding the models.Model class to save:
```python
class ProjectCategory(models.Model):

    category = models.TextField(null=False)
    subcategory = models.TextField(null=True)
    name = models.TextField(null=False, default='project category')

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.id:
            if self.subcategory:
                self.name = f'{self.category} > {self.subcategory}'
            else:
                self.name = self.category

        super().save(*args, **kwargs)
 ```
