# Errors and Return Values
## Errors
Usually this occurs when the Module has to convert to responses into Objects, but the responses were not in JSON Format, or did not contain all the necessary information.
For most cases, it should return a value describing the error instead of erroring, but in the event of it erroring, it could be either Roblox's internal errors or
Discord's internal errors. These errors may go undetected, which is why you should wrap the functions in pcall(if you are relying on this heavily,
else if it's just a test in Studio, it is not necessary to wrap it since these events are rare.) This is an extract from the Module:
## Return Values
If a function is ran successfully, it will return an Object, boolean etc. But if the function failed to run, it may return other values, which could break your existing code.

**`HTTP 400 (Bad Request)`:**

Something in the code went wrong, e.g. using `:SendMessage()` on a VoiceChannel, or inputting the wrong arguments.

**`HTTP 401 (Unauthorized)`:**

1. The bot argument of `:SetAuth()` is incorrect. Only set true if it is a bot, and set false if it is not a bot **OR**
2. The Client does not have the permissions (e.g. View Channel, Send Messages) **OR**
3. The Object cannot be accessed by the Client (e.g. the Client is not in the Guild/Channel) **OR**
4. The requests exceeded the Request Limit (See Rate-Limits.md)
