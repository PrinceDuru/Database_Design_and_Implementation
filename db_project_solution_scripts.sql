/* Drop tables if exist */

DROP TABLE EC_CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE EC_ORDERS CASCADE CONSTRAINTS;
DROP TABLE EC_PAYMENTS CASCADE CONSTRAINTS;
DROP TABLE EC_SHIPPING CASCADE CONSTRAINTS;
DROP TABLE EC_CATEGORIES CASCADE CONSTRAINTS;
DROP TABLE EC_PRODUCTS CASCADE CONSTRAINTS;
DROP TABLE EC_SELLER CASCADE CONSTRAINTS;
DROP TABLE EC_PRODUCT_SELLER CASCADE CONSTRAINTS;
DROP TABLE EC_ORDER_DETAILS CASCADE CONSTRAINTS;
DROP TABLE ec_payments_log CASCADE CONSTRAINTS;

DROP SEQUENCE ec_customers_customer_id_seq;
DROP SEQUENCE ec_orders_order_id_seq;
DROP SEQUENCE ec_shipping_tracking_ID_seq;
DROP SEQUENCE ec_categories_category_ID_seq;
DROP SEQUENCE ec_products_product_id_seq;
DROP SEQUENCE payment_log_seq;


/* Start creation of tables ------------------- */


--- Create EC_CUSTOMERS table 
CREATE TABLE EC_CUSTOMERS
(
customer_ID NUMBER(4),
FirstName VARCHAR2(15) NOT NULL,
LastName VARCHAR2(15) NOT NULL,
billing_address VARCHAR2(50),
shipping_address VARCHAR2(50),
email VARCHAR2(25),
phone_number NUMBER(15),
CONSTRAINT ec_customers_customer_ID_pk PRIMARY KEY(customer_ID)
);

--- Create SEQUENCE for EC_CUSTOMERS table
Create sequence ec_customers_customer_id_seq
start with 10;

--- Create INDEX for EC_CUSTOMERS table
CREATE INDEX ec_customers_FName_LName_idx
ON ec_customers(FirstName, LastName);


--- Insert multiple rows of data into customers table
insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Evlyn', 'Frank', '15 Welligton street N, Hamilton, ON', '25 Brent stree E, Burlington, ON', 'evlyn.frank@gmail.com', 2985645031);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL,'Theres', 'Ford', '35 Nelson street W, Brampton, ON', null, 'theres.ford@gmail.com', 5624658765);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Steve', 'Crux', '150 Lakeshore rd, Burlington, ON', null, 'steve.crux@gmail.com', 5424568562);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Emmanuel', 'John', '65 Southompton drive, Oakville, ON', '127 gateway drive, North York, ON', 'emmanuel.john@gmail.com', 2654526345);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Doris', 'Alpha', '102 upper James rd, Toronto, ON ', null, 'doris.alpha@gmail.com', 3649562485);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Izee', 'Philips', '115 Nebo street N, Brentford, ON', null, 'izee.philips@gmail.com', 5267894512);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Whitney', 'Briggs', '78 Raul drive, London, ON', '98 Centennial rd, Toronto, ON', 'whitney.briggs@gmail.com', 9654521324);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Vic', 'Ted', '332 Wiston Churchill rd, Missisauga, ON', null, 'vic.ted@gmail.com', 3654126589);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Carol', 'James', '257 college drive, Toronto, ON', null, 'carol.james@gmail.com', 2689654857);

insert into EC_CUSTOMERS
(customer_ID, FirstName, LastName, billing_address, shipping_address, email, phone_number)
values(ec_customers_customer_id_seq.NEXTVAL, 'Rose', 'Ben', '342 Dunda street, Toronto, ON', null, 'rose.ben@gmail.com', 2856563617);


--- Create EC_ORDERS table with ORGANIZATION INDEX
CREATE TABLE EC_ORDERS
(
order_ID NUMBER(4),
customer_ID NUMBER(4) NOT NULL,
order_date DATE NOT NULL,
order_qty NUMBER(4) NOT NULL,
order_amount NUMBER(5) NOT NULL,
CONSTRAINT ec_orders_order_ID_pk PRIMARY KEY(order_ID),
CONSTRAINT ec_orders_customer_ID_fk FOREIGN KEY (customer_ID)
    REFERENCES ec_CUSTOMERS(customer_ID)
)
ORGANIZATION INDEX;

--- Create SEQUENCE for EC_ORDERS table
Create sequence ec_orders_order_id_seq
increment by 10  
start with 100;


--- Insert multiple rows of data into orders table
insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 11, '21-JUN-21', 3, 790);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 15, '30-JUN-21', 1, 105);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 12, '23-DEC-21', 2, 300);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 14, '25-MAR-22', 5, 545);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 10, '10-OCT-21', 1, 340);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 11, '05-JAN-22', 3, 810);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 19, '13-FEB-22', 3, 130);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 14, '02-NOV-21', 2, 110);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 15, '18-AUG-21', 4, 1060);

insert into EC_ORDERS
(order_ID, customer_ID, order_date, order_qty, order_amount)
values(ec_orders_order_id_seq.NEXTVAL, 17, '22-MAY-21', 1, 450);


--- Create EC_PAYMENTS table
CREATE TABLE EC_PAYMENTS
(
payment_ID NUMBER(4),
customer_ID NUMBER(4) NOT NULL,
order_ID NUMBER(4) NOT NULL,
amount NUMBER(6,2) NOT NULL,
payment_method VARCHAR2(15),
payment_date DATE,
CONSTRAINT ec_payments_payment_ID_pk PRIMARY KEY(payment_ID),
CONSTRAINT ec_payments_customer_ID_fk FOREIGN KEY (customer_ID)
    REFERENCES ec_CUSTOMERS(customer_ID),
CONSTRAINT ec_payments_order_ID_fk FOREIGN KEY (order_ID)
    REFERENCES ec_ORDERS(order_ID)
);


--- Insert multiple rows of data into EC_PAYMENTS table
insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(101, 14, 170, 110, 'transfer', '02-NOV-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(151, 11, 150, 810, 'debit card', '05-JAN-22');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(201, 11, 100, 790, 'debit card', '21-JUN-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(251, 14, 130, 545, 'credit card', '25-MAR-22');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(301, 19, 160, 130, 'paypal', '13-FEB-22');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(351, 15, 110, 105, 'credit card', '30-JUN-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(401, 17, 190, 450, 'credit card', '22-MAY-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(451, 12, 120, 300, 'credit card', '23-DEC-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(501, 10, 140, 340, 'credit', '10-OCT-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(551, 15, 180, 1060, 'debit card', '18-AUG-21');


---  Create EC_SHIPPING table
CREATE TABLE EC_SHIPPING
(
tracking_ID NUMBER(10),
order_ID NUMBER(4) NOT NULL,
ship_date DATE NOT NULL,
delivered_date DATE,
delivery_status VARCHAR2(20) NOT NULL,
delivery_address VARCHAR2(50) NOT NULL,
CONSTRAINT ec_shipping_tracking_ID_pk PRIMARY KEY(tracking_ID),
CONSTRAINT ec_shipping_order_ID_fk FOREIGN KEY (order_ID)
    REFERENCES ec_ORDERS(order_ID)
);

--- Create SEQUENCE for EC_SHIPPING table
Create sequence ec_shipping_tracking_ID_seq
increment by 2  
start with 100000;

--- Insert multiple rows of data into EC_SHIPPING table
insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 190, '23-MAY-21', '26-MAY-21', 'delivered', '332 Wiston Churchill rd, Missisauga, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 170, '02-NOV-21', '05-NOV-21', 'delivered', '102 upper James rd, Toronto, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 120, '24-DEC-21', '28-DEC-21', 'delivered', '150 Lakeshore rd, Burlington, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 160, '14-FEB-22', NULL, 'could not deliver', '342 Dunda street, Toronto, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 130, '25-MAR-22', NULL, 'in-transit', '102 upper James rd, Toronto, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 180, '18-AUG-21', '21-AUG-21', 'delivered', '115 Nebo street N, Brentford, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 100, '21-JUN-21', '24-JUN-21', 'delivered', '35 Nelson street W, Brampton, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 110, '01-JUL-21', '03-JUL-21', 'delivered', '115 Nebo street N, Brentford, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 150, '05-JAN-22', '08-JAN-22', 'delivered', '35 Nelson street W, Brampton, ON');

insert into EC_SHIPPING
(tracking_ID, order_ID, ship_date, delivered_date, delivery_status, delivery_address)
values(ec_shipping_tracking_ID_seq.NEXTVAL, 140, '10-OCT_21', '13-OCT-21', 'delivered', '25 Brent stree E, Burlington, ON');


--- Create EC_CATEGORIES table
CREATE TABLE EC_CATEGORIES
(
category_ID NUMBER(5),
category_name VARCHAR2(30) NOT NULL,
CONSTRAINT ec_categories_category_ID_pk PRIMARY KEY(category_ID)
);

--- Create SEQUENCE for EC_CATEGORIES table
Create sequence ec_categories_category_ID_seq
increment by 25  
start with 250;

--- Insert multiple rows of data into EC_CATEGORIES table
insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Toys and Games');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Home accessories');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Kitchen accessories');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Computers and accessories');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Cell phones and accessories');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Sports and Outdoors');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Furniture');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Electronics');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Luggage and Travel Gear');

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Office accessories');


--- Create EC_PRODUCTS table
CREATE TABLE EC_PRODUCTS
(
product_ID NUMBER(4),
product_name VARCHAR2(30) NOT NULL,
price NUMBER(5,2) NOT NULL,
quantity NUMBER(3) NOT NULL,
category_ID NUMBER(4),
CONSTRAINT ec_products_product_ID_pk PRIMARY KEY(product_ID),
CONSTRAINT ec_products_category_ID_fk FOREIGN KEY (category_ID) REFERENCES ec_CATEGORIES(category_ID)
);

--- Create SEQUENCE for EC_PRODUCTS table
Create sequence ec_products_product_id_seq
increment by 5  
start with 50;

--- Create BITMAP INDEX type for EC_PRODUCTS table
CREATE BITMAP INDEX ec_products_product_name_idx
ON ec_products(product_name);

--- Insert multiple rows of data into EC_PRODUCTS table
insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'stapler', 15, 14, 475);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'office desk', 220, 10, 475);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Sony TV set', 340, 8, 425);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Techno phone', 150, 9, 350);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'microwave', 80, 11, 300);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Teddy Bear', 25, 15, 250);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Blending machine', 105, 13, 300);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'usb cord', 5, 17, 350);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'large sized travel bag', 55, 16, 450);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'book shelf', 280, 9, 400);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'dell precision 7100 laptop', 780, 7, 325);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'glass dining table', 450, 11, 275);

insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Samsung Phone Battery', 160, 3, 350);


--- Create EC_SELLER table
CREATE TABLE EC_SELLER
(
seller_ID NUMBER(4),
seller_name VARCHAR2(25) NOT NULL,
seller_address VARCHAR2(50),
seller_phone# NUMBER(15),
CONSTRAINT ec_seller_seller_ID_pk PRIMARY KEY(seller_ID)
);

--- Insert multiple rows of data into EC_SELLER
insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(501, 'A-Z Salez', NULL, 4568597412);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(502, 'EZY Plus', NULL, 7486521245);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(503, 'Super Stores Zone', NULL, 2948562384);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(504, 'Two Point Click', NULL, 2587845626);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(505, 'Round Deals', NULL, 2315462578);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(506, 'Boomy Stuffs', NULL, 3456987825);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(507, 'Flash Sales Anchor', NULL, 8954523645);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(508, 'Acu Stores', NULL, 2894568256);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(509, 'TreasureP ST', NULL, 3654785621);

insert into EC_SELLER
(seller_ID, seller_name, seller_address, seller_phone#)
values(510, 'EazyComm shop', NULL, 6258964523);


--- Create EC_PRODUCT_SELLER table
CREATE TABLE EC_PRODUCT_SELLER
(
Prod_Seller_ID NUMBER(4),
product_ID NUMBER(4) NOT NULL,
seller_ID NUMBER(4) NOT NULL,
CONSTRAINT ec_ProdSeller_ProdSell_ID_pk PRIMARY KEY(Prod_Seller_ID),
CONSTRAINT ec_ProdSeller_product_ID_fk FOREIGN KEY (product_ID) REFERENCES ec_PRODUCTS(product_ID),
CONSTRAINT ec_ProdSeller_seller_ID_fk FOREIGN KEY (seller_ID) REFERENCES ec_SELLER(seller_ID)
);

--- Insert multiple rows of data inot EC_PRODUCT_SELLER table
insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(701, 80, 501);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(702, 80, 505);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(703, 60, 507);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(704, 60, 504);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(705, 65, 505);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(706, 65, 504);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(707, 65, 501);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(708, 75, 506);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(709, 75, 508);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(710, 95, 509);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(711, 95, 508);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(712, 100, 510);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(713, 105, 502);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(714, 90, 505);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(715, 90, 507);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(716, 70, 509);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(717, 55, 506);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(718, 55, 510);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(719, 50, 503);

insert into EC_PRODUCT_SELLER
(Prod_Seller_ID, product_ID, seller_ID)
values(720, 85, 510);


--- Create EC_ORDER_DETAILS table
CREATE TABLE EC_ORDER_DETAILS
(
order_details_ID NUMBER(4),
order_ID NUMBER(4) NOT NULL,
product_ID NUMBER(4),
prod_seller_id NUMBER(5) NOT NULL,
product_qty NUMBER(3),
amount NUMBER(5,2) NOT NULL,
CONSTRAINT ec_OrderDet_order_det_ID_pk PRIMARY KEY(order_details_ID),
CONSTRAINT ec_OrderDet_order_ID_fk FOREIGN KEY (order_ID) REFERENCES ec_ORDERS(order_ID),
CONSTRAINT ec_OrderDet_product_ID_fk FOREIGN KEY (product_ID) REFERENCES ec_PRODUCTS(product_ID),
CONSTRAINT ec_OrderDet_prod_seller_id_fk FOREIGN KEY (prod_seller_id) REFERENCES ec_PRODUCT_SELLER(prod_seller_id),
CONSTRAINT ec_OrderDet_qty_ordered_ck CHECK (product_qty > 0)
);

--- Create index on EC_ORDER_DETAILS table
CREATE INDEX ec_order_det_orderID_idx
ON EC_ORDER_DETAILS(order_ID);

--- Insert multiple rows of data into EC_ORDER_DETAILS table
insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id, product_qty, amount)
values(5, 100, 100, 712, 1, 780);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id, product_qty, amount)
values(10, 100, 85, 720, 2, 10);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id, product_qty,  amount)
values(15, 110, 80, 701, 1, 105);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id, 
product_qty, amount)
values(20, 120, 65, 706, 2, 300);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(25, 130, 55, 717, 1, 220);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(30, 130, 50, 719, 3, 45);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(35, 130, 95, 710, 1, 280);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(40, 140, 60, 703, 1, 340);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(45, 150, 100, 712, 1, 780);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(50, 150, 85, 720, 2, 30);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(55, 160, 70, 716, 1, 80);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(60, 160, 75, 709, 2, 50);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(65, 170, 90, 714, 2, 110);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(70, 180, 105, 713, 2, 900);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(75, 180, 70, 716, 2, 160);

insert into EC_ORDER_DETAILS
(order_details_ID, order_ID, product_ID, prod_seller_id,
product_qty, amount)
values(80, 190, 105, 713, 1, 450);



--- Create ec_payments_log table
CREATE TABLE ec_payments_log (
  log_id NUMBER(4),
  payment_id NUMBER(4),
  log_date   DATE,
  amount NUMBER(6),
  action     VARCHAR2(30),
CONSTRAINT ec_payment_log_Log_ID_pk PRIMARY KEY(log_id),
CONSTRAINT ec_PaymentLog_payment_ID_fk FOREIGN KEY (payment_id) REFERENCES ec_PAYMENTS(payment_id));

--- Create SEQUENCE on ec_payments_log table
create sequence payment_log_seq
increment by 1
start with 1;
------------------------------------------------------------------------------------------------------------




---TEST Table creation
SELECT * FROM EC_CUSTOMERS;
SELECT * FROM EC_ORDERS;
SELECT * FROM EC_PAYMENTS;
SELECT * FROM EC_SHIPPING;
SELECT * FROM EC_CATEGORIES;
SELECT * FROM EC_PRODUCTS;
SELECT * FROM EC_SELLER;
SELECT * FROM EC_PRODUCT_SELLER;
SELECT * FROM EC_ORDER_DETAILS;
SELECT * FROM ec_payments_log;
---------------------------------------------------------------
---TEST Index Creation
SELECT table_name, index_name, column_name
FROM user_ind_columns
where table_name in ('EC_CUSTOMERS', 'EC_ORDERS', 'EC_PRODUCTS', 'EC_ORDER_DETAILS', 'ec_payments_log'); 
----EC_ORDERS table is created as an Index Organized Table(IOT)
--------------------------------------------------------------------------------------------------------

---TEST Sequence Creation
---Confirm creation of sequences
select sequence_name, min_value, increment_by, last_number from user_sequences
where sequence_name in (select object_name from user_objects where object_type = 
                            'SEQUENCE' and object_name like 'EC_%');

---Use SEQUENCES to insert sample data
insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Pressing Iron', 75, 10, 275);

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Fashion');
---------------------------------------------------------------------------------

/* PL/SQL */

---Use SEQUENCES to update table(s) - Implement using PL/SQL Procedure
create or replace procedure Update_Customer_Info
(lv_ship_address IN EC_CUSTOMERS.shipping_address%TYPE)
AS
last_seq_number NUMBER(4);
BEGIN
	SELECT EC_CUSTOMERS_CUSTOMER_ID_SEQ.CURRVAL into last_seq_number from dual;
	UPDATE EC_CUSTOMERS SET shipping_address = lv_ship_address WHERE customer_id = last_seq_number;
END;

---Test use of sequence to update table via a procedure
----Before Update
select * from EC_CUSTOMERS;

---Call procedure
BEGIN
    Update_Customer_Info(lv_ship_address => '33 Centennial Rd, Burlington, ON');
END;

---After Update
select * from EC_CUSTOMERS;
------------------------------------------------------------------------------------------

---PROCEDURES

--- 1. Procedure to add a new customer record to the customers table
create or replace procedure New_Customer_Record
(lv_Fname IN ec_customers.firstname%TYPE, 
lv_Lname IN ec_customers.lastname%TYPE,
lv_bill_address IN ec_customers.billing_address%TYPE,
lv_email IN ec_customers.email%TYPE,
lv_phone IN ec_customers.phone_number%TYPE)
AS
BEGIN
    IF (INSTR(lv_email, '@') = 0) THEN
        RAISE_APPLICATION_ERROR(-20978, 'INVALID EMAIL ADDRESS; PLEASE ENTER A VALID EMAIL');
    END IF;

    INSERT INTO ec_customers (customer_id, firstname, lastname, billing_address, email, phone_number)
    values (EC_CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, lv_Fname, lv_Lname, lv_bill_address, lv_email, lv_phone);
    COMMIT;
END;
/

---TEST PROCEDURE IN ANONYMOUS BLOCK
---Before Procedure call
select * from ec_customers;

---Call PROCEDURE IN ANONYMOUS BLOCK
BEGIN 
    New_Customer_Record(lv_Fname => 'Michael', lv_Lname => 'Jordan', 
    lv_bill_address => '53 Times Square Blvd, Toronto, ON', lv_email => 'mich.jor@gmail.com', lv_phone => 8956234520); 
END;

---After Procedure call
select * from ec_customers;
---------------------------------------------------------------------------------------------------------

--- 2. Procedure to update product price on Products table
create or replace procedure Update_product_Price
(lv_prod_id IN ec_products.product_ID%TYPE,
lv_prod_price IN ec_products.price%TYPE)
AS
lv_product_name ec_products.product_name%TYPE;
lv_prev_price ec_products.price%TYPE;
BEGIN
    select product_name, price into lv_product_name,  lv_prev_price from ec_products where product_id = lv_prod_id;
    update ec_products set price = lv_prod_price where product_id = lv_prod_id;
    DBMS_OUTPUT.PUT_LINE(lv_product_name ||' has been updated from '||'$'|| lv_prev_price ||' to '||'$'||lv_prod_price);
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('NO RECORD UPDATED; PLEASE ENTER A VALID PRODUCT ID');
END;
/

---TEST PROCEDURE IN ANONYMOUS BLOCK
---Before Procedure call
select * from ec_products;

---CALL PROCEDURE IN ANONYMOUS BLOCK
BEGIN
    Update_product_Price(lv_prod_id => 55, lv_prod_price => 15);
END;

---After Procedure call
select * from ec_products;
--------------------------------------------------------------------------------------------------------------


---FUNCTIONS
---1. Function to get the sum of order amount arising from a specified seller
create or replace FUNCTION seller_total
(lv_seller_name IN ec_seller.seller_name%TYPE)
RETURN NUMBER
AS
lv_total_sum NUMBER(5); 
lv_count_name NUMBER(3);
BEGIN
    SELECT COUNT(seller_name) INTO lv_count_name FROM ec_seller WHERE seller_name = lv_seller_name;
    IF lv_count_name = 0 THEN
        RAISE_APPLICATION_ERROR(-20220, 'INVALID SELLER NAME; PLEASE ENTER A VALID SELLER NAME');
    END IF;   
    SELECT SUM(amount) INTO lv_total_sum 
    from ec_order_details 
    join ec_product_seller using (prod_seller_id) join ec_seller using (seller_id)
    where seller_name = lv_seller_name;
    RETURN lv_total_sum;
END;
/

---CALL THE FUNCTION TO TEST
DECLARE
lv_total_sum NUMBER(5);
BEGIN
    lv_total_sum := seller_total(lv_seller_name => 'EZY Plus');
    DBMS_OUTPUT.PUT_LINE('The total is' ||' '||lv_total_sum );
END;
---------------------------------------------------------------------------

--- 2. Function to get sum of order amounts for a specified customer
create or replace function cust_total_order_amount
(cust_id IN ec_customers.customer_id%TYPE)
RETURN VARCHAR2
AS
lv_order_total ec_orders.order_amount%TYPE;
lv_customer_name VARCHAR2(40);
msg VARCHAR2(50);
BEGIN
    select sum(order_amount), firstname||' '||lastname NAME into lv_order_total,  lv_customer_name 
    from ec_orders
    join ec_customers using(customer_id) where customer_id = cust_id 
    group by firstname, lastname;
    msg := 'Total order amount for ' ||lv_customer_name ||': '||TO_CHAR(lv_order_total);
    RETURN msg;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Please enter valid customer_id');
END;
/

-- Test function using anonymous block
DECLARE
total_order_amount VARCHAR2(50);
BEGIN
    total_order_amount := cust_total_order_amount(cust_id => 12);
    DBMS_OUTPUT.PUT_LINE(total_order_amount);
END;
-----------------------------------------------------------------------------

---TRIGGERS
----1. TRIGGER to log each completed payment on a log table
CREATE OR REPLACE TRIGGER log_payment_completion
  AFTER INSERT ON ec_payments
  FOR EACH ROW
BEGIN
  INSERT INTO ec_payments_log (log_id, payment_id, log_date, amount, action)
  VALUES (payment_log_seq.NEXTVAL, :NEW.payment_id, SYSDATE, :NEW.amount, 'payment completed');
END;
/

---Before Insert
select * from ec_payments;
select * from ec_payments_log;

---Insert payment records
insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(203, 14, 170, 110, 'transfer', '02-NOV-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(204, 14, 170, 110, 'transfer', '02-NOV-21');

---After inserts
select * from ec_payments;
select * from ec_payments_log;
-------------------------------------------------------------------------------------

---2. TRIGGER to verify that change in a product's price cannot be to a less value
CREATE OR REPLACE TRIGGER verify_price_change
  BEFORE UPDATE ON ec_products
  FOR EACH ROW
DECLARE
  price_diff  NUMBER;
BEGIN
  price_diff  := :NEW.price  - :OLD.price;
  DBMS_OUTPUT.PUT(:NEW.product_name || ': ');
  DBMS_OUTPUT.PUT('Old price = ' || :OLD.price || ', ');
  DBMS_OUTPUT.PUT('New price = ' || :NEW.price || ', ');
  DBMS_OUTPUT.PUT_LINE('Difference: ' || price_diff);
  if price_diff < 0 Then
    RAISE_APPLICATION_ERROR(-20220, 'YOU CANNOT CHANGE PRICE TO A LOWER VALUE');
  else
    DBMS_OUTPUT.PUT_LINE('Product price change successful');
  END IF;
END;
/

---Test with an Update
update ec_products set price = 3 where product_id=50;
select * from ec_products;
--------------------------------------------------------------------------------

---PACKAGES
---- 1. PACKAGE contaning 2 program units related to customers
CREATE OR REPLACE PACKAGE manage_customer_pkg
  AS
  PROCEDURE New_Customer_Record
  (lv_Fname IN ec_customers.firstname%TYPE, 
  lv_Lname IN ec_customers.lastname%TYPE,
  lv_bill_address IN ec_customers.billing_address%TYPE,
  lv_email IN ec_customers.email%TYPE,
  lv_phone IN ec_customers.phone_number%TYPE);

  FUNCTION cust_total_order_amount
  (cust_id IN ec_customers.customer_id%TYPE)
  RETURN VARCHAR2;

END;
/
CREATE OR REPLACE PACKAGE BODY manage_customer_pkg
  AS
  PROCEDURE New_Customer_Record
  (lv_Fname IN ec_customers.firstname%TYPE, 
  lv_Lname IN ec_customers.lastname%TYPE,
  lv_bill_address IN ec_customers.billing_address%TYPE,
  lv_email IN ec_customers.email%TYPE,
  lv_phone IN ec_customers.phone_number%TYPE)
  AS
  BEGIN
    IF (INSTR(lv_email, '@') = 0) THEN
      RAISE_APPLICATION_ERROR(-20978, 'INVALID EMAIL ADDRESS; PLEASE ENTER A VALID EMAIL');
    END IF;
   INSERT INTO ec_customers (customer_id, firstname, lastname,  billing_address, email, phone_number)
   values (EC_CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, lv_Fname, lv_Lname, lv_bill_address, lv_email, lv_phone);
   COMMIT;
  END New_Customer_Record;
  FUNCTION cust_total_order_amount
   (cust_id IN ec_customers.customer_id%TYPE)
    RETURN VARCHAR2
    AS
    lv_order_total ec_orders.order_amount%TYPE;
    lv_customer_name VARCHAR2(40);
    msg VARCHAR2(50);
    BEGIN
        select sum(order_amount), firstname||' '||lastname NAME into lv_order_total, lv_customer_name 
        from ec_orders
        join ec_customers using(customer_id) where customer_id = cust_id 
        group by firstname, lastname;
        msg := 'Total order amount for ' ||lv_customer_name ||': '|| TO_CHAR(lv_order_total);
        RETURN msg;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Please enter valid customer_id');
    END cust_total_order_amount;
END;
/
----------+++++++++++++++++++++++++++--------------------
---Test "manage_customer_pkg" package

---TEST PACKAGE IN ANONYMOUS BLOCK
---Before PACKAGE.Procedure call
select * from ec_customers;

---Call PROCEDURE by package name IN ANONYMOUS BLOCK
BEGIN 
    manage_customer_pkg.New_Customer_Record(lv_Fname => 'John', lv_Lname => 'Paul', 
    lv_bill_address => '37 Times Square Blvd, Toronto, ON', lv_email => 'john.paul@gmail.com', lv_phone => 8967234520); 
END;

---After PACKAGE.Procedure call
select * from ec_customers;
------------------------+++++++++++++++++++-----------------------

---Test "manage_customer_pkg" package

-- Test PACKAGE.function using anonymous block
DECLARE
total_order_amount VARCHAR2(50);
BEGIN
    total_order_amount := manage_customer_pkg.cust_total_order_amount(cust_id => 15);
    DBMS_OUTPUT.PUT_LINE(total_order_amount);
END;
--------------------------------------------------------------------------------

---2. PACKAGE containing 2 program units related to products
CREATE OR REPLACE PACKAGE manage_product_pkg
  AS
  PROCEDURE Update_product_Price
  (lv_prod_id IN ec_products.product_ID%TYPE,
  lv_prod_price IN ec_products.price%TYPE);

  FUNCTION seller_total
  (lv_seller_name IN ec_seller.seller_name%TYPE)
  RETURN NUMBER;
  END;
  /
CREATE OR REPLACE PACKAGE BODY manage_product_pkg
  AS
   PROCEDURE Update_product_Price
   (lv_prod_id IN ec_products.product_ID%TYPE,
   lv_prod_price IN ec_products.price%TYPE)
  AS
  lv_product_name ec_products.product_name%TYPE;
  lv_prev_price ec_products.price%TYPE;
  BEGIN
    select product_name, price into lv_product_name,  lv_prev_price from   ec_products where product_id = lv_prod_id;
    update ec_products set price = lv_prod_price where product_id =   lv_prod_id;
    DBMS_OUTPUT.PUT_LINE(lv_product_name ||' has been updated from '||'$'|| lv_prev_price ||' to '||'$'||lv_prod_price);
    COMMIT;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO RECORD UPDATED; PLEASE ENTER A VALID PRODUCT ID');
  END Update_product_Price;

  FUNCTION seller_total
  (lv_seller_name IN ec_seller.seller_name%TYPE)
  RETURN NUMBER
  AS
  lv_total_sum NUMBER(5); 
  lv_count_name NUMBER(3);
  BEGIN
    SELECT COUNT(seller_name) INTO lv_count_name FROM ec_seller WHERE seller_name = lv_seller_name;
    IF lv_count_name = 0 THEN
        RAISE_APPLICATION_ERROR(-20220, 'INVALID SELLER NAME; PLEASE ENTER A VALID SELLER NAME');
    END IF;
    SELECT SUM(amount) INTO lv_total_sum 
    from ec_order_details join ec_product_seller using (prod_seller_id)
    join ec_seller using (seller_id)
    where seller_name = lv_seller_name;
    RETURN lv_total_sum;
  END seller_total;
END;
/

-----------------++++++++++++++++++++++-------------------------------

---Test "manage_product_pkg" PACKAGE

---TEST PACKAGE IN ANONYMOUS BLOCK
---Before PACKAGE.Procedure call
select * from ec_products;

---CALL PROCEDURE by package name IN ANONYMOUS BLOCK
BEGIN
    manage_product_pkg.Update_product_Price(lv_prod_id => 55, lv_prod_price => 500);
END;

---After PACKAGE.Procedure call
select * from ec_products;


---Test seller_total function through the manage_product_pkg PACKAGE

---CALL THE FUNCTION through the manage_product_pkg package TO TEST it
DECLARE
lv_total_sum NUMBER(5);
BEGIN
    lv_total_sum := manage_product_pkg.seller_total(lv_seller_name => 'EZY Plus');
    DBMS_OUTPUT.PUT_LINE('The total is' ||' '||lv_total_sum );
END;
-----------------------------------------------------------------------------------------------------------------