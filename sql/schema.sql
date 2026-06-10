-- =============================================
-- Marketing Campaign ROI Analysis
-- Database Schema
-- =============================================

USE master;
GO

CREATE DATABASE MarketingDB;
GO

USE MarketingDB;
GO

-- =============================================
-- Table: campaign_data
-- Description: Marketing campaign performance
-- data pulled from REST API using Python Flask.
-- Contains daily metrics for 6 channels and
-- 5 campaign types across 5 regions of India.
-- Date range: Jan 2024 to Mar 2024 (90 days)
-- Total rows: 2,700
-- =============================================
CREATE TABLE campaign_data (
    campaign            VARCHAR(50),
    channel             VARCHAR(50),
    clicks              INT,
    conversion_rate     DECIMAL(5,2),
    conversions         INT,
    ctr                 DECIMAL(5,2),
    date                DATE,
    impressions         INT,
    region              VARCHAR(50),
    revenue             DECIMAL(15,2),
    roas                DECIMAL(10,2),
    spend               DECIMAL(15,2)
);
GO

-- =============================================
-- Indexes for query performance
-- =============================================
CREATE INDEX idx_channel  ON campaign_data(channel);
CREATE INDEX idx_campaign ON campaign_data(campaign);
CREATE INDEX idx_date     ON campaign_data(date);
CREATE INDEX idx_region   ON campaign_data(region);
GO

-- =============================================
-- How data was loaded:
-- 1. Flask API server built in Python (api_server.py)
-- 2. API called using requests library
-- 3. JSON response parsed to pandas DataFrame
-- 4. DataFrame loaded to SQL Server via SQLAlchemy
-- =============================================