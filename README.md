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

### DiscordChannelObject
The DiscordChannelObject contains functions to send messages and a lot of useful properties.

**Functions:**
  * :SendMessage(string JSONEncodedDictionary)
    * The argument must be a valid JSON Encoded dictionary, errors if the channel does not support sending messages.
      * Code Sample
        ```lua
        require(game.ServerScriptService.DiscordModule)
        _G.Discord.Client:SetAuth("bot_auth_id", true)
        local channel = _G.Discord:GetChannel("channel_id")
        channel:SendMessage(string.format("{%q: %q}", "content", "Chicken Ice Cream"))
        ```
    * Return Type: JSON Encoded dictionary returned by Discord

**Properties:**
  * string Name `(readonly)`
    * Name of the DiscordChannelObject, returns "" if nil.
  * string Id `(readonly)`
    * ChannelId of the DiscordChannelObject, returns "0" if nil.
  * string GuildId `(readonly)`
    * Id of the guild the channel belongs to, returns "0" if nil.
  * string ParentCategoryId `(readonly)`
    * Id of the parent category of the Channel, returns "0" if nil.
  * string LastMessageId `(readonly)`
    * Id of the last message sent in the channel, returns "0" if nil.
  * string LastPinTimestamp `(readonly)`
    * The last time when a message was pinned, returns "0" if nil.
  * number ChannelType `(readonly)`
    * The type this channel belongs to.
      * When a DiscordEnumItem is called, it returns a number, which can be compared with the value.
  * number Position `(readonly)`
    * The position of this channel from the top, as viewed in the Discord app, returns 0 if nil.
  * bool NSFW `(readonly)`
    * This channel is NSFW if true, returns nil if nil.
      * Note: Roblox does not allow NSFW materials.
  * string LimitTime `(readonly)`
    * The time required until another message can be sent, returns "0" if nil.
      * `tonumber()` can be used to check if the limittime is over.
  * dictionary PermissionOverwrites `(readonly)`
    * A dictionary containing all the permission overwrites, returns {} if nil.
  * string Topic `(readonly)`
    * The topic of the channel, returns "" if nil.

## Enumeration

### DiscordEnums
DiscordEnums datatype. Can be accessed with `_G.Discord.Enum`.

**Enums:**
  * ChannelType:
    * TextChannel
    * DMChannel
    * VoiceChannel
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

## Errors
**`HTTP 400 (Bad Request)`:**

Something in the code went wrong, e.g. using :SendMessage() on a VoiceChannel, or inputting the wrong arguments.

**`HTTP 401 (Unauthorized)`:**

1. The bot argument of :SetAuth() is incorrect. Only set true if it is a bot, and set false if it is not a bot **OR**
2. The Client does not have the permissions (e.g. View Channel, Send Messages)

**`Can't parse JSON`:**

See HTTP 401

## Code Samples
```lua
require(game.ServerScriptService.DiscordModule)
local discord = _G.Discord
discord.Client:SetAuth("bot_auth_id", true)
local channel = discord:GetChannel("channel_id")
local embed = discord.Embed.new()
embed.Title = "EMBED TITLE"
embed.Description = "Description?"
channel:SendMessage(string.format("{%q: %q, %s}", "content", "Chicken Ice Cream", embed:ToJSON()))
```
