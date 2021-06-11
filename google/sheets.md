# google sheets app script
[following this guide](https://developers.google.com/apps-script/quickstart/fundamentals-codelabs?authuser=1)

## app script fundamentals
[lesson 1](https://developers.google.com/codelabs/apps-script-fundamentals-1?authuser=1#0)

app scripts for developing on your google workspace

allows you to do all sort of fun stuff with spreadsheets in google sheets



### intro
- macros = record action in a spreadsheet so you can reuse it
- custom functions = similar to the built in functions for a sheet, you can use custom functions in an app script. you can call these functions like a built-in function

#### macros
walks thru creating a macro and shows how you can access the macro's code in a the script editor
`/** @OnlyCurrentDoc */` lets you authorize the macro to only work on the current sheet

they call this "activation":
```
var spreadsheet = SpreadsheetApp.getActive();
sheet.getRange(
    spreadsheet.getCurrentCell().getRow(),
    1, 1, sheet.getMaxColumns()).activate();
```

### custom functions
guide for creating your own script: https://developers.google.com/codelabs/apps-script-fundamentals-1?authuser=1#4

code comment will show up like a docstring

example of the cache api and how you fetch:
```
function USDTOCHF(dollars){
  // Gets a cache that is common to all users of the script.
  var cache = CacheService.getScriptCache();

  // Accesses the memory location (rates.CHF) of the script cache.
  var rate = cache.get('rates.CHF');

  // If a cache miss occurs, the program fetches the current
  // CHF rate from an API and stores the rate in the cache
  // for later convenience.
  if (!rate) {
    var response =
UrlFetchApp.fetch('https://api.exchangeratesapi.io/latest?base=USD');
    var result = JSON.parse(response.getContentText());
    rate = result.rates.CHF;
    cache.put('rates.CHF', rate);
  }
  // Converts dollars to CHF according to the latest rate.
  var swissFrancs = dollars * rate;
  // Returns the CHF value.
  return 'CHF' + swissFrancs;
}
```

## misc resources

- [a1](https://developers.google.com/sheets/api/guides/concepts?authuser=1#a1_notation) applicable to all spreadsheets (?)
- [spreadsheet notation](https://developers.google.com/apps-script/reference/spreadsheet/)
