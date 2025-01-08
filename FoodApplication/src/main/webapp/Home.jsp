<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.ns.food.model.Restaurant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Home Page</title>
    <link rel="stylesheet" href="home.css">
</head>
<body>
    <nav class="navbar">
        <div class="logo">
            <span class="site-title">FoodieHub</span>
        </div>
        <div class="welcome-text">
            Welcome Back <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
        </div>
    </nav>

    <div class="search-container">
        <div class="search-filters">
            <div class="search-group">
                <i class="search-icon">🔍</i>
                <input 
                    type="text" 
                    id="searchInput"
                    placeholder="Search restaurants or cuisine..."
                    class="search-input"
                >
            </div>

            <div class="filter-group">
                <select id="cuisineFilter" class="filter-select">
                    <option value="">All Cuisines</option>
                    <option value="Italian">Italian</option>
                    <option value="Chinese">Chinese</option>
                    <option value="Indian">Indian</option>
                    <option value="Japanese">Japanese</option>
                </select>
            </div>

            <div class="filter-group">
                <i class="rating-icon">⭐</i>
                <select id="ratingFilter" class="filter-select">
                    <option value="">Any Rating</option>
                    <option value="4.5">4.5+</option>
                    <option value="4.0">4.0+</option>
                    <option value="3.5">3.5+</option>
                </select>
            </div>

            <div class="filter-group">
                <i class="time-icon">⏰</i>
                <select id="timeFilter" class="filter-select">
                    <option value="">Any Time</option>
                    <option value="30">Under 30 mins</option>
                    <option value="45">Under 45 mins</option>
                    <option value="60">Under 60 mins</option>
                </select>
            </div>
        </div>
    </div>

    <div id="restaurantContainer" class="card-container">
        <% 
        List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("RestaurantList");
        if (restaurantList != null && !restaurantList.isEmpty()) {
            for (Restaurant restaurant : restaurantList) { 
        %>
        <div class="card" 
             data-name="<%= restaurant.getName().toLowerCase() %>"
             data-cuisine="<%= restaurant.getCuisineType() %>"
             data-rating="<%= restaurant.getRatings() %>"
             data-time="<%= restaurant.getDeliveryTime() %>">
            <img 
                src="<%= restaurant.getImagePath() %>" 
                alt="<%= restaurant.getName() %>" 
                class="restaurant-image" 
                onerror="this.onerror=null; this.src='images/default.jpg';"
            >
            <div class="card-content">
                <h2 class="card-title"><%= restaurant.getName() %></h2>
                <p class="card-subtitle"><%= restaurant.getCuisineType() %> Cuisine</p>
                <div class="restaurant-info">
                    <p class="delivery-time">
                        <i class="time-icon">⏰</i>
                        <%= restaurant.getDeliveryTime() %> mins
                    </p>
                    <p class="ratings">
                        <i class="star-icon">⭐</i>
                        <span><%= restaurant.getRatings() %> / 5</span>
                    </p>
                </div>
                <p class="address"><%= restaurant.getAddress() %></p>
                <a href="MenuServlet?restaurantId=<%= restaurant.getRestaurantId() %>" class="view-menu-link">
                    View Menu
                </a>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
        <p class="no-restaurants">No restaurants available at the moment.</p>
    <% } %>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const cuisineFilter = document.getElementById('cuisineFilter');
            const ratingFilter = document.getElementById('ratingFilter');
            const timeFilter = document.getElementById('timeFilter');
            const cards = document.querySelectorAll('.card');

            function filterRestaurants() {
                const searchTerm = searchInput.value.toLowerCase();
                const selectedCuisine = cuisineFilter.value;
                const selectedRating = parseFloat(ratingFilter.value) || 0;
                const selectedTime = parseInt(timeFilter.value) || Number.MAX_VALUE;

                cards.forEach(card => {
                    const name = card.dataset.name;
                    const cuisine = card.dataset.cuisine;
                    const rating = parseFloat(card.dataset.rating);
                    const time = parseInt(card.dataset.time);

                    const matchesSearch = name.includes(searchTerm) || 
                                       cuisine.toLowerCase().includes(searchTerm);
                    const matchesCuisine = !selectedCuisine || cuisine === selectedCuisine;
                    const matchesRating = rating >= selectedRating;
                    const matchesTime = time <= selectedTime;

                    if (matchesSearch && matchesCuisine && matchesRating && matchesTime) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });

                // Show/hide no results message
                const visibleCards = document.querySelectorAll('.card[style=""]').length;
                let noResults = document.querySelector('.no-results');
                
                if (visibleCards === 0) {
                    if (!noResults) {
                        noResults = document.createElement('p');
                        noResults.className = 'no-restaurants no-results';
                        noResults.textContent = 'No restaurants match your search criteria.';
                        document.getElementById('restaurantContainer').appendChild(noResults);
                    }
                    noResults.style.display = '';
                } else if (noResults) {
                    noResults.style.display = 'none';
                }
            }

            // Add event listeners
            searchInput.addEventListener('input', filterRestaurants);
            cuisineFilter.addEventListener('change', filterRestaurants);
            ratingFilter.addEventListener('change', filterRestaurants);
            timeFilter.addEventListener('change', filterRestaurants);
        });
    </script>
</body>
</html>
