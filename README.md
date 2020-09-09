# CISIDB
Information regarding data stored in databases (on AWS)

**NIH GRANTS PROJECT**:

nih_grants schema for RePORTER project created entirely from the following:

master - contains drug/target information. Original file in: /Dropbox (ScienceandIndustry)/PROJECT-GrantSupportProject/FINAL - Master 12-11-17 with notes.xlsx

targetpmids/drugpmids - List of PMIDs associated with PubMed searches for the 210 drugs and 151 targets. Original files in /PROJECT-GrantSupportProject/Drug_pmids and /Target_pmids (manual download)

reporterpublink - links PubMed PMIDs and RePORTER Projects. Downloaded from https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=0&index=5

projects_final - Core project information including costs. Downloaded from https://exporter.nih.gov/ExPORTER_Catalog.aspx?sid=5&index=0

proj_year_nodups_imputed_costs contains the final 221,891 unique funding years with costs after year 2000; created by matching project fiscal year (from projects_final) with publication year (from reporterpublink). If FY does not match publication year, costs were "imputed" from last year of core projects. Exclusion criteria: publication predates grant or grant predates publication by more than 4 years. Remove imputed costs after 2015 and before 2000.

Current version: v2/First week of May, 2020

SQL Syntax is in NIH_dbvis_sql.sql

**IPO COMPANIES PROJECT (1997-2016)**:

ipo schema created entirely from the following:

daily_stocks - daily stock prices for all biotech and non-biotech companies downloaded from Compustat/Bloomberg. Original csv files in Dropbox (ScienceandIndustry)/PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/StockDataIPOsCSVs/WRDS files for DB and /2016 Data

ipovalwindow - contains IPO window and valuation information. Original file: PROJECT - Public Biotech/Project with Anne Schnader/Raw Data/ControlsBiotechListTickerValDate.csv [UPDATE: DO NOT USE file/table because valuations are a mix of NASDAQ and BCIQ data!]

ipofate + deletion key - current active status of all 935 companies, ipo window (adj_ipo_window), company_type (use this as reference!). Original files in /Test Run Files and ../Deletion_reason_KEY_Compustat.docx

*Company type in ipovalwindow and ipofate was updated from the original for Adeza, Aclara, Amyris, Cepheid, Genaissance, Versartis and Applied Genetic Tech.

ipogeobiotech - geographical information for biotechs only. Original files in /Test Run Files (FATEDETAIL1997to2016_updated_02-08-18)

gvc_naics + naics_key - completed NAICS codes. Original files in NAICS folder (based on NAICS_Codes.xlsx, completed by Kat). KFRED, CPAAU, CFCOU have made up gvc codes, because they are not in Compustat.

ipogeo_class - addresses, naics, sic, gvc codes, active status and all iterations of tickers. Original file in Raw Data/GVCKeys063017.xls, partially completed by Kat.

gvc_cisikey - links company number (created by Skyler) and Compustat's gvc key code.

biotechcontrolpairs - biotech companies paired with a single non-biotech control (original in PROJECT - Public Biotech\Project with Anne Schnader\Analyses\Paired comparisons\Controls_Pairings.xlsx FINAL LIST tab (also BiotechControlPairs_new.csv); pair closest in IPO date was determined using Match and Index Excel functions.

bloomberg_financials - financials downloaded from Bloomberg through the IPO -> GO function Originals in PROJECT - Public Biotech\Liam\IPO Bloomberg for database.csv and WORKING SPREADSHEET 10-18. 

compustat_financials - financials downloaded from Compustat through Fundamentals Annual (Jeremy, Spring 2018). Created from ipo_products.dummy_variable_indl_only (see info on that table below, under IPO Products). 

SQL Syntax is in IPO_sql.sql

**IPO Products**
This schema is created by the following tables:

Company List -319 biotech companies with raw data. No calculation or inflation adjustments. 
Company_list_v0 -319 biotech companies. the original data
Company_list_derived - 319 biotech companies with inflation adjusted numbers

Product List - 373 products for 204 companies

Dummy variable indl only - 5275 rows. This is the dataset after cleaning. It includes all the data Jeremy collected except those with FS industry format and ipo date before the data date. Original file is Dropbox (ScienceandIndustry)\PROJECT - Public Biotech\Sunyi\7_3_18 dummy variable  - FOR TRANSFER TO DATABASE under the tab "IPO date larger only INDL" (this sheet includes 5273 records but we added 2 more records for Omethera and Secure Work later. Details can be found in the google doc "Biotech IPO Project")												

Dummy variable pre cleaning - 8317 rows. Jeremy's original sheet but the column E,G,H are deleted. the IPO date for OncoMed and Kythera have been fixed. Original file is Dropbox (ScienceandIndustry)\PROJECT - Public Biotech\Sunyi\7_3_18 dummy variable  - FOR TRANSFER TO DATABASE under the tab "WRDS"

top_200_pharmaceuticals_by_sales_2016 - top 200 best selling drugs in 2016

