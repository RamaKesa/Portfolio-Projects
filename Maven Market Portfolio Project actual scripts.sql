
-- CREATE TABLE CUSTOMERS

CREATE TABLE mavenmarket_customers(
	customer_id SERIAL PRIMARY KEY,
	customer_acct_num BIGINT,
	first_name VARCHAR(20),
	last_name VARCHAR (20),
	customer_address VARCHAR (50),
	customer_city VARCHAR (20),
	customer_state_province VARCHAR(20),
	customer_postal_code INT,
	customer_country VARCHAR (20),
	birthdate VARCHAR (20),
	marital_status VARCHAR (10),
	yearly_income VARCHAR (50),
	gender VARCHAR (10),
	total_children INT,
	num_children_at_home INT,
	education VARCHAR (50),
	acct_open_date VARCHAR (20),
	member_card VARCHAR (50),
	occupation VARCHAR (50),
	homeowner VARCHAR (10)
);

SELECT * FROM mavenmarket_customers;

COPY mavenmarket_customers FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Customers.csv' delimiter ',' csv header;  



-- CREATE TABLE PRODUCTS

CREATE TABLE mavenMarket_products(
	product_id SERIAL PRIMARY KEY,
	product_brand VARCHAR (20),
	product_name VARCHAR (50),
	product_sku BIGINT,
	product_retail_price VARCHAR (10),
	product_cost VARCHAR (10),
	product_weight VARCHAR (10) ,
	recyclable INT,
	low_fat INT
);

SELECT * FROM mavenmarket_products;

COPY mavenmarket_products FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Products.csv' delimiter ',' csv header;



-- CREATE TABLE CALENDAR

CREATE TABLE mavenMarket_calendar(
	date VARCHAR (20)
);

SELECT * FROM mavenmarket_calendar;

COPY mavenmarket_calendar FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Calendar.csv' delimiter ',' csv header;



-- CREATE TABLE STORES

CREATE TABLE mavenmarket_stores(
	store_id SERIAL PRIMARY KEY,
	region_id INT,
	store_type VARCHAR (50),
	store_name VARCHAR (20),
	store_street_address VARCHAR (100),
	store_city VARCHAR (20),
	store_state VARCHAR (50),
	store_country VARCHAR (20),
	store_phone VARCHAR (50),
	first_opened_date VARCHAR (20),
	last_remodel_date VARCHAR (20),
	total_sqft INT,
	grocery_sqft INT
);

SELECT * FROM mavenmarket_stores;

COPY mavenmarket_stores FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Stores.csv' delimiter ',' csv header;



-- CREATE TABLE REGIONS

CREATE TABLE mavenmarket_regions(
	region_id SERIAL PRIMARY KEY,
	sales_district VARCHAR (50),
	sales_region VARCHAR (50)
);

SELECT * FROM mavenmarket_regions;

COPY mavenmarket_regions FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Regions.csv' delimiter ',' csv header;



-- CREATE TABLE RETURNS WITH RELATIONSHIPS

CREATE TABLE mavenmarket_returns(
	return_date VARCHAR (50),
	product_id INT,
	store_id INT,
	quantity INT,
	FOREIGN KEY (product_id) REFERENCES mavenmarket_products (product_id),
	FOREIGN KEY (store_id) REFERENCES mavenmarket_stores (store_id)
);

SELECT * FROM mavenmarket_returns;

COPY mavenmarket_returns FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Returns.csv' delimiter ',' csv header;



-- CREATE TABLE ORDERS 1997 WITH RELATIONSHIPS

CREATE TABLE mavenmarket_orders_1997(
	transaction_date VARCHAR (20),
	stock_date VARCHAR (20),
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES mavenmarket_products (product_id),
	FOREIGN KEY (customer_id) REFERENCES mavenmarket_customers (customer_id),
	FOREIGN KEY (store_id) REFERENCES mavenmarket_stores (store_id)
);

SELECT * FROM mavenmarket_orders_1997;

COPY mavenmarket_orders_1997 FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Orders_1997.csv' delimiter ',' csv header;



-- CREATE TABLE ORDERS 1998 WITH RELATIONSHIPS

CREATE TABLE mavenmarket_orders_1998(
	transaction_date VARCHAR (20),
	stock_date VARCHAR (20),
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES mavenmarket_products (product_id),
	FOREIGN KEY (customer_id) REFERENCES mavenmarket_customers (customer_id),
	FOREIGN KEY (store_id) REFERENCES mavenmarket_stores (store_id)
);

SELECT * FROM mavenmarket_orders_1998;

COPY mavenmarket_orders_1998 FROM 'D:\Downloads\MAVEN\Maven\MavenMarket_Orders_1998.csv' delimiter ',' csv header;



-- MERGING THE ORDERS TABLE WITH RELATIONSHIPS

CREATE TABLE mavenmarket_orders(
	transaction_date VARCHAR (20),
	stock_date VARCHAR (20),
	product_id INT NOT NULL,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (product_id) REFERENCES mavenmarket_products (product_id),
	FOREIGN KEY (customer_id) REFERENCES mavenmarket_customers (customer_id),
	FOREIGN KEY (store_id) REFERENCES mavenmarket_stores (store_id)
);

-- Insert data from orders_1997

INSERT INTO mavenmarket_orders (transaction_date, stock_date, product_id, customer_id, store_id, quantity)
SELECT transaction_date, stock_date, product_id, customer_id, store_id, quantity
FROM mavenmarket_orders_1997;

-- Insert data from orders_1998

INSERT INTO mavenmarket_orders (transaction_date, stock_date, product_id, customer_id, store_id, quantity)
SELECT transaction_date, stock_date, product_id, customer_id, store_id, quantity
FROM mavenmarket_orders_1998;

SELECT * FROM mavenmarket_orders;
