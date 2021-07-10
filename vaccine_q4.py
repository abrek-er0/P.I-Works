import pandas
import os

#read csv file
vaccines = pandas.read_csv(os.path.join(os.getcwd(), "country_vaccination_stats.csv"))

#fill NaN values by their respective countries'.
vaccines["daily_vaccinations"] = vaccines.groupby("country").transform(lambda x: x.fillna(x.min()))["daily_vaccinations"]
    
#fill remaining NaNs by zeros.
vaccines["daily_vaccinations"].fillna(0, inplace = True)

#Save changes
vaccines.to_csv(os.path.join(os.getcwd(), "country_vaccination_stats.csv"))
