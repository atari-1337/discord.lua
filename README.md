# discord.lua

## How to use:

```lua
require(game.ServerScriptService.DiscordModule)
```
## Documentation:

### \_G.Discord
A table that contains all Discord-related Classes.

**Functions:**

  :GetChannel(string channelid)
    Returns a Channel Object Of That Id. Will not work if Authorization Code is not set.

### \_G.Discord.Client
The Client Class. Contains the SetAuth function.

**Functions:**

  :SetAuth(string authid, bool bot)
    Sets that Auth property with the authid string. If that client is a bot, the bot arg must be true, else set it to false.

**Properties:**

  string Auth
    the property that contains the Authorization Code.
  string Name
    the Name of the current Client. This isn't related to the Discord Client Username/Display Name.
