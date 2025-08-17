-- CPRG 250 PROJECT 2--
-- Phase two: Data Implementation -- 
-- Create tables --
-- Author: Hoang Phuong Uyen Nguyen --

--Delete all existing tables from public
DROP TABLE IF EXISTS MovieAdvisory CASCADE;
DROP TABLE IF EXISTS MovieDirector CASCADE;
DROP TABLE IF EXISTS MovieCategory CASCADE;
DROP TABLE IF EXISTS MovieActor CASCADE;
DROP TABLE IF EXISTS Wishlist CASCADE;
DROP TABLE IF EXISTS Rental CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Movie CASCADE;
DROP TABLE IF EXISTS Advisory CASCADE;
DROP TABLE IF EXISTS Director CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS Actor CASCADE;

--Create a new tables

--PARENT TABLES

--MOVIE
CREATE TABLE Movie (
	movie_id INT PRIMARY KEY,
	title VARCHAR(255),
	duration_minutes SMALLINT CHECK(duration_minutes > 0),
	rating CHAR(3) CHECK (rating IN ('G','PG','14A','18A','R')),
	sd_price DECIMAL(10,2),
	hd_price DECIMAL(10,2),
	is_new_release BOOLEAN,
	is_most_popular BOOLEAN,
	is_coming_soon BOOLEAN
);
-- ADVISORY
CREATE TABLE Advisory (
	advisory_id INT PRIMARY KEY,
	short_desc TEXT,
	long_desc TEXT
);
-- DIRECTOR
CREATE TABLE Director (
	director_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	date_of_birth DATE,
	email VARCHAR(255)
);
-- CATEGORY
CREATE TABLE Category (
	category_id INT PRIMARY KEY,
	category_name VARCHAR(255),
	parent_category_id INT --fk from Category
);
-- ACTOR
CREATE TABLE Actor (
	actor_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	date_of_birth DATE,
	email VARCHAR(255)
);
-- RENTAL
CREATE TABLE Rental (
	rental_id INT PRIMARY KEY,
	customer_id INT, -- fk from Customer
	movie_id INT , -- fk from Movie
	rental_date DATE,
	start_view_date DATE CHECK (start_view_date > rental_date),
	expiry_date DATE CHECK (expiry_date > start_view_date),
	price_paid DECIMAL(10,2),
	credit_card_num VARCHAR(20),
	credit_card_type CHAR(2) CHECK(credit_card_type IN ('AX','MC','VS')),
    customer_rating INT CHECK (customer_rating BETWEEN 1 AND 5)
);
-- CUSTOMER
CREATE TABLE Customer (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(255) CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
	default_credit_card_num VARCHAR(20),
	credit_card_type CHAR(2) CHECK(credit_card_type IN ('AX','MC','VS')),
	address VARCHAR(255),
	postal_code CHAR(6)CHECK (postal_code ~ '^[A-Za-z][0-9][A-Za-z][0-9][A-Za-z][0-9]$') ,
	phone_number CHAR(12) CHECK (phone_number ~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{4}$')
);
-- WISHLIST
CREATE TABLE Wishlist (
	wishlist_id INT PRIMARY KEY,
	customer_id INT, -- fk from Customer
	movie_id INT, -- fk from Movie
	date_added DATE
);

-- CHILD TABLES

-- Movie - Advisory
CREATE TABLE MovieAdvisory (
	movie_id INT, --fk from Movie
	advisory_id INT, --fk from Advisory
	PRIMARY KEY(movie_id,advisory_id)
);
-- Movie - Director
CREATE TABLE MovieDirector (
	director_id INT, -- fk from Director
	movie_id INT, -- fk from Movie
	PRIMARY KEY(director_id,movie_id)
);
-- Movie Category
CREATE TABLE MovieCategory (
	movie_id INT, -- fk from Movie
	category_id INT, -- fk from Category
	PRIMARY KEY(movie_id,category_id)
);
-- Movie Actor
CREATE TABLE MovieActor (
	movie_id INT, -- fk from Movie
	actor_id INT, -- fk from Actor
	role_name VARCHAR(255),
	PRIMARY KEY(movie_id,actor_id)
);

-- CONSTRAINTS

-- Foreign keys  

-- Category -> Parent_Category
ALTER TABLE Category
ADD CONSTRAINT fk_parent_category
FOREIGN KEY (parent_category_id) REFERENCES Category(category_id);

-- Rental -> (Customer, Movie)
ALTER TABLE Rental
ADD CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
ADD CONSTRAINT fk_rental_movie    FOREIGN KEY (movie_id)    REFERENCES Movie(movie_id);

-- Wishlist -> (Customer, Movie)
ALTER TABLE Wishlist
ADD CONSTRAINT fk_wishlist_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
ADD CONSTRAINT fk_wishlist_movie    FOREIGN KEY (movie_id)    REFERENCES Movie(movie_id);

-- MovieAdvisory -> (Movie, Advisory)
ALTER TABLE MovieAdvisory
ADD CONSTRAINT fk_movieadvisory_movie    FOREIGN KEY (movie_id)    REFERENCES Movie(movie_id),
ADD CONSTRAINT fk_movieadvisory_advisory FOREIGN KEY (advisory_id) REFERENCES Advisory(advisory_id);

-- MovieDirector -> (Movie, Director)
ALTER TABLE MovieDirector
ADD CONSTRAINT fk_moviedirector_movie    FOREIGN KEY (movie_id)    REFERENCES Movie(movie_id),
ADD CONSTRAINT fk_moviedirector_director FOREIGN KEY (director_id) REFERENCES Director(director_id);

-- MovieCategory -> (Movie, Category)
ALTER TABLE MovieCategory
ADD CONSTRAINT fk_moviecategory_movie    FOREIGN KEY (movie_id)    REFERENCES Movie(movie_id),
ADD CONSTRAINT fk_moviecategory_category FOREIGN KEY (category_id) REFERENCES Category(category_id);

-- MovieActor -> (Movie, Actor)  ✅ FIXED TARGET TABLE
ALTER TABLE MovieActor
ADD CONSTRAINT fk_movieactor_movie FOREIGN KEY (movie_id) REFERENCES Movie(movie_id),
ADD CONSTRAINT fk_movieactor_actor FOREIGN KEY (actor_id) REFERENCES Actor(actor_id);

