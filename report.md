# Introduction to database system : Deliverable 1

## Assumptions
- 1) Friends is not always reciprocal  (not always reciprocal)
- 2) A business can have, the same day, several and overlaping opening hours. Eg an hotel can have the breakfeast starting at 7 and its pool opening at 8 
- 3) There are only 6 attributes to a business : business parking, good for meal, ambiance, noise level, music, dietary restrictions. We called these attributes categories
- 4) There are not a reasonable fixed number of category name possible for a business
- 5) In business hours, open now is not a relevant feature because it depends of the time data have been extracted
- 6) A business could have no attributes
- 7) A business could have no schedule




## Entity Relationship Schema

### Schema
<!-- Put the shema here -->
<!-- ![ER schema](path2ER.jpg) -->

### Description 
Elite is associated to a user, so it is a weak regarding users table. 
A tip is given by a user to a business, so it is weak regarding these two entities.
Same reasoning for review table. 
A schedule is dependant of a business, so it is also a weak entity. 

The Friends table should be a many-to-many relationship, due to assumption 1

We splitted the weekly schedule of a busness into dayly schedules, to make it more exploitable. As a business could open and close twice in a day (eg a restaurant), we created an Schedule ID to identify each time slot. This manages assumption 2.

We didn't do a ISA for Category of a business because there are too many possibilities for each one (assumption 4)

Assumptions 6 and 7 justifies the thin lines between business and 'has' linked to Attributes and Schedule tables

<!-- OLD WAY ISA : add descriptive attributes specific to a subclass. These attributes are not appropriate for all entities in the superclass (assumption 3)
- Overlap constraint allowed (a busness can have several attributes like ambiance and noise level at the same time)
- Covering constraint : no -->

## Relational schema
<!-- OLD WAY We choose to translate the ISA relationship by 6 tables. Each attribute has its own sub-attributes, mostly boolean as in the data. We also added 6 boolean values in business entity, to know wich attributes a business have. It is necessary, but it could make us save a lot of time further. For example, if we want to know wich attributes has a business, you would not have to scan all the 6 tables looking for a bid.  --> 

Weak entities and their relationship table to their owner entity can be merged into one table in the RM, eg Was-Elite, Rates-Review, Gives-Tip, Has-Schedule

For all entities, when a attribute is a key (usually a primary or foreign key), it has a condition NOT NULL. There are no condition on other non-necessary attribute

ATTRIBUTES table relates to what we called the 6 attributes categories of a business. Each of attribute category have several attributes. At first, we hesitated to design attributes as an ISA relationaship. However, we choose a simpler form. All information is grouped in ATTRIBUTES table, which is weak. For example, for each attribute a business has, the table has a row looking like (bid, attributes_category, attribute). As there is not twice the same attributes accross the 6 categories, (bid, attribute) can be the PK. This will design a very long table, but efficient for all type of query related to this.

<!-- At first, we hesitated to design attributes as an ISA relationaship. However, we choose a simpler form. All information is grouped in attributes table, which is weak. We could do that because there are at most 6 attributes possible for business. For example, for each attributes a business has, the table has a row looking like (bid, attributes_category, ) -->

## Data cleaning and transformation discussion
If not an int => put a 0 
Ignore non essential attributes that are null
we used for adress, schedule, text of the tip, open and close time, etc CHARVAR to allow flexibility. 
split attributes or cat names from dictionary to smaller strings

## General comments 
The team had a good dynamic, we all worked well on it. We split the work into 3 (design ER, write the RM, and write the report), so we had to communicate a lot to avoid misunderstandings. 