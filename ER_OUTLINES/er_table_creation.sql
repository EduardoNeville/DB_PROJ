CREATE TABLE USERS (
        Uid INT NOT NULL AUTO_INCREMENT,
        Name VARCHAR(20) NOT NULL,
        yelp_since DATE NOT NULL,
        average_stars FLOAT,
        review_count INT NOT NULL,
        fans INT NOT NULL, -- TBD if this is the correct way maybe we find way to tell if fan
        elite BOOLEAN NOT NULL,
        compliment_cool INT NOT NULL,
        compliment_funny INT NOT NULL,
        compliment_hot INT NOT NULL,
        compliment_list INT NOT NULL,
        compliment_more INT NOT NULL,
        compliment_photos INT NOT NULL,
        compliment_plain INT NOT NULL,
        compliment_profile INT NOT NULL,
        compliment_writer INT NOT NULL,
        -- not sure about this part
        cool INT NOT NULL,
        funny INT NOT NULL,
        useful INT NOT NULL,
        PRIMARY KEY (Uid)
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

CREATE TABLE CATEGORIES (
        Bid INT NOT NULL,
        Category VARCHAR(100) NOT NULL,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);



CREATE TABLE SCHEDULE (
        Bid INT NOT NULL,
        Day DATE,
        Open_time TIME,
        Close_time TIME,
        PRIMARY KEY (Bid, Day),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE TIPS (
        Tid INT NOT NULL AUTO_INCREMENT,
        Uid INT NOT NULL,
        Bid INT NOT NULL,
        Text VARCHAR(1000) NOT NULL,
        Date DATE NOT NULL,
        PRIMARY KEY (Tid),
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

CREATE TABLE FRIENDS (
        Uid INT NOT NULL,
        Friend_uid INT NOT NULL,
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Friend_uid) REFERENCES USERS(Uid)
);


CREATE TABLE ATTRIBUTES (
        Bid INT NOT NULL,
        Attributes VARCHAR(1000) NOT NULL,
        PRIMARY KEY (Bid),
        FOREIGN KEY (Bid) REFERENCES BUSINESSES(Bid)
);

"""
Check if this is really needed
CREATE TABLE FANS (
        Uid INT NOT NULL,
        Fan_uid INT NOT NULL,
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Fan_uid) REFERENCES USERS(Uid)
);
"""
