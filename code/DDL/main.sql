CREATE TABLE Shops ( 
Name_ Varchar(100), 
PRIMARY KEY(Name_)
);


CREATE TABLE Products (
Name_ Varchar(100), 
Maker VarChar(100) NOT NULL,
Category VarChar(100) NOT NULL,
PRIMARY KEY(Name_)
);


CREATE TABLE Users(
ID Int,
Name_ VarChar(100) NOT NULL,
PRIMARY KEY(ID)
);


CREATE TABLE Products_in_shops (
PName VarChar(100) REFERENCES Products(Name_), 
Sname VarChar(100), 
Price Float NOT NULL, 
Quantity Int NOT NULL,
PRIMARY KEY(Pname,Sname),
FOREIGN KEY(Pname) REFERENCES Products(Name_) 
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(Sname) REFERENCES Shops(Name_)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Price_History (
Pname VarChar(100),
Sname VarChar(100),
Start_date_ Date,
End_date Date,
Price Float NOT NULL,
PRIMARY KEY(Pname,Sname,Start_date_,End_date),
FOREIGN KEY(Pname) REFERENCES Products(Name_)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(Sname) REFERENCES Shops(Name_)
ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Orders (
ID Int,
UserID Int,
Shipping_Address VarChar(100) NOT NULL,
Date_time DateTime NOT NULL,
UNIQUE(UserID,Date_time),
PRIMARY KEY(ID),
FOREIGN KEY(UserID) REFERENCES Users(ID)
ON DELETE SET NULL ON UPDATE SET NULL
);


CREATE TABLE Product_in_Orders(
Pname VarChar(100) REFERENCES Products(Name_),
OrderID Int,
Sname VarChar(100),
Status_ VarChar(100) NOT NULL,
Delivery_date Date,
Quantity Int NOT NULL,
Price Float NOT NULL,
PRIMARY KEY(Pname,OrderID,Sname),
FOREIGN KEY(Pname) REFERENCES Products(Name_)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(OrderID) REFERENCES Orders(ID),
FOREIGN KEY(Sname) REFERENCES Shops(Name_)
ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Feedback(
UserID Int,
Date_time DateTime,
Pname VarChar(100) NOT NULL,
Sname VarChar(100) NOT NULL,
OrderID Int NOT NULL,
Rating Int NOT NULL,
Comment VarChar(100),
PRIMARY KEY(UserID, Date_time),
FOREIGN KEY(UserID) REFERENCES Users(ID),
FOREIGN KEY(Pname) REFERENCES Products(Name_)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(Sname) REFERENCES Shops(Name_)
ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(OrderID) REFERENCES Orders(ID)
);


CREATE TABLE Employees(
ID Int,
Name_ VarChar(100) NOT NULL,
Salary Float NOT NULL,
PRIMARY KEY(ID)
);


CREATE TABLE Complaints(
ID Int,
Text_ VarChar(100) NOT NULL,
Status_ VarChar(20) NOT NULL,
EmployeeID Int,
Filed_date_time DateTime NOT NULL,
Handled_date_time DateTime,
UserID Int NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(UserID) REFERENCES Users(ID),
FOREIGN KEY(EmployeeID) REFERENCES Employees(ID)
);


CREATE TABLE Complaints_on_Orders(
ComplaintID Int REFERENCES Complaints(ID),
OrderID Int NOT NULL,
PRIMARY KEY(ComplaintID),
FOREIGN KEY(ComplaintID) REFERENCES Complaints(ID),
FOREIGN KEY(OrderID) REFERENCES Orders(ID)
);


CREATE TABLE Complaints_on_Shops(
ComplaintID Int REFERENCES Complaints(ID),
SName VarChar(100) NOT NULL,
PRIMARY KEY(ComplaintID),
FOREIGN KEY(Sname) REFERENCES Shops(Name_),
FOREIGN KEY(ComplaintID) REFERENCES Complaints(ID)
);