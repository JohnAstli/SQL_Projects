-- In this script we will develop some queries on the IG clone database

-- Let's find our 5 oldest users 
SELECT 
    *
FROM
    users
ORDER BY created_at
LIMIT 5;

/* We need to figure out when to schedule an ad campaign. In order to have a more 
targeted campaign let's find out what day(s) of the week do most users register on.*/

SELECT 
    DAYNAME(created_at) AS day, COUNT(*)
FROM
    users
GROUP BY day
ORDER BY COUNT(*) DESC
LIMIT 3; 	

/* We want to target the inactive users with an email campaign. In this section 
we will try to find out which users have never posted a photo.*/

SELECT 
    username
FROM
    users
        LEFT JOIN
    photos ON users.id = photos.user_id
WHERE
    photos.id IS NULL;
    
/* We are running a contest, where we want to find who posted the most 
liked photo. */

SELECT 
    username, photos.image_url, photos.id, COUNT(*) AS total
FROM
    photos
        INNER JOIN
    likes ON photos.id = likes.photo_id
        INNER JOIN
    users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


/* Let's see how many time does the average user posts.
In order to see that, we have to calculate the average photos, every user posts.*/

SELECT 
    (SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT 
            COUNT(*)
        FROM
            users) AS average; 

/* In this section we will find the 5 most used tags. */

SELECT 
    tags.tag_name, COUNT(*) AS total
FROM
    photo_tags
        JOIN
    tags ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total DESC
LIMIT 5;

/* Let's find the allegedly bot users, that have liked every single photo */

SELECT 
    username, COUNT(*) AS num_likes
FROM
    users
        INNER JOIN
    likes ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = (SELECT 
        COUNT(*)
    FROM
        photos);


