-- %%%%%%%%%%%%%%%%%%%%%

-- Users table

CREATE TABLE USERS (
        Uid INT NOT NULL AUTO_INCREMENT,
        Name VARCHAR(20) NOT NULL,
        yelping_since VARCHAR(15) NOT NULL,
        average_stars FLOAT,
        review_count INT NOT NULL,
        fans INT NOT NULL,
        compliment_cool INT,
        compliment_funny INT,
        compliment_hot INT, 
        compliment_list INT,
        compliment_more INT,
        compliment_photos INT,
        compliment_plain INT, 
        compliment_profile INT,
        compliment_writer INT,

        cool INT,
        funny INT, 
        useful INT ,
        PRIMARY KEY (Uid)
);

-- Entities to support users

-- Elite table
CREATE TABLE ELITE(
        Uid INT NOT NULL,
        Year INT NOT NULL,
        PRIMARY KEY (Uid, Year),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid)
);

-- Friends table
CREATE TABLE FRIENDS (
        Uid INT NOT NULL,
        Friend_uid INT NOT NULL,
        PRIMARY KEY (Uid, Friend_uid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Friend_uid) REFERENCES USERS(Uid)
);

-- %%%%%%%%%%%%%%%%%%%%%

-- Reviews table
-- Weak entity
CREATE TABLE REVIEWS (
        Rid INT NOT NULL,
        Uid INT NOT NULL,
        Bid INT NOT NULL,
        Stars INT,
        Date VARCHAR(20) NOT NULL,
        Text VARCHAR(1000) NOT NULL,
        USEFUL INT,
        FUNNY INT,
        COOL INT,
        PRIMARY KEY (Rid, Uid, Bid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

-- %%%%%%%%%%%%%%%%%%%%%

-- Tips table
-- Weak entity
CREATE TABLE TIPS (
        Tid INT NOT NULL AUTO_INCREMENT,
        Uid INT NOT NULL,
        Bid INT NOT NULL,
        Text VARCHAR(1000),
        Date VARCHAR(20) NOT NULL,, 
        Compliment_count INT, 
        PRIMARY KEY (Tid, Uid, Bid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

-- %%%%%%%%%%%%%%%%%%%%%

-- Business table 
CREATE TABLE BUSINESSES (
        Bid INT NOT NULL AUTO_INCREMENT,
        Name VARCHAR(100) NOT NULL,
        -- Should we concatenate addr, city, state, postal_code? 
        Address VARCHAR(100) NOT NULL,
        City VARCHAR(20) NOT NULL,
        State VARCHAR(2) NOT NULL,
        Postal_code VARCHAR(10) NOT NULL,
        Latitude FLOAT NOT NULL,
        Longitude FLOAT NOT NULL,
        Stars FLOAT NOT NULL,
        Review_count INT NOT NULL,
        PRIMARY KEY (Bid)
);

-- Categories of a business

-- Business 'has' a category

CREATE TABLE CATEGORIES (
        Bid INT NOT NULL,
        Category_name VARCHAR(100),
        PRIMARY KEY (Bid, Category),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE SCHEDULES (
        Sid INT NOT NULL AUTO_INCREMENT,
        Bid INT NOT NULL,
        Day VARCHAR(10),
        Open_time VARCHAR(10),
        Close_time VARCHAR(20),
        PRIMARY KEY (Bid, Sid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

-- Attributes of the business
-- Business has a 'ISA' relationship with them 
CREATE TABLE ATTRIBUTES(
        Bid INT NOT NULL,
        -- e.g. 'Business_Parking' or 'Ambience' or 'NoiseLevel' or 'GoodForMeal' or 'Music' or 'DietaryRestrictions'
        attribute_category VARCHAR(20),
        -- Attributes of the category they are in eg. 'Business_Parking has 'garage' attribute 
        attribute VARCHAR(20), 
        PRIMARY KEY (Bid, attribute),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

/**

CREATE TABLE BUSINESS_PARKING(
        Bid INT NOT NULL,
        garage BOOLEAN,
        street BOOLEAN,
        validated BOOLEAN,
        lot BOOLEAN,
        valet BOOLEAN,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE AMBIENCE(
        Bid INT NOT NULL,
        touristy BOOLEAN,
        hipster BOOLEAN,
        romantic BOOLEAN,
        intimate BOOLEAN,
        trendy BOOLEAN,
        upscale BOOLEAN,
        classy BOOLEAN,
        casual BOOLEAN,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE NOISELEVEL(
        Bid INT NOT NULL,
        noise_level VARCHAR(10),
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE GOODFORMEAL(
        Bid INT NOT NULL,
        dessert BOOLEAN,
        latenight BOOLEAN,
        lunch BOOLEAN,
        dinner BOOLEAN,
        brunch BOOLEAN,
        breakfast BOOLEAN,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
); 

CREATE TABLE MUSIC(
        dj BOOLEAN,
        background_music BOOLEAN,
        no_music BOOLEAN,
        jukebox BOOLEAN,
        live BOOLEAN,
        video BOOLEAN,
        karaoke BOOLEAN,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE DIETARY_RESTRICTIONS(
        Bid INT NOT NULL,
        dairy_free BOOLEAN,
        gluten_free BOOLEAN,
        vegan BOOLEAN,
        kosher BOOLEAN,
        halal BOOLEAN,
        soy_free BOOLEAN,
        vegetarian BOOLEAN,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

**/



