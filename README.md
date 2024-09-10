DBMS code 

create database project;
use project;


CREATE TABLE loan (
    LoanId VARCHAR(20) NOT NULL,
    user VARCHAR(50) NOT NULL,
    LoanAmount DECIMAL(19,2) NOT NULL,
    InterestRate DECIMAL(5,4),
    StartDate DATE NOT NULL,
    EndDate DATE,
    RemainingBalance DECIMAL(19,2) NOT NULL,
    LoanTerm INT,
    LoanStatus VARCHAR(20),
    PRIMARY KEY (LoanId),
    FOREIGN KEY (user) REFERENCES login(username)
);


CREATE TABLE login (
    username VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    Salary DECIMAL(19,2) NOT NULL,
    PRIMARY KEY (username)
);


CREATE TABLE payment (
    PaymentID INT NOT NULL AUTO_INCREMENT,
    LoanID VARCHAR(20) NOT NULL,
    PaymentDate DATE,
    PaymentAmount DECIMAL(15,2),
    PaymentType VARCHAR(20),
    PaymentStatus VARCHAR(20),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (LoanID) REFERENCES loan(LoanId)
);
