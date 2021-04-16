--// DiscordModule \\--
--\\    v1.3.0     //--

-- Extra Functions
local function t(cnd, tru, fls) return cnd and tru or fls end -- Ternary
local function loopthru(tab, func)local z={} for i,v in pairs(tab)do z[#z+1]=func(v) end return z end -- Iterate Through tab
local function sleepuntil(t, i) i=i or .1 while t>os.time() do wait(i) end end
local function empty() end
local num = tonumber
local str = tostring
local binl = bit32.lshift
local format = string.format

-- HttpService
local h = {
	g = "GET", -- using GetAsync for GET
	p = "POST",
	pu = "PUT",
	d = "DELETE",
	pa = "PATCH"
}
local cached_url = ""
local base = "https://discord.com/api/v8"
local emoji_base = "https://cdn.discordapp.com/emojis"
local http = game:GetService("HttpService")
local rateremain = "x-ratelimit-remaining"
local ratereset = "x-ratelimit-reset"
local ratelim = {}
local function jsonencode(...) return http:JSONEncode(...) end
local function jsondecode(...) return http:JSONDecode(...) end
local function sendhttp(url, m, head, body)
	local u = url:gsub(base,""):split("?")[1]
	u = format("%s/%s",u:split("/")[2],u:split("/")[3])
	local r = ratelim[u]
	local sleep = function() t(r and num(r[1]) < 1,sleepuntil,empty)(r[2]+2) end
	t(r,sleep,empty)()
	local x, y = pcall(function()
		return http:RequestAsync{Url=url, Method=m, Headers=head, Body=body}
	end)
	if not x then return y else
		ratelim[u]={y.Headers[rateremain],y.Headers[ratereset],u} return y.Body end
end

-- Setup
local function newchannelobject()end
local function newuserobject()end
local function newmessageobject()end
local function newembedobject() end
local function newchannelmodifyparams() end
local function newemojiobject() end

-- discord & DiscordEnum

_G.Discord = {Client = newproxy(true), Events = newproxy(true)}
local discord = _G.Discord

discord.Enum = {
	["ChannelType"] = {
		["TextChannel"] = 1,
		["DMChannel"] = 2,
		["VoiceChanel"] = 3,
		["GroupDMChannel"] = 4,
		["CategoryChannel"] = 5,
		["NewsChannel"] = 6,
		["StoreChannel"] = 7,
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.ChannelType) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	},
	["MessageType"] = {
		["Default"] = 1,
		["RecipientAdd"] = 2,
		["RecipientRemove"] = 3,
		["Call"] = 4,
		["ChannelNameChange"] = 5,
		["ChannelIconChange"] = 6,
		["ChannelPinnedMessage"] = 7,
		["GuildMemberJoin"] = 8,
		["UserPremiumGuildSubscription"] = 9,
		["UserPremiumGuildSubscription1"] = 10,
		["UserPremiumGuildSubscription2"] = 11,
		["UserPremiumGuildSubscription3"] = 12,
		["AddChannelFollow"] = 13,
		["GuildDiscoveryDisqualified"] = 14,
		["GuildDiscoveryRequalified"] = 15,
		["Reply"] = 19,
		["ApplicationCommand"] = 20,
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.MessageType) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	},
	["MessageFlags"] = {
		["None"] = binl(1,-1), -- 0
		["Crossposted"] = binl(1,0), -- 1
		["IsCrosspost"] = binl(1,1), -- 2
		["SupressEmbeds"] = binl(1,2), -- 4
		["SourceMessageDeleted"] = binl(1,3), -- 8
		["Urgent"] = binl(1,4), -- 16
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.Flags) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	},
	["UserFlags"] = {
		["None"] = binl(1,-1), -- 0
		["DiscordEmployee"] = binl(1,0), -- 1
		["PartneredServerOwner"] = binl(1,1), -- 2
		["HypeSquadEvents"] = binl(1,2), -- 4
		["BugHunterLevel1"] = binl(1,3), -- 8
		["HouseBravery"] = binl(1,6), -- 64
		["HouseBrilliance"] = binl(1,7), -- 128
		["HouseBalance"] = binl(1,8), -- 256
		["EarlySupporter"] = binl(1,9), -- 512
		["TeamUser"] = binl(1,10), -- 1024
		["System"] = binl(1,12), -- 4096
		["BugHunterLevel2"] = binl(1,14), -- 16384
		["VerifiedBot"] = binl(1,16), -- 65536
		["EarlyVerifiedBotDeveloper"] = binl(1,17), -- 131072
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.Flags) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	},
	["GatewayIntents"] = {
		["Guilds"] = binl(1,0), -- 1
		["GuildMembers"] = binl(1,1), -- 2
		["GuildBans"] = binl(1,2), -- 4
		["GuildEmojis"] = binl(1,3), -- 8
		["GuildIntegrations"] = binl(1,4), -- 16
		["GuildWebhooks"] = binl(1,5), -- 32
		["GuildInvites"] = binl(1,6), -- 64
		["GuildVoiceStates"] = binl(1,7), -- 128
		["GuildPresences"] = binl(1,8), -- 256
		["GuildMessages"] = binl(1,9), -- 512
		["GuildMessageReactions"] = binl(1,10), -- 1024
		["GuildMessageTyping"] = binl(1,11), -- 2048
		["DirectMessages"] = binl(1,12), -- 4096
		["DirectMessageReactions"] = binl(1,13), -- 8192
		["DirectMessageTyping"] = binl(1,14), -- 16384
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.Flags) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	},
	["NewObjects"] = {
		["Embed"] = 1,
		["ChannelModifyParams"] = 2,
		["GetEnumItems"] = function()
			local tab = {}
			for i, v in pairs(discord.Enum.NewObjects) do
				if type(v) == "number" then
					tab[v] = i
				end
			end
			return tab
		end
	}
}

setmetatable(discord.Enum, {
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "Discord.Enum"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnums value")
	end,
})

setmetatable(discord.Enum.ChannelType, {
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.ChannelType\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "ChannelType"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

setmetatable(discord.Enum.MessageType, { -- Not on wiki pls dont be lazy and document it thx
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.MessageType\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "MessageType"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

setmetatable(discord.Enum.MessageFlags, { -- Not on wiki pls dont be lazy and document it thx
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.UserFlags\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "UserFlags"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

setmetatable(discord.Enum.UserFlags, { -- Not on wiki pls dont be lazy and document it thx
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.UserFlags\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "UserFlags"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

setmetatable(discord.Enum.NewObjects, { -- Not on wiki pls dont be lazy and document it thx
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.NewObjects\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "NewObjects"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

setmetatable(discord.Enum.GatewayIntents, { -- Not on wiki pls dont be lazy and document it thx
	__newindex = function(tab,key,value)
		error(key.." cannot be assigned to")
	end,
	__index = function(tab, key)
		error(key.." is not a valid member of \"Discord.Enum.GatewayIntents\"")
	end,
	__metatable = "The metatable is locked",
	__tostring = function()
		return "GatewayIntents"
	end,
	__len = function()
		error("attempt to get length of a DiscordEnum value")
	end,
})

-- DiscordEventsList

local eventdata = {
	Ready = function() end,
	MessageCreate = function() end
}

local Events = setmetatable(eventdata, {
	__index = function(tab, key)
		error(key.." is not a valid member of DiscordEventsList \"DiscordEventsList\"")
	end})

local eventmeta = getmetatable(discord.Events)
eventmeta.__index = Events
eventmeta.__newindex = function(tab,key,value)
	if Events[key] then
		Events[key] = value
	else
		error(format("%s is not a valid member of DiscordEventsList \"%s\"", key, eventdata.Name))
	end
end
eventmeta.__metatable = "The metatable is locked"
eventmeta.__tostring = function()
	return Events.Name
end
eventmeta.__len = function()
	error("attempt to get length of a DiscordEventsList value")
end

-- Parse & Events Function

local function eventfire(json)
	for i, v in pairs(json) do
		if v.t == "READY" then
			discord.Events.Ready(v)
		elseif v.t == "MESSAGE_CREATE" then
			discord.Events.MessageCreate(newmessageobject(v.d))
		end
	end
end

local function parse(json)
	if json == "204 No Content" then
		return false
	end
	local newjson = {}
	for i, v in pairs(json) do
		newjson[#newjson+1] = jsondecode(v)
	end
	eventfire(newjson)
end

-- DiscordClientObject

local clientdata = {
	Auth = "",
	Name = "DiscordClientObject"
}

clientdata.SetAuth = function(self, auth, bot)
	bot = bot or true
	if auth == nil then
		error("Argument 1 missing or nil")
	end
	if type(auth) ~= "string" then
		error("String expected, got "..type(auth))
	end
	if bot then
		self.Auth = "Bot "..auth
	else
		self.Auth = auth
	end
	self.Name = "DiscordClientObject"
end

clientdata.GetGateway = function(self, bot)
	if bot then
		local x, y = pcall(function()
			return http:GetAsync(format("%s/gateway/bot", base),
				true,
				{["authorization"]=discord.Client.Auth})
		end)
		return y or nil
	else
		local x, y = pcall(function()
			return http:GetAsync(format("%s/gateway", base),
				true,
				{["authorization"]=discord.Client.Auth})
		end)
		y = jsondecode(y)
		return t(y and y.url, y.url, nil)
	end
end

clientdata.GetUser = function(self, id)
	id = id or "@me"
	local x, y = pcall(function()
		return http:GetAsync(format("%s/users/%s", base, id),
			true,
			{["authorization"]=discord.Client.Auth})
	end)
	return newuserobject(jsondecode(y))
end

clientdata.Connect = function(self, wsurl, url, intents)
	local x, y = pcall(function()
		return http:GetAsync(format("%s/start/%s", url, discord.Client.Auth),
			true,
			{["authorization"]=discord.Client.Auth,["uri"]=wsurl,["intents"]=str(intents)})
	end)
	return y
end

clientdata.Retrieve = function(self, url)
	local x, y = pcall(function()
		return http:GetAsync(format("%s/get/%s", url, discord.Client.Auth),
			true,
			{["authorization"]=discord.Client.Auth})
	end)
	return jsondecode(y)
end

clientdata.Run = function(self, dict) -- a shortcut to the setup functions (:Connect())
	if not dict.Authorization then
		error("missing argument 'Authorization' to 'Run' (snowflake expected)")
	end
	if not dict.ProxyServerURL then
		error("missing argument 'ProxyServerURL' to 'Run' (string expected)")
	end
	cached_url = dict.ProxyServerURL
	dict.Bot = dict.Bot or false
	dict.GatewayIntents = dict.GatewayIntents or binl(1,9)
	self:SetAuth(dict.Authorization, dict.Bot)
	dict.WebSocketURL = dict.WebSocketURL or self:GetGateway()
	if self:Connect(dict.WebSocketURL, dict.ProxyServerURL, dict.GatewayIntents) == "200 OK" then
		return coroutine.resume(coroutine.create(function()
			while true do
				wait(0.5)
				parse(clientdata:Retrieve(dict.ProxyServerURL))
			end
		end))
	else
		return false
	end
end

local Client = setmetatable(clientdata, {
	__index = function(tab, key)
		error(key.." is not a valid member of DiscordClientObject \""..discord.Client.."\"")
	end})

local clientmeta = getmetatable(discord.Client)
clientmeta.__index = Client
clientmeta.__newindex = function(tab,key,value)
	if Client[key] then
		Client[key] = value
	else
		error(format("%s is not a valid member of DiscordClientObject \"%s\"", key, clientdata.Name))
	end
end
clientmeta.__metatable = "The metatable is locked"
clientmeta.__tostring = function()
	return Client.Name
end
clientmeta.__len = function()
	error("attempt to get length of a DiscordClientObject value")
end

-- DiscordChannelObject

newchannelobject = function(y)
	local channel = newproxy(true)
	local channelmeta = getmetatable(channel)
	local channeldata = {
		["Name"] = y.name,
		["Id"] = y.id,
		["GuildId"] = y.guild_id or "0",
		["ParentCategoryId"] = y.parent_id or "0",
		["LastMessageId"] = y.last_message_id or "0",
		["LastPinTimestamp"] = y.last_pin_timestamp or "0",
		["ChannelType"] = y.type or -1,
		["Position"] = y.position or -1,
		["NSFW"] = y.nsfw,
		["LimitTime"] = y.rate_limit_per_user or 0,
		["PermissionOverwrites"] = y.permission_overwrites or {},
		["Topic"] = y.topic or "",
		["SendMessage"] = function(self, message, embed)
			return t(embed, function() newmessageobject(jsondecode(sendhttp(format("%s/channels/%s/messages", base, self.Id),
				h.p, {["authorization"]=discord.Client.Auth,
					["Content-Type"]="application/json"}, format("{%q: %q, %s}",
					"content", message, embed:ToJSON()))))end,
				function() newmessageobject(jsondecode(sendhttp(format("%s/channels/%s/messages", base, self.Id),
					h.p, {["authorization"]=discord.Client.Auth,
						["Content-Type"]="application/json"}, format("{%q: %q}",
						"content", message))))end)()
		end,
		["Modify"] = function(self, channelmodifyparams)
			sendhttp(format("%s/channels/%s", base, self.Id),
				h.pa, {["authorization"]=discord.Client.Auth,
					["Content-Type"]="application/json"}, channelmodifyparams:ToJSON())
		end,
		["SetParent"] = function(self, parentid)
			if parentid then 
				sendhttp(format("%s/channels/%s", base, self.Id),
					h.pa, {["authorization"]=discord.Client.Auth,
						["Content-Type"]="application/json"}, string.format("{%q: %q}", "parent_id", parentid))
			else
				sendhttp(format("%s/channels/%s", base, self.Id),
					h.pa, {["authorization"]=discord.Client.Auth,
						["Content-Type"]="application/json"}, string.format("{%q: %s}", "parent_id", "null"))
			end
		end,
		["StartTyping"] = function(self)
			if sendhttp(format("%s/channels/%s/typing", base, self.Id),
				h.p, {["authorization"]=discord.Client.Auth,
					["Content-Type"]="application/json"}, "") == "" then
				return true
			else
				return false
			end
		end,
		["BulkDelete"] = function(self, ...)
			if sendhttp(format("%s/channels/%s/messages/bulk-delete", base, self.Id),
				h.p, {["authorization"]=discord.Client.Auth,
					["Content-Type"]="application/json"}, jsonencode({["messages"] = {...}})) == "" then
				return true
			else
				return false
			end
		end,
		["GetMessage"] = function(self, id)
			local x, y = pcall(function()
				return http:GetAsync(format("%s/channels/%s/messages/%s", base, self.Id, id),
					true,
					{["authorization"]=discord.Client.Auth})
			end)
			return newmessageobject(jsondecode(y))
		end,
		["BulkGetMessages"] = function(self, option, id, limit)
			local x, y = pcall(function()
				return http:GetAsync(format("%s/channels/%s/messages?%s=%s&%i",
					base, self.Id, option, id, limit),
					true,
					{["authorization"]=discord.Client.Auth})
			end)
			return loopthru(jsondecode(y), newmessageobject)
		end,
	}
	channeldata.Position += 1
	channeldata.ChannelType += 1
	local Channel = setmetatable(channeldata, {
		__index = function(tab, key)
			error(key.." is not a valid member of DiscordChannelObject \""..channeldata.Name.."\"")
		end

	})
	channelmeta.__index = Channel
	channelmeta.__newindex = function(tab,key,value)
		error("can't set value")
	end
	channelmeta.__metatable = "The metatable is locked"
	channelmeta.__tostring = function()
		return channeldata.Name
	end
	channelmeta.__len = function()
		error("attempt to get length of a DiscordClientObject value")
	end
	return channel
end

-- DiscordChannelObject

newuserobject = function(y)
	local user = newproxy(true)
	local usermeta = getmetatable(user)
	local userdata = {
		["Username"] = y.username,
		["Id"] = y.id,
		["Discriminator"] = y.discriminator,
		["AvatarHash"] = y.avatar or "0",
		["IsBot"] = y.bot and true,
		["IsSystem"] = y.system and true,
		["HasMFAEnabled"] = y.mfa_enabled or false,
		["Locale"] = y.locale or "",
		["Verfied"] = y.verified or false,
		["Email"] = y.email or "",
		["UserFlags"] = y.public_flags or 0,
		["Topic"] = y.topic or "",
		
	}
	local User = setmetatable(userdata, {
		__index = function(tab, key)
			error(key.." is not a valid member of DiscordUserObject \"DiscordUserObject\"")
		end

	})
	usermeta.__index = User
	usermeta.__newindex = function(tab,key,value)
		error("can't set value")
	end
	usermeta.__metatable = "The metatable is locked"
	usermeta.__tostring = function()
		return userdata.Name
	end
	usermeta.__len = function()
		error("attempt to get length of a DiscordClientObject value")
	end
	return user
end

-- DiscordMessageObject

newmessageobject = function(y)
	if not y then return {} end
	if y == [[{
    ["code"] = 0,
    ["message"] = "HTTP 400 (Bad Request)"
  }]] then error("HTTP 400") end
	local message = newproxy(true)
	local messagemeta = getmetatable(message)
	local messagedata = {
		["Id"] = y.id,
		["ChannelId"] = y.channel_id,
		["GuildId"] = y.guild_id or "0",
		["Author"] = newuserobject(y.author),
		["AuthorMemberProperties"] = y.member or {}, -- Member Object
		["Content"] = y.content,
		["Timestamp"] = y.timestamp,
		["EditedTimestamp"] = y.edited_timestamp or "0",
		["TTS"] = y.tts,
		["MentionEveryone"] = y.mention_everyone,
		["MentionRoles"] = y.mention_roles or {},
		["MentionChannels"] = y.mention_channels or {}, -- Channel Mention Objects {array}
		["Attachments"] = y.attachments, -- Attachment Objects
		["Embeds"] = y.embeds, -- Embed Objects
		["Reactions"] = y.reactions or {}, -- Reaction Objects
		["Nonce"] = y.nonce or "0",
		["Pinned"] = y.pinned,
		["WebhookId"] = y.webhook_id or "0",
		["MessageType"] = t(y.type, y.type+1, 1),
		["MessageActivity"] = y.activity or {}, -- Message Activity Object
		["MessageApplication"] = y.application or {}, -- Message Application Object
		["MessageReference"] = y.message_reference or {}, -- Message Reference Object
		["MessageFlags"] = y.flags or 0,
		["Stickers"] = y.stickers or {}, -- Stickers Objects
		["ReferencedMessage"] = newmessageobject(y.referenced_message),
		["Interaction"] = y.interaction or {} -- Message Interaction Object
	}
	messagedata.EditContent = function(self, content)
		local ret = sendhttp(format("%s/channels/%s/messages/%s", base, self.ChannelId, self.Id),
			h.pa, {["authorization"]=discord.Client.Auth,
				["Content-Type"]="application/json"}, string.format("{%q: %q}", "content", content))
		for i, v in pairs(jsondecode(ret)) do
			if i and v then
				if i == "id" then messagedata.Id = v
				elseif i == "channel_id" then messagedata.ChannelId = v
				elseif i == "guild_id" then messagedata.GuildId = v
				elseif i == "author" then messagedata.Author = v
				elseif i == "member" then messagedata.AuthorMemberProperties = v
				elseif i == "content" then messagedata.Content = v
				elseif i == "timestamp" then messagedata.Timestamp = v
				elseif i == "edited_timestamp" then messagedata.EditedTimestamp = v
				elseif i == "tts" then messagedata.TTS = v
				elseif i == "mention_everyone" then messagedata.MentionEveryone = v
				elseif i == "mention_roles" then messagedata.MentionRoles = v
				elseif i == "mention_channels" then messagedata.MentionChannels = v
				elseif i == "attachments" then messagedata.Attachments = v
				elseif i == "embeds" then messagedata.Embeds = v
				elseif i == "reactions" then messagedata.Reactions = v
				elseif i == "nonce" then messagedata.Nonce = v
				elseif i == "pinned" then messagedata.Pinned = v
				elseif i == "webhook_id" then messagedata.WebhookId = v
				elseif i == "type" then messagedata.MessageType = v+1
				elseif i == "activity" then messagedata.MessageActivity = v
				elseif i == "application" then messagedata.MessageApplication = v
				elseif i == "message_reference" then messagedata.MessageReference = v
				elseif i == "flags" then messagedata.MessageFlags = v+1
				elseif i == "stickers" then messagedata.Stickers = v
				elseif i == "referenced_message" then messagedata.ReferencedMessage = newmessageobject(v)
				elseif i == "interaction" then messagedata.Interaction = v
				end
			end
		end
		return message
	end
	messagedata.Destroy = function(self)
		return sendhttp(format("%s/channels/%s/messages/%s", base, self.ChannelId, self.Id),
			h.d, {["authorization"]=discord.Client.Auth,
				["Content-Type"]="application/json"}) == ""
	end
	messagedata.Delete = function(self)
		messagedata.Destroy(self)
	end
	messagedata.React = function(self, emoji)
		return sendhttp(format("%s/channels/%s/messages/%s/reactions/%s/@me", base, self.ChannelId, self.Id, emoji:GetId()),
			h.pu, {["authorization"]=discord.Client.Auth,
				["Content-Type"]="application/json"}, "")== ""
	end
	local Message = setmetatable(messagedata, {
		__index = function(tab, key)
			error(key.." is not a valid member of DiscordMessageObject \"DiscordMessageObject\"")
		end

	})
	messagemeta.__index = Message
	messagemeta.__newindex = function(tab,key,value)
		print(tab)
		error("can't set value")
	end
	messagemeta.__metatable = "The metatable is locked"
	messagemeta.__tostring = function()
		return "DiscordMessageObject"
	end
	messagemeta.__len = function()
		error("attempt to get length of a DiscordMessageObject value")
	end
	return message
end

-- DiscordEmojiObject

newemojiobject = function(y)
	if not y then return {} end
	local emoji = newproxy(true)
	local emojimeta = getmetatable(emoji)
	local emojidata = {
		["Id"] = y.id or false,
		["Name"] = y.name or false,
		["Roles"] = y.roles or {},
		["Creator"] = newuserobject(y.user), -- User Object
		["RequireColons"] = y.require_colons,
		["Managed"] = y.managed or false,
		["Animated"] = y.animated or false,
		["Available"] = y.available or false
	}
	emojidata.GetId = function(self)
		if not self.Id then
			return self.Name
		elseif not self.Name then
			error("Emoji does not have Name, possibly removed by Guild Owner.")
		else
			return string.format(":%s:%s", self.Name, self.Id)
		end
	end
	emojidata.GetURL = function(self)
		if self.Animated then
			return format("%s/%s.gif", emoji_base, self.Id)
		else
			return format("%s/%s.png", emoji_base, self.Id)
		end
	end
	local Emoji = setmetatable(emojidata, {
		__index = function(tab, key)
			error(key.." is not a valid member of DiscordEmojiObject \"DiscordEmojiObject\"")
		end

	})
	emojimeta.__index = Emoji
	emojimeta.__newindex = function(tab,key,value)
		print(tab)
		error("can't set value")
	end
	emojimeta.__metatable = "The metatable is locked"
	emojimeta.__tostring = function()
		return "DiscordEmojiObject"
	end
	emojimeta.__len = function()
		error("attempt to get length of a DiscordEmojiObject value")
	end
	return emoji
end

-- DiscordEmbedObject

newembedobject = function()
	local embed = newproxy(true)
	local embedmeta = getmetatable(embed)
	local embeddata = {
		["Title"] = "Title",
		["Description"] = "Description",
		ToJSON = function(self)
			return jsonencode({embed = {
				title = self.Title,
				description = self.Description
			}})
		end
	}
	local Embed = setmetatable(embeddata,
		{__index = function(tab, key)
			error(key.." is not a valid member of DiscordEmbedObject \""..tab.."\"")
		end})
	embedmeta.__index = Embed
	embedmeta.__newindex = function(tab,key,value)
		if Embed[key] then
			Embed[key] = value
		else
			error(key.." is not a valid member of DiscordEmbedObject \""..tab.."\"")
		end
	end
	embedmeta.__metatable = "The metatable is locked"
	embedmeta.__tostring = function()
		return "DiscordEmbedObject"
	end
	embedmeta.__len = function()
		error("attempt to get length of a DiscordEmbedObject value")
	end
	return embed
end

-- DiscordChannelModifyParams

newchannelmodifyparams = function()
	local cmp = newproxy(true)
	local cmpmeta = getmetatable(cmp)
	local cmpdata = {
		["Name"] = "Name",
		["ChannelType"] = discord.Enum.ChannelType.TextChannel,
		["Position"] = 1,
		["Topic"] = "",
		["NSFW"] = false,
		["LimitTime"] = 0,
		["Bitrate"] = 96000,
		["UserLimit"] = 0,
		-- PermissionOverwrites
		["ParentCategoryId"] = "-1",
		ToJSON = function(self)
			if self.ParentCategoryId == "-1" then
				return jsonencode({
					name = self.Name,
					type = self.ChannelType-1,
					position = self.Position-1,
					topic = self.Topic,
					nsfw = self.NSFW,
					rate_limit_per_user = self.LimitTime,
					bitrate = self.Bitrate,
					user_limit = self.UserLimit,
					-- PermissionOverwrites
				})
			else
				return jsonencode({
					name = self.Name,
					type = self.ChannelType-1,
					position = self.Position-1,
					topic = self.Topic,
					nsfw = self.NSFW,
					rate_limit_per_user = self.LimitTime,
					bitrate = self.Bitrate,
					user_limit = self.UserLimit,
					-- PermissionOverwrites
					parent_id = self.ParentCategoryId
				})
			end
		end
	}
	local CMP = setmetatable(cmpdata,
		{__index = function(tab, key)
			error(key.." is not a valid member of DiscordEmbedObject \"DiscordEmbedObject\"")
		end})
	cmpmeta.__index = CMP
	cmpmeta.__newindex = function(tab,key,value)
		if CMP[key] then
			CMP[key] = value
		else
			error(key.." is not a valid member of DiscordEmbedObject \""..tab.."\"")
		end
	end
	cmpmeta.__metatable = "The metatable is locked"
	cmpmeta.__tostring = function()
		return "DiscordEmbedObject"
	end
	cmpmeta.__len = function()
		error("attempt to get length of a DiscordEmbedObject value")
	end
	return cmp
end

-- discord Functions

discord.GetChannel = function(self, channelid)
	local x, y = pcall(function()
		return http:GetAsync(base.."/channels/"..channelid,
			true,
			{["authorization"]=self.Client.Auth})
	end)
	return newchannelobject(jsondecode(y))
end

discord.new = function(t)
	if t == discord.Enum.NewObjects.Embed then
		return newembedobject()
	elseif t == discord.Enum.NewObjects.ChannelModifyParams then
		return newchannelmodifyparams()
	end
end

discord.CalculateGatewayIntents = function(...)
	local res = 0
	for i, v in pairs{...} do
		if type(v) ~= "number" then
			error(format("invalid argument #%i to 'CalculateGatewayIntents' (number expected, got %s)", i, type(v)))
		end
		res += v
	end
	return res
end

discord.GetRateLimit = function()
	tab = {}
	loopthru(ratelim, function(v)
		if v[3]:find("/channels") then
			local u = format("%s/%s",v[3]:split("/")[2],v[3]:split("/")[3])
			t(tab[u],empty,function()tab[u]={0,0}end)
			tab[u][2] = t(v[2]>tab[u][2],function()tab[u][2]=v[2] tab[u][1]=v[1]end,empty)
		end
	end)
	return tab
end

discord.GetEmoji = function(self, guildid, emojiid)
	local x, y = pcall(function()
		return http:GetAsync(base.."/guilds/"..guildid.."/emojis/"..emojiid,
			true,
			{["authorization"]=self.Client.Auth})
	end)
	return newemojiobject(jsondecode(y))
end

-- game:BindToClose() Handling

pcall(function()
	game:BindToClose(function()
		sendhttp(format("%s/close/%s", cached_url, discord.Client.Auth),
			h.d, {["authorization"]=discord.Client.Auth,
				["Content-Type"]="application/json"})
	end)
end)

return true
