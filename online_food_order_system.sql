-- Create Restaurants table
CREATE TABLE Restaurants (
  RestaurantID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Description TEXT,
  Address VARCHAR(200) NOT NULL,
  ContactInfo VARCHAR(50) NOT NULL
);

-- Create MenuItems table
CREATE TABLE MenuItems (
  ItemID INT PRIMARY KEY,
  RestaurantID INT NOT NULL,
  Name VARCHAR(100) NOT NULL,
  Description TEXT,
  Price DECIMAL(10,2) NOT NULL,
  Availability BOOLEAN NOT NULL,
  FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID)
);

-- Create Orders table
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT NOT NULL,
  RestaurantID INT NOT NULL,
  ItemID INT NOT NULL,
  OrderDate DATETIME NOT NULL,
  DeliveryStatus VARCHAR(50) NOT NULL,
  TotalAmount DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (RestaurantID) REFERENCES Restaurants(RestaurantID),
  FOREIGN KEY (ItemID) REFERENCES MenuItems(ItemID)
);

-- Create Customers table
CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  Name VARCHAR(100) NOT NULL,
  Email VARCHAR(100) UNIQUE NOT NULL,
  PhoneNumber VARCHAR(20) NOT NULL,
  Address VARCHAR(200) NOT NULL
);

-- Sample Queries

-- Add a new restaurant
INSERT INTO Restaurants (RestaurantID, Name, Description, Address, ContactInfo)
VALUES (1, 'Pizzeria Delizioso', 'Authentic Italian pizza', '123 Main St, Anytown USA', '555-1234');

-- Add a new menu item
INSERT INTO MenuItems (ItemID, RestaurantID, Name, Description, Price, Availability)
VALUES (1, 1, 'Margherita Pizza', 'Classic Neapolitan-style pizza', 15.99, true);

-- Place a new order
INSERT INTO Orders (OrderID, CustomerID, RestaurantID, ItemID, OrderDate, DeliveryStatus, TotalAmount)
VALUES (1, 1, 1, 1, '2023-04-15 18:30:00', 'Pending', 15.99);

-- Get all available menu items for a restaurant
SELECT *
FROM MenuItems
WHERE RestaurantID = 1 AND Availability = true;

-- Get all orders for a customer
SELECT *
FROM Orders
WHERE CustomerID = 1;

-- Update the delivery status of an order
UPDATE Orders
SET DeliveryStatus = 'Delivered'
WHERE OrderID = 1;

-- Generate a report of total sales per restaurant
SELECT r.Name, SUM(o.TotalAmount) AS TotalSales
FROM Orders o
JOIN Restaurants r ON o.RestaurantID = r.RestaurantID
GROUP BY r.Name;
