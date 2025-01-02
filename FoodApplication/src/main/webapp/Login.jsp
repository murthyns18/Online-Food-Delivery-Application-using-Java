<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="loginn.css"> 
</head>
<body>
    <div class="container">
        <h1>Sign In To Your Account</h1>
            <p>Don't have an account? <a href="Register.jsp">Sign Up</a></p>
            
        <form action="Login" method="post" class="form-container">
            <label for="email">Enter your email</label>
            <input type="email" id="email" name="email" required>
            <label for="password">Enter your password</label>
            <input type="password" id="password" name="password" required>
            <button type="submit" class="btn primary-btn">Login</button>
        </form>
    </div>
</body>
</html>
