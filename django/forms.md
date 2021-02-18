# forms

## form and field validation
[words re-typed from here](https://docs.djangoproject.com/en/3.2/ref/forms/validation/)

form validation happens when the data is cleaned. if you want to customize this process, there are various places to make changes, each one serving a different purpose. three types of cleaning methods are run during form processing. these are normally executed whn you called the `is_valid()` method on the form. 

in general, any cleaning methods can raise a `ValidationError` if there is a problem with the data it is processing. this will pass the relevant info to the `ValidationError` constructor. if no `ValidationError` is raised, the method should return the cleaned data as a python object.

most validation can be done using validators -- helpers that can be reused. validators are functions that take a single argument and raise `ValidationError` on invalid input. validators are run after the field's `to_python` and `validate` methods have been called.

validation of a form is split into several steps:
- `to_python()` method on a Field is the first step of every validation. it coerces the values to a correct datatype and raises validation error if that's not possible. this method accepts the raw value from the widget and returns the convert value.
- the `validate()` method on a field handles field-specific validation that is not suitable for a validator. it takes a value that has been coeerced to the correct datatype and raises a validation error on any error. this method does not return anything and shouldn't alter the value. you should override it to handle validation logic that you can't or don't want to put in a validator.
- `run_validators()` method on a field runs all of the field's validators and aggregates all the errors into a single validation error. you shouldn't need to override this method.
- the `clean()` method on a field subclass is responsible for running `to_python`, `validate`, and `run_validators` in the correct order and propogating their errors. if there is an error at any time, the validation stops and that error is raised. this method returns the clean data, which is then inserted into the `cleaned_data` dictionary of the form.
- `clean_<fieldname>()` is called on a form subclass. this method does any cleaning that is specific to that particular attribute, unrelated to the type of field that it is. this method does any cleaning that is specific to that particular attibute, unrelated to the type of field that it is. this method isn't passed any parameters. you'll need to look up the valye of the field in `self.cleaned_data`. that variable will be a python object at this point, not the original string submitted in the form (it will be in `cleaned_data` because the general field `clean()` method, above has already cleaned the data once.
- [see the docs to read more about how this cleaning works](https://docs.djangoproject.com/en/3.2/ref/forms/validation/)

### example of using the clean methods
[this stackoverflow answer shows one use case](https://stackoverflow.com/questions/7948750/custom-form-validation#answer-7948998)

here's my version of that code, using the more flexible `ModelForm` instead of a `UserCreationForm`:
```python
class SignUpForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ('email', 'first_name', 'last_name')

    def clean_email(self):
        """Validate the uniqueness of a User email address."""
        email = self.cleaned_data['email']
        
        if User.objects.filter(email=email).exists():
            raise ValidationError(f'User with email {email} already exists.')
        
        return email
```

### raising validation errors
[see the docs](https://docs.djangoproject.com/en/3.2/ref/forms/validation/#raising-validationerror) for examples on the best way to raise validation errors.
