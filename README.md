
<artifacts>
<artifact identifier="clean_readme" type="text/markdown" title="Clean PlanetKart Analytics README">

# 🌌 PlanetKart Analytics
Modern Data Engineering Platform for Multi-Planetary E-commerce
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

## 🚀 How to Run and Test the Project

### Prerequisites
```bash
# Required tools
- Python 3.8+
- dbt-core with Snowflake adapter
- Snowflake account with ACCOUNTADMIN privileges
- VS Code (recommended)
```

### Step 1: Environment Setup
```bash
# Clone the repository
git clone https://github.com/yourusername/planetkart-analytics.git
cd planetkart-analytics

# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
```

### Step 2: dbt Configuration
```bash
# Install dbt packages
dbt deps

# Test connection to Snowflake
dbt debug
```
*Should show "All checks passed!" if connection is successful*

### Step 3: Build the Complete Pipeline
```bash
# Build all models in correct order
dbt run

# Expected output: 13 models built successfully
# - 5 staging views
# - 4 marts tables  
# - 4 analysis views
```

### Step 4: Create Type 2 SCD Snapshot
```bash
# Create customer snapshot for change tracking
dbt snapshot

# Verify snapshot created
dbt ls -s snapshots
```

### Step 5: Run Data Quality Tests
```bash
# Execute all 25+ data quality tests
dbt test

# Expected: All tests should pass
# Tests cover: unique keys, not null values, accepted values, relationships
```

### Step 6: Generate Documentation
```bash
# Generate project documentation with lineage
dbt docs generate

# Serve documentation locally (optional)
dbt docs serve
# Opens at http://localhost:8080
```

### Execute Project Commands
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

## 🧪 Data Quality Framework

| Test Category | Count | Purpose |
|---------------|-------|---------|
| **Uniqueness** | 8 tests | Ensure primary key integrity |
| **Not Null** | 10 tests | Validate required fields |
| **Relationships** | 4 tests | Check referential integrity |
| **Accepted Values** | 3 tests | Validate business rules |
| **Custom Logic** | 2 tests | Revenue/profit calculations |

### Data Quality Features
- **25+ Automated Tests**: Uniqueness, referential integrity, business rules
- **Source Freshness**: Monitoring data recency with configurable alerts
- **Type 2 SCD**: Historical tracking of customer profile changes
- **Custom Validations**: Revenue calculations and profit logic verification

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

## Screenshots 

**Dbt DAG Ref** : 

<img width="1346" height="804" alt="image" src="https://github.com/user-attachments/assets/b5ee1f32-218c-479b-9250-7b4d33644766" />

**Airbyte Initial Setup** : 

<img width="512" height="320" alt="Airbyte Initial setup " src="https://github.com/user-attachments/assets/ecff848a-9f07-40ac-9f01-2dfae54e9b29" />

**Airbyte Data Moving**:

<img width="512" height="320" alt="image" src="https://github.com/user-attachments/assets/c9379ed5-81ea-446b-9092-85ddc2f4ec4a" />

**Snowflake Data**:

<img width="2044" height="1184" alt="image" src="https://github.com/user-attachments/assets/045e37fe-6161-445f-8240-bd3d8eddf39a" />

<img width="1094" height="733" alt="image" src="https://github.com/user-attachments/assets/701dc7a7-4882-4f05-acf9-76c4cf78d370" />

**Dashobard In Progress**: 

<img width="727" height="599" alt="Screenshot 2025-07-21 at 11 01 29 PM" src="https://github.com/user-attachments/assets/e62ca056-100e-4daa-8ae8-ef895d6f2ccc" />


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

## 🎯 Project Metrics

- **17 Models**: 5 staging + 4 marts + 4 analysis + 4 snapshots
- **5 Schemas**: Organized data flow across Raw → Stage → Analytics → Snapshots
- **100% Test Coverage**: All critical business logic validated
- **Star Schema**: 1 fact table + 3 dimension tables optimized for analytics

---

**Tech Stack**: dbt • Snowflake • SQL • Python • Git  
**Contact**: [LinkedIn](https://linkedin.com/in/sudhanshu-sharan) | [Email](mailto:s.sharan5454@gmail.com)
</artifact>
</artifacts>
