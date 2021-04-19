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
  <!----------GetGateway---------->
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
<details>
<summary>Note</summary>

```diff
# Cache Results Note
You should cache the url string of this result and only call this function again when necessary.
``` 

</details>
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
  <!----------GetUser---------->
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
  <!----------Connect---------->
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
You should setup the Gateway before using this function.
``` 

</details>
        </li>
      </ul>
      Parameters:
      <ul TYPE="disc">
        <code>string</code> <code>websocketurl</code>
          <ul TYPE="disc">
            <li>
              The WebSocket URL to connect to. It can be retrieved using <code>:GetGateway()</code>. This function retrieves data from a ProxyServer, but does not connect to the WebSocket. Used internally and should not be used by Developers as it complicates code.
          </ul>
        <code>string</code> <code>proxyurl</code>
          <ul TYPE="disc">
            <li>
              The Proxy Server URL to connect to. Read the above Note for more information.
          </ul>
      </ul>
    </td>
  </tr>
  <!----------Retrieve---------->
  <tr>
    <td>
      <code>variant</code> <code>:Retrieve(string: proxyurl)</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
         Returns an <code>array</code> on success and a <code>string</code> describing the failure if failed.
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
        <code>string</code> <code>proxyurl</code>
          <ul TYPE="disc">
            <li>
              The Proxy Server URL to connect to. Read the above Note for more information.
          </ul>
      </ul>
    </td>
  </tr>
  <!----------Run---------->
  <tr>
    <td>
      <code>variant</code> <code>:Run{string: Authorization, string: ProxyServerURL[, bool: Bot=false[, int: GatewayIntents=512[, string: WebSocketURL=DiscordClientObject:GetGateway()]]]}</code>
    </td>
  </tr>
  <tr>
    <td>
      Description:
      <ul TYPE="disc">
        <li>
         Returns a <code>coroutine thread</code> that listen to events on success and <code>false</code> if failed.
         This function handles all the setup functions, and Developers should use this function over the others.
         It is not a blocking function, which means it does not have to be in the last line. It is recommended to put it on top.
         It uses <code>{}</code> instead of <code>()</code>. You can also pass in a dictionary in <code>()</code>.
         The optional values do not have to be in order. You can also leave them out.
         Examples of Accepted Values (not all):
          <ul TYPE="disc">
            <li>
              <code>:Run{Authorization="bot-token-here", ProxyServerURL="url-here"}</code>
            </li>
            <li>
              <code>:Run(dictionary)</code>
            </li>
            <li>
              <code>:Run{Authorization="bot-token-here", ProxyServerURL="url-here", GatewayIntents=515}</code>
            </li>
          </ul>
<details>
<summary>Note</summary>

```diff
# Gateway Note
You should setup the Gateway before continuing this tutorial.
``` 

</details>
      Parameters:
      <ul TYPE="disc">
        <code>string</code> <code>Authorization</code>
          <ul TYPE="disc">
            <li>
              The Authorization Code (token) used by the Client.
          </ul>
        <code>string</code> <code>ProxyServerURL</code>
          <ul TYPE="disc">
            <li>
              The URL of the Proxy Server. Refer to the above Note.
          </ul>
        <code>bool</code> <code>Bot</code> <i><code>(Optional)</code></i>
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
        <code>int</code> <code>GatewayIntents</code>
          <ul TYPE="disc">
            <li>
              Refer to the GatewayIntents Enum docs or article.
          </ul>
        <code>string</code> <code>WebSocketURL</code>
          <ul TYPE="disc">
            <li>
              The URL of the WebSocket. This parameter may be removed as leaving it blank is better.
          </ul>
      </ul>
    </td>
  </tr>
</table> 
