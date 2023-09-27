/* Creating the spring clothes database */
CREATE DATABASE shirts_db;

/* An important step so as to not create a table in another databe */
USE shirts_db; 

/* The creation of shirt table */
CREATE TABLE shirts (

	shirt_id INT AUTO_INCREMENT, 
    article VARCHAR(20) , 
    color VARCHAR(20) ,
    shirt_size VARCHAR(5) ,
    last_worn INT ,
    PRIMARY KEY (shirt_id)
);

DESC shirts; 

/* Inserting the first values of the table */
INSERT INTO shirts (article, color, shirt_size, last_worn) 
VALUES ('t-shirt', 'white', 'S', 10),
('t-shirt', 'green', 'S', 200),
('polo shirt', 'black', 'M', 10),
('tank top', 'blue', 'S', 50),
('t-shirt', 'pink', 'S', 0),
('polo shirt', 'red', 'M', 5),
('tank top', 'white', 'S', 200),
('tank top', 'blue', 'M', 15);

/* Lets get all the data from the table*/
SELECT * FROM shirts;

/* Will add a new entry on the table*/
INSERT INTO shirts (article, color, shirt_size, last_worn) 
VALUES ('polo shirt', 'purple', 'M' , 50);

/* Will print all the shirts but show only article and color */
SELECT article, color FROM shirts;

/* Print all medium shirts, but not show the shirt_id values */
SELECT article, color, shirt_size, last_worn FROM shirts 
WHERE shirt_size = 'M' ;

/* Update all polo shirts to size L */
UPDATE shirts SET shirt_size= 'L' WHERE article= 'polo shirt' ;

/* Update the shirt that was worn 15 days ago to 0 */
UPDATE shirts SET last_worn = 0 WHERE last_worn= 15 ;

/* Update all white shirts to size XS and color to off white */
UPDATE shirts SET shirt_size = 'XS', color= 'off white' WHERE color= 'white' ; 

/* Delete all old shirts (last worn to 200 days ago) */ 
DELETE FROM shirts WHERE last_worn = 200 ; 

/* Delete all tank tops */
DELETE FROM shirts WHERE article = 'tank top';

/*Delete all shirts */
DELETE FROM shirts; 

/* Drop table */ 
DROP TABLE shirts ; 


