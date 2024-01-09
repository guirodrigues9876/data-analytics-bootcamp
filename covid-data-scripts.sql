Select *
From Portifolioproject..CovidDeaths$
order by 3,4

--Select *
--From Portifolioproject..CovidVaccinations$
--order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population
From Portifolioproject..CovidDeaths$
order by 1,2


-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Portifolioproject..CovidDeaths$
Where location like '%France%'
order by 1,2


-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid
Select Location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
From Portifolioproject..CovidDeaths$
Where location like '%France%'
order by 1,2

--Looking at countries with Highest Infection Rate compared to Population
Select Location, population, MAX(total_cases) as HihestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
From Portifolioproject..CovidDeaths$
--Where location like '%France%'
Group by Location, population
order by PercentagePopulationInfected desc

-- Showing Countries with Highest Death Count per Population
Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portifolioproject..CovidDeaths$
Where continent is not null
Group by Location, population
order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT


Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portifolioproject..CovidDeaths$
Where continent is null
Group by location
order by TotalDeathCount desc

-- Showing continents with the highest death count per population
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portifolioproject..CovidDeaths$
Where continent is null
Group by location
order by TotalDeathCount desc


-- Global numbers
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From Portifolioproject..CovidDeaths$
Where continent is not null
Group by date
order by 1,2


-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From Portifolioproject..CovidDeaths$ dea
Join Portifolioproject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 1,2,3


-- Creating View to store data for later visualizations

Create View GlobalNumbers as 
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From Portifolioproject..CovidDeaths$
Where continent is null
Group by location

SELECT * From GlobalNumbers