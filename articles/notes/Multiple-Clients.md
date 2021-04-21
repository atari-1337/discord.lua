# Multiple Clients
```diff
# Multiple Client Objects Warning
! You are strongly discouraged to use multiple Client Objects.
! Read the article Multiple-Clients.md for other alternatives.
```
You can use Discord.Client() to create a new Client Object, however there are a lot of problems when there are multiple client objects. All functions use the Authorization Code (or token) of the last client.
```lua
local client1 = Discord.Client() -- does not use the token of this client, even if :Run() is used, which breaks every single function
local client2 = Discord.Client() -- as this is the newest client object created, functions will use the properties of this clientobject.
```
You can use another script if you want another ClientObject (however since Roblox isn't a stable platform and your bot may suddenly go offline you don't really need another clientobject do you?). Use other Discord API wrappers like discord.py or discord.js and heroku for a stable and safe bot as this API wrapper is experimental.
