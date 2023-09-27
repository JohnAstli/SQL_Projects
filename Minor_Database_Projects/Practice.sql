 

CREATE TABLE cats 
(

	cat_id INT AUTO_INCREMENT,
    name VARCHAR (30), 
    breed VARCHAR(30) ,
    age INT,
    PRIMARY KEY (cat_id)
    
);

DESC cats;

INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
	   ('Cindy', 'Maine Coon', 10),
	   ('Dumbledore', 'Maine Coon', 11),
	   ('Egg', 'Persian', 4),
	   ('Misty', 'Tabby', 13),
	   ('George Michael', 'Ragdoll', 9),
	   ('Jackson', 'Sphynx', 7);
SELECT * FROM cats;
SELECT cat_id FROM cats;
SELECT name, breed FROM cats;
SELECT name, age FROM cats WHERE breed= 'Tabby' ; 
SELECT cat_id, age FROM cats WHERE cat_id= age; 

SELECT cat_id AS id FROM cats; 

SELECT name FROM cats WHERE name='Jackson' ; 
UPDATE cats SET name = 'Jack' WHERE name= 'Jackson' ; 
SELECT name FROM cats;
SELECT name, breed FROM  cats WHERE name = 'Ringo';
UPDATE cats SET breed = 'British Shorthair' WHERE name = 'Ringo'; 
SELECT name, age FROM cats WHERE breed = 'Maine Coon';
UPDATE cats SET age = 12 WHERE breed = 'Maine Coon'; 

SELECT * FROM cats WHERE age = 4; 
DELETE FROM cats WHERE age = 4 ; 
SELECT * FROM cats ; 
DELETE FROM cats ; 
SELECT * FROM cats WHERE cat_id = age ; 
DELETE FROM cats WHERE cat_id= age ; 

DESC cats; 
