-- Users table

CREATE TABLE USERS (
        Uid INT NOT NULL AUTO_INCREMENT,
        Name VARCHAR(20) NOT NULL,
        yelp_since DATE NOT NULL,
        average_stars FLOAT,
        review_count INT NOT NULL,
        fans INT NOT NULL, -- TBD if this is the correct way maybe we find way to tell if fan

        compliment_cool INT,
        compliment_funny INT,
        compliment_hot INT, 
        compliment_list INT,
        compliment_more INT,
        compliment_photos INT,
        compliment_plain INT, 
        compliment_profile INT,
        compliment_writer INT,
        -- not sure about this part
        cool INT,
        funny INT, 
        useful INT ,
        PRIMARY KEY (Uid)
);

CREATE TABLE ELITE(
        Uid INT NOT NULL,
        Year INT NOT NULL,
        PRIMARY KEY (Uid, Year),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid)
);

CREATE TABLE REVIEWS (
        Rid INT NOT NULL AUTO_INCREMENT,
        Uid INT NOT NULL,
        Bid INT NOT NULL,
        Stars INT NOT NULL,
        Date DATE NOT NULL,
        Text VARCHAR(1000) NOT NULL,
        USEFUL INT NOT NULL,
        FUNNY INT NOT NULL,
        COOL INT NOT NULL,
        PRIMARY KEY (Rid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

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
        Is_open BOOLEAN NOT NULL,
        -- Attributes and categories to be specified how to deal with later???
        Category VARCHAR(100) NOT NULL,
        Attributes VARCHAR(1000) NOT NULL,
        PRIMARY KEY (Bid),
        Foreign Key (Category) REFERENCES CATEGORIES(Category),
        Foreign Key (Attributes) REFERENCES ATTRIBUTES(Attributes)
);

-- Categories of a business

-- Business 'has' a category

CREATE TABLE CATEGORIES (
        Bid INT NOT NULL,
        Category VARCHAR(100) NOT NULL,
        PRIMARY KEY (Bid),
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

CREATE TABLE TIPS (
        Tid INT NOT NULL AUTO_INCREMENT,
        Uid INT NOT NULL,
        Bid INT NOT NULL,
        Text VARCHAR(1000),
        Date DATE, 
        Complement_count INT, 
        PRIMARY KEY (Tid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE FRIENDS (
        Uid INT NOT NULL,
        Friend_uid INT NOT NULL,
        PRIMARY KEY (Uid, Friend_uid)
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Friend_uid) REFERENCES USERS(Uid)
);


-- Attributes of the business
-- Business has a 'ISA' relationship with them 

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

