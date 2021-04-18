#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include unit-testing.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force
SetBatchLines, -1

assert := new unittesting()


assert.group("parse")
assert.label("simple array")
assert.test(JSON.parse("[1, 2, 3]"), [1, 2, 3])
assert.label("keyed object")
obj := {"application":"none", "level":"INFO", "msg":"completed", "process":"none", "utc":"20210219192828"}
assert.test(JSON.parse("{""application"":""none"",""level"":""INFO"",""msg"":""completed"",""process"":""none"",""utc"":""20210219192828""}"), obj)


assert.group("stringify")
assert.label("simple array")
assert.test(JSON.stringify([1, 2, 3]), "[1,2,3]")
assert.label("keyed object")
assert.test(JSON.stringify(obj), "{""application"":""none"",""level"":""INFO"",""msg"":""completed"",""process"":""none"",""utc"":""20210219192828""}")


assert.group("test")
assert.label("invalid json")
assert.false(JSON.test(""))
assert.false(JSON.test("[[[,,,,""[]"))
assert.false(JSON.test("[1, 2, 3]]"))
assert.false(JSON.test("[{}{{{]"))
assert.false(JSON.test("[[}}]"))

assert.label("valid json")
assert.true(JSON.test("[1, 2, 3]"))
assert.true(JSON.test("{""name"":""Jon""}"))
assert.true(JSON.test("{""application"":""none"",""level"":""INFO"",""msg"":""completed"",""process"":""none"",""utc"":""20210219192828""}"))
assert.label("valid json with depth of 2")
assert.true(JSON.test("{""application"":""none"",""depth"":[1,2,3],""level"":""INFO"",""msg"":""completed"",""process"":""none"",""utc"":""20210219192828""}"))
assert.true(JSON.test("{""face"": ""😐""}"))
assert.true(JSON.test("{""face"": ""\uD83D\uDE10""}"))


assert.fullReport()
ExitApp
