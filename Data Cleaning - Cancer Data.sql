-- Data Cleaning and Transformation Practise
-- This is to pratise data cleaning and transformation within MySQL.
-- https://www.kaggle.com/datasets/rabieelkharoua/cancer-prediction-dataset


-- Viewing the raw data
SELECT *
FROM Cancer_Data;

-- 1. Creating a psuedo table to work on the data
CREATE TABLE Cancer_Data_staging
LIKE Cancer_Data;

INSERT INTO Cancer_Data_staging
SELECT *
FROM Cancer_Data;

-- Viewing the newly created table.
SELECT *
FROM Cancer_Data_staging;

-- 2. Transforming Data based on provided attributes

-- In the gender column, 0 represents 'Male' and 1 represents 'Female'.
UPDATE Cancer_Data_staging
SET Gender = 'Male'
WHERE Gender = 0;

UPDATE Cancer_Data_staging
SET Gender = 'Female'
WHERE Gender = '1';

SELECT *
FROM Cancer_Data_staging;

-- In the smoking column, o represents Not smoking and 1 represents Smoking.
UPDATE Cancer_Data_staging
SET Smoking = 'Not Smoking'
WHERE Smoking = 0;

UPDATE Cancer_Data_staging
SET Smoking = 'Smoking'
WHERE Smoking = '1';

SELECT *
FROM Cancer_Data_staging;


-- GeneticRisk column represents genetic risk levels for cancer, with 0 indicating Low, 1 indicating Medium, and 2 indicating High.
UPDATE Cancer_Data_staging
SET GeneticRisk = 'Low'
WHERE GeneticRisk = 0;

UPDATE Cancer_Data_staging
SET GeneticRisk = 'Medium'
WHERE GeneticRisk = '1';

UPDATE Cancer_Data_staging
SET GeneticRisk = 'High'
WHERE GeneticRisk = '2';

SELECT *
FROM Cancer_Data_staging;

-- The CnacerHistory column represents the pateints history for Cancer and symptoms, where 0 means 'No' and 1 means 'Yes'.
UPDATE Cancer_Data_staging
SET CancerHistory = 'No'
WHERE CancerHistory = 0;

UPDATE Cancer_Data_staging
SET CancerHistory = 'Yes'
WHERE CancerHistory = '1';

SELECT *
FROM Cancer_Data_staging;

-- The Diagnosis column represents Cancer DDiagnosis status, where 0 indicates 'No Cancer' and 1 indicates 'Cancer'.
UPDATE Cancer_Data_staging
SET Diagnosis = 'No Cancer'
WHERE Diagnosis = 0;

UPDATE Cancer_Data_staging
SET Diagnosis = 'Cancer'
WHERE Diagnosis = '1';

SELECT *
FROM Cancer_Data_staging;

-- Now we have a proper data to work with.

-- 3. Checking for any Null values
SELECT *
FROM Cancer_Data_staging
WHERE BMI IS NULL;

SELECT *
FROM Cancer_Data_staging
WHERE PhysicalActivity IS NULL AND AlcoholIntake IS NULL;

-- No NULL Values
-- 4. Rounding off the numerical values

WITH ROUND_CTE AS
(
SELECT BMI, ROUND(BMI, 2), PhysicalActivity, ROUND(PhysicalActivity, 2), AlcoholIntake, ROUND(AlcoholIntake, 2)
FROM Cancer_Data_staging
)
UPDATE Cancer_Data_staging
SET BMI = ROUND(BMI, 2), PhysicalActivity = ROUND(PhysicalActivity, 2), AlcoholIntake = ROUND(AlcoholIntake, 2);

SELECT *
FROM Cancer_Data_staging;

-- 5. Adding a Column 'PhysicalHealth' based on BMI numbers
SELECT BMI,
CASE
	WHEN BMI < 18.5 THEN 'UnderWeight'
    WHEN BMI >= 18.5 AND BMI < 24.9 THEN 'Normal'
    WHEN BMI >= 24.9 AND BMI < 29.9 THEN 'OverWeight'
    ELSE 'Obese'
END AS PhysHealth
FROM Cancer_Data_staging;

ALTER TABLE Cancer_Data_staging
ADD COLUMN PhysicalHealth VARCHAR(50);

SELECT *
FROM Cancer_Data_staging;

UPDATE Cancer_Data_staging
SET PhysicalHealth = 
(
CASE
	WHEN BMI < 18.5 THEN 'UnderWeight'
    WHEN BMI >= 18.5 AND BMI < 24.9 THEN 'Normal'
    WHEN BMI >= 24.9 AND BMI < 29.9 THEN 'OverWeight'
    ELSE 'Obese'
    END
);

-- Lets check to see if the case statement is working properly
SELECT *
FROM Cancer_Data_staging
WHERE BMI = 21;

SELECT COUNT(BMI), GeneticRisk
FROM Cancer_Data_staging
GROUP BY GeneticRisk;
































