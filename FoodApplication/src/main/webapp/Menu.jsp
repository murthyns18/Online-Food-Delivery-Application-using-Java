<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.ns.food.model.Menu" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Items</title>
    <link rel="stylesheet" href="mennu.css">
</head>
<body>
<header>
    <h1 class="main-title">Menu Items</h1>
</header>
<div class="menu-container">
    <%
        List<Menu> menuList = (List<Menu>) session.getAttribute("MenuList");
        if (menuList != null && !menuList.isEmpty()) {
            for (Menu menu : menuList) {
    %>
    <div class="menu-item">
        <img src="<%= menu.getImagePath() %>" alt="<%= menu.getName() %>" class="menu-image">
        <div class="menu-details">
            <h2 class="menu-title"><%= menu.getName() %></h2>
            <p class="menu-description"><%= menu.getDescription() %></p>
            <p class="menu-price"><strong>Price:</strong> ₹<%= menu.getPrice() %></p>
        </div>
        
        <form action="CartServlet" method="post" class="cart-form">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="itemId" value="<%= menu.getMenuId() %>">
            <label for="quantity-<%= menu.getMenuId() %>">Quantity:</label>
            <input type="number" id="quantity-<%= menu.getMenuId() %>" name="quantity" value="1" min="1" class="quantity-input">
            <button type="submit" class="add-to-cart-btn">Add to Cart</button>
        </form>
    </div>
    <% 
            }
        } 
        else 
        { 
    %>
    <p class="no-menu">No menu items available for this restaurant.</p>
    <% } %>
</div>
</body>
</html>
