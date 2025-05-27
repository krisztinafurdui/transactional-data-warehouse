--Create schema BL_CL
CREATE SCHEMA bl_cl;

SET ROLE postgres;

CREATE ROLE data_loader_role WITH LOGIN PASSWORD 'your_secure_password';

GRANT USAGE, CREATE ON SCHEMA bl_cl TO data_loader_role;
GRANT USAGE, CREATE ON SCHEMA bl_3nf TO data_loader_role;
GRANT USAGE, CREATE ON SCHEMA bl_dm TO data_loader_role;
GRANT USAGE ON SCHEMA sa_online_sales TO data_loader_role;
GRANT USAGE ON SCHEMA sa_offline_sales TO data_loader_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bl_cl TO data_loader_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bl_3nf TO data_loader_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA bl_dm TO data_loader_role;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA bl_cl TO data_loader_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA bl_cl 
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO data_loader_role;

ALTER DEFAULT PRIVILEGES IN SCHEMA bl_cl 
GRANT EXECUTE ON FUNCTIONS TO data_loader_role;

GRANT data_loader_role TO current_user;

SET ROLE data_loader_role;

SELECT current_user;


--Create logging table
CREATE TABLE IF NOT EXISTS bl_cl.process_log (
    log_id SERIAL PRIMARY KEY,
    log_timestamp TIMESTAMP DEFAULT NOW(),
    procedure_name TEXT,
    rows_affected INT,
    message TEXT
);

--Procedure to log information about procedures
CREATE OR REPLACE PROCEDURE bl_cl.log_entry(
    p_procedure_name TEXT,
    p_rows_affected INT,
    p_message TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO bl_cl.process_log (procedure_name, rows_affected, message)
    VALUES (p_procedure_name, p_rows_affected, p_message);
END;
$$;