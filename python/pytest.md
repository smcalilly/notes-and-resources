pytest won't print if it's a successful test? see this: https://stackoverflow.com/questions/24617397/how-to-print-to-console-in-pytest#answer-24617813
add `-s` this to your command: 
```bash
pytest my_tests.py -s
```
