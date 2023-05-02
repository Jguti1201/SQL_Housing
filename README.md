# SQL_Housing

This is a SQL script that performs various data cleaning and transformation tasks on the "nashville housing data for data cleaning" table in the "project_nashville" database.

The script first standardizes the date format by using the STR_TO_DATE function and then converts the "SaleDate" column to the "DATE" data type using the MODIFY COLUMN statement.

The next step populates the missing "PropertyAddress" data by joining the table with a subquery that finds the minimum address for each ParcelID where the PropertyAddress is not null.

Then, the script breaks out the "PropertyAddress" into individual columns (Address and City) by using the ALTER TABLE statement to add two new columns ("PropertySplitAddress2" and "PropertySplitCity2") and then uses the SUBSTRING_INDEX and TRIM functions to populate these columns with the appropriate values.

Similarly, the script breaks out the "OwnerAddress" into individual columns (Address, City, and State) by using the ALTER TABLE statement to add three new columns ("OwnerSplitAddress", "OwnerSplitcity", and "OwnerSplitstate") and then uses the SUBSTRING_INDEX and TRIM functions to populate these columns with the appropriate values.

Finally, the script changes the values in the "SoldAsVacant" column from 'Y' and 'N' to 'Yes' and 'No', respectively, using the CASE statement. The script then drops the unused columns ("OwnerAddress", "TaxDistrict", and "PropertyAddress") using the ALTER TABLE statement with the DROP COLUMN clause.
