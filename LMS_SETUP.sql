-- Library Management System Setup

-- Create Books Table
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Title VARCHAR(255),
    Author VARCHAR(255),
    Genre VARCHAR(100),
    AvailabilityStatus VARCHAR(20)
);

-- Create Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE
);

-- Create Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ISBN VARCHAR(13),
    IssueDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

-- Insert Sample Data into Books Table
INSERT INTO Books (ISBN, Title, Author, Genre, AvailabilityStatus) VALUES
('978-3-16-148410-0', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'Available'),
('978-1-56619-909-4', '1984', 'George Orwell', 'Dystopian', 'Available');

-- Insert Sample Data into Users Table
INSERT INTO Users (Name, Email) VALUES
('John Doe', 'john.doe@example.com'),
('Jane Smith', 'jane.smith@example.com');

-- Query 1: Fetch all available books
SELECT * FROM Books WHERE AvailabilityStatus = 'Available';

-- Query 2: Track overdue books
SELECT * FROM Transactions WHERE ReturnDate < CURDATE();

-- Query 3: Get borrowing history for a specific user
SELECT t.TransactionID, b.Title, t.IssueDate, t.ReturnDate
FROM Transactions t
JOIN Books b ON t.ISBN = b.ISBN
WHERE t.UserID = 1;  -- Change UserID as needed

-- Query 4: Count total books by genre
SELECT Genre, COUNT(*) AS TotalBooks
FROM Books
GROUP BY Genre;

-- Query 5: Check the availability of a specific book
SELECT Title, AvailabilityStatus
FROM Books
WHERE ISBN = '978-3-16-148410-0';  -- Change ISBN as needed
