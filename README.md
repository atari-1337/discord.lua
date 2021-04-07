# discord.lua

## How to use:

```lua
require(game.ServerScriptService.DiscordModule)
```
## Documentation:

### \_G.Discord
A table that contains all Discord-related Classes.

**Functions:**

  * :GetChannel(string channelid)
    * Returns a Channel Object Of That Id. Will not work if Authorization Code is not set.
    * Return Type: DiscordChannelObject

### DiscordClientObject
The DiscordClientObject class which can be called with `_G.Discord.Client`. Contains the SetAuth function.

**Functions:**

  * :SetAuth(string authid, bool bot)
    * Sets that Auth property with the authid string. If that client is a bot, the bot arg must be true, else set it to false.
    * Return Type: Void

**Properties:**

  * string Auth
    * the property that contains the Authorization Code.
  * string Name
    * the Name of the current Client. This isn't related to the Discord Client Username/Display Name.

### DiscordEmbed
The DiscordEmbed Datatype which can be called with `_G.Discord.Embed`, contains the Embed.new() constructor.

**Constructors:**

  * .new()
    * Creates a new DiscordEmbedObject and returns it.
    * Return Type: DiscordEmbedObject

### DiscordEmbedObject
The DiscordEmbedObject class which can be called with `DiscordEmbed.new()`. This is useful when creating embedded messages.

**Functions:**
  * :ToJSON()
    * Returns a JSON Version of the DiscordEmbedObject. This must be used when sending messages.
    * Return Type: string

**Properties:**
  * string Title
    * the Title property of the DiscordEmbedObject
  * string Description
    * the Description property of the DiscordEmbedObject

### DiscordEnums
DiscordEnums datatype. Can be accessed with `_G.Discord.Enum`.
**Enums:**
  * ChannelType:
    * TextChannel
    * DMChannel
    * VoiceChanel
    * GroupDMChannel
    * CategoryChannel
    * NewsChannel
    * StoreChannel

### DiscordEnum
DiscordEnum datatype.
**Functions:**
  * :GetEnumItems()
    * Returns an array containing all of the DiscordEnumItem options available for this DiscordEnum.

### DiscordEnumItem
DiscordEnumItem datatype.
