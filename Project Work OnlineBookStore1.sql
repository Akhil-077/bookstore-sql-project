create database OnlineBookStore;
use OnlineBookStore;

Drop Table If Exists Books;
create table books (
Book_Id int ,
Title varchar(500),
Author varchar(500),
Genre varchar(500),
Published_Year int,
Price numeric (10, 2),
Stock int
);
select * from Books;


Drop Table If Exists Customers;
create table customers(
Customer_ID int,
Name varchar(500),
Email varchar(500) primary key,
Phone int,
City varchar(500),
Country varchar(500)
);

 select * from Customers;

Drop Table If Exists orders;
Create table Orders (
Order_ID int,
Book_ID int References Books(Book_ID),
Customer_ID int  References Customers(Custer_ID),
Order_date DATE,
Quantity int,
Total_Amount  numeric ( 10,2)
);
ALTER TABLE orders
RENAME COLUMN oreder_ID  TO order_ID;
select * from orders;
 
  
  
  -- 1) retrieve all books in the friction genre ?
  
  select * from books
  where genre = 'fiction';
  
  -- 2) Find books published after the year 1950
  
   select * from books 
   where published_year >1950
   order by published_year;
   
   -- 3) List all customers from the canada ?
    
    select * from customers
    where country = 'canada'
    order by country;
    
    -- 4) show orders placed in november 2023
    
      select * from orders
      where order_date between'2023-01-01' and '2023-12-31';
      
      -- 5) Retrieve the total stock of books ?
      
       select sum(stock) from books
       order by stock;
	
    -- 6) find the details of the most expensive book ?
    
     select max(price) from books;
             -- (or)
   select * from books order by Price DESC LIMIT 1;
   
    -- 7) show all customers who ordered more than 1 quantity of a book ?
    
      select * from orders
      where quantity>1
      order by quantity;
      
      -- 8) Retrieve all orders where the total amount exceeds $20 ?
      
        select * from orders
        where total_amount >20;
      
      -- 9) List all genre available in the books table ?
      
       select distinct (genre) from books;
       
       -- 10) find the books with the lowest stock ?
       
        select min(stock) from books;
             -- (or)
	   select * from books order by stock ASC Limit 1;
       
       -- 11) calculate the total revenue generated from all orders ?
       
        select sum(total_amount) AS revenue from orders;
        
        -- 12) retrieve the total number of books sold for each genre ?
        
         select b.genre, sum(o.quantity) as Total_Books_Sold
         from orders o
         join books b on o.Book_ID = b.Book_Id
         group by b.genre;
        
        -- 13) find the average price of books in the fantasy genre ?
        
         select avg(price) as Average_Price 
         from books
         where genre = 'fantasy';
         
         -- 14) List customers who have placed at least 2 orders ?
         
          select o.customer_ID,c.name, count(o.order_id) as Order_Count
          from orders o
          join customers c on o.Customer_ID = c.Customer_ID
          group by o.Customer_ID, c.name
          Having count(order_ID)>=2;
          
          -- 15) Find the most frequently ordered book ?
          
          select o.book_ID, b.title, count(o.order_ID) as ORDER_COUNT
          from orders o
          join books b on o.book_ID = b.Book_Id
          group by o.Book_ID,b.Title
          order by order_count DESC LIMIT 1;
          
          -- 16) Show the top 3 most expensive books of fantasy genre ?
          
          select * from books
          where genre = 'fantasy'
          order by price DESC LIMIt 3;
          
           -- 17) Retrieve the total quantity of boos sold by each author ?
           
           select  b.author, sum(o.quantity) as TOTAL_BOOKS_SOLD
           from orders o 
           join books b on o.Book_Id = b.Book_Id
           group by b.Author;
           
           -- 18) List the cities where customers who spent over $30 are located ?
          
         select distinct c.city, TOTAL_AMOUNT
         from orders o 
         join customers c on o.Customer_ID = c.Customer_ID
         where o.Total_Amount > 30;
        
        -- 19)  Find the customers who spendthe most on orders ?
      
       select c.customer_ID, c.name, sum(o.total_amount) as TOTAL_SPENT
       from orders o 
       join customers c on o.Customer_ID = c.Customer_ID
       group by c.Customer_ID, c.name
       order by Total_spent DESC limit 1;
       
	-- 20) calculate the stock remaining after fulfilling all orders
	SELECT 
    b.Book_Id, 
    b.Title, 
    b.Stock, 
    COALESCE(SUM(o.Quantity), 0) AS Order_Quantity,
    b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o 
    ON b.Book_Id = o.Book_Id
GROUP BY b.Book_Id, b.Title, b.Stock;

         