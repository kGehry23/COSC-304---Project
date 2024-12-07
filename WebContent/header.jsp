<%

    String username = session.getAttribute("authenticatedUser") == null ?
            null : session.getAttribute("authenticatedUser").toString();

    String userGreeting = "Guest";
    String loginLink = "login.jsp";
    String loginMsg = "Login";

    if (username != null) {
        userGreeting = username;
        loginLink = "logout.jsp";
        loginMsg = "Logout";
    }
%>


<!DOCTYPE html>
<html lang="en">

<body>
    <nav style="display: flex; justify-content: flex-end; background-color: #f8f9fa; padding: 10px;">
        <ul style="list-style: none; display: flex; margin: 0; padding: 0;">
            <li style="margin: 0 10px;">
                <a href="index.jsp" style="text-decoration: none; color: black;">Home</a>
            </li>
        </ul>
        <div style="margin-left: 20px;">
            <span style="margin-right: 10px;">Welcome, <%= userGreeting %></span>
            <a href="<%= loginLink %>" style="text-decoration: none; color: white; background-color: blue; padding: 5px 10px; border-radius: 5px;">
                <%= loginMsg %>
            </a>
        </div>
    </nav>
</body>
</html> 
