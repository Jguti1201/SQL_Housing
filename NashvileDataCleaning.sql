SELECT * FROM project_nashville.`nashville housing data for data cleaning`;
#Standarize Date Format
UPDATE project_nashville.`nashville housing data for data cleaning` SET SaleDate = STR_TO_DATE(SaleDate, '%M %d, %Y');
ALTER TABLE project_nashville.`nashville housing data for data cleaning` MODIFY COLUMN SaleDate DATE;

#Populate Property Adress Data ( There were some null adress, if there was the same ParcellID with an adress I assign that one to the null)
UPDATE project_nashville.`nashville housing data for data cleaning` t1
JOIN (
  SELECT ParcelID, MIN(PropertyAddress) AS Address
  FROM project_nashville.`nashville housing data for data cleaning`
  WHERE PropertyAddress IS NOT NULL
  GROUP BY ParcelID
) t2 ON t1.ParcelID = t2.ParcelID
SET t1.PropertyAddress = t2.Address
WHERE t1.PropertyAddress IS NULL;

#Breaking out address into Individual Columns (Address, City)
ALTER TABLE project_nashville.`nashville housing data for data cleaning`
 ADD PropertySplitAddress2 Nvarchar(255);

UPDATE project_nashville.`nashville housing data for data cleaning`
SET PropertySplitAddress2 = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', 1));
 
ALTER TABLE project_nashville.`nashville housing data for data cleaning`
 ADD PropertySplitCity2 Nvarchar(255);
 
UPDATE project_nashville.`nashville housing data for data cleaning`
 SET PropertySplitCity2 = TRIM(SUBSTRING_INDEX(PropertyAddress, ',', -1));
 
 #Breaking out owner address into Individual Columns (Address, City, State)
 
 ALTER TABLE project_nashville.`nashville housing data for data cleaning`
 ADD OwnerSplitAddress Nvarchar(255);
UPDATE project_nashville.`nashville housing data for data cleaning`
SET OwnerSplitAddress = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', 1));

ALTER TABLE project_nashville.`nashville housing data for data cleaning`
 ADD OwnerSplitcity Nvarchar(255);
UPDATE project_nashville.`nashville housing data for data cleaning`
SET OwnerSplitcity = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', -2), ',', 1));

ALTER TABLE project_nashville.`nashville housing data for data cleaning`
 ADD OwnerSplitstate Nvarchar(255);
UPDATE project_nashville.`nashville housing data for data cleaning`
SET OwnerSplitstate = TRIM(SUBSTRING_INDEX(OwnerAddress, ',', -1));

#Change Y and N to Yes and No on "Sold as Vacant" field
UPDATE project_nashville.`nashville housing data for data cleaning`
SET SoldAsVacant = CASE SoldAsVacant
  WHEN 'Y' THEN 'Yes'
  WHEN 'N' THEN 'No'
END;

#Delete Unused columns
ALTER TABLE project_nashville.`nashville housing data for data cleaning`
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress;