
-- Query 1: Overall Campaign KPIs
SELECT
    COUNT(DISTINCT channel)                              AS total_channels,
    COUNT(DISTINCT campaign)                             AS total_campaigns,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS overall_roas,
    SUM(conversions)                                     AS total_conversions,
    SUM(clicks)                                          AS total_clicks,
    SUM(impressions)                                     AS total_impressions
FROM campaign_data;

-- Query 2: ROAS by Channel
SELECT
    channel,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas,
    CAST((SUM(revenue)-SUM(spend))/SUM(spend)*100
        AS DECIMAL(10,2))                                AS roi_pct,
    SUM(conversions)                                     AS total_conversions,
    CAST(SUM(spend)/SUM(conversions) AS DECIMAL(10,2))   AS cac
FROM campaign_data
GROUP BY channel
ORDER BY roas DESC;

-- Query 3: Best Performing Campaigns
SELECT
    campaign,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas,
    SUM(conversions)                                     AS total_conversions
FROM campaign_data
GROUP BY campaign
ORDER BY roas DESC;

-- Query 4: Channel + Campaign Matrix
SELECT
    channel,
    campaign,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas
FROM campaign_data
GROUP BY channel, campaign
ORDER BY roas DESC;

-- Query 5: Regional Performance
SELECT
    region,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas,
    SUM(conversions)                                     AS total_conversions
FROM campaign_data
GROUP BY region
ORDER BY total_revenue DESC;

-- Query 6: Monthly Trend with Cumulative Revenue
SELECT
    YEAR(date)                                           AS yr,
    MONTH(date)                                          AS mon,
    SUM(spend)                                           AS monthly_spend,
    SUM(revenue)                                         AS monthly_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS monthly_roas,
    SUM(SUM(revenue)) OVER
        (ORDER BY YEAR(date), MONTH(date))               AS cumulative_revenue
FROM campaign_data
GROUP BY YEAR(date), MONTH(date)
ORDER BY yr, mon;

-- Query 7: Top 5 Best ROI Channel-Campaign Combinations
SELECT TOP 5
    channel,
    campaign,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas,
    CAST((SUM(revenue)-SUM(spend))/SUM(spend)*100
        AS DECIMAL(10,2))                                AS roi_pct,
    RANK() OVER
        (ORDER BY SUM(revenue)/SUM(spend) DESC)          AS roas_rank
FROM campaign_data
GROUP BY channel, campaign
ORDER BY roas DESC;

-- Query 8: Underperforming Channels (ROAS below 1)
SELECT
    channel,
    campaign,
    SUM(spend)                                           AS total_spend,
    SUM(revenue)                                         AS total_revenue,
    CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2))       AS roas,
    SUM(spend) - SUM(revenue)                            AS money_lost
FROM campaign_data
GROUP BY channel, campaign
HAVING CAST(SUM(revenue)/SUM(spend) AS DECIMAL(10,2)) < 1
ORDER BY money_lost DESC;