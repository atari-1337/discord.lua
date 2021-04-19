# DiscordClientObject
A class that contains all the client-related function and Authorization Code.
<table>
  <tr>
    <th>Properties</th>
  </tr>
  <tr>
    <td>
      <code>string</code> <code>Auth</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          The Authorization Code or Token used in all functions using the Discord API. Developers should not edit this property directly. Use <code>:Run()</code>.
        </li>
      </ul>
    </td>
  </tr>
</table> 
<table>
  <tr>
    <th>Functions</th>
  </tr>
  <tr>
    <td>
      <code>Void</code> <code>:SetAuth(string: token [, bool: bot=false])</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          Sets the Auth Property. Used internally and should not be used by Developers as it complicates code.
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>string</code> <code>token</code>
          <ul TYPE="disc">
            <li>
              The token of the Client.
            </li>
          </ul>
        <code>bool</code> <code>bot</code> <i><code>(Optional)</code></i>
          <ul TYPE="disc">
            <li>
              Whether the Client is a Bot or not. Defaults to <code>false</code>.
<details>
<summary>Warning</summary>

```diff
! Logging on with a user token is against the Discord Terms of Service and
!   doing so might potentially get your account banned.
! Use this at your own risk.
``` 

</details>
            </li>
          </ul>
        </li>
      </ul>
    </td>
  </tr>
  <!--GetGateway-->
  <tr>
    <td>
      <code>Variant</code> <code>:GetGateway([bool: bot=false])</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
          Gets the Gateway Link from Discord. Used internally and should not be used by Developers as it complicates code.
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>bool</code> <code>bot</code> <i><code>(Optional)</code></i>
          <ul TYPE="disc">
            <li>
              Whether the Client is a Bot or not. Defaults to <code>false</code>.
<details>
<summary>Warning</summary>

```diff
! Logging on with a user token is against the Discord Terms of Service and
!   doing so might potentially get your account banned.
! Use this at your own risk.
``` 

</details>
            </li>
          </ul>
      </ul>
    </td>
  </tr>
  <!--GetUser-->
  <tr>
    <td>
      <code>DiscordUserObject</code> <code>:GetUser([variant: id="@me"])</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
         Retrieves the <code>UserObject</code> of the UserId (or self if <code>id</code> left out)
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>variant</code> <code>id</code> <i><code>(Optional)</code></i>
          <ul TYPE="disc">
            <li>
              Accepts <code>snowflake</code>. If <code>snowflake</code>, returns the <code>UserObject</code> of the specified id. If left out, returns the <code>UserObject</code> of self instead.
            </li>
          </ul>
      </ul>
    </td>
  </tr>
  <!--Connect-->
  <tr>
    <td>
      <code>string</code> <code>:Connect(string: websocketurl, string: proxyurl, int intents)</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
         Returns a <code>string</code> describing if the connection was successful or not. This function connects to the WebSocket through a ProxyServer, but does not retrieve data. Used internally and should not be used by Developers as it complicates code.
<details>
<summary>Note</summary>

```diff
# Gateway Note
You should setup the Gateway before continuing this tutorial.
``` 

</details>
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>string</code> <code>websocketurl</code>
          <ul TYPE="disc">
            <li>
              The WebSocket URL to connect to. It can be retrieved using <code>:GetGateway()</code>
          </ul>
        <code>string</code> <code>proxyurl</code>
          <ul TYPE="disc">
            <li>
              The Proxy Server URL to connect to. Read the above Note for more information.
          </ul>
      </ul>
    </td>
  </tr>
</table> 
