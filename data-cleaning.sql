-- Standardize Date Format

Select SaleDateConverted, CONVERT(Date, SaleDate)
From Portifolioproject.dbo.NashvilleHousing$

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing$
Add SaleDateConverted Date;


Update NashvilleHousing$
SET SaleDateConverted = CONVERT(Date,SaleDate)


-- Populate Property Adress data

Select *
From Portifolioproject.dbo.NashvilleHousing$
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From Portifolioproject.dbo.NashvilleHousing$ a
JOIN Portifolioproject.dbo.NashvilleHousing$ b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From Portifolioproject.dbo.NashvilleHousing$ a
JOIN Portifolioproject.dbo.NashvilleHousing$ b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress is null


-- Breaking out Address into Individual Columns (Address, city, State)

Select PropertyAddress
From Portifolioproject.dbo.NashvilleHousing$

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',' , PropertyAddress) + 1, LEN(PropertyAddress)) as Address
From Portifolioproject.dbo.NashvilleHousing$

