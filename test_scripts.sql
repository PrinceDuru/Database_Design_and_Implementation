TEST Table creation

SELECT * FROM EC_CUSTOMERS;
SELECT * FROM EC_ORDERS;
SELECT * FROM EC_PAYMENTS;
SELECT * FROM EC_SHIPPING;
SELECT * FROM EC_CATEGORIES;
SELECT * FROM EC_PRODUCTS;
SELECT * FROM EC_SELLER;
SELECT * FROM EC_PRODUCT_SELLER;
SELECT * FROM EC_ORDER_DETAILS;

TEST Index Creation
SELECT table_name, index_name, column_name
FROM user_ind_columns
where table_name in ('EC_CUSTOMERS', 'EC_ORDERS', 'EC_PRODUCTS', 'EC_ORDER_DETAILS'); 
----EC_ORDERS table is created as an Index Organized Table(IOT)

TEST Sequence Creation
---Confirm creation of sequences
select sequence_name, min_value, increment_by, last_number from user_sequences
where sequence_name in (select object_name from user_objects where object_type = 
                            'SEQUENCE' and object_name like 'EC_%');


Use SEQUENCES to insert sample data
insert into EC_PRODUCTS
(product_ID, product_name, price, quantity, category_ID)
values(ec_products_product_id_seq.NEXTVAL, 'Pressing Iron', 75, 10, 275);

insert into EC_CATEGORIES
(category_ID, category_name)
values(ec_categories_category_ID_seq.NEXTVAL, 'Fashion');

Use SEQUENCES to update table(s)
create or replace procedure Update_Customer_Info
(lv_ship_address IN EC_CUSTOMERS.shipping_address%TYPE)

AS
last_seq_number NUMBER(4);

BEGIN
	SELECT EC_CUSTOMERS_CUSTOMER_ID_SEQ.CURRVAL into last_seq_number from dual;

	UPDATE EC_CUSTOMERS SET shipping_address = lv_ship_address WHERE customer_id = last_seq_number;
END;

BEGIN
Update_Customer_Info(lv_ship_address => '33 Centennial Rd, Burlington, ON');
END;


PROCEDURES
--- Procedure to add a new customer records to the customers table

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

---TEST PROCEDURE IN ANONYMOUS BLOCK
BEGIN 
    New_Customer_Record(lv_Fname => 'Michael', lv_Lname => 'Jordan', 
    lv_bill_address => '53 Times Square Blvd, Toronto, ON', lv_email => 'mich.jor@gmail.com', lv_phone => 8956234520); 
END;

---After Procedure call
select * from ec_customers;


--- Procedure to update product price on Products table

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



---FUNCTIONS

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
    from ec_order_details join ec_product_seller using (prod_seller_id)
    join ec_seller using (seller_id)
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

----------------------------------------------------

create or replace function cust_total_order_amount
(cust_id IN ec_customers.customer_id%TYPE)

RETURN VARCHAR2

AS
lv_order_total ec_orders.order_amount%TYPE;
lv_customer_name VARCHAR2(40);
msg VARCHAR2(50);

BEGIN

select sum(order_amount), firstname||' '||lastname NAME into lv_order_total,  lv_customer_name from ec_orders
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



---TRIGGERS

CREATE OR REPLACE TRIGGER log_payment_completion
  AFTER INSERT ON ec_payments
  FOR EACH ROW
BEGIN
  INSERT INTO ec_payments_log (log_id, payment_id, log_date, amount, action)
  VALUES (payment_log_seq.NEXTVAL, :NEW.payment_id, SYSDATE, :NEW.amount, 'payment completed');
END;
/


---Before Insert
select * from ec_products;
select * from ec_payments_log;

---Insert
insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(203, 14, 170, 110, 'transfer', '02-NOV-21');

insert into EC_PAYMENTS
(payment_ID, customer_ID, order_ID, amount, payment_method, payment_date)
values(204, 14, 170, 110, 'transfer', '02-NOV-21');

---After Update
select * from ec_products;
select * from ec_payments_log;



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

---Before Update

update ec_products set price = 30 where product_id=50;
select * from ec_products;




------------------------
---PACKAGES

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
      RAISE_APPLICATION_ERROR(-20978, 'INVALID EMAIL ADDRESS;       PLEASE     ENTER A VALID EMAIL');
    END IF;


   INSERT INTO ec_customers (customer_id, firstname, lastname,    billing_address, email, phone_number)
   values (EC_CUSTOMERS_CUSTOMER_ID_SEQ.NEXTVAL, lv_Fname,    lv_Lname, lv_bill_address, lv_email, lv_phone);

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

     select sum(order_amount), firstname||' '||lastname NAME into      lv_order_total,  lv_customer_name from ec_orders
     join ec_customers using(customer_id) where customer_id =      cust_id 
     group by firstname, lastname;

     msg := 'Total order amount for ' ||lv_customer_name ||': '||     TO_CHAR(lv_order_total);
     RETURN msg;

    EXCEPTION
     WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Please enter valid customer_id');

    END cust_total_order_amount;

END;
/



CREATE OR REPLACE PACKAGE manage_product_pkg
  AS
  PROCEDURE Update_product_Price
  (lv_prod_id IN ec_products.product_ID%TYPE,
  lv_prod_price IN ec_products.price%TYPE);

  FUNCTION seller_total
  (lv_seller_name IN ec_seller.seller_name%TYPE)
  RETURN NUMBER;
  END;

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
  DBMS_OUTPUT.PUT_LINE(lv_product_name ||' has been updated from '||'$'||   lv_prev_price ||' to '||'$'||lv_prod_price);

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.PUT_LINE('NO RECORD UPDATED; PLEASE ENTER A VALID PRODUCT   ID');

  END Update_product_Price;

  FUNCTION seller_total
  (lv_seller_name IN ec_seller.seller_name%TYPE)
  RETURN NUMBER
  AS
  lv_total_sum NUMBER(5); 
  lv_count_name NUMBER(3);
  BEGIN

    SELECT COUNT(seller_name) INTO lv_count_name FROM ec_seller WHERE    seller_name = lv_seller_name;
    
    IF lv_count_name = 0 THEN
        RAISE_APPLICATION_ERROR(-20220, 'INVALID SELLER NAME; PLEASE   ENTER A VALID SELLER NAME');
    END IF;
       
    SELECT SUM(amount) INTO lv_total_sum 
    from ec_order_details join ec_product_seller using (prod_seller_id)
    join ec_seller using (seller_id)
    where seller_name = lv_seller_name;
        
    RETURN lv_total_sum;
  END seller_total;
END;
/