from flask import Flask, jsonify, request
import random
from datetime import datetime, timedelta

app = Flask(__name__)

CHANNELS = ['Google Ads', 'Facebook Ads', 'Email', 'Instagram', 'YouTube', 'SEO']
CAMPAIGNS = ['Summer Sale', 'New Launch', 'Retargeting', 'Brand Awareness', 'Festive Offer']
REGIONS = ['North India', 'South India', 'West India', 'East India', 'Central India']

def generate_campaign_data(days=90):
    data = []
    start_date = datetime(2024, 1, 1)
    random.seed(42)
    for day in range(days):
        current_date = start_date + timedelta(days=day)
        for channel in CHANNELS:
            for campaign in CAMPAIGNS:
                impressions = random.randint(1000, 50000)
                ctr = random.uniform(0.01, 0.08)
                clicks = int(impressions * ctr)
                conversion_rate = random.uniform(0.01, 0.05)
                conversions = int(clicks * conversion_rate)
                spend = round(random.uniform(500, 10000), 2)
                revenue = round(conversions * random.uniform(500, 5000), 2)
                data.append({
                    'date': current_date.strftime('%Y-%m-%d'),
                    'channel': channel,
                    'campaign': campaign,
                    'region': random.choice(REGIONS),
                    'impressions': impressions,
                    'clicks': clicks,
                    'conversions': conversions,
                    'spend': spend,
                    'revenue': revenue,
                    'ctr': round(ctr * 100, 2),
                    'conversion_rate': round(conversion_rate * 100, 2),
                    'roas': round(revenue / spend, 2) if spend > 0 else 0
                })
    return data

@app.route('/api/campaigns', methods=['GET'])
def get_campaigns():
    days = request.args.get('days', 90, type=int)
    channel = request.args.get('channel', None)
    data = generate_campaign_data(days)
    if channel:
        data = [d for d in data if d['channel'] == channel]
    return jsonify({'status': 'success', 'total_records': len(data), 'data': data})

@app.route('/api/summary', methods=['GET'])
def get_summary():
    data = generate_campaign_data(90)
    summary = {}
    for record in data:
        ch = record['channel']
        if ch not in summary:
            summary[ch] = {'spend': 0, 'revenue': 0, 'conversions': 0, 'clicks': 0}
        summary[ch]['spend'] += record['spend']
        summary[ch]['revenue'] += record['revenue']
        summary[ch]['conversions'] += record['conversions']
        summary[ch]['clicks'] += record['clicks']
    for ch in summary:
        summary[ch]['roas'] = round(summary[ch]['revenue'] / summary[ch]['spend'], 2)
        summary[ch]['cac'] = round(summary[ch]['spend'] / summary[ch]['conversions'], 2) if summary[ch]['conversions'] > 0 else 0
    return jsonify({'status': 'success', 'summary': summary})

if __name__ == '__main__':
    app.run(debug=True, port=5000)