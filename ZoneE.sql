---------------------------------------------------------Externel Table category_name_translation ------------------------

create or replace directory dic_source as 'E:\dic_source';
create or replace directory dic_log as 'E:\dic_log';

create table category_name_translation (
  product_category_name VARCHAR(50) ,
  product_category_name_english VARCHAR(50)
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\r\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'category_name_translation.bad'
    logfile dic_log:'category_name_translation.log'
    fields terminated BY ','
   )
    LOCATION ('category_name_translation.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from CATEGORY_NAME_TRANSLATION ; 

DROP TABLE CATEGORY_NAME_TRANSLATION ; 

---------------------------------------------------------Externel Table customers ------------------------
create table customers (
  customer_id VARCHAR(50) ,
  customer_unique_id VARCHAR(50) , 
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(50) ,
  customer_state VARCHAR(6)
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'customers.bad'
    logfile dic_log:'customers.log'
    fields terminated BY ','
   )
    LOCATION ('customers.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from customers  ; 

DROP TABLE customers ; 
    
---------------------------------------------------------Externel Table geolocation ------------------------
 
create table geolocation (
  geolocation_zip_code_prefix  VARCHAR(10) ,
  geolocation_lat VARCHAR(50) , 
  geolocation_lng VARCHAR(10),
  geolocation_city  VARCHAR(50) ,
  geolocation_state VARCHAR(6)
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'geolocation.bad'
    logfile dic_log:'geolocation.log'
    fields terminated BY ','
   )
    LOCATION ('geolocation.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from geolocation  ; 

DROP TABLE geolocation ; 

---------------------------------------------------------Externel Table items ------------------------
 
create table items (
  order_id  VARCHAR(60) ,
  order_item_id Number , 
  product_id VARCHAR(60),
  seller_id  VARCHAR(60) ,
  shipping_limit_date VARCHAR(20) ,
  price number(10,2) , 
  Freight_value number(10,2) 
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'items.bad'
    logfile dic_log:'items.log'
    fields terminated BY ','
   )
    LOCATION ('items.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from items  ; 

DROP TABLE items ; 
commit ; 

---------------------------------------------------------Externel Table orders ------------------------
create table orders (
  order_id  VARCHAR(50) ,
  customer_id VARCHAR(50) , 
  order_status VARCHAR(50),
  order_purchase_timestamp VARCHAR(20) ,
  order_approved_at   VARCHAR(20),
  order_delivered_carrier_date VARCHAR(20) ,
  order_delivered_customer_date VARCHAR(20) ,
  order_estimated_delivery_date VARCHAR(20) 
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'orders.bad'
    logfile dic_log:'orders.log'
    fields terminated BY ','
   )
    LOCATION ('orders.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from orders  ; 

DROP TABLE orders ; 
---------------------------------------------------------Externel Table payments ------------------------
create table payments (
  order_id  VARCHAR(50) ,
  payment_sequential VARCHAR(50) , 
  payment_type VARCHAR(20),
  payment_installments NUMBER(10) ,
  payment_value  NUMBER(6,2)
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'payments.bad'
    logfile dic_log:'payments.log'
    fields terminated BY ','
   )
    LOCATION ('payments.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from payments  ; 

DROP TABLE payments ; 

---------------------------------------------------------Externel Table products ------------------------
create table products (
  product_id  VARCHAR(50) ,
  product_category_name VARCHAR(50) , 
  product_name_lenght NUMBER(6),
  product_description_lenght NUMBER(15) ,
  product_photos_qty  NUMBER(6),
  product_weight_g NUMBER(15),
  product_length_cm NUMBER(15),
  product_height_cm NUMBER(15) ,
  product_width_cm NUMBER(15)
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'products.bad'
    logfile dic_log:'products.log'
    fields terminated BY ','
   )
    LOCATION ('products.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from products  ; 

DROP TABLE products ; 

---------------------------------------------------------Externel Table reviews ------------------------
create table reviews (
  review_id  VARCHAR(50) ,
  order_id VARCHAR(50) , 
  review_score NUMBER(10),
  review_comment_title VARCHAR(50) ,
  review_comment_message  VARCHAR(200),
  review_creation_date VARCHAR(50),
  review_answer_timestamp VARCHAR(50)
  
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'reviews.bad'
    logfile dic_log:'reviews.log'
    fields terminated BY ','
   )
    LOCATION ('reviews.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from reviews  ; 

DROP TABLE reviews ; 

 
---------------------------------------------------------Externel Table sellers ------------------------
create table sellers (
  seller_id  VARCHAR(50) ,
  seller_zip_code_prefix VARCHAR(10) , 
  seller_city VARCHAR(50),
  seller_state VARCHAR(50) 
  )
  ORGANIZATION EXTERNAL 
  (TYPE ORACLE_LOADER  
   DEFAULT Directory dic_source 
   ACCESS PARAMETERS 
   (records  DELIMITED BY '\n' 
    SKIP  1 
    CHARACTERSET UTF8
    badfile dic_log:'sellers.bad'
    logfile dic_log:'sellers.log'
    fields terminated BY ','
   )
    LOCATION ('sellers.csv'))
    REJECT LIMIT UNLIMITED ;
SELECT * from sellers  ; 

DROP TABLE sellers ; 