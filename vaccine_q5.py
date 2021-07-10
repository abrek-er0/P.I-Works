import pandas
import os

#read csv file
vaccines = pandas.read_csv(os.path.join(os.getcwd(), "country_vaccination_stats.csv"))

#calculate the median for each group
pairs = vaccines.groupby(["country"])["daily_vaccinations"].median()

#Sort pairs by the median value
pairs.sort_values(ascending = False, inplace = True)

#Print first 3 countries.
print("\n".join(pairs.keys()[:3]))
