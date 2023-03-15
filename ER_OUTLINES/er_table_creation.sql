CREATE TABLE USERS (
        Uid INT NOT NULL AUTO_INCREMENT,
        Name VARCHAR(20) NOT NULL,
        elite BOOLEAN NOT NULL,
        yelp_since DATE NOT NULL,
        fans INT NOT NULL, -- TBD if this is the correct way maybe we find way to tell if fan

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
        Category VARCHAR(100) NOT NULL,
        PRIMARY KEY (Bid)
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

"""
CREATE TABLE FANS (
        Uid INT NOT NULL,
        Fan_uid INT NOT NULL,
        FOREIGN KEY (Uid) REFERENCES USERS(Uid),
        FOREIGN KEY (Fan_uid) REFERENCES USERS(Uid)
);
"""


