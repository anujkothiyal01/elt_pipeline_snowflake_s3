-- Use Target Database
USE DATABASE DEMO_DB;

-- Create Target Table
CREATE OR REPLACE TABLE users_tbl (
    user_id INTEGER,
    user_name STRING,
    age INTEGER
);

-- Create File Format
CREATE OR REPLACE FILE FORMAT csv_format
TYPE = 'CSV'
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"';

-- Create Snowflake Storage Integration with AWS S3 - IAM role
CREATE OR REPLACE STORAGE INTEGRATION s3_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::478024548952:role/snowflake-storage-role'
STORAGE_ALLOWED_LOCATIONS = ('s3://demo-db-bucket01/orders/');

DESC INTEGRATION s3_integration;

-- External Stage pointing to S3 Location
CREATE OR REPLACE STAGE s3_stage
URL = 's3://demo-db-bucket01/orders/'
STORAGE_INTEGRATION = s3_integration
FILE_FORMAT = csv_format;

-- Snowpipe to Automate Ingestion from S3 to Snowflake
CREATE OR REPLACE PIPE load_customer_orders
AUTO_INGEST = TRUE
AS
COPY INTO users_tbl
FROM @s3_stage
FILE_FORMAT = (FORMAT_NAME = csv_format)
ON_ERROR = 'CONTINUE';

-- Confirming Config.
DESC PIPE load_customer_orders;

-- Verifying Ingested Data
SELECT * FROM users_tbl;