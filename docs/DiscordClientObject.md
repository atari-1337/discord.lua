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
        <li>
          <code>string</code> <code>token</code>
            <ul TYPE="disc">
              <li>
                The token of the Client.
              </li>
            </ul>
        </li>
        <li>
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
        </li>
      </ul>
    </td>
  </tr>
</table> 
