--create block named countries
with countries 
AS 
( 
--give columns as country and median
SELECT country, 
(
  --Add two elements from middle then divide by 2 to calculate median(sorted).
 (SELECT MAX(daily_vaccinations) FROM
   (SELECT TOP 50 PERCENT daily_vaccinations FROM country_vaccination_stats WHERE first.country = country ORDER BY daily_vaccinations) AS BottomHalf)
 +
 (SELECT MIN(daily_vaccinations) FROM
   (SELECT TOP 50 PERCENT daily_vaccinations FROM country_vaccination_stats WHERE first.country = country ORDER BY daily_vaccinations DESC) AS TopHalf)
) / 2 AS median FROM country_vaccination_stats as first WHERE first.daily_vaccinations IS NULL
  )
--We have median values, now we can update our table
UPDATE country_vaccination_stats
set daily_vaccinations = countries.median
--Inner join on country name. 
FROM country_vaccination_stats INNER JOIN countries 
    ON country_vaccination_stats.country = countries.country

--Set remaining NaNs to 0.
UPDATE country_vaccination_stats
	set daily_vaccinations = 0
    WHERE daily_vaccinations is NULL