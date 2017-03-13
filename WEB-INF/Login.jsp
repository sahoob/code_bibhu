<html>
<head>
<title>Login Page for Example FormBasedAuth</title>
</head>
<body bgcolor="white">
<h2>Custom Login Page</h2>
<hr>

<!--
  This is the custom logon page.  You must use the exact action and form field names
  for a custom logon page.
-->

<form method="POST" action="j_security_check">
  <table border="0" cellspacing="5">
    <tr>
      <th align="right">Username:</th>
      <td align="left"><input type="text" name="j_username"></td>
    </tr>
    <tr>
      <th align="right">Password:</th>
      <td align="left"><input type="password" name="j_password"></td>
    </tr>
    <tr>
      <td align="right"><input type="submit" value="Login"></td>
      <td align="left"><input type="reset"></td>
    </tr>
  </table>
</form>
</body>
</html>

