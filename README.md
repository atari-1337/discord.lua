# discord.lua

## About

This is a Discord API wrapper written in Roblox Lua. The Source code of the Module can be found here and is written in pure Luau. However it does not contain events since connecting to the discord gateway requires a Websocket, which is not possible in Lua. You would need to use heroku to connect it up.

## How to use

```lua
require(game.ServerScriptService.DiscordModule)
```

## Disclaimer

This Module is not created for malicious uses. It is an experimental module and may be discontinued anytime in the future. Anyone using this module must comply with the Roblox ToS and Discord ToS. This Module is not designed for heavy-duty or in-game use. It is a small Module that can run in Roblox Studio for developers to play around with.

## Note

For arguments that require a snowflake, do not input a number or `tostring(number)`, instead input a number inside a string ("123456789"). The precision is lost when converted to a number and returns a number with scientific notation (e.g. 1e+9). This will break the system. Another option would be separating the number into 2 (e.g. 456789123456789 split into 4567891, 23456789), in this case, both numbers can be kept and math operations can be done. When necessary, convert them into strings and use the concatenation operator.

## Documentation

### \_G.Discord
A table that contains all Discord-related Classes.

**Functions:**

  * `:GetChannel(snowflake channelid)`
    * Returns a Channel Object Of That Id.
    * Return Type: DiscordChannelObject
  * `:GetEmoji(snowflake guildid, snowflake emojiid)`
    * Returns a DiscordEmojiObject of that emoji. The emoji must be a custom emoji of that guild. Errors if one of the two arguments is wrong.
    * Return Type: DiscordEmojiObject

**Constructors:**

  * `.new(number type)`
    * Constructs a new object and returns it.

### DiscordClientObject
The DiscordClientObject class which can be called with `_G.Discord.Client`. Contains the SetAuth function.

**Functions:**

  * `:SetAuth(string authid, bool bot=true)`
    * Sets the Auth property with the authid string. If that client is a bot, the bot arg must be true, else set it to false.
      * **Logging on with a user token is against the Discord Terms of Service and doing so might potentially get your account banned. Use this at your own risk.**
    * Return Type: Void
  * `:GetGateway(bool bot)`
    * Gets the Gateway URL and returns it. The URL is used to connect to Discord to listen to events, which requires a websocket and is not achievable in Roblox.
      * Returns a dictionary containing extra data if the bot arugment is true.
    * Return Type: string or dictionary
  * `:GetUser(snowflake id="@me")`
    * Returns a DiscordUserObject of the id. If the argument is left blank, it returns the user object of itself.

**Properties:**

  * `string Auth`
    * the property that contains the Authorization Code.
  * `string Name`
    * the Name of the current Client. This isn't related to the Discord Client Username/Display Name.

### DiscordChannelObject
The DiscordChannelObject contains functions to send messages and a lot of useful properties.

**Functions:**
  * `:SendMessage(string JSONEncodedDictionary)`
    * The argument must be a valid JSON Encoded dictionary, errors if the channel does not support sending messages.
      * Code Sample
        ```lua
        require(game.ServerScriptService.DiscordModule)
        _G.Discord.Client:SetAuth("bot_auth_id", true)
        local channel = _G.Discord:GetChannel("channel_id")
        channel:SendMessage(string.format("{%q: %q}", "content", "Chicken Ice Cream"))
        ```
    * Return Type: DiscordMessageObject
  * `:Modify(DiscordChannelModifyParams cmp)`
    * The DiscordChannelObject will modify according to the DiscordChannelModifyParams. See the documentation for DiscordChannelModifyParams for more info.
    * Return Type: Void
  * `:SetParent(snowflake ParentId)`
    * Leave the argument out to remove the parent category (The parent will be the guild.)
    * Return Type: Void
  * `StartTyping()`
    * Trigger the typing indicator. Returns true if successful, else returns false.
    * Return Type: bool
  * `BulkDelete(... snowflake MessageIds)`
    * Deletes all of the messages in one request. Fails if one of the following requirements is not met:
      * 2 < number of arguments < 100
      * All message are not older than 2 weeks
      * No duplicate IDs
    * Also if the given Id is invalid, it will be skipped but will still count to the number of arguments. Any Messages after the 100th will not be deleted. Returns true if successful, else returns false.
    * Return Type: bool

**Properties:**
  * `string Name` `(readonly)`
    * Name of the DiscordChannelObject.
  * `snowflake Id` `(readonly)`
    * ChannelId of the DiscordChannelObject.
  * `snowflake GuildId` `(readonly)`
    * Id of the guild the channel belongs to, returns "0" if nil.
  * `snowflake ParentCategoryId` `(readonly)`
    * Id of the parent category of the Channel, returns "0" if nil.
  * `snowflake LastMessageId` `(readonly)`
    * Id of the last message sent in the channel, returns "0" if nil.
  * `string LastPinTimestamp` `(readonly)`
    * The last time when a message was pinned, returns "0" if nil.
  * `number ChannelType` `(readonly)`
    * The type this channel belongs to.
      * When a DiscordEnumItem is called, it returns a number, which can be compared with the value.
  * `number Position` `(readonly)`
    * The position of this channel from the top, as viewed in the Discord app, returns 0 if nil.
  * `bool NSFW` `(readonly)`
    * This channel is NSFW if true, returns nil if nil.
      * Note: Roblox does not allow NSFW materials.
  * `number LimitTime` `(readonly)`
    * The time required until another message can be sent, returns 0 if nil.
      * `tonumber()` can be used to check if the limittime is over.
  * `dictionary PermissionOverwrites` `(readonly)`
    * A dictionary containing all the permission overwrites, returns {} if nil.
  * `string Topic` `(readonly)`
    * The topic of the channel, returns "" if nil.

### DiscordMessageObject
The DiscordMessageObject class can be obtained with `DiscordChannelObject:SendMessage()`.

**Functions:**
  * `:EditContent(string content)`
    * The message must be editable and made by the same client. After editing, the properties of the DiscordMessageObject will be edited (not only the content property, some other properties (e.g. Embeds, Reactions) which may be edited will be updated). It returns the updated DiscordMessageObject but the old one(s) will still be updated.
    * Return Type: DiscordMessageObject
  * `:Destroy()`
    * Deletes the message and returns true if successful, else returns false.
    * Return Type: bool
  * `:Delete()` `(deprecated)`
    * Same as `DiscordMessageObject:Destroy()`
    * Return Type: bool
  * `:React(string emoji)

**Properties:**
  * `snowflake Id` `(readonly)`
    * MessageId of the DiscordMessageObject.
  * `snowflake ChannelId` `(readonly)`
    * ChannelId of the Channel this DiscordMessageObject belongs to.
  * `snowflake GuildId` `(readonly)`
    * GuildId of the Guild this DiscordMessageObject belongs to, returns "0" if nil.
  * `DiscordUserObject Author` `(readonly)`
    * The Author of the DiscordMessageObject.
  * `DiscordMemberProperties AuthorMemberProperties` `(readonly)`
    * The Member Properties of the Author of the DiscordMessageObject, returns {} if nil.
  * `string Content` `(readonly)`
    * The contents of the Message Object.
  * `string Timestamp` `(readonly)`
    * The time when the message was created.
  * `string EditedTimestamp` `(readonly)`
    * The last time the message was edited, returns "0" if nil.
  * `bool TTS` `(readonly)`
    * True if the message is Text-To-Speech.
  * `bol MentionEveryone` `(readonly)`
    * True if the message mentions everyone.
  * `array MentionRoles` `(readonly)`
    * An array of snowflake ids of mentioned roles, returns {} if nil.
  * `array MentionChannels` `(readonly)`
    * An array of DiscordChannelMentionObjects, returns {} if nil.
  * `array Attachments` `(readonly)`
    * An array of DiscordAttachmentObjects, returns {} if nil.
  * `array Embeds` `(readonly)`
    * An array of DiscordEmbedObjects, returns {} if nil.
  * `array Reactions` `(readonly)`
    * An array of DiscordReactionObjects, returns {} if nil.
  * `number/string Nonce` `(readonly)`
    * Used for validating a message was sent, returns "0" if nil.
  * `bool Pinned` `(readonly)`
    * True if the message is pinned.
  * `snowflake WebhookId` `(readonly)`
    * Id of the webhook that send the message, useful when validating if a message was sent by a Webhook or a bot/user, returns "0" if nil.
  * `number MessageType` `(readonly)`
    * The type this message belongs to.
      * When a DiscordEnumItem is called, it returns a number, which can be compared with the value.
  * `DiscordMessageActivityObject MessageActivity` `(readonly)`
    * Sent with Rich Presence-related chat embeds, returns {} if nil.
  * `DiscordMessageApplicationObject MessageApplication` `(readonly)`
    * Sent with Rich Presence-related chat embeds, returns {} if nil.
  * `DiscordMessageReferenceObject MessageReference` `(readonly)`
    * Reference data sent with crossposted messages and replies, returns {} if nil.
  * `number MessageFlags` `(readonly)`
    * The flags this message has.
      * When a DiscordEnumItem is called, it returns a number, which can be compared with the value.
  * `array Stickers` `(readonly)`
    * An array of DiscordStickerObjects, returns {} if nil.
  * `DiscordMessageObject ReferencedMessage` `(readonly)`
    * The DiscordMessageObject of the referenced message, returns {} if nil.
  * `MessageInteractionObject Interaction` `(readonly)`
    * Returns {} if nil.

### DiscordEmojiObject
The DiscordEmojiObject class is used in Reactions and Emojis.

**Functions:**
  * `:GetId()`
    * Returns the Id of the emoji used in Reactions and used by the Module.
      * This is different than DiscordEmojiObject.Id
  * `:GetURL()`
    * Returns a URL that can be used as a Image.

**Properties:**


### DiscordEmbedObject
The DiscordEmbedObject class which can be called with `Discord.new(Discord.Enum.NewObjects.Embed)` or `Discord.new(1)`. This is useful when creating embedded messages.

**Functions:**
  * `:ToJSON()`
    * Returns a JSON Version of the DiscordEmbedObject. This must be used when sending messages.
    * Return Type: string

**Properties:**
  * `string Title`
    * the Title property of the DiscordEmbedObject
  * `string Description`
    * the Description property of the DiscordEmbedObject

### DiscordChannelModifyParams
The DiscordChannelModifyParams class is required when using DiscordChannelObject:Modify(). It can be obtained with `Discord.new(Discord.Enum.NewObjects.ChannelModifyParams)`.

**Functions:**
  * `:ToJSON()`
    * Returns a JSON Version of the DiscordChannelModifyParams. It is used by the Module.
    * Return Type: string

**Properties:**
  * `string Name`
    * The name of the to be modified channel.
  * `number ChannelType`
    * Only available to TextChannels and NewsChannels to convert between each other. Their values can be viewed in `Discord.Enum.ChannelType`.
  * `number Position`
    * The position of this channel from the top, as viewed in the Discord app.
  * `string Topic`
    * The topic of the to be modified channel.
  * `bool NSFW`
    * The to be modified channel is NSFW if true, returns nil if nil.
      * Note: Roblox does not allow NSFW materials.
  * `number LimitTime`
    * The time required until another message can be sent.
  * `number Bitrate`
    * The bitrate of the to be modified voice channel.
  * `number UserLimit`
    * The number of people allowed in the voice channel.
  * `DiscordPermissionsObject PermissionOverwrites`
    * Not usable.
  * `snowflake ParentCategoryId` `(deprecated)`
    * Id of the parent category of the Channel.
      * Defaults to "-1". Set to "-1" to keep the same parent category. It is recommended to use `DiscordChannelObject:SetParent()` to set the ParentCategoryId.

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

Something in the code went wrong, e.g. using `:SendMessage()` on a VoiceChannel, or inputting the wrong arguments.

**`HTTP 401 (Unauthorized)`:**

1. The bot argument of `:SetAuth()` is incorrect. Only set true if it is a bot, and set false if it is not a bot **OR**
2. The Client does not have the permissions (e.g. View Channel, Send Messages) **OR**
3. The Object cannot be accessed by the Client (e.g. the Client is not in the Guild/Channel) **OR**
4. The requests exceeded the Request Limit (See Rate Limits)

**`Can't parse JSON`:**

See HTTP 401

## Rate Limits

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
However this is inaccurate and may still send requests even when the bot is rate limited.

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
