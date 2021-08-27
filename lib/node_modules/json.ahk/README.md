# JSON.ahk

##### [JSON](http://json.org/) lib for [AutoHotkey](http://ahkscript.org/)

Works on both v1 and v2 of AutoHotkey


-----



## Installation
In a terminal or command line navigated to your project folder:

```bash
npm install json.ahk
```

In your code only export.ahk needs to be included:

```autohotkey
#Include %A_ScriptDir%\node_modules\json.ahk\export.ahk

JSON.stringify([1, 2, 3])
; => "[1, 2, 3]"

JSON.parse("[1, 2, 3]")
; => [1, 2, 3]
```
You may also review or copy the library from [./export.ahk on GitHub](https://raw.githubusercontent.com/chunjee/json.ahk/master/export.ahk); #Incude as you would normally if manually downloading.

## API

### .parse()
Parses a JSON string into a value.

##### Syntax:
```autohotkey
value := JSON.parse(string [, reviver ])
```

##### Return Value:
value (object, string, number)

##### Parameter(s):
 * **string** - JSON formatted string
 * **reviver** [optional] - function object, prescribes how the value originally produced by parsing is transformed, before being returned. Similar to JavaScript's `JSON.parse()` reviver parameter

##### Example:
```autohotkey
JSON.parse("[1, 2, 3]")
; => [1, 2, 3]
```



### .stringify()
Converts a value into a JSON string.

##### Syntax:
```autohotkey
str := JSON.stringify(value, [, replacer, space ])
```

##### Return Value:
A JSON formatted string

##### Parameter(s):
 * **value** - (object, string, number)
 * **replacer** [optional] - function object, alters the behavior of the stringification process. Similar to JavaScript's `JSON.stringify()` replacer parameter
 * **space** [optional] -if space is a non-negative integer or string, then JSON array elements and object members will be pretty-printed with that indent level. Blank( ``""`` ) (the default) or ``0`` selects the most compact representation. Using a positive integer space indents that many spaces per level, this number is capped at 10 if it's larger than that. If space is a string (such as ``"`t"``), the string (or the first 10 characters of the string, if it's longer than that) is used to indent each level

##### Example:
```autohotkey
JSON.stringify([1, 2, 3])
; => "[1, 2, 3]"
```



## .test()
tests if a string is a valid json string or not.

##### Syntax:
```autohotkey
JSON.test(string)
```

##### Return Value:
`true` if the string is interpreted as valid json, else `false`

##### Parameter(s):
 * **string** - the string value to be tested for validity

##### Example:
```autohotkey
JSON.test("[1, 2, 3]")
; => true

JSON.test([1, 2, 3]) ; an object
; => false

JSON.test("")
; => false
```
