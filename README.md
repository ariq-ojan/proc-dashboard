# 📈 MRO Procurement BI Dashboard – Data Analytics Case Study

## 📌 Project Overview
This project showcases a full-cycle data analytics & BI workflow using past and present procurement data collected from an actual Maintenance, Repair, and Overhaul (MRO) company. The final result is an interactive Tableau dashboard to monitor general procurement performance metrics.

🚀 **Live Dashboard:** [View on Tableau Public](https://public.tableau.com/shared/CJC2P6X2K?:display_count=n&:origin=viz_share_link)

📊 **Tools Used:** 
- SQL (MySQL)
- Tableau Public
- Excel for general data preprocessing
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

## ⚠️ Limitations and Future Improvements

The dashboard was built as a lightweight decision-support tool specifically for the procurement team. It has very limited usability due to the data that was available to access. There are several areas where further improvements and integrations could expand its value:

**1. ⚙️ Integration with Engineering & Production Planning**

Currently, the dashboard focuses only on executed orders. If authorized, demands from the production and engineering team can also be collected straight from AMOS. This would provide visibility into active or upcoming demands, which would enable:
   -Real-time tracking of procurement coverage and fulfillment gaps
   -Identification of unfilfilled or overdue material requests
   -Demand trend analysis, allowing the procurement team to anticipate future needs based on seasonality or recurring patterns.
   
**2. 📊 Supplier Performance Tracking**

SPR (Supplier Performance Reviews) which includes supplier response rate, accuracy, consistency, QC, etc. are not included in this dashboard. Linking SPR data would allow the team to:
- Highlight top-performing or at-risk suppliers
- Identify suppliers with expired or obsolete performance reviews
- Flag newer or unauthorized suppliers for furher vetting.
  
**3. 💰 Finance Integration**

Finance was the greatest bottleneck in the procurement operations as both departments have a really hard time communicating and showing urgency. If invoices can be systematically recorded, and budget/target spending can be shared with our team, it would grant more visibility of:

- Outstanding payments
- Budget vs Actual spend
- Cost savings
- Incoming and paid invoices

**4. 🚚 Logistics & Procurement Cycle Tracking**

There is no current visibility into shipment movement or detailed procurement stage tracking. With more data from the logistics/supply chain team, future enhancements could include:

- Shipment status (in transit, at freight forwarder, customs clearance)
- Delivery terms and vendor lead time breakdowns
- A more granular view of procurement cycle stages: request, PO issuance, confirmation, shipment, GRN, invoicing, payment
  
**5. 📦 Warehouse Integration (Advanced)**

Integration with warehouse modules and inventory systems could unlock further insights like:
- Stock availability and reorder levels
- Purchase triggers based on historical demand
- Items failed in receiving inspection  

