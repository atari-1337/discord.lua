# Snowflake
For arguments that require a snowflake, do not input a number or tostring(number), instead input a number inside a string ("123456789").
The precision is lost when converted to a number and returns a number with scientific notation (e.g. 1e+9).
This will break the system.
Another option would be separating the number into 2 (e.g. 456789123456789 split into 4567891, 23456789), in this case, both numbers can be kept and there will be more flexibility.
When necessary, convert them into strings and use the concatenation operator.

Example:
```lua
-- The following snowflakes are just randomly gernerated numbers.
local snowflake_num = 2567646356654716386 -- Will error; since it returns "2.5676463566547e+18" when converted to a string. 
local snowflake_str = "2567646356654716386" -- Will work; since the precision is not lost when it reaches the Module.
local snowflake1 = 256764635
local snowflake2 = 6654716386 -- Will work; since the precision is not lost when split into 2

print(snowflake_num)
print(snowflake_str)
print(tostring(snowflake1)..tostring(snowflake2))

--- Output:
2.5676463566547e+18
2567646356654716386
2567646356654716386
```
