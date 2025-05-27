
--load data from foreign table into src table for online sales
INSERT INTO sa_online_sales.src_online_sales (order_no, order_date, customer_name, address, city, state, customer_type, 
											account_manager, product_name, product_category, ship_mode,
											cost_price, retail_price, profit_margin, order_quantity, sub_total, discount_percent,
    										discount_amount, order_total, total, supplier_name, supplier_region, payment_method)
SELECT DISTINCT order_no, order_date, customer_name, address, city, state, customer_type, 
		account_manager, product_name, product_category, ship_mode, 
		cost_price, retail_price, profit_margin, order_quantity, sub_total, discount_percent,
    	discount_amount, order_total, total, supplier_name, supplier_region, payment_method
FROM sa_online_sales.ext_online_sales;

--load data from foreign table into src table for offline sales
INSERT INTO sa_offline_sales.src_offline_sales(order_no, order_date, customer_name, address, city, state, customer_type, 
											account_manager, product_name, product_category, cost_price, retail_price, 
											profit_margin, order_quantity, sub_total, discount_percent, discount_amount, 
											order_total, total, supplier_name, supplier_region, payment_method)
SELECT DISTINCT	order_no, order_date, customer_name, address, city, state, customer_type, 
		account_manager, product_name, product_category, cost_price, retail_price, 
		profit_margin, order_quantity, sub_total, discount_percent, discount_amount, 
		order_total, total, supplier_name, supplier_region, payment_method
FROM sa_offline_sales.ext_offline_sales;

--Inserting default rows into 3nf layer tables

-- Insert default row for CE_SHIPPING_MODE
INSERT INTO BL_3NF.CE_SHIPPING_MODE (shipping_mode_id, shipping_mode_name, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_SHIPPING_MODE WHERE shipping_mode_id = -1);
COMMIT;

-- Insert default row for CE_ACCOUNT_MANAGERS
INSERT INTO BL_3NF.CE_ACCOUNT_MANAGERS (account_manager_id, account_manager_name, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_ACCOUNT_MANAGERS WHERE account_manager_id = -1);
COMMIT;

-- Insert default row for CE_PAYMENT_METHODS
INSERT INTO BL_3NF.CE_PAYMENT_METHODS (payment_method_id, payment_method, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_PAYMENT_METHODS WHERE payment_method_id = -1);
COMMIT;

-- Insert default row for CE_SUPPLIER_REGIONS
INSERT INTO BL_3NF.CE_SUPPLIER_REGIONS (supplier_region_id, supplier_region, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_SUPPLIER_REGIONS WHERE supplier_region_id = -1);
COMMIT;

-- Insert default row for CE_SUPPLIERS
INSERT INTO BL_3NF.CE_SUPPLIERS (supplier_id, supplier_name, supplier_region_id, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', -1, 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_SUPPLIERS WHERE supplier_id = -1);
COMMIT;

-- Insert default row for CE_COUNTRIES
INSERT INTO BL_3NF.CE_COUNTRIES (country_id, country_name, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_COUNTRIES WHERE country_id = -1);
COMMIT;

-- Insert default row for CE_CITIES
INSERT INTO BL_3NF.CE_CITIES (city_id, city_name, source_id, source_entity, source_system, country_id, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', -1, '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_CITIES WHERE city_id = -1);
COMMIT;

-- Insert default row for CE_CUSTOMER_TYPES
INSERT INTO BL_3NF.CE_CUSTOMER_TYPES (customer_type_id, customer_type_name, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_CUSTOMER_TYPES WHERE customer_type_id = -1);
COMMIT;

-- Insert default row for CE_ADDRESSES
INSERT INTO BL_3NF.CE_ADDRESSES (address_id, address, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_ADDRESSES WHERE address_id = -1);
COMMIT;

-- Insert default row for CE_CUSTOMERS
INSERT INTO BL_3NF.CE_CUSTOMERS (customer_id, customer_name, address_id, customer_type_id, city_id, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', -1, -1, -1, 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_CUSTOMERS WHERE customer_id = -1);
COMMIT;

-- Insert default row for CE_PRODUCT_CATEGORIES
INSERT INTO BL_3NF.CE_PRODUCT_CATEGORIES (product_category_id, product_category, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_PRODUCT_CATEGORIES WHERE product_category_id = -1);
COMMIT;

-- Insert default row for CE_PRODUCTS_SCD
INSERT INTO BL_3NF.CE_PRODUCTS_SCD (product_id, product_name, cost_price, retail_price, profit_margin, product_category_id, source_id, source_entity, source_system, start_dt, end_dt, is_active, insert_dt, update_dt)
SELECT -1, 'n.a.', -1, -1, -1, -1, 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '9999-12-31', FALSE, '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_3NF.CE_PRODUCTS_SCD WHERE product_id = -1);

COMMIT;


--Procedures to load data from source to 3NF layer


--Function to get distinct shipping modes
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_shipping_modes()
RETURNS TABLE (
    shipping_mode_name VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.ship_mode, 'n.a.')::VARCHAR AS shipping_mode_name,
        COALESCE(src.ship_mode, 'n.a.')::VARCHAR AS source_id,
        'src_online_sales'::VARCHAR AS source_entity,
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src;
END;
$$;

--Procedure to load data into CE_SHIPPING_MODE
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_shipping_mode_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct shipping modes
    FOR rec IN SELECT * FROM bl_cl.get_distinct_shipping_modes() LOOP
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_SHIPPING_MODE (
            shipping_mode_name, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.shipping_mode_name, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_SHIPPING_MODE tgt
            WHERE tgt.shipping_mode_name = rec.shipping_mode_name
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Ensure logging gets the final accumulated count
    CALL bl_cl.log_entry('load_ce_shipping_mode', rows_inserted, 
                         'Shipping mode load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_shipping_mode', 0, 
                             'Error: ' || SQLERRM);
END;
$$;


--Function to get disctint account managers from source
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_account_managers()
RETURNS TABLE (
    account_manager_name VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.account_manager, 'n.a.')::VARCHAR AS account_manager_name,
        COALESCE(src.account_manager, 'n.a.')::VARCHAR AS source_id,
        'src_online_sales'::VARCHAR AS source_entity,
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.account_manager, 'n.a.')::VARCHAR AS account_manager_name,
        COALESCE(src.account_manager, 'n.a.')::VARCHAR AS source_id,
        'src_offline_sales'::VARCHAR AS source_entity,
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_ACCOUNT_MANAGERS
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_account_managers_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct account managers
    FOR rec IN SELECT * FROM bl_cl.get_distinct_account_managers() LOOP
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_ACCOUNT_MANAGERS (
            account_manager_name, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.account_manager_name, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_ACCOUNT_MANAGERS tgt
            WHERE tgt.account_manager_name = rec.account_manager_name
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Ensure logging gets the final accumulated count
    CALL bl_cl.log_entry('load_ce_account_managers', rows_inserted, 
                         'Account managers load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_account_managers', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct payment methods
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_payment_methods()
RETURNS TABLE (
    payment_method VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.payment_method, 'n.a.')::VARCHAR AS payment_method,
        COALESCE(src.payment_method, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.payment_method, 'n.a.')::VARCHAR AS payment_method,
        COALESCE(src.payment_method, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_PAYMENTH_METHODS
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_payment_methods_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct payment methods
    FOR rec IN SELECT * FROM bl_cl.get_distinct_payment_methods() LOOP
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_PAYMENT_METHODS (
            payment_method, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.payment_method, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_PAYMENT_METHODS tgt
            WHERE tgt.payment_method = rec.payment_method
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Ensure logging gets the final accumulated count
    CALL bl_cl.log_entry('load_ce_payment_methods', rows_inserted, 
                         'Payment methods load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_payment_methods', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct supplier regions from source
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_supplier_regions()
RETURNS TABLE (
    supplier_region VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS supplier_region,
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS supplier_region,
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;


--Procedure to load data into CE_SUPPLIER_REGIONS
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_supplier_regions_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct supplier regions
    FOR rec IN SELECT * FROM bl_cl.get_distinct_supplier_regions() LOOP
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_SUPPLIER_REGIONS (
            supplier_region, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.supplier_region, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_SUPPLIER_REGIONS tgt
            WHERE tgt.supplier_region = rec.supplier_region
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Ensure logging gets the final accumulated count
    CALL bl_cl.log_entry('load_ce_supplier_regions', rows_inserted, 
                         'Supplier regions load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_supplier_regions', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct suppliers from source
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_suppliers()
RETURNS TABLE (
    supplier_name VARCHAR,
    supplier_region VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.supplier_name, 'n.a.')::VARCHAR AS supplier_name,
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS supplier_region,
        COALESCE(src.supplier_name, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.supplier_name, 'n.a.')::VARCHAR AS supplier_name,
        COALESCE(src.supplier_region, 'n.a.')::VARCHAR AS supplier_region,
        COALESCE(src.supplier_name, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;


--Procedure to load data into CE_SUPPLIERS
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_suppliers_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
    sup_region_id INT;  
BEGIN
    -- Loop through distinct suppliers
    FOR rec IN SELECT * FROM bl_cl.get_distinct_suppliers() LOOP
        -- Fetch supplier_region_id and store in renamed variable
        SELECT sr.supplier_region_id INTO sup_region_id
        FROM BL_3NF.CE_SUPPLIER_REGIONS sr
        WHERE sr.supplier_region = rec.supplier_region
        AND sr.source_entity = rec.source_entity
        AND sr.source_system = rec.source_system;

        -- Skip insertion if supplier_region_id is NULL
        IF sup_region_id IS NULL THEN
            CALL bl_cl.log_entry('load_ce_suppliers', 0, 
                'Skipping supplier ' || rec.supplier_name || ' due to missing supplier_region_id.');
            CONTINUE;
        END IF;

        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_SUPPLIERS (
            supplier_name, 
            supplier_region_id, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.supplier_name, 
            sup_region_id,  
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_SUPPLIERS tgt
            WHERE tgt.supplier_name = rec.supplier_name
            AND tgt.supplier_region_id = sup_region_id  
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Ensure logging gets the final accumulated count
    CALL bl_cl.log_entry('load_ce_suppliers', rows_inserted, 
                         'Suppliers load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_suppliers', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct countries
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_countries()
RETURNS TABLE (
    country_name VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.state, 'n.a.')::VARCHAR AS country_name,
        COALESCE(src.state, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.state, 'n.a.')::VARCHAR AS country_name,
        COALESCE(src.state, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_COUNTRIES
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_countries_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct countries
    FOR rec IN SELECT * FROM bl_cl.get_distinct_countries() LOOP
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_COUNTRIES (
            country_name, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.country_name, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_COUNTRIES tgt
            WHERE tgt.country_name = rec.country_name
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count only if a row was inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log the number of inserted rows
    CALL bl_cl.log_entry('load_ce_countries', rows_inserted, 
                         'Countries load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_countries', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct cities
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_cities()
RETURNS TABLE (
    city_name VARCHAR,
    country_name VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.city, 'n.a.')::VARCHAR AS city_name,
        COALESCE(src.state, 'n.a.')::VARCHAR AS country_name, -- Using state as country
        COALESCE(src.city, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.city, 'n.a.')::VARCHAR AS city_name,
        COALESCE(src.state, 'n.a.')::VARCHAR AS country_name,  
        COALESCE(src.city, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_CITIES
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_cities_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
    countryid BIGINT;
BEGIN
    -- Loop through distinct cities
    FOR rec IN SELECT * FROM bl_cl.get_distinct_cities() LOOP
        -- Fetch country_id
        SELECT c.country_id INTO countryid
        FROM BL_3NF.CE_COUNTRIES c
        WHERE c.country_name = rec.country_name
        AND c.source_entity = rec.source_entity
        AND c.source_system = rec.source_system;

        -- Skip if country_id is NULL
        IF countryid IS NULL THEN
            CALL bl_cl.log_entry('load_ce_cities', 0, 
                'Skipping city ' || rec.city_name || ' due to missing country_id.');
            CONTINUE;
        END IF;

        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_CITIES (
            city_name, 
            source_id, 
            source_entity, 
            source_system, 
            country_id,
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.city_name, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            countryid,
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_CITIES tgt
            WHERE tgt.city_name = rec.city_name
            AND tgt.country_id = countryid
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count if inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log final row count
    CALL bl_cl.log_entry('load_ce_cities', rows_inserted, 
                         'Cities load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_cities', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct customer types
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_customer_types()
RETURNS TABLE (
    customer_type_name VARCHAR,
    source_id VARCHAR,
    source_entity VARCHAR,
    source_system VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.customer_type, 'n.a.')::VARCHAR AS customer_type_name,
        COALESCE(src.customer_type, 'n.a.')::VARCHAR AS source_id,  
        'src_online_sales'::VARCHAR AS source_entity, 
        'sa_online_sales'::VARCHAR AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.customer_type, 'n.a.')::VARCHAR AS customer_type_name,
        COALESCE(src.customer_type, 'n.a.')::VARCHAR AS source_id,  
        'src_offline_sales'::VARCHAR AS source_entity, 
        'sa_offline_sales'::VARCHAR AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_CUSTOMER_TYPES
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_customer_types_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct customer types
    FOR rec IN SELECT * FROM bl_cl.get_distinct_customer_types() LOOP
        
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_CUSTOMER_TYPES (
            customer_type_name, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.customer_type_name, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_CUSTOMER_TYPES tgt
            WHERE tgt.customer_type_name = rec.customer_type_name
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count if inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log final row count
    CALL bl_cl.log_entry('load_ce_customer_types', rows_inserted, 
                         'Customer types load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_customer_types', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct addresses from source
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_addresses()
RETURNS TABLE (
    address VARCHAR(100),
    source_id VARCHAR(255),
    source_entity VARCHAR(255),
    source_system VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.address, 'n.a.')::VARCHAR(100) AS address,
        COALESCE(src.address, 'n.a.')::VARCHAR(255) AS source_id,  
        'src_online_sales'::VARCHAR(255) AS source_entity, 
        'sa_online_sales'::VARCHAR(255) AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.address, 'n.a.')::VARCHAR(100) AS address,
        COALESCE(src.address, 'n.a.')::VARCHAR(255) AS source_id,  
        'src_offline_sales'::VARCHAR(255) AS source_entity, 
        'sa_offline_sales'::VARCHAR(255) AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_ADDRESSES
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_addresses_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct addresses
    FOR rec IN SELECT * FROM bl_cl.get_distinct_addresses() LOOP
        
        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_ADDRESSES (
            address, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.address, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_ADDRESSES tgt
            WHERE tgt.address = rec.address
            AND tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count if inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log final row count
    CALL bl_cl.log_entry('load_ce_addresses', rows_inserted, 
                         'Addresses load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_addresses', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Fucnction to get distinct customers:
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_customers()
RETURNS TABLE (
    customer_name VARCHAR(100),
    customer_type_name VARCHAR(255),
    address VARCHAR(100),
    city_name VARCHAR(100),
    source_id VARCHAR(255),
    source_entity VARCHAR(255),
    source_system VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.customer_name, 'n.a.')::VARCHAR(100) AS customer_name,
        COALESCE(src.customer_type, 'n.a.')::VARCHAR(255) AS customer_type_name,
        COALESCE(src.address, 'n.a.')::VARCHAR(100) AS address,
        COALESCE(src.city, 'n.a.')::VARCHAR(100) AS city_name,
        (COALESCE(src.customer_name, 'n.a.') || '|' || COALESCE(src.address, 'n.a.'))::VARCHAR(255) AS source_id,  
        'src_online_sales'::VARCHAR(255) AS source_entity, 
        'sa_online_sales'::VARCHAR(255) AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.customer_name, 'n.a.')::VARCHAR(100) AS customer_name,
        COALESCE(src.customer_type, 'n.a.')::VARCHAR(255) AS customer_type_name,
        COALESCE(src.address, 'n.a.')::VARCHAR(100) AS address,
        COALESCE(src.city, 'n.a.')::VARCHAR(100) AS city_name,
        (COALESCE(src.customer_name, 'n.a.') || '|' || COALESCE(src.address, 'n.a.'))::VARCHAR(255) AS source_id,  
        'src_offline_sales'::VARCHAR(255) AS source_entity, 
        'sa_offline_sales'::VARCHAR(255) AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_CUSTOMERS
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_customers_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    custyp_id BIGINT;
    addr_id BIGINT;
    cityid BIGINT;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct customers
    FOR rec IN SELECT * FROM bl_cl.get_distinct_customers() LOOP
        
        -- Fetch customer_type_id
        SELECT customer_type_id INTO custyp_id
        FROM BL_3NF.CE_CUSTOMER_TYPES
        WHERE customer_type_name = rec.customer_type_name
		AND source_entity = rec.source_entity
        AND source_system = rec.source_system
 		LIMIT 1;

        -- If customer_type does not exist, log an error and continue
        IF custyp_id IS NULL THEN
            CALL bl_cl.log_entry('load_ce_customers', 0, 
                                 'Missing customer_type: ' || rec.customer_type_name);
            CONTINUE;
        END IF;

        -- Fetch address_id
        SELECT address_id INTO addr_id
        FROM BL_3NF.CE_ADDRESSES
        WHERE address = rec.address
		AND source_entity = rec.source_entity
        AND source_system = rec.source_system
        LIMIT 1;

        -- If address does not exist, log an error and continue
        IF addr_id IS NULL THEN
            CALL bl_cl.log_entry('load_ce_customers', 0, 
                                 'Missing address: ' || rec.address);
            CONTINUE;
        END IF;

        -- Fetch city_id
        SELECT city_id INTO cityid
        FROM BL_3NF.CE_CITIES
        WHERE city_name = rec.city_name
		AND source_entity = rec.source_entity
        AND source_system = rec.source_system
        LIMIT 1;

        -- If city does not exist, log an error and continue
        IF cityid IS NULL THEN
            CALL bl_cl.log_entry('load_ce_customers', 0, 
                                 'Missing city: ' || rec.city_name);
            CONTINUE;
        END IF;

        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_CUSTOMERS (
            customer_name, 
            customer_type_id, 
            address_id, 
            city_id,
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.customer_name, 
            custyp_id, 
            addr_id, 
            cityid, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_CUSTOMERS tgt
            WHERE tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count if inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log final row count
    CALL bl_cl.log_entry('load_ce_customers', rows_inserted, 
                         'Customers load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_customers', 0, 
                             'Error: ' || SQLERRM);
END;
$$;

--Function to get distinct product categories
CREATE OR REPLACE FUNCTION bl_cl.get_distinct_product_categories()
RETURNS TABLE (
    product_category VARCHAR(20),
    source_id VARCHAR(255),
    source_entity VARCHAR(255),
    source_system VARCHAR(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT 
        COALESCE(src.product_category, 'n.a.')::VARCHAR(20) AS product_category,
        COALESCE(src.product_category, 'n.a.')::VARCHAR(255) AS source_id,  
        'src_online_sales'::VARCHAR(255) AS source_entity, 
        'sa_online_sales'::VARCHAR(255) AS source_system
    FROM sa_online_sales.src_online_sales src

    UNION

    SELECT DISTINCT 
        COALESCE(src.product_category, 'n.a.')::VARCHAR(20) AS product_category,
        COALESCE(src.product_category, 'n.a.')::VARCHAR(255) AS source_id,  
        'src_offline_sales'::VARCHAR(255) AS source_entity, 
        'sa_offline_sales'::VARCHAR(255) AS source_system
    FROM sa_offline_sales.src_offline_sales src;
END;
$$;

--Procedure to load data into CE_PRODUCT_CATEGORIES
CREATE OR REPLACE PROCEDURE bl_cl.load_ce_product_categories_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    rows_inserted INT := 0;
BEGIN
    -- Loop through distinct product categories
    FOR rec IN SELECT * FROM bl_cl.get_distinct_product_categories() LOOP

        -- Insert only if it does not already exist
        INSERT INTO BL_3NF.CE_PRODUCT_CATEGORIES (
            product_category, 
            source_id, 
            source_entity, 
            source_system, 
            insert_dt, 
            update_dt
        )
        SELECT 
            rec.product_category, 
            rec.source_id, 
            rec.source_entity, 
            rec.source_system, 
            NOW(), 
            NOW()
        WHERE NOT EXISTS (
            SELECT 1 
            FROM BL_3NF.CE_PRODUCT_CATEGORIES tgt
            WHERE tgt.source_id = rec.source_id
            AND tgt.source_entity = rec.source_entity
            AND tgt.source_system = rec.source_system
        );

        -- Increase row count if inserted
        IF FOUND THEN 
            rows_inserted := rows_inserted + 1;
        END IF;
    END LOOP;

    -- Log final row count
    CALL bl_cl.log_entry('load_ce_product_categories', rows_inserted, 
                         'Product categories load completed successfully. Rows inserted: ' || rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_product_categories', 0, 
                             'Error: ' || SQLERRM);
END;
$$;


/*New solution */

CREATE OR REPLACE PROCEDURE bl_cl.load_ce_products_scd_to_3nf()
LANGUAGE plpgsql
AS $$
DECLARE
    v_rows_updated INT := 0;
    v_rows_inserted INT := 0;
BEGIN
    -- Step 1: Stage products from both sources, consolidating categories
    CREATE TEMP TABLE temp_products AS
    WITH source_products AS (
        SELECT 
            COALESCE(product_name, 'n.a.')::VARCHAR(100) AS product_name,
            COALESCE(CAST(REPLACE(cost_price, '$', '') AS NUMERIC(10,2)), -1) AS cost_price,
            COALESCE(CAST(REPLACE(retail_price, '$', '') AS NUMERIC(10,2)), -1) AS retail_price,
            COALESCE(CAST(REPLACE(profit_margin, '$', '') AS NUMERIC(10,2)), -1) AS profit_margin,
            COALESCE(product_category, 'n.a.')::VARCHAR(20) AS product_category,
            COALESCE(product_name, 'n.a.')::VARCHAR(255) AS source_id,
            'src_online_sales'::VARCHAR(255) AS source_entity,
            'sa_online_sales'::VARCHAR(255) AS source_system
        FROM sa_online_sales.src_online_sales
        UNION
        SELECT 
            COALESCE(product_name, 'n.a.')::VARCHAR(100) AS product_name,
            COALESCE(CAST(REPLACE(cost_price, '$', '') AS NUMERIC(10,2)), -1) AS cost_price,
            COALESCE(CAST(REPLACE(retail_price, '$', '') AS NUMERIC(10,2)), -1) AS retail_price,
            COALESCE(CAST(REPLACE(profit_margin, '$', '') AS NUMERIC(10,2)), -1) AS profit_margin,
            COALESCE(product_category, 'n.a.')::VARCHAR(20) AS product_category,
            COALESCE(product_name, 'n.a.')::VARCHAR(255) AS source_id,
            'src_offline_sales'::VARCHAR(255) AS source_entity,
            'sa_offline_sales'::VARCHAR(255) AS source_system
        FROM sa_offline_sales.src_offline_sales
    ),
    deduped_products AS (
        SELECT DISTINCT ON (source_id, source_entity, source_system)
            product_name,
            cost_price,
            retail_price,
            profit_margin,
            product_category,
            source_id,
            source_entity,
            source_system
        FROM source_products
        ORDER BY source_id, source_entity, source_system, product_category
    )
    SELECT 
        dp.product_name,
        dp.cost_price,
        dp.retail_price,
        dp.profit_margin,
        COALESCE(
            (SELECT pc.product_category_id 
             FROM BL_3NF.CE_PRODUCT_CATEGORIES pc 
             WHERE pc.product_category = dp.product_category 
             AND pc.source_entity = dp.source_entity 
             AND pc.source_system = dp.source_system 
             ORDER BY pc.product_category_id LIMIT 1),
            (SELECT product_category_id 
             FROM BL_3NF.CE_PRODUCT_CATEGORIES 
             WHERE product_category = 'unknown' 
             AND source_entity = 'system' 
             AND source_system = 'system' 
             LIMIT 1)
        ) AS product_category_id,
        dp.source_id,
        dp.source_entity,
        dp.source_system,
        CURRENT_DATE AS start_dt,
        '9999-12-31'::DATE AS end_dt,
        TRUE AS is_active,
        CURRENT_DATE AS insert_dt,
        CURRENT_DATE AS update_dt
    FROM deduped_products dp;

    -- Step 2: Update existing active records with attribute changes, respecting source
    UPDATE BL_3NF.CE_PRODUCTS_SCD existing
    SET 
        is_active = FALSE,
        end_dt = CASE 
                    WHEN existing.start_dt = CURRENT_DATE THEN CURRENT_DATE 
                    ELSE CURRENT_DATE - INTERVAL '1 day' 
                 END,
        update_dt = CURRENT_DATE
    FROM temp_products incoming
    WHERE existing.source_id = incoming.source_id
    AND existing.source_entity = incoming.source_entity
    AND existing.source_system = incoming.source_system
    AND existing.is_active = TRUE
    AND (
        existing.product_name != incoming.product_name
        OR existing.cost_price != incoming.cost_price
        OR existing.retail_price != incoming.retail_price
        OR existing.profit_margin != incoming.profit_margin
        OR existing.product_category_id != incoming.product_category_id
    );

    GET DIAGNOSTICS v_rows_updated = ROW_COUNT;

    -- Step 3: Insert new or changed products, respecting source
    INSERT INTO BL_3NF.CE_PRODUCTS_SCD (
        product_name,
        cost_price,
        retail_price,
        profit_margin,
        product_category_id,
        source_id,
        source_entity,
        source_system,
        start_dt,
        end_dt,
        is_active,
        insert_dt,
        update_dt
    )
    SELECT 
        incoming.product_name,
        incoming.cost_price,
        incoming.retail_price,
        incoming.profit_margin,
        incoming.product_category_id,
        incoming.source_id,
        incoming.source_entity,
        incoming.source_system,
        incoming.start_dt,
        incoming.end_dt,
        incoming.is_active,
        incoming.insert_dt,
        incoming.update_dt
    FROM temp_products incoming
    WHERE NOT EXISTS (
        SELECT 1
        FROM BL_3NF.CE_PRODUCTS_SCD existing
        WHERE existing.source_id = incoming.source_id
        AND existing.source_entity = incoming.source_entity
        AND existing.source_system = incoming.source_system
        AND existing.is_active = TRUE
        AND existing.product_name = incoming.product_name
        AND existing.cost_price = incoming.cost_price
        AND existing.retail_price = incoming.retail_price
        AND existing.profit_margin = incoming.profit_margin
        AND existing.product_category_id = incoming.product_category_id
    );

    GET DIAGNOSTICS v_rows_inserted = ROW_COUNT;

    -- Step 4: Clean up
    DROP TABLE temp_products;

    -- Log the result
    CALL bl_cl.log_entry('load_ce_products_scd_to_3nf', v_rows_updated + v_rows_inserted, 
                         'SCD Type 2 products loaded successfully. Rows updated: ' || v_rows_updated || 
                         ', Rows inserted: ' || v_rows_inserted);

EXCEPTION
    WHEN OTHERS THEN
        CALL bl_cl.log_entry('load_ce_products_scd_to_3nf', 0, 
                             'Error: ' || SQLERRM);
        RAISE NOTICE 'Exception occurred: %', SQLERRM;
END;
$$;


SELECT BL_CL.load_ce_shipping_mode_to_3nf();
SELECT BL_CL.load_ce_account_managers_to_3nf();
SELECT BL_CL.load_ce_payment_methods_to_3nf();
SELECT BL_CL.load_ce_supplier_regions_to_3nf();
SELECT BL_CL.load_ce_suppliers_to_3nf();
SELECT BL_CL.load_ce_countries_to_3nf();
SELECT BL_CL.load_ce_cities_to_3nf();
SELECT BL_CL.load_ce_customer_types_to_3nf();
SELECT BL_CL.load_ce_addresses_to_3nf();
SELECT BL_CL.load_ce_customers_to_3nf();
SELECT BL_CL.load_ce_product_categories_to_3nf();
SELECT BL_CL.load_ce_products_scd_to_3nf();

--Inserting default rows into dimensional layer tables

-- Insert default row for DIM_SHIPPING_MODE
INSERT INTO BL_DM.DIM_SHIPPING_MODE (shipping_mode_surr_id, shipping_mode, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_SHIPPING_MODE WHERE shipping_mode_surr_id = -1);
COMMIT;

-- Insert default row for DIM_ACCOUNT_MANAGERS
INSERT INTO BL_DM.DIM_ACCOUNT_MANAGERS (account_manager_surr_id, account_manager_name, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_ACCOUNT_MANAGERS WHERE account_manager_surr_id = -1);
COMMIT;

-- Insert default row for DIM_PAYMENT_METHODS
INSERT INTO BL_DM.DIM_PAYMENT_METHODS (payment_method_surr_id, payment_method, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_PAYMENT_METHODS WHERE payment_method_surr_id = -1);
COMMIT;

-- Insert default row for DIM_SUPPLIERS
INSERT INTO BL_DM.DIM_SUPPLIERS (supplier_surr_id, supplier_name, supplier_region_id, supplier_region, source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', -1, 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_SUPPLIERS WHERE supplier_surr_id = -1);
COMMIT;

-- Insert default row for DIM_CUSTOMERS
INSERT INTO BL_DM.DIM_CUSTOMERS (customer_surr_id, customer_name, address, city_id, city_name, country_id, country_name, customer_type,  source_id, source_entity, source_system, insert_dt, update_dt)
SELECT -1, 'n.a.', 'n.a.', -1, 'n.a.', -1, 'n.a.', 'n.a.', 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_CUSTOMERS WHERE customer_surr_id = -1);
COMMIT;

-- Insert default row for DIM_PRODUCTS_SCD
INSERT INTO BL_DM.DIM_PRODUCTS_SCD (product_surr_id, product_name, product_categories_id, product_category, cost_price, retail_price, profit_margin, source_id, source_entity, source_system, start_dt, end_dt, is_active, insert_dt, update_dt)
SELECT -1, 'n.a.', -1, 'n.a.', -1, -1, -1, 'n.a.', 'MANUAL', 'MANUAL', '1900-01-01', '9999-12-31', FALSE, '1900-01-01', '1900-01-01'
WHERE NOT EXISTS (SELECT 1 FROM BL_DM.DIM_PRODUCTS_SCD WHERE product_surr_id = -1);

COMMIT;

SET ROLE postgres;

CREATE ROLE data_loader_role_dm WITH LOGIN PASSWORD 'your_secure_password';

GRANT USAGE, CREATE ON SCHEMA bl_cl TO data_loader_role_dm;
GRANT USAGE, CREATE ON SCHEMA bl_3nf TO data_loader_role_dm;
GRANT USAGE, CREATE ON SCHEMA bl_dm TO data_loader_role_dm;
GRANT USAGE ON SCHEMA sa_online_sales TO data_loader_role_dm;
GRANT USAGE ON SCHEMA sa_offline_sales TO data_loader_role_dm;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bl_cl TO data_loader_role_dm;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bl_3nf TO data_loader_role_dm;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA bl_dm TO data_loader_role_dm;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA bl_cl TO data_loader_role_dm;

ALTER DEFAULT PRIVILEGES IN SCHEMA bl_cl 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO data_loader_role_dm;

ALTER DEFAULT PRIVILEGES IN SCHEMA bl_dm 
GRANT SELECT, INSERT, UPDATE, DELETE, ON TABLES TO data_loader_role_dm;

ALTER DEFAULT PRIVILEGES IN SCHEMA bl_cl 
GRANT EXECUTE ON FUNCTIONS TO data_loader_role_dm;

GRANT data_loader_role_dm TO current_user;

SET ROLE data_loader_role_dm;

SELECT current_user;

-- Create a unique index for DIM_SHIPPING_MODE
CREATE UNIQUE INDEX idx_dim_shipping_mode_unique 
ON BL_DM.DIM_SHIPPING_MODE (source_id, source_entity, source_system);

CREATE UNIQUE INDEX idx_dim_account_managers_unique 
ON BL_DM.DIM_ACCOUNT_MANAGERS (source_id, source_entity, source_system);

CREATE UNIQUE INDEX idx_dim_payment_methods_unique 
ON BL_DM.DIM_PAYMENT_METHODS (source_id, source_entity, source_system);

CREATE UNIQUE INDEX idx_dim_suppliers_unique 
ON BL_DM.DIM_SUPPLIERS (source_id, source_entity, source_system);

CREATE UNIQUE INDEX idx_dim_customers_unique 
ON BL_DM.DIM_CUSTOMERS (source_id, source_entity, source_system);

CREATE UNIQUE INDEX idx_dim_products_scd_unique 
ON BL_DM.DIM_PRODUCTS_SCD (source_id, source_entity, source_system, start_dt);


--Load data from 3NF to DM layer
CREATE OR REPLACE FUNCTION BL_CL.load_dim_shipping_mode()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_SHIPPING_MODE (
        shipping_mode,
        source_id,
        source_entity,
        source_system,
        insert_dt,
        update_dt
    )
    SELECT 
        shipping_mode_name,
        shipping_mode_id::VARCHAR(255),
        source_entity,
        source_system,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_SHIPPING_MODE
    ON CONFLICT (source_id, source_entity, source_system)
    DO NOTHING;

    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_shipping_mode', rows_affected, 
                         'Shipping modes loaded successfully. Rows affected: ' || rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_shipping_mode', 0, 'Error: ' || SQLERRM);
END;
$$;

CREATE OR REPLACE FUNCTION BL_CL.load_dim_account_managers()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_ACCOUNT_MANAGERS (
        account_manager_name,
        source_id,
        source_entity,
        source_system,
        insert_dt,
        update_dt
    )
    SELECT 
        account_manager_name,
        account_manager_id::VARCHAR(255),
        source_entity,
        source_system,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_ACCOUNT_MANAGERS
    ON CONFLICT (source_id, source_entity, source_system)
    DO NOTHING;

    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_account_managers', rows_affected, 
                         'Account managers loaded successfully. Rows affected: ' || rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_account_managers', 0, 'Error: ' || SQLERRM);
END;
$$;

CREATE OR REPLACE FUNCTION BL_CL.load_dim_payment_methods()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_PAYMENT_METHODS (
        payment_method,
        source_id,
        source_entity,
        source_system,
        insert_dt,
        update_dt
    )
    SELECT 
        payment_method,
        payment_method_id::VARCHAR(255),
        source_entity,
        source_system,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_PAYMENT_METHODS
    ON CONFLICT (source_id, source_entity, source_system)
    DO NOTHING;

    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_payment_methods', rows_affected, 
                         'Payment methods loaded successfully. Rows affected: ' || rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_payment_methods', 0, 'Error: ' || SQLERRM);
END;
$$;

CREATE OR REPLACE FUNCTION BL_CL.load_dim_suppliers()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_SUPPLIERS (
        supplier_name,
        supplier_region_id,
        supplier_region,
        source_id,
        source_entity,
        source_system,
        insert_dt,
        update_dt
    )
    SELECT 
        s.supplier_name,
        sr.supplier_region_id,
        sr.supplier_region,
        s.supplier_id::VARCHAR(255),
        s.source_entity,
        s.source_system,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_SUPPLIERS s
    JOIN BL_3NF.CE_SUPPLIER_REGIONS sr 
        ON sr.supplier_region_id = s.supplier_region_id
        AND sr.source_entity = s.source_entity
        AND sr.source_system = s.source_system
    ON CONFLICT (source_id, source_entity, source_system)
    DO NOTHING;

    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_suppliers', rows_affected, 
                         'Suppliers loaded successfully. Rows affected: ' || rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_suppliers', 0, 'Error: ' || SQLERRM);
END;
$$;

CREATE OR REPLACE FUNCTION BL_CL.load_dim_customers()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_CUSTOMERS (
        customer_name,
        address_id,
        address,
        city_id,
        city_name,
        country_id,
        country_name,
        customer_type_id,
        customer_type,
        source_id,
        source_entity,
        source_system,
        insert_dt,
        update_dt
    )
    SELECT 
        c.customer_name,
        a.address_id,
        a.address,
        ci.city_id,
        ci.city_name,
        co.country_id,
        co.country_name,
        ct.customer_type_id,
        ct.customer_type_name,
        c.customer_id::VARCHAR(255),
        c.source_entity,
        c.source_system,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_CUSTOMERS c
    JOIN BL_3NF.CE_ADDRESSES a 
        ON a.address_id = c.address_id
        AND a.source_entity = c.source_entity
        AND a.source_system = c.source_system
    JOIN BL_3NF.CE_CITIES ci 
        ON ci.city_id = c.city_id
        AND ci.source_entity = c.source_entity
        AND ci.source_system = c.source_system
    JOIN BL_3NF.CE_COUNTRIES co 
        ON co.country_id = ci.country_id
        AND co.source_entity = ci.source_entity
        AND co.source_system = ci.source_system
    JOIN BL_3NF.CE_CUSTOMER_TYPES ct 
        ON ct.customer_type_id = c.customer_type_id
        AND ct.source_entity = c.source_entity
        AND ct.source_system = c.source_system
    ON CONFLICT (source_id, source_entity, source_system)
    DO NOTHING;

    GET DIAGNOSTICS rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_customers', rows_affected, 
                         'Customers loaded successfully. Rows affected: ' || rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_customers', 0, 'Error: ' || SQLERRM);
END;
$$;

CREATE OR REPLACE FUNCTION BL_CL.load_dim_products_scd()
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
    v_rows_affected INT;
BEGIN
    INSERT INTO BL_DM.DIM_PRODUCTS_SCD (
        product_name,
        product_categories_id,
        product_category,
        cost_price,
        retail_price,
        profit_margin,
        source_id,
        source_entity,
        source_system,
        start_dt,
        end_dt,
        is_active,
        insert_dt,
        update_dt
    )
    SELECT 
        p.product_name,
        pc.product_category_id,
        pc.product_category,
        p.cost_price,
        p.retail_price,
        p.profit_margin,
        p.product_id::VARCHAR(255),
        p.source_entity,
        p.source_system,
        p.start_dt,
        p.end_dt,
        p.is_active,
        CURRENT_DATE,
        CURRENT_DATE
    FROM BL_3NF.CE_PRODUCTS_SCD p
    JOIN BL_3NF.CE_PRODUCT_CATEGORIES pc 
        ON pc.product_category_id = p.product_category_id
        AND pc.source_entity = p.source_entity
        AND pc.source_system = p.source_system
    ON CONFLICT (source_id, source_entity, source_system, start_dt)
    DO NOTHING;

    GET DIAGNOSTICS v_rows_affected = ROW_COUNT;

    CALL BL_CL.log_entry('load_dim_products_scd', v_rows_affected, 
                         'Products SCD loaded successfully. Rows affected: ' || v_rows_affected);
EXCEPTION
    WHEN OTHERS THEN
        CALL BL_CL.log_entry('load_dim_products_scd', 0, 'Error: ' || SQLERRM);
END;
$$;

SELECT BL_CL.load_dim_shipping_mode();
SELECT BL_CL.load_dim_account_managers();
SELECT BL_CL.load_dim_payment_methods();
SELECT BL_CL.load_dim_suppliers();
SELECT BL_CL.load_dim_customers();
SELECT BL_CL.load_dim_products_scd();