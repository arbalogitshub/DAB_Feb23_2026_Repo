# Discussion Questions
<b> 1) What are the key advantages of using Pandas for data cleaning compared to other methods?</b><br />

The key advantages that using Pandas for data cleaning purposes in comparison to other methods are the following: 
* Pandas can work on entire columns at once instead of one value at a time, which makes the cleaning process faster.
* Pandas contains a variety of built-in cleaning tools for certain data cleaning tasks.
* Pandas does not change the oringinal data.
* Pandas can create better charts and graphs.
* Pandas can provide more accurate results.
* Pandas are easier to understand.

<b> 2) How would your approach to handling missing values differ if the missing data was not random but had a pattern or meaning?</b>
If the missing data isn't completely at random, investigate why the data is missing, try to identify for any patterns. Create a "missing" indicator variables for important features. Avoid utilizing a "one size fits all" imputation, for example not every missing data in numerical columns would require imputation using the mean or median. Document all missing data decisions and transformations, and utilize domain knowldege for imputation choices. Avoid dropping rows without checking for bias.

<b> 3) What types of data quality issues might not be immediately visible through simple DataFrame inspection methods?</b><br />
Hidden duplicates for example, having a value in a name column Alvaro Gonzalez and another value withe same name but written in lower case or an added space. Incorrect data types but looks fine for example "7" and 7 in a numerical column.  Having Valid outliers, Inconsistent categorical values. logical or unit inconsistencies in columns. Temporal inconsistencies such as mismatching time data like having a 24 hour time vs the 2400 hour time structure in a column.

<b> 4) How would you document your data cleaning process to ensure reproducibility?</b><br />
To ensure my work is reproducible, 

<b> 5) In what scenarios might it be better to remove rows with missing values rather than imputing them?</b><br />
* When you have a really large dataset.
* When the missingness of the data is at a small percent and the missingness is completely random.
* When imputating data creates bias or noise.
* When the missing values are in the target variable.
