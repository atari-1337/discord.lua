`:SendMessage()` is a function of DiscordChannelObject. It takes in 2 arguments, the message(required) and the embed(optional).
```lua
:SendMessage(string Message, DiscordEmbedObject Embed=nil)
```
By default the embed argument is nil. This article will explain how to send emojis, attachments and embeds.
## Emojis
### Discord Emojis
You can send them just like how you would when you're using Discord.
```lua
Channel:SendMessage(":thumbsup:")
```
![image](https://user-images.githubusercontent.com/68418829/114303002-54340c80-9afe-11eb-9fcc-c6a414125371.png)

As you see, it works nicely.
### Custom Emojis
#### Guild Custom Emoji
You can send custom emojis created in the same guild in the following format:
```lua
Channel:SendMessage("<:name:id>")
```
For example, this:
```lua
channel:SendMessage("<:roBlock:830771637560934450>")
```
![image](https://user-images.githubusercontent.com/68418829/114303187-767a5a00-9aff-11eb-94b4-066a107b403c.png)
#### External Custom Emoji
You would first need to tick the "Use External Emoji" box in the Channel and also allow the bot to use External Emojis.

![image](https://user-images.githubusercontent.com/68418829/114303232-b2adba80-9aff-11eb-89f5-12db348457da.png)

Once you have it, you can send it just like the Guild Custom Emojis.
## Attachments
You can send attachments by inserting a link. It's the same for files or images. For example, we can put [this link](https://user-images.githubusercontent.com/68418829/114303324-22bc4080-9b00-11eb-9e9e-25eccc67303c.png)
in there.
```lua
channel:SendMessage("https://user-images.githubusercontent.com/68418829/114303324-22bc4080-9b00-11eb-9e9e-25eccc67303c.png")
```
![image](https://user-images.githubusercontent.com/68418829/114303378-762e8e80-9b00-11eb-8cfb-f3d2b47475a4.png)

Indeed it works.
### Note
Don't put links that lead to offensive content or links that violate the Roblox/Discord ToS!
