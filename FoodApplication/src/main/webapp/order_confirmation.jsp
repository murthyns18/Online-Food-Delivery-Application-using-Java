<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ns.food.model.Orders" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="orderConfirmation.css">
</head>
<body>
    <div class="bike-container"></div>

    <div class="confirmation-container">
        <h1>Order Placed Successfully</h1>
        <%
            Orders order = (Orders) session.getAttribute("order");

            if (order != null) 
            {
        %>
        <div class="order-details">
            <h2>Thank you for your order!</h2>
            <p>Order ID: <strong><%= order.getOrdersId() %></strong></p>
            <p>Restaurant ID: <strong><%= order.getRestaurantId() %></strong></p>
            <p>Total Amount: <strong>₹<%= order.getTotalAmount() %></strong></p>
            <p>Payment Mode: <strong><%= order.getPaymentMode() %></strong></p>
            <p>Status: <strong><%= order.getStatus() %></strong></p>
        </div>
        <div class="next-steps">
            <p class="msg">You will receive a order shortly.</p>
            <a href="Home.jsp" class="btn">Return to Home</a>
        </div>
        <% } else { %>
        <div class="error-message">
            <h2>Something went wrong!</h2>
            <p>We couldn't retrieve your order details. Please contact support.</p>
            <a href="Home.jsp" class="btn">Return to Home</a>
        </div>
        <% } %>
    </div>

    <script>
        window.addEventListener('load', () => {
            const bike = document.querySelector('.bike-container');
            bike.style.display = 'block'; 
        });
    </script>
</body>
</html>
