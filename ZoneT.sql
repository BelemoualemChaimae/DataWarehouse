----------Exécution de Script pour Gérer l'exception --------------
@"E:\app\chama\product\12.1.0\dbhome_1\RDBMS\ADMIN\utlexcpt.sql"
drop table exceptions;
--------------TABLE T_category_name_translation ---------------  
CREATE OR REPLACE TYPE T_category_translation_type AS OBJECT (
    product_category_name VARCHAR(50),
    product_category_name_english VARCHAR(50) 
);
/
CREATE TABLE T_category_name_translation OF T_category_translation_type;

---Creation d'index sur la table T_category_name_translation
--CREATE INDEX idx_T_category_name_translation on T_category_name_translation(product_category_name) ; 

--------------TABLE T_customers -------------------------------------------------------
CREATE OR REPLACE TYPE T_customers_type AS OBJECT  (
  customer_id VARCHAR(50) ,
  customer_unique_id VARCHAR(50) , 
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(50) ,
  customer_state VARCHAR(6) 
);
/
CREATE TABLE T_customers OF T_customers_type;
drop table T_customers ; 
---Creation d'index sur la table T_customers
CREATE INDEX idx_T_customers on T_customers(customer_id); 

-- Add Constraint Primary Key For table T_customers 
alter table T_customers 
add constraint pk_customer_id primary key(customer_id) ; 
-----------TABLE T_geolocation -------------------------cgeolocation_zip_code_prefix

CREATE OR REPLACE TYPE T_geolocation AS OBJECT  (
  geolocation_zip_code_prefix VARCHAR(10),
  geolocation_lat VARCHAR(50), 
  geolocation_lng VARCHAR(10),
  geolocation_city  VARCHAR(50),
  geolocation_state VARCHAR(6),
  MEMBER FUNCTION getGzip RETURN VARCHAR,
  MEMBER FUNCTION getGlat RETURN VARCHAR,
  MEMBER FUNCTION getGlng RETURN VARCHAR,
  MEMBER FUNCTION getGcity RETURN VARCHAR
);
/
CREATE OR REPLACE TYPE BODY T_geolocation_type AS
    MEMBER FUNCTION getGzip RETURN VARCHAR IS
    BEGIN
        RETURN geolocation_zip_code_prefix;
    END;
    MEMBER FUNCTION getGlat RETURN VARCHAR IS
    BEGIN
        RETURN geolocation_lat;
    END;
    MEMBER FUNCTION getGlng RETURN VARCHAR IS
    BEGIN
        RETURN geolocation_lng;
    END;
    MEMBER FUNCTION getGcity RETURN VARCHAR IS
    BEGIN
        RETURN geolocation_city;
    END;    
END;
/

CREATE TABLE T_geolocation OF T_geolocation_type;

---Creation d'index sur la table T_geolocation
CREATE INDEX idx_T_geolocation on T_geolocation(geolocation_zip_code_prefix) ; 

-- Add Constraint Primary Key For table T_customers 
alter table T_geolocation 
add constraint pk_geolocation_zip_code_prefix primary key(geolocation_zip_code_prefix) ; 
--------------- Table T_items---------------------------------

CREATE OR REPLACE TYPE T_items_type AS OBJECT(
  order_id  VARCHAR(60),
  order_item_id NUMBER, 
  product_id VARCHAR(60),
  seller_id  VARCHAR(60),
  shipping_limit_date VARCHAR(20),
  price NUMBER, 
  Freight_value NUMBER,
  MEMBER FUNCTION getOrder_id RETURN VARCHAR,
  MEMBER FUNCTION getOrder_item_id RETURN NUMBER,
  MEMBER FUNCTION getProduct_id RETURN VARCHAR,
  MEMBER FUNCTION getSeller_id RETURN VARCHAR,
  MEMBER FUNCTION getPrice RETURN NUMBER,
  MEMBER FUNCTION getFreight_value RETURN NUMBER,
  MEMBER FUNCTION getYear RETURN NUMBER,
  MEMBER FUNCTION getMonth RETURN NUMBER,
  MEMBER FUNCTION getDayOfWeek RETURN NUMBER);
/
CREATE OR REPLACE TYPE BODY T_items_type AS
    MEMBER FUNCTION getOrder_id RETURN VARCHAR IS
    BEGIN
        RETURN order_id;
    END getOrder_id;
    MEMBER FUNCTION getOrder_item_id RETURN NUMBER IS
    BEGIN
        RETURN order_item_id;
    END getOrder_item_id;
    MEMBER FUNCTION getProduct_id RETURN VARCHAR IS
    BEGIN
        RETURN product_id;
    END getProduct_id;
    MEMBER FUNCTION getSeller_id RETURN VARCHAR IS
    BEGIN
        RETURN seller_id;
    END getSeller_id;
    MEMBER FUNCTION getPrice RETURN NUMBER IS
    BEGIN
        RETURN price;
    END getPrice;
    MEMBER FUNCTION getFreight_value RETURN NUMBER IS
    BEGIN
        RETURN freight_value;
    END getFreight_value;
    MEMBER FUNCTION getYear RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(SUBSTR(shipping_limit_date, 1, 4));
    END getYear;
    MEMBER FUNCTION getMonth RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(SUBSTR(shipping_limit_date, 6, 2));
    END getMonth;
    MEMBER FUNCTION getDayOfWeek RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(SUBSTR(shipping_limit_date, 9, 2));
    END getDayOfWeek;    
END;
/

CREATE TABLE T_items OF T_items_type;


 
---Creation d'index sur la table T_items
CREATE INDEX idx_T_items on T_items(order_id) ;

-- Add Constraint Primary Key For table T_customers 
alter table T_items 
add constraint pk_order_items_id primary key(order_id);
alter table T_items
add constraint fk22_order_id foreign key(order_id) REFERENCES T_orders(order_id);
alter table T_items
add constraint fk_product_id foreign key (product_id) REFERENCES T_products(product_id)
add constraint fk_seller_id foreign key (seller_id) REFERENCES T_sellers(seller_id);



----------------------------Table t_orders------------------------------
CREATE OR REPLACE TYPE T_orders_type AS OBJECT  (
  order_id  VARCHAR2(50),
  customer_id VARCHAR2(50) , 
  order_status VARCHAR2(50),
  order_purchase_timestamp VARCHAR2(20) ,
  order_approved_at   VARCHAR2(20),
  order_delivered_carrier_date VARCHAR2(20) ,
  order_delivered_customer_date VARCHAR2(20) ,
  order_estimated_delivery_date VARCHAR2(20),
  MEMBER FUNCTION getOrder_id RETURN VARCHAR2,
  MEMBER FUNCTION getCustomer_id RETURN VARCHAR2
);
/
CREATE OR REPLACE TYPE BODY T_orders_type AS
    MEMBER FUNCTION getOrder_id  RETURN VARCHAR2 IS
    BEGIN
        RETURN order_id;
    END getOrder_id;
    MEMBER FUNCTION getCustomer_id RETURN VARCHAR2 IS
    BEGIN
        RETURN customer_id;
    END getCustomer_id;  
END;
/

CREATE TABLE T_orders OF T_orders_type;
---Creation d'index sur la table T_orders
CREATE INDEX idx_T_orders on T_orders(order_id) ;
-- Add Constraint Primary Key For table T_orders 
alter table T_orders 
add constraint pk_order_idd primary key(order_id) ; 

alter table T_orders 
add constraint fk_customer_id foreign key (customer_id) REFERENCES T_customers(customer_id) ; 
----------------------------Table t_payments------------------------------
CREATE OR REPLACE TYPE T_payments_type AS OBJECT  (
  order_id  VARCHAR2(50),
  payment_sequential VARCHAR2(50), 
  payment_type VARCHAR2(20),
  payment_installments NUMBER(10),
  payment_value  NUMBER,
  MEMBER FUNCTION getOrder_id RETURN VARCHAR2
);
/
CREATE OR REPLACE TYPE BODY T_payments_type AS
    MEMBER FUNCTION getOrder_id  RETURN VARCHAR2 IS
    BEGIN
        RETURN order_id;
    END getOrder_id;   
END;
/
 
CREATE TABLE T_payments OF T_payments_type;
---Creation d'index sur la table T_payments
CREATE INDEX idx_T_payments on T_payments(order_id) ;

-- Add Constraint Primary Key For table T_orders 
alter table T_payments 
add constraint pk_payments primary key(order_id) 
add constraint fk_payment foreign key(order_id) REFERENCES T_orders(order_id) ; 
----------------------------Table t_products------------------------------
CREATE OR REPLACE TYPE T_products_type AS OBJECT(
  product_id  VARCHAR2(50),
  product_category_name VARCHAR2(50), 
  product_name_lenght NUMBER(6),
  product_description_lenght NUMBER(15) ,
  product_photos_qty  NUMBER(6),
  product_weight_g NUMBER(15),
  product_length_cm NUMBER(15),
  product_height_cm NUMBER(15),
  product_width_cm NUMBER(15),
  MEMBER FUNCTION getProduct_id RETURN VARCHAR2,
  MEMBER FUNCTION getProduct_category_name RETURN VARCHAR2,
  MEMBER FUNCTION getProduct_photos_qty RETURN NUMBER);
/
CREATE OR REPLACE TYPE BODY T_products_type AS
    MEMBER FUNCTION getProduct_id  RETURN VARCHAR2 IS
    BEGIN
        RETURN product_id;
    END getProduct_id;
    MEMBER FUNCTION getProduct_category_name  RETURN VARCHAR2 IS
    BEGIN
        RETURN product_category_name;
    END getProduct_category_name;
    MEMBER FUNCTION getProduct_photos_qty  RETURN NUMBER IS
    BEGIN
        RETURN product_photos_qty;
    END getProduct_photos_qty;    
END;
/

CREATE TABLE T_products OF T_products_type;
---Creation d'index sur la table T_products
CREATE INDEX idx_T_products on T_products(product_id) ;

-- Add Constraint Primary Key For table T_products 
alter table T_products 
add constraint pk_products primary key(product_id) ; 
----------------------------Table t_reviews------------------------------

CREATE OR REPLACE TYPE T_reviews_type AS OBJECT(
  review_id  VARCHAR2(50),
  order_id VARCHAR2(50), 
  review_score NUMBER(10),
  review_comment_title VARCHAR2(50),
  review_comment_message  VARCHAR2(200),
  review_creation_date VARCHAR2(50),
  review_answer_timestamp VARCHAR2(50),
  MEMBER FUNCTION getReview_id RETURN VARCHAR2,
  MEMBER FUNCTION getReview_score RETURN NUMBER,
  MEMBER FUNCTION getReview_comment_title RETURN VARCHAR2);
/
CREATE OR REPLACE TYPE BODY T_reviews_type AS
    MEMBER FUNCTION getReview_id  RETURN VARCHAR2 IS
    BEGIN
        RETURN review_id;
    END getReview_id;
    MEMBER FUNCTION getReview_score  RETURN NUMBER IS
    BEGIN
        RETURN review_score;
    END getReview_score;
    MEMBER FUNCTION getReview_comment_title  RETURN VARCHAR2 IS
    BEGIN
        RETURN review_comment_title;
    END getReview_comment_title;    
END;
/

CREATE TABLE T_reviews OF  T_reviews_type;
---Creation d'index sur la table T_reviews
CREATE INDEX idx_T_reviews on T_reviews(review_id) ;

-- Add Constraint Primary Key For table T_reviews 
alter table T_reviews 
add constraint pk_reviews primary key(review_id); 
alter table T_reviews
add constraint fk_order_id foreign key (order_id) REFERENCES T_orders(order_id);

----------------------------Table t_sellers------------------------------

CREATE OR REPLACE TYPE T_sellers_type AS OBJECT(
  seller_id  VARCHAR2(50),
  seller_zip_code_prefix VARCHAR2(50), 
  seller_city VARCHAR2(50),
  seller_state VARCHAR2(50), 
  MEMBER FUNCTION getSeller_id RETURN VARCHAR2,
  MEMBER FUNCTION getSeller_zip_code_prefix RETURN VARCHAR2,
  MEMBER FUNCTION getSeller_city RETURN VARCHAR2
);
/
CREATE OR REPLACE TYPE BODY T_sellers_type AS
    MEMBER FUNCTION getSeller_id  RETURN VARCHAR2 IS
    BEGIN
        RETURN seller_id;
    END getSeller_id;
    MEMBER FUNCTION getSeller_zip_code_prefix  RETURN VARCHAR2 IS
    BEGIN
        RETURN seller_zip_code_prefix;
    END getSeller_zip_code_prefix;
    MEMBER FUNCTION getSeller_city  RETURN VARCHAR2 IS
    BEGIN
        RETURN seller_city;
    END getSeller_city;    
END;
/
CREATE TABLE T_sellers OF  T_sellers_type;
---Creation d'index sur la table T_sellers
CREATE INDEX idx_T_sellers on T_sellers(seller_id) ;
-- Add Constraint Primary Key For table T_sellers 
alter table T_sellers 
add constraint pk_idseller primary key(seller_id); 


commit;
---------------------------------Desactivation des contraintes-----------------------------------------------------------------------
alter table T_customers DISABLE constraint pk_customer_id;
alter table T_geolocation disable constraint pk_geolocation_zip_code_prefix;
alter table T_items disable constraint pk_order_items_id;
alter table T_items disable constraint fk22_order_id;
alter table T_items disable constraint fk_product_id;
alter table T_items disable constraint fk_seller_id;
alter table T_payments  disable constraint pk_payments;
alter table T_payments  disable constraint fk_payment;
alter table T_orders disable constraint  pk_order_idd;
alter table T_products disable constraint pk_products;
alter table T_reviews disable constraint pk_reviews;
alter table T_reviews disable constraint fk_order_id;
alter table T_sellers disable constraint  pk_idseller;
alter table T_Orders disable constraint  fk_customer_id;
commit;
--------------------- Copie des donnees de la zone d'extraction-----------------------------------
INSERT INTO T_category_name_translation
SELECT product_category_name, product_category_name_english
FROM category_name_translation;

INSERT INTO T_customers
SELECT *
FROM customers;

INSERT INTO T_geolocation
SELECT *
FROM geolocation;

INSERT INTO T_items
SELECT *
FROM items;

INSERT INTO T_orders
SELECT *
FROM orders;

INSERT INTO T_payments
SELECT *
FROM payments;

INSERT INTO T_reviews
SELECT *
FROM reviews;

INSERT INTO T_products
SELECT *
FROM products;
INSERT INTO T_sellers
SELECT *
FROM sellers;

--------------Activation les contraintes-----------------------------
alter table T_customers ENABLE constraint pk_customer_id;
alter table T_geolocation ENABLE constraint pk_geolocation_zip_code_prefix EXCEPTIONS INTO exceptions;
alter table T_items ENABLE constraint pk_order_items_id EXCEPTIONS INTO exceptions;
alter table T_items ENABLE constraint fk22_order_id EXCEPTIONS INTO exceptions;
alter table T_items ENABLE constraint fk_product_id EXCEPTIONS INTO exceptions;
alter table T_items ENABLE constraint fk_seller_id EXCEPTIONS INTO exceptions;
alter table T_payments ENABLE constraint pk_payments EXCEPTIONS INTO exceptions;
alter table T_payments ENABLE constraint fk_payment EXCEPTIONS INTO exceptions;
alter table T_orders ENABLE constraint  pk_order_idd EXCEPTIONS INTO exceptions;
alter table T_products ENABLE constraint pk_products EXCEPTIONS INTO exceptions;
alter table T_reviews ENABLE constraint pk_reviews EXCEPTIONS INTO exceptions;
alter table T_reviews ENABLE constraint fk_order_id EXCEPTIONS INTO exceptions;
alter table T_sellers ENABLE constraint  pk_idseller EXCEPTIONS INTO exceptions;

select * from exceptions;


--------- netteyage des donnees-----------------------
select * from exceptions;
delete from T_geolocation where rowid in (select row_id from exceptions);
delete from T_items where rowid in (select row_id from exceptions);
delete from T_payments where rowid in (select row_id from exceptions);
delete from T_reviews where rowid in (select row_id from exceptions);
 
select count(*) from T_items;
truncate table T_items;

DELETE FROM T_items  WHERE product_id NOT IN (SELECT product_id FROM T_products);

select * from T_items;






