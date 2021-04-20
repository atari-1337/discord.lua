**Constructors:**

  * `.new(number type)`
    * Constructs a new object and returns it.

# \_G.Discord
A table that contains all Discord-related Classes.
<table>
  <tr>
    <th>Functions</th>
  </tr>
  <tr>
    <td>
      <code>DiscordChannelObject</code> <code>:GetChannel(snowflake: channelid)</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          Returns a Channel Object Of That Id.
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>snowflake</code> <code>channelid</code>
          <ul TYPE="disc">
            <li>
              The Id of the DiscordChannelObject.
            </li>
          </ul>
        </li>
      </ul>
    </td>
  </tr>
  <!----------GetEmoji---------->
  <tr>
    <td>
      <code>DiscordEmojiObject</code> <code>:GetEmoji(snowflake: guildid, snowflake: emojiid)</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          Obtains a DiscordEmojiObject in the specified Guild with the same Id.
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>snowflake</code> <code>guildid</code>
          <ul TYPE="disc">
            <li>
              The Id of the Guild the Emoji belongs to.
            </li>
          </ul>
       <code>snowflake</code> <code>emojiid</code>
          <ul TYPE="disc">
            <li>
              The Id of the Emoji.
            </li>
          </ul>
      </ul>
    </td>
  </tr>
</table> 
<table>
  <tr>
    <th>Constructors</th>
  </tr>
  <tr>
    <td>
      <code>Variant</code> <code>.new(number: objectid)</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          Returns an Object with the specified Id. A list of Ids can be found in Discord.Enum.NewObjects. The Enum List contains all creatable object and their ObjectIds that can be used.
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>number</code> <code>objectid</code>
          <ul TYPE="disc">
            <li>
              The Id of the Object. A list of Ids can be found in Discord.Enum.NewObjects. The Enum List contains all creatable object and their ObjectIds that can be used.
            </li>
          </ul>
        </li>
      </ul>
    </td>
  </tr>
</table> 
