# ER schema    
   
## What will it contain   
   
The ER schema contains four entities: User, Business, Review, and Tip. The entities have relationships with each other as follows:   
   
User entity has a one-to-many relationship with Review entity, as a user can write multiple reviews. User entity also has a one-to-many relationship with Tip entity, as a user can give multiple tips.     
   
Business entity has a one-to-many relationship with Review entity, as a business can have multiple reviews. Business entity also has a one-to-many relationship with Tip entity, as a business can have multiple tips.   
   
Review entity has a many-to-one relationship with User entity, as a review can be written by only one user. Review entity also has a many-to-one relationship with Business entity, as a review can be written for only one business.   
   
Tip entity has a many-to-one relationship with User entity, as a tip can be given by only one user. Tip entity also has a many-to-one relationship with Business entity, as a tip can be given for only one business.   
   
## Attributes of each entity   
   
The attributes of each entity are as follows:   
   
### User Entity:   
User_id: unique identifier for each user     
Name: first name of the user   
Yelping_since: date when the user joined Yelp   
Average_stars: average stars the user has received from other users for their reviews   
Review_count: the number of reviews this user has written   
Fans_cont: the number of fans this user has   
Elite: list of years in which this user has an elite status   
Friends: list of friends, whose elements are the user_id of the friends (who are also users on Yelp).   
Compliment_cool: the number of cool compliments this user has received   
Compliment_funny: the number of funny compliments this user has received  
Compliment_hot: the number of hot compliments this user has received   
Compliment_list: the number of list compliments this user has received   
Compliment_more: the number of more compliments this user has received   
Compliment_note: the number of note compliments this user has received   
Compliment_photos: the number of photo compliments this user has received
Compliment_plain: the number of plain compliments this user has received 
Compliment_profile: the number of profile compliments this user has received   
Compliment_writer: the number of writer compliments this user has received   
   
### Business Entity:   
Business_id: unique identifier for each business   
Name: name of the business   
Address: street address of the business   
City: city in which the business is located   
State: state in which the business is located   
Postal_code: postal code of the business   
Latitude: latitude of the business location   
Longitude: longitude of the business location   
Stars: average rating of the business   
Review_count: the number of reviews for the business   
Is_open: indicates whether the business is currently open or closed   
Attributes: list of attributes associated with the business   
Categories: list of categories to which the business belongs   
   
### Review Entity:   
Review_id: unique identifier for each review   
User_id: foreign key referencing the User entity, identifies the user who wrote the review   
Business_id: foreign key referencing the Business entity, identifies the business being reviewed   
Stars: rating given by the user for the business   
Useful: number of useful votes received from other users for the review   
Funny: number of funny votes received from other users for the review   
Cool: number of cool votes received from other users for the review   
Text: the content of the review   
   
### Tip Entity:   
Tip_id: unique identifier for each tip   
User_id: foreign key referencing the User entity, identifies the user who wrote the tip   
Business_id: foreign key referencing the Business entity, identifies the business being tipped   
Date: Date the tip was made
Likes: number of likes received from other users for the tip   
Text: the content of the tip 
   
### Category Entity:   
Category_id: unique identifier for each category   
Name: name of the category   
   
### Attribute Entity:   
Attribute_id: unique identifier for each attribute   
Name: name of the attribute   

### Opening_hours:
Day: what day they are open
Opening: Opening hours
Closing: Closing hours
   

