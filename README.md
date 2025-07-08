# Real-Time ELT Pipeline using Snowflake, S3, Snowpipe & Power BI

![architecture](https://github.com/user-attachments/assets/38131cac-0e95-469b-a438-adf2ed554d43)


# 🚀 Why I Built This
As someone passionate about real-world data engineering, I wanted to go beyond toy datasets and build a fully automated ELT pipeline — something that could mirror what happens inside companies that need to move fast, scale easily, and extract insight from raw data in real time.

So I decided to simulate an end-to-end cloud-native data engineering pipeline — starting from raw CSV files in Amazon S3, all the way to dashboard-ready analytics in Power BI, with zero manual triggers.

# 🔁 What This Project Does
I designed and built a complete ELT system using:

🟤 Bronze Layer → Automatically ingest raw CSV data from S3 to Snowflake

⚪ Silver Layer → Clean and validate the raw data for business use

🟡 Gold Layer → Aggregate and model the clean data into KPIs and facts

📊 Power BI → Connects to Gold layer for real-time dashboards

All transformations, ingestion, and updates happen without manual intervention — thanks to Snowpipe, AWS SQS event triggers, and Snowflake Tasks.

# 🛠️ Tech Stack & Tools
Layer	Tools Used
Ingestion	AWS S3, SQS, Snowflake Snowpipe
Transformation	SQL, Snowflake Tasks, Stored Procedures
Modeling	Star Schema (Fact/Dim), Materialized Views
Orchestration	Snowflake Tasks + JavaScript Procedures
BI Layer	Power BI (DirectQuery / Auto-refresh)

# 🧱 Step-by-Step Breakdown
1️⃣ Real-Time Ingestion from S3 to Snowflake (Bronze)
I started with raw users.csv files in an S3 bucket.

I created a Storage Integration to securely connect Snowflake with AWS.

Then I set up Snowpipe with AUTO_INGEST = TRUE to auto-load files.

To make it truly real-time, I configured AWS SQS to trigger Snowpipe whenever a new file lands in S3.

⏱ Result: The moment a CSV is uploaded to S3, Snowflake ingests it into the bronze__users_tbl.

# 2️⃣ Clean, Validate & Enrich (Silver Layer)
In the Silver layer, I transformed the raw data:

Removed nulls and invalid rows

Standardized column types

Added metadata like ingestion_timestamp

These transformations are triggered by Snowflake Tasks on a schedule or after ingestion.

⏳ This ensures the Silver data is clean, trustworthy, and consistent — ready for analytics.

# 3️⃣ Dimensional Modeling & Aggregation (Gold Layer)
Here I applied Star Schema modeling with:

dim_customer, fact_orders, gold__monthly_metrics

I built Materialized Views for better Power BI performance.

KPIs like total revenue, orders by region, and monthly active users are calculated here.

📈 This Gold layer is what business teams and dashboards query.

# 4️⃣ Power BI Dashboards (BI Layer)
Power BI connects directly to the Gold tables and materialized views.

Dashboards are configured for auto-refresh to keep insights always up to date.

This layer supports:

Monthly revenue trend charts

Region-wise order volumes

User-level activity breakdown

# 🤖 Full Automation Flow
To automate the entire pipeline end-to-end:

✅ Used Snowflake Tasks to schedule Bronze → Silver → Gold transitions

✅ Chained tasks using AFTER to maintain the correct order

✅ Created a JavaScript Stored Procedure to execute the full pipeline manually or via scheduler

✅ Logged every step in a pipeline_log table with timestamps and row counts

