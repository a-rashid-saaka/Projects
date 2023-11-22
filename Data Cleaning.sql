SELECT *
FROM NashvilleHousing

-- Change date format
SELECT SalesDate,CAST(SaleDate AS Date) 
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD SalesDate Date

UPDATE NashvilleHousing
SET SalesDate = CAST(SaleDate AS Date)

--Property adress
SELECT *
FROM NashvilleHousing
WHERE PropertyAddress IS NULL


SELECT T1.ParcelID,T1.PropertyAddress,T2.ParcelID,T2.PropertyAddress,ISNULL(T1.PropertyAddress,T2.PropertyAddress)
FROM NashvilleHousing T1
JOIN NashvilleHousing T2
ON T1.ParcelID=T2.ParcelID 
AND T1.[UniqueID ] <> T2.[UniqueID ]
WHERE T1.PropertyAddress IS NULL

UPDATE T1
SET PropertyAddress = ISNULL(T1.PropertyAddress,T2.PropertyAddress)
FROM NashvilleHousing T1
JOIN NashvilleHousing T2
ON T1.ParcelID=T2.ParcelID 
AND T1.[UniqueID ] <> T2.[UniqueID ]
WHERE T1.PropertyAddress IS NULL

--Splitting address
SELECT PropertyAddress
FROM NashvilleHousing

SELECT SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1),
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1,LEN(PropertyAddress))
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertyAddress1 nvarchar(225)
UPDATE NashvilleHousing
SET PropertyAddress1 = SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertyCity nvarchar(225)
UPDATE NashvilleHousing
SET PropertyCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress))


---Splittig Owner Address
SELECT OwnerAddress
FROM PortfolioProject.dbo.NashvilleHousing

SELECT PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerAddress1 nvarchar(225)
UPDATE NashvilleHousing
SET OwnerAddress1 = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerAddressCity nvarchar(225)
UPDATE NashvilleHousing
SET OwnerAddressCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerAddressState nvarchar(225)
UPDATE NashvilleHousing
SET OwnerAddressState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)



---Replace Y and N with Yes and No in SoldAsVacant Column
SELECT SoldAsVacant,
CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'Yes' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE 'No'
END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
WHEN SoldAsVacant = 'Y' THEN 'Yes'
WHEN SoldAsVacant = 'Yes' THEN 'Yes'
WHEN SoldAsVacant = 'N' THEN 'No'
ELSE 'No'
END
FROM NashvilleHousing

SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

--Removing duplicates
WITH RowNum  AS(
SELECT *,
   ROW_NUMBER() OVER(
   PARTITION BY ParcelID,
                PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY UniqueID) rownum
FROM NashvilleHousing)
SELECT *
FROM RowNum
WHERE rownum > 1
ORDER BY PropertyAddress

--Deleting unused columns
ALTER TABLE NashvilleHousing
DROP COLUMN PropertyAddress,SaleDate,OwnerAddress
