<!doctype html public "-//w3c/dtd HTML 4.0//en">
<!-- Copyright (c) 2005 by BEA Systems, Inc. All Rights Reserved.-->
<%@ page import="javax.naming.Context,
                 javax.naming.InitialContext,
                 java.lang.System,
                 java.io.PrintWriter,
                 java.util.Enumeration,
                 javax.management.MBeanServer,
                 javax.management.ObjectName" %>

<%!
  String serverName;
  String failoverMessage="";
  private static final String PREFIX_LABEL="SessionServlet.";

  private String getServerName() throws Exception {
    try {
      Context ctx = new InitialContext();
			MBeanServer mbeanServer = (MBeanServer)ctx.lookup("java:comp/env/jmx/runtime");

			String runtimeServiceName =  "com.bea:Name=RuntimeService,Type=weblogic.management.mbeanservers.runtime.RuntimeServiceMBean";

			// Create Objectname for the runtime service
      ObjectName runtimeService = new ObjectName(runtimeServiceName);

			// Get the ObjectName for the ServerRuntimeMBean ObjectName
      ObjectName serverRuntime = (ObjectName) mbeanServer.getAttribute(runtimeService,"ServerRuntime");

			// Get the name of the server
			String serverName = (String) mbeanServer.getAttribute(serverRuntime,"Name");        
      if (serverName == null) return "";
      else return serverName;
    }
    catch (Exception e) {
      throw e;
    }
  }

  private String removePrefix(String name) {
    if (name.startsWith(PREFIX_LABEL))
      name = name.substring(PREFIX_LABEL.length());
    return name;
  }

  private String addPrefix(String name) {
    if (!name.startsWith(PREFIX_LABEL))
      name = PREFIX_LABEL + name;
    return name;
  }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html;CHARSET=iso-8859-1">
<meta name="description" content="BEA WebLogic Server">
<meta name="keywords" content="BEA WebLogic Server">
<title>Cluster Replication of an HTTP Session in Memory</title>
<LINK REL="stylesheet"
TYPE="text/css"
HREF="wls_examples.css"
TITLE="BEA WebLogic Server">
</head>

<body bgcolor="#ffffff" link="#3366cc" vlink="#9999cc" alink="#0000cc">

<!-- RED LINE -->
<table cellspacing="0" cellpadding="0"  border="0" width="100%">
  <tr>
    <td  width="100%" bgcolor="#ff0000" height="1">
      <p class="small">&nbsp;</p>
    </td>
  </tr>
</table>

<!-- TITLE -->
<table border="0" cellspacing="18" cellpadding="0">
  <tr>
    <td valign="top">
      <a HREF="http://www.bea.com"><IMG SRC="images/logo_tm_onwt.jpg" alt="BEA Logo" border="0"></a>
      <h3>Cluster Replication of an HTTP Session in Memory - Session JSP</h3>
    </td>
  </tr>
</table>

<!-- RED LINE -->
<table cellspacing="0" cellpadding="0"  border="0" width="100%">
  <tr>
    <td  width="100%" bgcolor="#ff0000" height="1">
      <p class="small">&nbsp;</p>
    </td>
  </tr>
</table>

<!-- EXAMPLE CONTENT -->
<table summary="EXAMPLES_CONTENT" border="0" cellspacing="18" cellpadding="0">
  <tr>
    <td valign="top">
<%
  try {
    System.out.println("getting Servername");
    serverName = getServerName();
%>
      <p>
      This Cluster Sample Program uses a JSP to demonstrate
      the use of replication of a session in memory, using a cluster-enabled proxy server.
      An end-user client adds or deletes named values to a session. <i>Server affinity</i> allows WebLogic Server to retrieve the same session the next time the client visits the page.
      </p>
      <p>
      Use this form to add some names and values to the session. Enter any names and values you choose.
      You will want to record or remember what you entered, so that when you visit this page again you
      can see replication of a session in memory at work.
      </p>
      <p>
      The information you enter is being replicated to other servers in the cluster. If the managed server
      processing your request should fail, another member of the cluster takes over. This failover is transparent to the
      end-user client.
      </p>
      <p>The server currently hosting this session is <B><%= serverName %><B><%= failoverMessage %></p>
<%
    if (request.getParameter("AddValue") != null) {
      String nameField = request.getParameter("NameField");
      if (nameField != null && nameField.trim().length() > 0)
        session.setAttribute(addPrefix(nameField.trim()),
                      request.getParameter("ValueField"));
    } else if (request.getParameter("DeleteValue") != null) {
      session.removeAttribute(addPrefix(request.getParameter("NameField")));
    }
%>
      <br>
      <center>
      <table border=1 cellspacing="2" cellpadding=5 width=400 bgcolor=#EEEEEE>
        <th colspan=2>Session<br></th>
        <tr>
          <td><B>Name</B></td>
          <td><B>Value</B></td>
        </tr>
<%
    Enumeration sessionNames = session.getAttributeNames();
    String name;
    while (sessionNames.hasMoreElements()) {
      name = (String)sessionNames.nextElement();
      if (!name.startsWith(PREFIX_LABEL)) continue;
      if (removePrefix(name).length() < 1) continue;
%>
        <tr>
          <td><%= removePrefix(name) %></td>
          <td>&nbsp;<%= "" + session.getAttribute(name) %></td>
        </tr>
<%
    } // end of while loop for session names
%>
      </table>
      </center>
    </td>
  </tr>
</table>
<br>

<form method="post" name="Session" action="Session.jsp">
  <center>
  <table border="0" cellspacing="2" cellpadding="5" width="400">
    <th>Name to add/delete</th>
    <th>Value</th>
    <tr>
      <td><input type="text" name="NameField"></td>
      <td><input type="text" name="ValueField"></td>
    </tr>
    <tr>
      <td colspan="2" align=center><input type="submit" value="Add" name="AddValue"></td>
    </tr>
    <tr>
      <td colspan="2" align=center><input type="submit" value="Delete" name="DeleteValue"></td>
    </tr>
  </table>
  </center>
</form>

<%
  }
  catch (Exception ex) {
    ex.printStackTrace(new PrintWriter(out));
  }
%>
<br>
<!-- RED LINE -->
<table cellspacing="0" cellpadding="0"  border="0" width="100%">
  <tr>
    <td  width="100%" bgcolor="#ff0000" height="1">
      <p class="small">&nbsp;</p>
    </td>
  </tr>
</table>

<!-- FOOTER -->
<table cellspacing="0" cellpadding="0" border="0" width="100%">
  <tr>
    <td align="left">
      <p class="copyright">Last updated: March 2002</p>
    </td>
  </tr>
</table>

<!-- RED LINE -->
<table cellspacing="0" cellpadding="0"  border="0" width="100%">
  <tr>
    <td  width="100%" bgcolor="#ff0000" height="1">
      <p class="small">&nbsp;</p>
    </td>
  </tr>
</table>


<p class="copyright"><a href="http://www.bea.com">Home</a> |
  <a href="http://www.bea.com/about/index.html" target="_top">Corporate Info</a> |
  <a href="http://www.bea.com/press/index.html" target="_top">News</a> |
  <a href="http://www.bea.com/solutions/index.html" target="_top">Solutions</a> |
  <a href="http://www.bea.com/products/index.html" target="_top">Products</a> |
  <a href="http://www.bea.com/partners/index.html" target="_top">Partners</a> |
  <a href="http://www.bea.com/services.html" target="_top">Services</a> |
  <a href="http://www.bea.com/events/index.html" target="_top">Events</a> |
  <a href="http://www.bea.com/download.html" target="_top">Download</a> |
  <a href="http://www.bea.com/purchase.html" target="_top">How to Buy</a>
  <br>Copyright 2005, BEA Systems, Inc. All rights reserved.
  <br>Required browser: Netscape 4.0 or higher, or Microsoft Internet Explorer 4.0 or higher.
  <br> <a href="http://www.bea.com/contact/index.html" target="_top">Contact BEA</a>
</p>

</body>
</html>
<%!


%>

