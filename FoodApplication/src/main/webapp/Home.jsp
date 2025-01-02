<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.ns.food.model.Restaurant" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Home Page</title>
    <link rel="stylesheet" href="hoome.css"> 
</head>
<body>
    <h1>Welcome Back <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></h1>

    <header>
        <h1 class="main-title">"From our kitchen to your plate, an adventure in every bite."</h1>
    </header>

    <%
        List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("RestaurantList");
        if (restaurantList != null && !restaurantList.isEmpty()) 
        {
    %>
    <div class="card-container">
        <% for (Restaurant restaurant : restaurantList)
        { %>
        <div class="card">
            <img 
                src="<%= restaurant.getImagePath() %>" 
                alt="<%= restaurant.getName() %>" 
                class="restaurant-image" 
                onerror="this.onerror=null; this.src='images/default.jpg';"
            >
            <div class="card-content">
                <h2 class="card-title"><%= restaurant.getName() %></h2>
                <p class="card-subtitle"><%= restaurant.getCuisineType() %> Cuisine</p>
                <p><strong>Delivery Time:</strong> <%= restaurant.getDeliveryTime() %> mins</p>
                <p><strong>Address:</strong> <%= restaurant.getAddress() %></p>
                <p class="ratings"><strong>Ratings:</strong> <span><%= restaurant.getRatings() %> / 5</span></p>
                <a href="MenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>" class="view-menu-link">View Menu</a>
            </div>
        </div>
        <% } %>
    </div>
    <% } 
        else 
        { %>
    		<p class="no-restaurants">No restaurants available at the moment.</p>
    <% } %>
</body>
</html>