-----------9---------------

DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Book;

CREATE TABLE Book(book_id INT PRIMARY KEY,
					title VARCHAR(150) NOT NULL,
					author VARCHAR(150) NOT NULL,
					publ_year INT CHECK (publ_year>0));

CREATE TABLE Member(member_id INT PRIMARY KEY,
					name VARCHAR(200) NOT NULL,
					email VARCHAR(200) UNIQUE NOT NULL,
					phone_number VARCHAR(15) UNIQUE NOT NULL);

CREATE TABLE Loan(
					loan_id INT PRIMARY KEY,
					book_id INT NOT NULL,
					member_id	 INT NOT NULL,
					loan_date DATE NOT NULL,
					return_date DATE,
					FOREIGN KEY (book_id) REFERENCES Book(book_id),
						FOREIGN KEY (member_id) REFERENCES Member(member_id)
					);

INSERT INTO Book(book_id, title, author, publ_year) 
			Values (1, 'title1', 'author1', 2024),
					(2, 'title2', 'author2', 2024),
					(3, 'title2', 'author3', 2024);
	

INSERT INTO Member(member_id, name, email, phone_number) 
			Values (1, 'name1', 'name1@gmail.com', '88-169-06-07'),
					(2, 'name2', 'name2@gmail.com', '88-169-06-06'),
					(3, 'name3', 'name3@gmail.com', '88-169-06-05');


INSERT INTO Loan(loan_id, book_id, member_id, loan_date)
			Values (1, 1, 1, '2024-07-07'),
					(2, 2, 2, '2024-07-07'),
					(3, 3, 3, '2024-07-07');


SELECT * FROM Book;
SELECT * FROM Member;
SELECT * FROM Loan;