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
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            margin: 0;
            background-color: #555;
        }

        ul.topnav {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
        }

        ul.topnav li {
            float: left;
        }

        ul.topnav li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        ul.topnav li a:hover:not(.active) {
            background-color: #0454aa;
        }

        ul.topnav li a.active {
            background-color: #0454aa;
        }

        ul.topnav li.right {
            float: right;
        }

        @media screen and (max-width: 600px) {
            ul.topnav li.right, 
            ul.topnav li {
                float: none;
            }
        }

        .welcome-message {
            font-family: Georgia, 'Times New Roman', Times, serif;
            color: white;
            margin: 0 10px;
            padding: 14px 16px;
        }
    </style>
</head>
<body>
    <ul class="topnav">
        <li class="right"><span class="welcome-message">Welcome, <%= userGreeting %></span></li>
    </ul>
</body>
</html>
