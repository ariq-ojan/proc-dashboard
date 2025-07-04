# 📈 MRO Procurement BI Dashboard – Data Analytics Case Study

## 📌 Project Overview
This project showcases a full-cycle data analytics & BI workflow using past and present procurement data collected from an actual Maintenance, Repair, and Overhaul (MRO) company. The final result is an interactive Tableau dashboard to monitor general procurement performance metrics.

🚀 **Live Dashboard:** [View on Tableau Public](https://public.tableau.com/shared/CJC2P6X2K?:display_count=n&:origin=viz_share_link)

📊 **Tools Used:** 
- SQL (MySQL)
- Tableau Public
- GitHub for documentation

## 🧠 Business Context
A more bare-bones version of this dashboard was originally developed by myself as a procurement project manager for a biweekly stakeholder meeting. It began as a side project to streamline discussions by enabling quick, interactive access to project-specific, supplier-specific, and time-based data—ultimately cutting meeting times in half by allowing decision-makers to grasp key insights at a glance.

Data was manually collected by the end of each week then put into a SQL database before updating them to the live dashboard.

This dashboard was designed as a practical tool for the procurement team, using data that could be consistently collected on a daily basis. As such, the dashboard focuses on metrics and insights most relevant to procurement operations and frequently requested by top management. It intentionally excludes common procurement metrics such as supplier ratings, invoice/payment tracking, demand forecasting, and cost savings—these will be discussed further in the next section.

## 📂 Data Overview

Data was manually collected weekly from the Maintenance/ERP Software used, AMOS. Data was split into three main tables:

- `suppliers`: supplier_id, supplier_name, supplier_location
- `orders`: order_no, order_type, supplier_id, order_state, date_issued, author
- `items`: item_no, part_no, qty, price, status, material_type

**⚠️ For this project, all personal data has been replaced with placeholders for privacy**

## 🔧 Process Overview

1. **Data Cleaning**: Cleaned and standardized order records, dates, and categories.
2. **SQL Database**: Built relational schema in MySQL to simulate real-world querying.
3. **Exploration & Querying**: Ran SQL queries to extract KPIs, supplier trends, and procurement performance.
4. **Dashboard Design and Development**: Created Procurement and Supplier dashboard.
   - Spending trends by project/year
   - Procurement/Supplier KPIs (Avg. procurement cycle, total spending, etc)
   - Supplier usage & cost contribution
   - Item-level analysis by material and priority

## 📁 Repository Content

| Folder/File     | Description                                  |
|-----------------|----------------------------------------------|
| `data/`         | Sample anonymized CSVs                       |
| `sql/`          | Table schema + example SQL queries           |
| `screenshots/`  | Visuals from the Tableau dashboard           |
| `README.md`     | Project documentation (you're reading it)    |
  

