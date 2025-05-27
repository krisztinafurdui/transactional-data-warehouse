CREATE EXTENSION IF NOT EXISTS file_fdw;

CREATE SCHEMA IF NOT EXISTS sa_online_sales;
CREATE SCHEMA IF NOT EXISTS sa_offline_sales;

CREATE SERVER csv_server FOREIGN DATA WRAPPER file_fdw;

--DROP FOREIGN TABLE IF EXISTS sa_online_sales.ext_online_sales;

--create external table for online sales
CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales (
    order_no VARCHAR(1000),
    order_date VARCHAR(1000),
    customer_name VARCHAR(1000),
    address VARCHAR(1000),
    city VARCHAR(1000),
    state VARCHAR(1000),
    customer_type VARCHAR(1000),
    account_manager VARCHAR(1000),
    product_name VARCHAR(1000),
    product_category VARCHAR(1000),
    ship_mode VARCHAR(1000),
    cost_price VARCHAR(1000),
    retail_price VARCHAR(1000),
    profit_margin VARCHAR(1000),
    order_quantity VARCHAR(1000),
    sub_total VARCHAR(1000),
    discount_percent VARCHAR(1000),
    discount_amount VARCHAR(1000),
    order_total VARCHAR(1000),
    total VARCHAR(1000),
    supplier_name VARCHAR(1000),
    supplier_region VARCHAR(1000),
    payment_method VARCHAR(1000)
    
) SERVER csv_server
OPTIONS (
    filename '/Source_files_csv/online_sales.csv',
    format 'csv',
    header 'false',
    delimiter ','
);

--create src table for online sales
CREATE TABLE IF NOT EXISTS sa_online_sales.src_online_sales(
	order_no VARCHAR(1000),
    order_date VARCHAR(1000),
    customer_name VARCHAR(1000),
    address VARCHAR(1000),
    city VARCHAR(1000),
    state VARCHAR(1000),
    customer_type VARCHAR(1000),
    account_manager VARCHAR(1000),
    product_name VARCHAR(1000),
    product_category VARCHAR(1000),
    ship_mode VARCHAR(1000),
    cost_price VARCHAR(1000),
    retail_price VARCHAR(1000),
    profit_margin VARCHAR(1000),
    order_quantity VARCHAR(1000),
    sub_total VARCHAR(1000),
    discount_percent VARCHAR(1000),
    discount_amount VARCHAR(1000),
    order_total VARCHAR(1000),
    total VARCHAR(1000),
    supplier_name VARCHAR(1000),
    supplier_region VARCHAR(1000),
    payment_method VARCHAR(1000)
);

--create external table for offline sales
REATE FOREIGN TABLE IF NOT EXISTS sa_offline_sales.ext_offline_sales (
    order_no VARCHAR(1000),
    order_date VARCHAR(1000),
    customer_name VARCHAR(1000),
    address VARCHAR(1000),
    city VARCHAR(1000),
    state VARCHAR(1000),
    customer_type VARCHAR(1000),
    account_manager VARCHAR(1000),
    product_name VARCHAR(1000),
    product_category VARCHAR(1000),
    cost_price VARCHAR(1000),
    retail_price VARCHAR(1000),
    profit_margin VARCHAR(1000),
    order_quantity VARCHAR(1000),
    sub_total VARCHAR(1000),
    discount_percent VARCHAR(1000),
    discount_amount VARCHAR(1000),
    order_total VARCHAR(1000),
    total VARCHAR(1000),
    supplier_name VARCHAR(1000),
    supplier_region VARCHAR(1000),
    payment_method VARCHAR(1000)
    
) SERVER csv_server
OPTIONS (
    filename '/Source_files_csv/offline_sales.csv',
    format 'csv',
    header 'true',
    delimiter ','
);

--create src table for offline sales
CREATE TABLE IF NOT EXISTS sa_offline_sales.src_offline_sales(
	order_no VARCHAR(1000),
    order_date VARCHAR(1000),
    customer_name VARCHAR(1000),
    address VARCHAR(1000),
    city VARCHAR(1000),
    state VARCHAR(1000),
    customer_type VARCHAR(1000),
    account_manager VARCHAR(1000),
    product_name VARCHAR(1000),
    product_category VARCHAR(1000),
    cost_price VARCHAR(1000),
    retail_price VARCHAR(1000),
    profit_margin VARCHAR(1000),
    order_quantity VARCHAR(1000),
    sub_total VARCHAR(1000),
    discount_percent VARCHAR(1000),
    discount_amount VARCHAR(1000),
    order_total VARCHAR(1000),
    total VARCHAR(1000),
    supplier_name VARCHAR(1000),
    supplier_region VARCHAR(1000),
    payment_method VARCHAR(1000)
);



CREATE SCHEMA IF NOT EXISTS BL_3NF;

-- Create sequence for the primary key of CE_SHIPPING_MODE table
CREATE SEQUENCE IF NOT EXISTS seq_shipping_mode_id START WITH 1 INCREMENT BY 1;

-- Create the CE_SHIPPING_MODE table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_SHIPPING_MODE (
    shipping_mode_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_shipping_mode_id'),
    shipping_mode_name VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_ACCOUNT_MANAGERS table
CREATE SEQUENCE IF NOT EXISTS seq_account_manager_id START WITH 1 INCREMENT BY 1;

-- Create the CE_ACCOUNT_MANAGERS table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_ACCOUNT_MANAGERS (
    account_manager_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_account_manager_id'),
    account_manager_name VARCHAR(100) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_PAYMENT_METHODS table
CREATE SEQUENCE IF NOT EXISTS seq_payment_method_id START WITH 1 INCREMENT BY 1;

-- Create the CE_PAYMENT_METHODS table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_PAYMENT_METHODS (
    payment_method_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_payment_method_id'),
    payment_method VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_SUPPLIER_REGIONS table
CREATE SEQUENCE IF NOT EXISTS seq_supplier_region_id START WITH 1 INCREMENT BY 1;

-- Create the CE_SUPPLIER_REGIONS table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_SUPPLIER_REGIONS (
    supplier_region_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_supplier_region_id'),
    supplier_region VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_SUPPLIERS table
CREATE SEQUENCE IF NOT EXISTS seq_supplier_id START WITH 1 INCREMENT BY 1;

-- Create the CE_SUPPLIERS table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_SUPPLIERS (
    supplier_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_supplier_id'),
    supplier_name VARCHAR(100) NOT NULL,
    supplier_region_id BIGINT NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT fk_supplier_region FOREIGN KEY (supplier_region_id) 
    REFERENCES BL_3NF.CE_SUPPLIER_REGIONS(supplier_region_id)
);

-- Create sequence for the primary key of CE_COUNTRIES table
CREATE SEQUENCE IF NOT EXISTS seq_country_id START WITH 1 INCREMENT BY 1;

-- Create the CE_COUNTRIES table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_COUNTRIES (
    country_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_country_id'),
    country_name VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_CITIES table
CREATE SEQUENCE IF NOT EXISTS bl_3nf.seq_city_id START WITH 1 INCREMENT BY 1;


-- Create the CE_CITIES table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_CITIES (
    city_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('bl_3nf.seq_city_id'),
    city_name VARCHAR(50) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    country_id BIGINT NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT fk_country FOREIGN KEY (country_id) 
    REFERENCES BL_3NF.CE_COUNTRIES(country_id)
);

-- Create sequence for the primary key of CE_CUSTOMER_TYPES table
CREATE SEQUENCE IF NOT EXISTS bl_3nf.seq_customer_type_id START WITH 1 INCREMENT BY 1;

-- Create the CE_CUSTOMER_TYPES table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_CUSTOMER_TYPES (
    customer_type_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('bl_3nf.seq_customer_type_id'),
    customer_type_name VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_ADDRESSES table
CREATE SEQUENCE IF NOT EXISTS bl_3nf.seq_address_id START WITH 1 INCREMENT BY 1;

-- Create the CE_ADDRESSES table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_ADDRESSES (
    address_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('bl_3nf.seq_address_id'),
    address VARCHAR(100) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

--- Create sequence for the primary key of CE_CUSTOMERS table
CREATE SEQUENCE IF NOT EXISTS bl_3nf.seq_customer_id START WITH 1 INCREMENT BY 1;

-- Create the CE_CUSTOMERS table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_CUSTOMERS (
    customer_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('bl_3nf.seq_customer_id'),
    customer_name VARCHAR(100) NOT NULL,
    customer_type_id BIGINT NOT NULL, -- Reference to CE_CUSTOMER_TYPES
    address_id BIGINT NOT NULL, -- Reference to CE_ADDRESSES
    city_id BIGINT NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT fk_cities FOREIGN KEY (city_id) 
        REFERENCES BL_3NF.CE_CITIES(city_id),
    CONSTRAINT fk_customer_type FOREIGN KEY (customer_type_id) 
        REFERENCES BL_3NF.CE_CUSTOMER_TYPES(customer_type_id),
    CONSTRAINT fk_address FOREIGN KEY (address_id) 
        REFERENCES BL_3NF.CE_ADDRESSES(address_id)
);



-- Create sequence for the primary key of CE_PRODUCT_CATEGORIES table
CREATE SEQUENCE IF NOT EXISTS bl_3nf.seq_product_category_id START WITH 1 INCREMENT BY 1;

-- Create the CE_PRODUCT_CATEGORIES table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_PRODUCT_CATEGORIES (
    product_category_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('bl_3nf.seq_product_category_id'),
    product_category VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of CE_PRODUCTS_SCD table
CREATE SEQUENCE IF NOT EXISTS seq_product_id START WITH 1 INCREMENT BY 1;

-- Create the CE_PRODUCTS_SCD table
CREATE TABLE IF NOT EXISTS BL_3NF.CE_PRODUCTS_SCD (
    product_id BIGINT NOT NULL DEFAULT nextval('seq_product_id'),
    product_name VARCHAR(100) NOT NULL,
    cost_price NUMERIC(10, 2) NOT NULL,
    retail_price NUMERIC(10, 2) NOT NULL,
    profit_margin NUMERIC(10, 2) NOT NULL,
    product_category_id BIGINT NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    start_dt DATE NOT NULL, 
    end_dt DATE NOT NULL,
    is_active BOOLEAN NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT pk_ce_products_scd PRIMARY KEY (product_id, start_dt),
    CONSTRAINT fk_product_category FOREIGN KEY (product_category_id) 
    REFERENCES BL_3NF.CE_PRODUCT_CATEGORIES(product_category_id)
);

-- Create sequence for the primary key of FCT_SALES_ORDERS table
CREATE SEQUENCE IF NOT EXISTS seq_order_id START WITH 1 INCREMENT BY 1;

-- Create the FCT_SALES_ORDERS table
CREATE TABLE IF NOT EXISTS BL_3NF.FCT_SALES_ORDERS (
    order_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_order_id'),
    order_source_id BIGINT NOT NULL,
    order_dt DATE NOT NULL,
    order_quantity INT NOT NULL,
    order_total NUMERIC(10, 2) NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL,
    discount_percentage INT NOT NULL,
    discount_amount NUMERIC(10, 2) NOT NULL,
    shipping_mode_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    account_manager_id BIGINT NOT NULL,
    supplier_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    payment_method_id BIGINT NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT fk_shipping_mode FOREIGN KEY (shipping_mode_id) 
    REFERENCES BL_3NF.CE_SHIPPING_MODE(shipping_mode_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id)
    REFERENCES BL_3NF.CE_CUSTOMERS(customer_id),
    CONSTRAINT fk_account_manager FOREIGN KEY (account_manager_id)
    REFERENCES BL_3NF.CE_ACCOUNT_MANAGERS(account_manager_id),
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id)
    REFERENCES BL_3NF.CE_SUPPLIERS(supplier_id),
    CONSTRAINT fk_payment_method FOREIGN KEY (payment_method_id)
    REFERENCES BL_3NF.CE_PAYMENT_METHODS(payment_method_id)
);


CREATE SCHEMA IF NOT EXISTS BL_DM;

-- Create sequence for the primary key of DIM_SHIPPING_MODE table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_shipping_mode_surr_id START WITH 1 INCREMENT BY 1;

-- Create the DIM_SHIPPING_MODE table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_SHIPPING_MODE (
    shipping_mode_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_shipping_mode_surr_id'),
    shipping_mode VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of DIM_ACCOUNT_MANAGERS table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_account_manager_surr_id START WITH 1 INCREMENT BY 1;

-- Create the DIM_ACCOUNT_MANAGERS table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_ACCOUNT_MANAGERS (
    account_manager_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_account_manager_surr_id'),
    account_manager_name VARCHAR(100) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of DIM_PAYMENT_METHODS table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_payment_method_surr_id START WITH 1 INCREMENT BY 1;

-- Create the DIM_PAYMENT_METHODS table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_PAYMENT_METHODS (
    payment_method_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_payment_method_surr_id'),
    payment_method VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of DIM_SUPPLIERS table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_supplier_surr_id START WITH 1 INCREMENT BY 1;

-- Create the DIM_SUPPLIERS table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_SUPPLIERS (
    supplier_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_supplier_surr_id'),
    supplier_name VARCHAR(100) NOT NULL,
    supplier_region_id BIGINT NOT NULL,
    supplier_region VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of DIM_CUSTOMERS table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_customer_surr_id START WITH 1 INCREMENT BY 1;
DROP TABLE BL_DM.Dim_customers;
-- Create the DIM_CUSTOMERS table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_CUSTOMERS (
    customer_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_customer_surr_id'),
    customer_name VARCHAR(100) NOT NULL,
    address_id BIGINT NOT NULL,
    address VARCHAR(100) NOT NULL,
    city_id BIGINT NOT NULL,
    city_name VARCHAR(50) NOT NULL,
    country_id BIGINT NOT NULL,
    country_name VARCHAR(50) NOT NULL,
    customer_type_id BIGINT NOT NULL,
    customer_type VARCHAR(20) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of DIM_PRODUCTS_SCD table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_product_surr_id START WITH 1 INCREMENT BY 1;

-- Create the DIM_PRODUCTS_SCD table
CREATE TABLE IF NOT EXISTS BL_DM.DIM_PRODUCTS_SCD (
    product_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_product_surr_id'),
    product_name VARCHAR(100) NOT NULL,
    product_categories_id BIGINT NOT NULL,
    product_category VARCHAR(20) NOT NULL,
    cost_price NUMERIC(10, 2) NOT NULL,
    retail_price NUMERIC(10, 2) NOT NULL,
    profit_margin NUMERIC(10, 2) NOT NULL,
    source_id VARCHAR(255) NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    start_dt DATE NOT NULL, 
    end_dt DATE NOT NULL,
    is_active BOOLEAN NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL
);

-- Create sequence for the primary key of FCT_SALES_ORDERS_DD table
CREATE SEQUENCE IF NOT EXISTS bl_dm.seq_order_surr_id START WITH 1 INCREMENT BY 1;

-- Create the FCT_SALES_ORDERS_DD table
CREATE TABLE IF NOT EXISTS BL_DM.FCT_SALES_ORDERS_DD (
    order_surr_id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('seq_order_surr_id'),
    order_source_id VARCHAR(255) NOT NULL,
    event_dt DATE NOT NULL,
    order_quantity INT NOT NULL,
    order_total NUMERIC(10, 2) NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL,
    discount_percentage INT NOT NULL,
    discount_amount NUMERIC(10, 2) NOT NULL,
    shipping_mode_surr_id BIGINT NOT NULL,
    customer_surr_id BIGINT NOT NULL,
    account_manager_surr_id BIGINT NOT NULL,
    supplier_surr_id BIGINT NOT NULL,
    product_surr_id BIGINT NOT NULL,
    payment_method_surr_id BIGINT NOT NULL,
    source_entity VARCHAR(255) NOT NULL,
    source_system VARCHAR(255) NOT NULL,
    insert_dt DATE NOT NULL,
    update_dt DATE NOT NULL,
    CONSTRAINT fk_dim_shipping_mode FOREIGN KEY (shipping_mode_surr_id) 
    REFERENCES BL_DM.DIM_SHIPPING_MODE(shipping_mode_surr_id),
    CONSTRAINT fk_customer FOREIGN KEY (customer_surr_id)
    REFERENCES BL_DM.DIM_CUSTOMERS(customer_surr_id),
    CONSTRAINT fk_account_manager FOREIGN KEY (account_manager_surr_id)
    REFERENCES BL_DM.DIM_ACCOUNT_MANAGERS(account_manager_surr_id),
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_surr_id)
    REFERENCES BL_DM.DIM_SUPPLIERS(supplier_surr_id),
    CONSTRAINT fk_dim_products FOREIGN KEY (product_surr_id) 
    REFERENCES BL_DM.DIM_PRODUCTS(product_surr_id),
    CONSTRAINT fk_payment_method FOREIGN KEY (payment_method_surr_id)
    REFERENCES BL_DM.DIM_PAYMENT_METHODS(payment_method_surr_id)
);

