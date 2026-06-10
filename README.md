# Marketing Campaign ROI Analysis

## Problem Statement
Analyzed 2,700 marketing campaign records across 6 channels and 5 campaigns
to identify highest ROI channels and optimize budget allocation.

## Tech Stack
- Python Flask — custom REST API
- Python requests + pandas — API integration
- SQL Server — data storage and queries
- Excel — A/B test analysis
- Power BI — 3-page dashboard

## Key Results
- Total Spend: ₹14.11M
- Total Revenue: ₹253.15M
- Overall ROAS: 17.95
- Best Channel: Email — ROAS 19.03
- Best Campaign: Summer Sale — ROAS 19.27
- A/B Test Winner: Email Personalised — 24% uplift

## How to Run
1. Start API server: python api_server.py
2. Open notebooks/01_marketing_analysis.ipynb
3. Run all cells — data loads automatically from API

## Project Structure
- api_server.py — Flask REST API
- notebooks/ — Python analysis notebook
- sql/ — schema and 8 business queries
- excel/ — A/B test calculator
- powerbi/ — dashboard file
- screenshots/ — all dashboard pages
  
