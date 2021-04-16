# Rate Limits

```diff
! You are required to respect Discord's rate limits.
! IP addresses(in this case, the Roblox Servers/Your IP if you are on Roblox Studio)
!   that make too many invalid HTTP requests are automatically and temporarily restricted from accessing the Discord API.
! Currently, this limit is 10,000 per 10 minutes.
```

Discord's API rate limits requests in order to prevent abuse and overload of their services. The Module has simple checks for rate limits, and it is something like this:
```
Script:
calls_function()
DiscordModule:
converts the arguments and hands it over to the send_http_reuqest() function
 send_http_request():
  checks the dictionary for the number of requests allowed
  if the number of requests is less than 1:
    waits until its over and the number resets
  sends the request and waits for the response
  take "X-RateLimit-Remaining" and "X-RateLimit-Reset" from the response headers and writes it down for next time
  goes back to the original function
receives the response and converts them into readable objects
...
sends back to the script
```
However this is inaccurate and may still send requests even when the bot is rate limited. There is a function that you can use to get the current rate limits,
you can use it to get an estimation of the current rate limits, but since it only updates everytime a resquest is sent, the data may not be updated.

Developers using this wrapper **should not** rely on the internal check. You should log the number of requests sent and cache responses (if possible).

You can cache the url from `:GetGateway()` or results that would not change that often.
```lua
-- Bad Example:
for i, v in pairs(_G.Discord:GetChannel("2567646356654716386"):BulkGetMessages("after", "97616169726654751673", 100)) do
  _G.Discord:GetChannel(v.ChannelId):SnedMessage("Deleting Message "..v.Id)
  v:Destroy()
end
```
The above example does not cache results, not only wastes rate limits, also does not wait which increase the chance of it throwing an error.
```lua
-- Better Example:
local channel = _G.Discord:GetChannel("2567646356654716386")
local msgs = channel:BulkGetMessages("after", "97616169726654751673", 100)
local id_table = {}
local id_strings = ""
for i, v in pairs(msgs) do
  id_strings = id_strings..Id..", "
  id_table[#id_table+1] = v.Id
end
channel:SendMessage("Deleting Messages: "id_string:sub(1,-3))
channel:BulkDelete(id_table:unpack())
```
The above example caches the channels and messages, also bulk deletes them all at once, saivng rate limits.
## Note:
```diff
! This Module should not be use in game as all the requests including onces from different games will be from the same IP.
! If one game exceeds the limit, all DiscordModules will fail.
! Developers should also implement their own code to prevent multiple servers sending requests at the same time.

Developers should:
+ implement custom rate limit checks;
+ cache results and responses;
+ only allow one or two servers do the HTTP work
+   while the others use MessageingService to send information to the responsible servers,
and should not:
- use this in a real game (especially games with high traffic);
- only rely on the internal check which may be inaccurate;
- log Roblox Chats (or anything) because Discord is not a logging platform.
```
