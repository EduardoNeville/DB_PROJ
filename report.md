# Introduction to database system : Deliverable 1

## Assumptions
- 1) A business can have, the same day, several and overlaping opening hours. Eg an hotel can have the breakfeast starting at 7 and its pool opening at 8 
- 2) Friends is not always reciprocal  (not always reciprocal)
- 3) There are only 6 attributes to a business : business parking, good for meal, ambiance, noise level, music, dietary restrictions
- 4) There are not a fixed number of category name 
- 5) In business hours, open now is not a relevant feature because it depends of the time data have been extracted

## Entity Relationship Schema

### Schema
<!-- Put the shema here -->

### Description 
Elite is associated to a user, so it is a weak regarding users table. 
A tip is given by a user to a business, so it is weak regarding these two entities.
Same reasoning for review table. 
An schedule is dependant of a business, so it is also a weak entity. 

We splitted the weekly schedule of a busness into dayly schedules, to make it more exploitable. As a business could open and close twice in a day (eg a restaurant), we created an Schedule ID to identify each time slot. 

ISA : add descriptive attributes specific to a subclass. These attributes are not appropriate for all entities in the superclass (assumption 3)
- Overlap constraint allowed (a busness can have several attributes like ambiance and noise level at the same time)
- Covering constraint : no

We didn't to a ISA for category because there are too many possibilities for each business (assumption 4)

Has friends should be a many-to-many relationship, due to assumption 2

## Relational schema
Have many option to translate the ISA relationship : we choose ...

Weak entities and their relationship table to their owner entity can be merged into one table in the RM, eg Was-Elite, Rates-Review, Gives-Tip, Has-Schedule

A propos des uniques et not null

## Data cleaning and transformation discussion
If not an int => put a 0 
Ignore non essential attributes that are null
we used for adress, schedule, text of the tip, open and close time, etc CHARVAR to allow flexibility. 
split attributes or cat names from dictionary to smaller strings