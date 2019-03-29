CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
(creates a copy of the databse to be normalized)

CREATE TABLE BOOKSHELVES (id SERIAL PRIMARY KEY, name VARCHAR(255));
(creates second table in lab14_normal database named bookshelves)

INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;
(query uses subquery to retrieve unique bookshelf values from books table and insert each into bookshelves table in the name column)

ALTER TABLE books ADD COLUMN bookshelf_id INT;
(adds column to books table named bookshelf_id to connect each book to a specific bookshelf in the other table)

UPDATE books SET bookshelf_id=shelf.id FROM (SELECT * FROM bookshelves) AS shelf WHERE books.bookshelf = shelf.name;
(prepares connection between the two tables. runs subquery for every row in books table that finds bookshelf row with name matching current book bookshelf value. id of bookshelf row is set as value of bookshelf_id property in current book row)

ALTER TABLE books DROP COLUMN bookshelf;
(modifies books table by removing column named bookshelf)

ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);
(modifies data type of bookshelf_id in books table, sets it as foreign key to reference primary key in bookshelves table)