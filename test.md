# 🌌 PlanetKart Analytics

**End-to-End Data Engineering Platform for Multi-Planetary E-commerce**

A complete analytics platform built with dbt and Snowflake that transforms raw e-commerce data into actionable business intelligence using modern data engineering best practices.

## 🎯 What This Project Demonstrates

- **Star Schema Design** with fact and dimension tables optimized for analytics
- **4-Layer Architecture** (Raw → Staging → Marts → Analysis) with clear separation of concerns
- **25+ Automated Tests** ensuring data quality and business rule validation
- **Type 2 SCD** for historical change tracking
- **Self-Service Analytics** with executive-ready business intelligence

## 🏗️ Architecture Overview

```
Raw Data (Excel/CSV) → Snowflake Raw → dbt Staging → dbt Marts → dbt Analysis
     ↓                    ↓              ↓            ↓           ↓
Source Files         Unmodified      Clean Data   Star Schema  Business Intelligence
```

### Star Schema Design
- **Central Fact**: `fact_orders` (order transactions with revenue/profit metrics)
- **Dimensions**: `dim_customers` (segmentation), `dim_products` (profitability), `dim_regions` (geographic)
- **Analysis**: Customer insights, product performance, regional intelligence, executive KPIs

## 🚀 How to Run and Test the Project

### Prerequisites
- dbt installed with Snowflake connection configured
- Access to PLANETKART database in Snowflake

### Execution Commands
```bash
# Build all models in dependency order
dbt run

# Run specific layers
dbt run --select staging        # Clean and standardize data
dbt run --select marts          # Build star schema
dbt run --select Advance_analysis  # Generate business insights

# Data quality validation
dbt test                        # Run all 25+ automated tests
dbt test --select dim_customers # Test specific model

# Historical change tracking
dbt snapshot                    # Capture customer profile changes

# Documentation and lineage
dbt docs generate              # Generate project documentation
dbt docs serve                # Serve interactive docs locally

# Source data freshness monitoring
dbt source freshness           # Check data recency
```

## 🎯 Business Intelligence Delivered

### Customer Intelligence
- **Revenue Segmentation**: High/Medium/Low value classification for targeted marketing
- **Lifecycle Analysis**: Loyal/Repeat/One-time buyer identification for retention strategies
- **Churn Risk Assessment**: Active/At-Risk/Churned status for proactive customer management

### Product Performance
- **Profitability Analysis**: Product-level profit margins driving inventory optimization
- **Sales Classification**: Best/Good/Slow seller categorization for marketing focus
- **Category Intelligence**: Category-level performance metrics for strategic planning

### Regional Strategy
- **Market Categorization**: Home Base/Expansion Territory/Frontier classification
- **Performance Analytics**: Revenue and profit analysis by planetary regions
- **Expansion Intelligence**: Data-driven market entry decision support

## 🔧 Key Design Decisions

### Star Schema Architecture
**Decision**: Implemented star schema with central fact table surrounded by dimension tables  
**Rationale**: Optimizes analytical query performance and provides intuitive business logic structure  
**Impact**: Fast aggregations, simple joins, and BI tool compatibility

### Materialization Strategy
**Decision**: Views for staging/analysis layers, tables for marts layer  
**Rationale**: Balance between data freshness and query performance  
**Impact**: Always current staging data with fast mart queries for business users

### Surrogate Key Implementation
**Decision**: Integer-based surrogate keys using `dbt_utils.generate_surrogate_key()`  
**Rationale**: Superior join performance and source system independence  
**Impact**: Faster queries and flexibility for future source system changes

### Four-Layer Architecture
**Decision**: Raw → Staging → Marts → Analysis progression  
**Rationale**: Clear separation of concerns with progressive data refinement  
**Impact**: Maintainable codebase, scalable architecture, and reliable data quality

### Comprehensive Testing Framework
**Decision**: 25+ automated tests covering uniqueness, referential integrity, and business rules  
**Rationale**: Ensure data reliability and catch issues before they impact business decisions  
**Impact**: High data confidence and proactive quality monitoring

## 📁 Complete Project Structure

```
planetkart-analytics/
│
├── 📁 models/                          # Main dbt transformation models
│   ├── 📁 staging/                     # Data cleaning and standardization layer
│   │   ├── 📄 _sources.yml            # Source definitions with freshness tests
│   │   ├── 📄 stg_customers.sql       # Clean customer profiles and tenure analysis
│   │   ├── 📄 stg_orders.sql          # Standardize order status and dates
│   │   ├── 📄 stg_order_items.sql     # Calculate line totals and validate pricing
│   │   ├── 📄 stg_products.sql        # Standardize product catalog and cost validation
│   │   └── 📄 stg_regions.sql         # Clean geographic and planetary data
│   │
│   ├── 📁 marts/                       # Business logic and dimensional modeling
│   │   ├── 📄 schema.yml              # Model documentation and 25+ data tests
│   │   ├── 📄 dim_customers.sql       # Customer intelligence with segmentation
│   │   ├── 📄 dim_products.sql        # Product performance and profitability
│   │   ├── 📄 dim_regions.sql         # Geographic market categorization
│   │   └── 📄 fact_orders.sql         # Central fact table with order metrics
│   │
│   └── 📁 Advance_analysis/            # Executive insights and self-service analytics
│       ├── 📄 customer_insights.sql   # Customer segment performance analysis
│       ├── 📄 product_insights.sql    # Category profitability and optimization
│       ├── 📄 regional_insights.sql   # Multi-planetary market intelligence
│       └── 📄 business_kpis.sql       # Executive dashboard metrics
│
├── 📁 snapshots/                       # Historical change tracking (Type 2 SCD)
│   └── 📄 snap_customers.sql          # Customer profile change history
│
├── 📁 macros/                          # Reusable SQL functions (DRY principle)
│   └── 📄 get_custom_schema.sql       # Custom schema naming logic
│
├── 📁 tests/                           # Custom data quality validations
│   └── 📄 [custom_tests].sql          # Business rule validations
│
├── 📁 target/                          # Compiled SQL output (auto-generated)
│   ├── 📁 compiled/                    # Compiled model SQL
│   ├── 📁 run/                         # Executed model SQL
│   └── 📄 manifest.json               # Project metadata and lineage
│
├── 📁 dbt_packages/                    # External package dependencies
│   └── 📁 dbt_utils/                   # Utilities for surrogate keys and testing
│
├── 📁 logs/                            # Execution logs and debugging information
├── 📁 docs/                            # Project documentation assets
├── 📁 screenshots/                     # Visual project demonstrations
│
├── ⚙️ Configuration Files
├── 📄 dbt_project.yml                  # Main project configuration and materializations
├── 📄 packages.yml                     # Package dependencies (dbt_utils)
├── 📄 package-lock.yml                 # Locked package versions for consistency
└── 📄 requirements.txt                 # Python package dependencies
```

## 📸 Screenshots

| Component | Description |
|-----------|-------------|
| ![Snowflake](screenshots/snowflake_schemas.png) | Clean database structure with 5 schemas |
| ![dbt Lineage](screenshots/dbt_lineage.png) | Model dependencies and data flow |
| ![Tests](screenshots/dbt_tests.png) | 25+ automated data quality tests |
| ![Insights](screenshots/customer_insights.png) | Executive business intelligence |

## 🎯 Project Metrics

- **17 Total Models**: 5 staging + 4 marts + 4 analysis + 4 snapshots
- **25+ Automated Tests**: Comprehensive data quality framework
- **5 Database Schemas**: Organized data architecture
- **3-Dimensional Star Schema**: Optimized for analytics workloads

---

**Tech Stack**: dbt • Snowflake • Python • Git • VS Code  
**Contact**: [Your LinkedIn](https://linkedin.com/in/yourprofile) | [Your Email](mailto:your.email@example.com)
