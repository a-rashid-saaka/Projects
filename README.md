## Covid19 Data Exploration and Data Cleaning Of Housing Data

### Covid19 Data Exploration
**Data Source**

- The datasets used for this exploration analysis is obtained from  [Here](https://github.com/AlexTheAnalyst/PortfolioProjects)
- Two tables are used for this analysis, namely CovidDeaths,CovidVaccinations
- The tables are imported as excel files into Microsoft SQL Server Management Studio for analysis

  **Analysis**
  
  From CovidDeaths table,I looked at:
  - Probability of dying from Covid
  - Percentage of population to contract Covid
  - Countries with high number of infections against population
  - Countries with high number of deaths against population
  - Continents with high death counts
  - Total death count
 
    From CovidVaccinations table,
   - Vaccinations against total population




 ### Data Cleaning of Housing Data   
 **Data Source**

  - The dataset used for this project is obtained from [Here](https://github.com/AlexTheAnalyst/PortfolioProjects)
  - The table named Nashville Housing Data for Data Cleaning was used for this project
  - The dataset is imported as an excel file into Microsoft SQL Server Management Studio to carrying out data cleaning

    **Data cleaning tasks**
    - Change of date format from Datetime to Date
    - Populate PropertyAddress where PropertyAddress is null
    - Split PropertyAddress into PropertyAddress1 and PropertyCity
    - Split OwnerAddress into OwnerAddress1,OwnerAddressCity and OwnerAddressState
    - Replace "Y" and "N" with "Yes" and "No" in SoldAsVacant column
    - Duplicates removal
    - Deletion of unused columns
