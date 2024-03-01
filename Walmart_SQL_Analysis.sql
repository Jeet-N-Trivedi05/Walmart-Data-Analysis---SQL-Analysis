USE WALMART;
SELECT * FROM WalmartSalesData wsd

/* FEATURE ENGINEERING -- TIME OF DAY */
SELECT 
    TIME,
    CASE
        WHEN TIME BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
        WHEN TIME BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
        ELSE "EVENING"
    END AS TIME_OF_DAY
FROM WalmartSalesData wsd;



/* FEATURE ENGINEERING -- TIME OF DAY ADDING COLUMN INTO TABLE */
ALTER TABLE WalmartSalesData
ADD COLUMN TIME_OF_DATE VARCHAR(20);

/* FEATURE ENGINEERING -- TIME OF DAY UPDATING VALUES OF A COLUMN  */
UPDATE WalmartSalesData 
SET TIME_OF_DATE = (
	CASE
        WHEN TIME BETWEEN "00:00:00" AND "12:00:00" THEN "MORNING"
        WHEN TIME BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
        ELSE "EVENING"
    END
);

/* FEATURE ENGINEERING -- DAY NAME  */

ALTER TABLE WalmartSalesData  ADD COLUMN DAY_NAME VARCHAR(20);

UPDATE WalmartSalesData 
SET DAY_NAME = (
	DAYNAME(`Date`) 
) ;


/* FEATURE ENGINEERING -- MONTH NAME  */

ALTER TABLE WalmartSalesData ADD COLUMN MONTH_NAME VARCHAR(20);

UPDATE WalmartSalesData 
SET MONTH_NAME = (
	MONTHNAME(`Date`) 
)


/* BUSINESS QUSTIONS */
/* HOW MANY UNIQUE CITIES THE DATA HAVE ? */

SELECT DISTINCT CITY FROM WalmartSalesData wsd ; 

/* HOW MANY UNIQUE PRODUCT LINE THE DATA HAVE ? */

SELECT DISTINCT Product_line FROM WalmartSalesData wsd;
SELECT COUNT(DISTINCT PRODUCT_LINE)FROM WalmartSalesData wsd;



/* WHAT IS MOST COMMON PAYMENT SYSTEM ? */
SELECT Payment,COUNT(Payment) FROM WalmartSalesData wsd GROUP BY Payment ORDER BY 2 DESC ; 


/* WHAT IS A MOST SELLING PRODUCT LINE ? */
SELECT PRODUCT_LINE, COUNT(Product_line) FROM WalmartSalesData wsd GROUP BY Product_line ORDER BY 2 DESC;

/* WHAT IS TOTALY REBENUE BY MONTH ? */
SELECT MONTH_NAME,SUM(Total) AS TOTAL_REVENUE FROM WalmartSalesData wsd GROUP BY MONTH_NAME ORDER BY 2 DESC  ;

/* WHAT MONTH HAS LARGEST COGS ? */
SELECT 
	MONTH_NAME AS MONTH,
	SUM(COGS) AS COGS
FROM WalmartSalesData wsd 
GROUP BY MONTH_NAME
ORDER BY COGS DESC;

/* WHAT PRODUCT LINE HAS THE LARGERST REVENUE ? */

SELECT Product_line,SUM(Total) AS REVENUE FROM WalmartSalesData wsd GROUP BY Product_line ORDER BY 2 DESC;

/* WHAT IS THE LARGEST CITY IN REVENUE ? */
SELECT CITY,SUM(TOTAL) AS REVENUE FROM WalmartSalesData wsd GROUP BY CITY ORDER BY REVENUE DESC;

/* WHAT PRODUCT LINE HAD THE LARGEST VAT ? */
SELECT `Tax_5%`  FROM WalmartSalesData wsd ;
SELECT Product_line ,AVG(`Tax_5%`)  FROM WalmartSalesData wsd GROUP BY Product_line ORDER BY 2 DESC  ;

/* FETCH EACH PRODUCT LINE ADN ADD A COLUMN TO THOSE PRODUCT LINE SHOWING "GOOD" "BAD". GOOD IF ITS GRATER THAN AVARAGE SALSE  */


/* WHICH BRANCH SOLD MORE PRODCUTS THAN AVARAGE PRODUCT SOLD ? */
SELECT BRANCH, SUM(Quantity) AS QTY FROM WalmartSalesData wsd GROUP BY Branch
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM WalmartSalesData wsd);

/* WHAT IS THE MOST COMMON PRODUCT LINE BY GENDER ? */
SELECT GENDER,Product_line,COUNT(*) FROM WalmartSalesData wsd GROUP BY Gender,Product_line ORDER BY 3 DESC  ; 

/* WHAT IS THE AVARAGE RATING OF EACH PRODCUT LINE ? */
SELECT 
	ROUND(AVG(RATING),2),Product_line
FROM WalmartSalesData wsd 
GROUP BY Product_line 
ORDER BY 1 DESC ; 

/* Sales Questions */
/* Number of sales made in each time of the day per weekday */
 SELECT TIME_OF_DATE,COUNT(*) AS SALES FROM WalmartSalesData wsd GROUP BY TIME_OF_DATE  ORDER BY 2 DESC ;
 SELECT TIME_OF_DATE, DAY_NAME,COUNT(*) AS SALES FROM WalmartSalesData wsd GROUP BY TIME_OF_DATE ,DAY_NAME ORDER BY DAY_NAME  ; 

/* Which of the customer types brings the most revenue?*/
SELECT Customer_type ,SUM(Total)  FROM WalmartSalesData wsd GROUP BY Customer_type ORDER BY 2 DESC;

/* Which city has the largest tax percent/ VAT (Value Added Tax)?*/
SELECT CITY,AVG(`Tax_5%`) FROM WalmartSalesData wsd GROUP BY CITY ORDER BY 2  DESC;

/* Which customer type pays the most in VAT? */
SELECT Customer_type ,AVG(`Tax_5%`) FROM WalmartSalesData wsd GROUP BY Customer_type  ORDER BY 2  DESC;

/* Customers Questions */
/* How many unique customer types does the data have? */
SELECT DISTINCT Customer_type  FROM WalmartSalesData wsd;

/* How many unique payment methods does the data have? */
SELECT DISTINCT Payment  FROM WalmartSalesData wsd;

/* What is the most common customer type? */
SELECT Customer_type , COUNT(*) FROM WalmartSalesData wsd GROUP BY Customer_type  ;


/* What is the gender of most of the customers? */
SELECT Gender, COUNT(*) FROM WalmartSalesData wsd GROUP BY Gender  ;

/* What is the gender distribution per branch? */
SELECT Gender,Branch,COUNT(*) FROM WalmartSalesData wsd GROUP BY Gender,Branch ORDER BY Branch  ;

/* Which time of the day do customers give most ratings? */
SELECT TIME_OF_DATE, AVG(Rating) FROM WalmartSalesData wsd GROUP BY  TIME_OF_DATE  ORDER BY 2 DESC;

/* Which day fo the week has the best avg ratings? */
SELECT DAY_NAME , AVG(Rating) FROM WalmartSalesData wsd GROUP BY  DAY_NAME  ORDER BY 2 DESC;


/* Which day of the week has the best average ratings per branch? */
SELECT DAY_NAME,Branch,AVG(Rating) FROM WalmartSalesData wsd GROUP BY DAY_NAME ,Branch ORDER BY Branch ;

SELECT * FROM WalmartSalesData wsd ;
































