# 🌌 PlanetKart Analytics

**Modern Data Engineering Platform for Multi-Planetary E-commerce**

A complete analytics platform built with dbt and Snowflake, transforming raw e-commerce data into actionable business intelligence using industry best practices.

## 🎯 What This Project Demonstrates

- **Star Schema Design** with optimized fact and dimension tables
- **4-Layer Architecture** (Raw → Staging → Marts → Analysis) for data quality
- **25+ Automated Tests** ensuring reliability and business rule validation
- **Type 2 SCD** for historical change tracking
- **Production-Ready** with comprehensive documentation and testing

## 🏗️ Data Architecture

### Data Flow Pipeline
```
📥 Source Files → ❄️ Snowflake Raw → 🧹 Staging → 🎯 Marts → 📈 Analysis
     ↓              ↓                ↓           ↓         ↓
  CSV Files    PLANETKART_RAW    5 Views    Star Schema  4 Views
```

### Detailed Architecture
```
┌─ Raw Data Layer ─────────────────────────┐
│  📄 customers.csv    → 👥 customers      │
│  📄 orders.csv       → 📦 orders         │
│  📄 order_items.csv  → 🛒 order_items    │
│  📄 products.csv     → 📦 products       │
│  📄 regions.csv      → 🌍 regions        │
└─────────────────────────────────────────┘
                    ↓
┌─ Staging Layer (Views) ─────────────────┐
│  👥 stg_customers    (data cleaning)    │
│  📦 stg_orders       (standardization)  │
│  🛒 stg_order_items  (calculations)     │
│  📦 stg_products     (validation)       │
│  🌍 stg_regions      (formatting)       │
└─────────────────────────────────────────┘
                    ↓
┌─ Marts Layer (Tables) - Star Schema ────┐
│           📊 fact_orders                │
│              ↗    ↑    ↖               │
│  👥 dim_customers  📦 dim_products      │
│              ↘           ↙              │
│            🌍 dim_regions               │
└─────────────────────────────────────────┘
                    ↓
┌─ Analysis Layer (Views) ────────────────┐
│  📊 business_kpis     (executive KPIs)  │
│  👥 customer_insights (segmentation)    │
│  📦 product_insights  (profitability)   │
│  🌍 regional_insights (market analysis) │
└─────────────────────────────────────────┘

┌─ Snapshots (Type 2 SCD) ───────────────┐
│  📸 snap_customers (change tracking)    │
└─────────────────────────────────────────┘
```

## ⭐ Star Schema Design

```
                    📊 FACT_ORDERS
                   ┌─────────────────┐
                   │ • order_sk (PK) │
👥 DIM_CUSTOMERS   │ • customer_sk   │   📦 DIM_PRODUCTS
┌──────────────┐   │ • region_sk     │   ┌──────────────┐
│ customer_sk  │◄──┤ • order_revenue │──►│ product_sk   │
│ customer_name│   │ • order_profit  │   │ product_name │
│ revenue_seg  │   │ • total_quantity│   │ category     │
│ lifecycle    │   │ • profit_tier   │   │ profit_seg   │
│ churn_risk   │   │ • is_completed  │   │ sales_perf   │
└──────────────┘   └─────────────────┘   └──────────────┘
                           │
                           ▼
                   🌍 DIM_REGIONS
                   ┌──────────────┐
                   │ region_sk    │
                   │ planet       │
                   │ zone         │
                   │ market_cat   │
                   └──────────────┘
```

## 🚀 How to Run

### Prerequisites
- dbt with Snowflake connection configured
- Access to PLANETKART database

### Execute Project
```bash
# Build all models
dbt run

# Run by layer
dbt run --select staging          # Clean data (5 views)
dbt run --select marts            # Star schema (4 tables)
dbt run --select Advance_analysis # Business insights (4 views)

# Quality assurance
dbt test                          # 25+ automated tests
dbt snapshot                      # Historical tracking

# Documentation
dbt docs generate && dbt docs serve
```

## 📊 Business Value

**Customer Intelligence**: Revenue segmentation, lifecycle analysis, churn risk identification
**Product Analytics**: Profitability analysis, category performance, inventory optimization  
**Regional Strategy**: Multi-planetary market analysis for expansion planning
**Executive Reporting**: Real-time KPIs for strategic decision making

## 🔧 Key Design Decisions

**Star Schema**: Chosen for query performance and business user intuition  
**Materialization**: Views for staging/analysis (fresh data), tables for marts (performance)  
**Surrogate Keys**: Integer-based keys using `dbt_utils` for scalability  
**Testing**: Comprehensive validation covering uniqueness, business rules, and data freshness

## 📁 Project Structure

```
planetkart-analytics/
├── models/
│   ├── staging/              # Data cleaning (5 views)
│   │   ├── _sources.yml      # Source definitions & freshness tests
│   │   ├── stg_customers.sql # Customer data standardization
│   │   ├── stg_orders.sql    # Order data cleaning
│   │   ├── stg_order_items.sql # Line item calculations
│   │   ├── stg_products.sql  # Product catalog cleaning
│   │   └── stg_regions.sql   # Geographic standardization
│   ├── marts/                # Star schema (4 tables)
│   │   ├── schema.yml        # Model tests & documentation
│   │   ├── dim_customers.sql # Customer dimension with segmentation
│   │   ├── dim_products.sql  # Product dimension with profitability
│   │   ├── dim_regions.sql   # Regional dimension with categories
│   │   └── fact_orders.sql   # Central fact table with metrics
│   └── Advance_analysis/     # Business insights (4 views)
│       ├── customer_insights.sql # Customer segment analysis
│       ├── product_insights.sql  # Product performance metrics
│       ├── regional_insights.sql # Regional intelligence
│       └── business_kpis.sql     # Executive dashboard
├── snapshots/
│   └── snap_customers.sql    # Type 2 SCD for change tracking
├── macros/
│   └── get_custom_schema.sql # Schema naming logic
├── tests/                    # Custom data validations
├── dbt_project.yml          # Project configuration
├── packages.yml             # Dependencies (dbt_utils)
└── requirements.txt         # Python dependencies
```

🧪 Data Quality Framework
<img width="717" height="170" alt="image" src="https://github.com/user-attachments/assets/3e857b32-f29c-4559-89fd-58c093c44f52" />

🚀 Quick Start
Prerequisites
bash# Required tools
- Python 3.8+
- dbt-core with Snowflake adapter
- Snowflake account with ACCOUNTADMIN privileges
- VS Code (recommended)
Installation & Setup

Clone Repository

bashgit clone https://github.com/yourusername/planetkart-analytics.git
cd planetkart-analytics

Environment Setup

bash# Create virtual environment
python -m venv venv

# Activate environment
source venv/bin/activate  # Mac/Linux
# OR
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

Database Configuration

sql-- Execute in Snowflake Web UI
CREATE DATABASE PLANETKART;
CREATE SCHEMA PLANETKART.PLANETKART_RAW;

-- Upload CSV files to PLANETKART_RAW schema
-- Files: customers.csv, orders.csv, order_items.csv, products.csv, regions.csv

dbt Setup

bash# Install dbt packages
dbt deps

# Verify connection
dbt debug
# Should return: "All checks passed!"
Execution Commands
Build Complete Pipeline
bash# Build all models (recommended)
dbt run

# Build by layer
dbt run --select staging          # 5 staging views
dbt run --select marts            # 4 star schema tables  
dbt run --select Advance_analysis # 4 business insight views
Quality Assurance
bash# Run all data quality tests
dbt test

# Create historical snapshots
dbt snapshot

# Generate documentation
dbt docs generate && dbt docs serve

## 📈 Sample Analytics

**Customer Segmentation**:
- High Value: $150+ revenue (Premium retention focus)
- Medium Value: $80-149 (Growth opportunities)  
- Low Value: $1-79 (Activation campaigns)

**Product Performance**:
- Galactic Blender: $205 revenue, 61% profit margin
- Solar Charger: $89 revenue, 28% profit margin
- Categories ranked by profitability for inventory decisions

**Regional Analysis**:
- Earth (Home Base): 60% of revenue
- Mars (Expansion): 25% of revenue, highest growth
- Venus (Territory): 15% of revenue, emerging market

## 🧪 Data Quality

- **25+ Automated Tests**: Uniqueness, referential integrity, business rules
- **Source Freshness**: Monitoring data recency with configurable alerts
- **Type 2 SCD**: Historical tracking of customer profile changes
- **Custom Validations**: Revenue calculations and profit logic verification

## 🎯 Project Metrics

- **17 Models**: 5 staging + 4 marts + 4 analysis + 4 snapshots
- **5 Schemas**: Organized data flow across Raw → Stage → Analytics → Snapshots
- **100% Test Coverage**: All critical business logic validated
- **Star Schema**: 1 fact table + 3 dimension tables optimized for analytics

---

**Tech Stack**: dbt • Snowflake • SQL • Python • Git  
**Contact**: [LinkedIn](https://linkedin.com/in/sudhanshu-sharan) | [Email](mailto:s.sharan5454@gmail.com)
