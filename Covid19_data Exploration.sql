SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--Select data to work with

SELECT continent,location,date,total_cases,new_cases,total_deaths,population
FROM CovidDeaths
ORDER BY 1,2

--probability of dying from covid after contraction
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 DeathPercent
FROM CovidDeaths
--WHERE location ='Ghana'
ORDER BY 1, 2

---percentage of population to contract covid
SELECT location,date,total_cases,population,(total_cases/population)*100 CasePercent
FROM CovidDeaths
--WHERE location = 'Ghana'
ORDER BY 1, 2

--Highest infection rate countries vs population
SELECT location,population,MAX(total_cases) HighestCaseCount,(MAX(total_cases)/population)*100 InfectedPopulationPercent
FROM CovidDeaths
--WHERE location = 'Ghana'
WHERE continent IS NOT NULL
GROUP BY location,population
ORDER BY 4 DESC

--Highest death count countries vs population
SELECT location,MAX(CAST(total_deaths as int)) DeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
--WHERE location = 'Ghana'
GROUP BY location
ORDER BY 2 DESC



--Breakdown By Continent
--Continent with highest death count
SELECT continent,MAX(CAST(total_deaths as int)) DeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
--WHERE location = 'Ghana'
GROUP BY continent
ORDER BY 2 DESC

--global
SELECT SUM(new_cases) TotalCases,SUM(CAST(new_deaths as int)) TotalDeaths,
SUM(CAST(new_deaths as int))/SUM(new_cases)*100 DeathPercent
FROM CovidDeaths
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2 DESC


--Total Population vs Vaccination
--CTE
WITH PopulationVac(continent,location,date,population,new_vaccinations,CummulativeVaccination)
AS(
SELECT D.continent,D.location,D.date,D.population,V.new_vaccinations,
SUM(CAST(V.new_vaccinations as int))OVER(PARTITION BY D.location ORDER BY D.LOCATION) CummulativeVaccination
FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.location=V.location AND D.date=V.date
WHERE D.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *,(CummulativeVaccination/population)*100 VaccinationPercent
FROM PopulationVac

--Temp table
DROP IF EXISTS #PopulationVaccinated
CREATE TABLE #PopulationVaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
CummulativeVaccination numeric
)

INSERT INTO #PopulationVaccinated
SELECT D.continent,D.location,D.date,D.population,V.new_vaccinations,
SUM(CAST(V.new_vaccinations as int))OVER(PARTITION BY D.location ORDER BY D.LOCATION) CummulativeVaccination
FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.location=V.location AND D.date=V.date
WHERE D.continent IS NOT NULL

SELECT *,(CummulativeVaccination/population)*100 VaccinationPercent
FROM #PopulationVaccinated
ORDER BY continent

---Views
CREATE VIEW PopulationVaccinated AS
SELECT D.continent,D.location,D.date,D.population,V.new_vaccinations,
SUM(CAST(V.new_vaccinations as int))OVER(PARTITION BY D.location ORDER BY D.LOCATION) CummulativeVaccination
FROM CovidDeaths D
JOIN CovidVaccinations V
ON D.location=V.location AND D.date=V.date
WHERE D.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PopulationVaccinated




