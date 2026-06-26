CREATE DATABASE social_media;
USE social_media;
CREATE TABLE platform(
platform VARCHAR(30) PRIMARY KEY,
avg_time INT,
age_group VARCHAR(20),
content_format VARCHAR(30),
data_source VARCHAR(30)
);

CREATE TABLE users(
user_id VARCHAR(30),
age INT,
age_group VARCHAR(20),
gender VARCHAR(30),
platform VARCHAR(30),
content_type VARCHAR(30),
usage_type VARCHAR(30),
platform_satisfaction VARCHAR(30),
CONSTRAINT FK_platform FOREIGN KEY(platform) REFERENCES platform(platform)
);
SELECT * FROM USERs;
-- Get the average age of users for each platform.

SELECT platform, Round(Avg(age)) AS Average_age 
FROM users
GROUP BY platform;

-- Platforms with more than 5 users
SELECT platform, COUNT(*) AS total_user
FROM users
GROUP BY platform
HAVING COUNT(*)>5
ORDER BY COUNT(*) ASC;

-- List platforms with no users
SELECT u.user_id,u.age,p.platform
FROM platform p
LEFT JOIN users u
ON p.platform = u.platform
WHERE u.user_id IS NULL;

-- Age group matches platform target age group

SELECT u.user_id,u.platform,u.age_group
FROM users u
JOIN platform p
ON u.platform = p.platform
WHERE u.age_group = p.age_group
LIMIT 15;

-- 10. Rank platforms based on number of users
SELECT Platform, COUNT(*) AS total_user,
RANK() OVER(ORDER BY COUNT(*) DESC) AS rank_value
FROM users
GROUP BY Platform;

SELECT user_id,age,
CASE
WHEN age < 18 THEN 'Teen'
WHEN age BETWEEN 18 AND 30 THEN 'Young Adult'
ELSE 'Adult'
END AS age_category
FROM users;

SELECT platform, avg_time 
FROM platform
WHERE avg_time > (SELECT AVG(avg_time) FROM platform);

SELECT platform,
       SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
       SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM users
GROUP BY platform;