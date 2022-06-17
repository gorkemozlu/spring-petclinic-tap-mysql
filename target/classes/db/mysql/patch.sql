ALTER TABLE vets ADD COLUMN city VARCHAR(100) AFTER last_name;

UPDATE vets SET city=NULL WHERE id = 1;
UPDATE vets SET city='Canton' WHERE id = 2;
UPDATE vets SET city='Boston' WHERE id = 3;
UPDATE vets SET city=NULL WHERE id = 4;
UPDATE vets SET city='Newton' WHERE id = 5;
UPDATE vets SET city='Cambridge' WHERE id = 6;