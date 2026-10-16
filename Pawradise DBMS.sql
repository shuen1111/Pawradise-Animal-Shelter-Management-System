DROP TABLE volunteer_duty CASCADE CONSTRAINTS;
DROP TABLE volunteer CASCADE CONSTRAINTS;
DROP TABLE donation CASCADE CONSTRAINTS;
DROP TABLE donor CASCADE CONSTRAINTS;
DROP TABLE veterinary CASCADE CONSTRAINTS;
DROP TABLE adoption CASCADE CONSTRAINTS;
DROP TABLE adopter CASCADE CONSTRAINTS;
DROP TABLE staff_duty CASCADE CONSTRAINTS;
DROP TABLE task CASCADE CONSTRAINTS;
DROP TABLE staff CASCADE CONSTRAINTS;
DROP TABLE animal_category CASCADE CONSTRAINTS;
DROP TABLE animal CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;

-- Create table for category
CREATE TABLE category(
    categoryID VARCHAR2(5) PRIMARY KEY,
    categoryName VARCHAR2(20) NOT NULL,
    categoryType VARCHAR2(10) CHECK (categoryType IN ('Dog', 'Cat')),
    categoryDescription VARCHAR2(500) NOT NULL
);

-- Create table for animal
CREATE TABLE animal (
    animalID VARCHAR2(5) PRIMARY KEY,
    animalName VARCHAR2(50) NOT NULL,
    animalSpecies VARCHAR2(50) NOT NULL,
    animalGender VARCHAR2(1) CHECK (animalGender IN ('M', 'F')),
    animalAge NUMERIC(2) CHECK (animalAge BETWEEN 0 AND 40),
    intakeDate DATE,
    healthRating NUMERIC(1) NOT NULL CHECK (healthRating BETWEEN 1 AND 5)
);

-- Create table for animal_category
CREATE TABLE animal_category(
    animalID VARCHAR2(5),
    categoryID VARCHAR2(5),
    PRIMARY KEY (animalID, categoryID),
    FOREIGN KEY (animalID) REFERENCES animal(animalID),
    FOREIGN KEY (categoryID) REFERENCES category(categoryID)
);

-- Create table for staff
CREATE TABLE staff(
    staffID VARCHAR2(5) PRIMARY KEY,
    staffName VARCHAR2(100) NOT NULL,
    staffIC VARCHAR2(14) NOT NULL CHECK (REGEXP_LIKE(staffIC, '^\d{6}-\d{2}-\d{4}$')),
    staffGender VARCHAR2(1) CHECK (staffGender IN ('M', 'F')),
    staffContact VARCHAR2(13) NOT NULL,
    staffPosition VARCHAR2(50) NOT NULL
);

--Create table for task
CREATE TABLE task(
    taskID VARCHAR2(5) PRIMARY KEY,
    taskName VARCHAR2(30) NOT NULL,
    taskDescription VARCHAR2(500) NOT NULL
);

-- Create table for staff_duty
CREATE TABLE staff_duty(
    dutyID VARCHAR2(5) PRIMARY KEY,
    taskID VARCHAR2(5),
    staffID VARCHAR2(5),
    animalID VARCHAR2(5),
    dutyDate DATE,
    FOREIGN KEY (taskID) REFERENCES task(taskID),
    FOREIGN KEY (staffID) REFERENCES staff(staffID),
    FOREIGN KEY (animalID) REFERENCES animal(animalID)
);

-- Create table for adopter
CREATE TABLE adopter(
    adopterID VARCHAR2(5) PRIMARY KEY,
    adopterName VARCHAR2(100) NOT NULL,
    adopterContact VARCHAR2(13) NOT NULL,
    adopterEmail VARCHAR2(100) CHECK (REGEXP_LIKE(adopterEmail, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    adopterAddress VARCHAR2(400) NOT NULL
);

-- Create table for adoption
CREATE TABLE adoption(
    adoptionID VARCHAR2(5) PRIMARY KEY,
    animalID VARCHAR2(5),
    adopterID VARCHAR2(5),
    adoptionDate DATE,
    FOREIGN KEY (animalID) REFERENCES animal(animalID),
    FOREIGN KEY (adopterID) REFERENCES adopter(adopterID)
);

-- Create table for veterinary
CREATE TABLE veterinary(
    veterinaryID VARCHAR2(5) PRIMARY KEY,
    staffID VARCHAR2(5),
    animalID VARCHAR2(5),
    treatmentDescription VARCHAR2(200) NOT NULL,
    FOREIGN KEY (staffID) REFERENCES staff(staffID),
    FOREIGN KEY (animalID) REFERENCES animal(animalID)
);

-- Create table for donor
CREATE TABLE donor(
    donorID VARCHAR2(5) PRIMARY KEY,
    donorName VARCHAR2(100) NOT NULL,
    donorContact VARCHAR2(13) NOT NULL
);

-- Create table for donation
CREATE TABLE donation(
    donationID VARCHAR2(5) PRIMARY KEY,
    donorID VARCHAR2(5),
    staffID VARCHAR2(5),
    donationItem VARCHAR2(200) NOT NULL,
    donationDate DATE,
    FOREIGN KEY (donorID) REFERENCES donor(donorID),
    FOREIGN KEY (staffID) REFERENCES staff(staffID)
);

-- Create table for volunteer
CREATE TABLE volunteer(
    volunteerID VARCHAR2(5) PRIMARY KEY,
    volunteerName VARCHAR2(100) NOT NULL,
    volunteerGender VARCHAR2(1) CHECK (volunteerGender IN ('M', 'F')),
    volunteerContact VARCHAR2(13) NOT NULL
);

-- Create table for volunteer_duty
CREATE TABLE volunteer_duty(
    dutyID VARCHAR2(5) PRIMARY KEY,
    volunteerID VARCHAR2(5),
    taskID VARCHAR2(5),
    supervisorID VARCHAR2(5),
    animalID VARCHAR2(5),
    dutyDate DATE,
    FOREIGN KEY (volunteerID) REFERENCES volunteer(volunteerID),
    FOREIGN KEY (taskID) REFERENCES task(taskID),
    FOREIGN KEY (supervisorID) REFERENCES staff(staffID),
    FOREIGN KEY (animalID) REFERENCES animal(animalID)
);


-- Insert data into category table
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('C1', 'Kitten', 'Cat', 'Cats under 6 months old requiring frequent care.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('C2', 'Adult Cat', 'Cat', 'Cats aged 6 months to 8 years, typically independent.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('C3', 'Senior Cat', 'Cat', 'Cats over 8 years old, better for quiet homes.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('C4', 'Short-haired Cat', 'Cat', 'Low-maintenance fur, easy to groom.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('C5', 'Long-haired Cat', 'Cat', 'Requires frequent brushing and grooming.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('D1', 'Puppy', 'Dog', 'Dogs under 1 year old, playful and trainable.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('D2', 'Adult Dog', 'Dog', 'Dogs aged 1 to 7 years, healthy and energetic.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('D3', 'Senior Dog', 'Dog', 'Dogs over 7 years old, need gentler care.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('D4', 'Small Breed Dog', 'Dog', 'Dogs under 10kg when fully grown.');
INSERT INTO category (categoryID, categoryName, categoryType, categoryDescription) VALUES ('D5', 'Large Breed Dog', 'Dog', 'Dogs over 25kg, need more space and exercise.');

-- Insert data into animal table
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A01', 'Luke', 'Ragdoll', 'M', 3, TO_DATE('15-JAN-2024','DD-MON-YYYY'), 5);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A02', 'Artem', 'Golden Retriever', 'M', 1, TO_DATE('21-FEB-2024','DD-MON-YYYY'), 5);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A03', 'Nana', 'British Shorthair', 'F', 2, TO_DATE('09-MAR-2024','DD-MON-YYYY'), 4);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A04', 'Vyn', 'Husky', 'M', 5, TO_DATE('12-APR-2024','DD-MON-YYYY'), 4);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A05', 'Sky', 'Poodle', 'F', 8, TO_DATE('28-APR-2024','DD-MON-YYYY'), 5);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A06', 'Money', 'Siamese Cat', 'F', 3, TO_DATE('10-MAY-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A07', 'Baby', 'Ragdoll', 'F', 10, TO_DATE('05-JUN-2024','DD-MON-YYYY'), 4);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A08', 'Marius', 'Siamese Cat', 'M', 5, TO_DATE('13-JUN-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A09', 'Caleb', 'Poodle', 'M', 3, TO_DATE('13-JUN-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A10', 'Goldie', 'Golden Retriever', 'F', 1, TO_DATE('31-AUG-2024','DD-MON-YYYY'), 4);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A11', 'Gucci', 'Beagle', 'F', 2, TO_DATE('07-SEP-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A12', 'Rafayel', 'Poodle','M', 6, TO_DATE('15-OCT-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A13', 'Xavier', 'American Shorthair','M', 3, TO_DATE('14-DEC-2024','DD-MON-YYYY'), 3);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A14', 'Peachy', 'Beagle', 'M', 7, TO_DATE('03-JAN-2025','DD-MON-YYYY'), 4);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A15', 'Sylus', 'American Shorthair','M', 2, TO_DATE('30-JAN-2025','DD-MON-YYYY'), 2);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A16', 'Feifei', 'Pug', 'F', 4, TO_DATE('22-FEB-2025','DD-MON-YYYY'), 2);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A17', 'Mimi', 'Maine Coon', 'F', 0, TO_DATE('01-MAY-2025','DD-MON-YYYY'), 1);
INSERT INTO animal (animalID, animalName, animalSpecies, animalGender, animalAge, intakeDate, healthRating) VALUES ('A18', 'Zayne', 'Chihuahua', 'M', 0, TO_DATE('20-MAY-2025','DD-MON-YYYY'), 1);

-- Insert data into animal_category table
INSERT INTO animal_category (animalID, categoryID) VALUES ('A01', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A01', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A02', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A02', 'D5');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A03', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A03', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A04', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A04', 'D5');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A05', 'D3');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A05', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A06', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A06', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A07', 'C3');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A07', 'C5');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A08', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A08', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A09', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A09', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A10', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A10', 'D5');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A11', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A11', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A12', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A12', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A13', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A13', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A14', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A14', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A15', 'C2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A15', 'C4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A16', 'D2');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A16', 'D4');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A17', 'C1');
INSERT INTO animal_category (animalID, categoryID) VALUES ('A17', 'C5'); 
INSERT INTO animal_category (animalID, categoryID) VALUES ('A18', 'D1'); 
INSERT INTO animal_category (animalID, categoryID) VALUES ('A18', 'D4');

-- Insert data into staff table
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S1', 'John Tan Wei Heng','001218-10-6543', 'M', '60122829495', 'AnimalCaretaker');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S2', 'Rahmin bin Azizi','970315-08-1283', 'M', '60116678972', 'VeterinaryStaff');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S3', 'Maisarah binti Azwan', '930919-22-4586', 'F', '60142039040', 'AnimalCaretaker');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S4', 'Dasheta A/P Deepak', '890615-05-9632', 'F', '601813492216', 'ShelterManager');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S5', 'Yong Ke Qin','951010-14-7544', 'F', '60199038005', 'AdoptionCounselor');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S6', 'Dhruv A/L Rohan', '850128-16-6473', 'M', '60132343668', 'AdministrativeStaff');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S7', 'Alicia Ng Xiao Qi', '040807-41-1458', 'F', '60195222223', 'AnimalCaretaker');
INSERT INTO staff (staffID, staffName, staffIC, staffGender, staffContact, staffPosition) VALUES ('S8', 'Aisyah binti Aiman', '021111-09-4766' , 'F', '60196547894', 'AnimalCaretaker');

-- Insert data into task table
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T1', 'Feeding and Watering', 'Providing animals with appropriate food and fresh water daily.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T2', 'Grooming', 'Performing tasks like bathing, brushing, and nail trimming.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T3', 'Enrichement Activities', 'Providing playtime to support mental wellbeing of animals.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T4', 'Adoption Support', 'Interacting with potential adopters, providing information about animals, and facilitating the adoption process.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T5', 'Record Tracking', 'Maintaining accurate records of each animals health, behavior, and care.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T6', 'Health Monitoring', 'Observing animals for signs of illness, injury, or behavioral changes, and provide treatment if needed.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T7', 'Quarantine Monitoring', 'Supervising animals in quarantine for illness.');
INSERT INTO task (taskID, taskName, taskDescription) VALUES ('T8', 'Cleaning', 'Maintaining clean and sanitary living spaces for the animals, including kennels, cages, and common areas.');

-- Insert data into staff_duty table
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D01', 'T1', 'S1', 'A05', TO_DATE('01-JAN-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D02', 'T1', 'S3', 'A07', TO_DATE('05-JAN-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D03', 'T1', 'S1', 'A01', TO_DATE('15-JAN-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D04', 'T2', 'S7', 'A03', TO_DATE('10-FEB-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D05', 'T2', 'S8', 'A08', TO_DATE('14-FEB-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D06', 'T2', 'S7', 'A13', TO_DATE('15-FEB-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D07', 'T4', 'S5', 'A11', TO_DATE('15-FEB-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D08', 'T3', 'S4', 'A16', TO_DATE('26-MAR-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D09', 'T5', 'S4', 'A02', TO_DATE('25-APR-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D10', 'T6', 'S2', 'A04', TO_DATE('14-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D11', 'T6', 'S2', 'A06', TO_DATE('12-JUN-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D12', 'T7', 'S6', 'A09', TO_DATE('13-JUN-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D13', 'T8', 'S3', 'A10', TO_DATE('14-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D14', 'T7', 'S6', 'A12', TO_DATE('15-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO staff_duty (dutyID, taskID, staffID, animalID, dutyDate) VALUES ('D15', 'T8', 'S8', 'A14', TO_DATE('17-JUL-2024', 'DD-MON-YYYY'));

-- Insert data into adopter table
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD1', 'Lim Wei Ling', '60123456789', 'weiling.lim@gmail.com', '12, Jalan SS2, Petaling Jaya, 47100, Selangor');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD2', 'Mohd Azmi', '60198765432', 'azmi.m@gmail.com', '30, Taman Seri, Ipoh, 51700, Perak');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD3', 'Chong Pei Pei', '60127654321', 'peipei_chong@yahoo.com', '88, Taman Molek, 63500, Johor Bahru');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD4', 'Raj Kumar', '60134567890', 'rajkumar@hotmail.com', '51, Jalan Pasar, Georgetown, 82100, Penang');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD5', 'Tan Mei Lin', '60166543210', 'meilin.tan@gmail.com', '25, Bandar Baru, 21300, Kuantan');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD6', 'Nur Aisyah', '60183332222', 'aisyah.nur@gmail.com', '79, Taman Universiti, 43100, Selangor');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD7', 'David Chong', '60191234567', 'dchong@outlook.com', '100, Jalan Melor, 42100, Melaka');
INSERT INTO adopter (adopterID, adopterName, adopterContact, adopterEmail, adopterAddress) VALUES ('AD8', 'Siti Zulaikha', '60188776655', 'zulaikha.siti@gmail.com', '63, Taman Impian, 71200, Seremban');

-- Insert data into adoption table
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP1', 'A01', 'AD1', TO_DATE('8-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP2', 'A02', 'AD2', TO_DATE('14-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP3', 'A03', 'AD3', TO_DATE('14-APR-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP4', 'A04', 'AD4', TO_DATE('04-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP5', 'A05', 'AD5', TO_DATE('08-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP6', 'A06', 'AD6', TO_DATE('03-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP7', 'A07', 'AD7', TO_DATE('05-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO adoption (adoptionID, animalID, adopterID, adoptionDate) VALUES ('AP8', 'A08', 'AD8', TO_DATE('02-JUL-2025', 'DD-MON-YYYY'));

-- Insert data into veterinary table
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V1', 'S2', 'A04', 'Vaccinated for rabies');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V2', 'S2', 'A09', 'Treated for minor skin rash');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V3', 'S2', 'A01', 'Neutered and microchipped');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V4', 'S2', 'A17', 'Deworming treatment');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V5', 'S2', 'A08', 'Antibiotic course completed');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V6', 'S2', 'A03', 'Dental cleaning performed');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V7', 'S2', 'A12', 'Surgery for broken leg');
INSERT INTO veterinary (veterinaryID, staffID, animalID, treatmentDescription) VALUES ('V8', 'S2', 'A06', 'Eye infection treated');

-- Insert data into donor table
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN1', 'Lee Hock Seng', '60187778888');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN2', 'Marina Lim', '60187775555');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN3', 'Tan Sri Lim', '60182223333');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN4', 'Noraini Bakar', '60189998888');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN5', 'Koh Ah Lian', '60186667777');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN6', 'Jason Goh', '60185556666');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN7', 'Adrian Choong', '60184445555');
INSERT INTO donor (donorID, donorName, donorContact) VALUES ('DN8', 'Meera Devi', '60183334444');

-- Insert data into donation table
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO1', 'DN1', 'S6', 'Pet food - 50kg', TO_DATE('06-MAR-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO2', 'DN2', 'S5', 'Cleaning supplies', TO_DATE('18-APR-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO3', 'DN3', 'S4', 'Donation RM1000', TO_DATE('13-JUN-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO4', 'DN4', 'S6', 'Blankets and towels', TO_DATE('01-SEP-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO5', 'DN5', 'S4', 'Toys and chewables', TO_DATE('16-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO6', 'DN6', 'S3', 'Vaccines for puppies', TO_DATE('02-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO7', 'DN7', 'S7', 'Leashes and collars', TO_DATE('30-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO donation (donationID, donorID, staffID, donationItem, donationDate) VALUES ('DO8', 'DN8', 'S8', 'Pet grooming kits', TO_DATE('25-DEC-2024', 'DD-MON-YYYY'));

-- Insert data into volunteer table
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V01', 'Hannah Wong', 'F', '60173334444');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V02', 'Azlan Othman', 'M', '60172225555');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V03', 'Lily Tan', 'F', '60174446666');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V04', 'Samuel Lee', 'M', '60175557777');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V05', 'Nurul Izzati', 'F', '60176668888');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V06', 'Marcus Goh', 'M', '60177779999');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V07', 'Puteri Aishah', 'F', '60178880000');
INSERT INTO volunteer (volunteerID, volunteerName, volunteerGender, volunteerContact) VALUES ('V08', 'Daniel Ho', 'M', '60179991111');

-- Insert data into volunteer_duty table
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD1', 'V01', 'T1', 'S1', 'A01', TO_DATE('01-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD2', 'V02', 'T2', 'S3', 'A02', TO_DATE('02-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD3', 'V03', 'T3', 'S5', 'A03', TO_DATE('03-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD4', 'V04', 'T4', 'S4', 'A04', TO_DATE('04-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD5', 'V05', 'T5', 'S6', 'A05', TO_DATE('05-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD6', 'V06', 'T6', 'S2', 'A06', TO_DATE('06-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD7', 'V07', 'T7', 'S7', 'A07', TO_DATE('07-JUL-2024', 'DD-MON-YYYY'));
INSERT INTO volunteer_duty (dutyID, volunteerID, taskID, supervisorID, animalID, dutyDate) VALUES ('VD8', 'V08', 'T8', 'S8', 'A08', TO_DATE('08-JUL-2024', 'DD-MON-YYYY'));


-- Display category table
SELECT * FROM category;

-- Display animal table
SELECT * FROM animal;

-- Display animal_category table
SELECT * FROM animal_category;

-- Display staff table
SELECT * FROM staff;

-- Display task table
SELECT * FROM task;

-- Display staff_duty table
SELECT * FROM staff_duty;

-- Display adopter table
SELECT * FROM adopter;

-- Display adoption table
SELECT * FROM adoption;

-- Display veterinary table
SELECT * FROM veterinary;

-- Display donor table
SELECT * FROM donor;

-- Display donotion table
SELECT * FROM donation;

-- Display volunteer table
SELECT * FROM volunteer;

-- Display volunteer_duty table
SELECT * FROM volunteer_duty;

--a. A query that requires an outer join:
--List all animals and any associated adoption information, including adopter name if adopted
SELECT a.animalID, a.animalName, ad.adoptionDate, adp.adopterName
FROM animal a
LEFT OUTER JOIN adoption ad ON a.animalID = ad.animalID
LEFT OUTER JOIN adopter adp ON ad.adopterID = adp.adopterID
ORDER BY a.animalID;

--b. A minimum 4 tables join with a group by function query:
--Count how many duties each staff has supervised for volunteers, including task name and number of duties.
SELECT s.staffName,t.taskName,COUNT(vd.dutyID) AS dutyCount
FROM volunteer_duty vd
JOIN staff s ON vd.supervisorID = s.staffID
JOIN task t ON vd.taskID = t.taskID
JOIN animal a ON vd.animalID = a.animalID
GROUP BY s.staffName, t.taskName
ORDER BY s.staffName, t.taskName;

--c. A string pattern matching and date function query:
--Find volunteers whose names contain 'ah', and show their duties performed in July 2024.
SELECT v.volunteerName,vd.dutyDate,t.taskName
FROM volunteer v
JOIN volunteer_duty vd ON v.volunteerID = vd.volunteerID
JOIN task t ON vd.taskID = t.taskID
WHERE LOWER(v.volunteerName) LIKE '%ah%'
    AND TO_CHAR(vd.dutyDate, 'MM-YYYY') = '07-2024'
ORDER BY vd.dutyDate;

-- d. A query having both OR and AND. 
--List the staff that conduct health monitoring, record tracking and quarantine monitoring duty between February 2024 to Jun 2024.
SELECT s.staffName, t.taskName, sd.dutyDate
FROM staff s
JOIN staff_duty sd ON s.staffID = sd.staffID
JOIN task t ON sd.taskID = t.taskID
WHERE t.taskID IN (
    SELECT taskID
    FROM task
    WHERE LOWER(taskName) LIKE '%monitoring%' OR LOWER(taskName) LIKE '%tracking%'
)
AND sd.dutyDate BETWEEN TO_DATE('01-FEB-2024','DD-MON-YYYY') AND TO_DATE('30-JUN-2024','DD-MON-YYYY');

--e. A query that consists of at least 2 subqueries. 
--List the animal that is not adopted yet and is in the category of adult cat.
SELECT animalID, animalName, animalSpecies
FROM animal
WHERE animalID NOT IN (
    SELECT animalID
    FROM adoption
)
AND animalID IN (
    SELECT animalID
    FROM animal_category
    WHERE categoryID = 'C2'
);

--f. Answer the following question based on your chosen scenario:
--List the animals that have been in the sanctuary for over a year and have received the most positive health check ratings for health studies
SELECT*
FROM animal
WHERE healthRating = 5 AND intakeDate < TO_DATE('19-JUN-2024','DD-MON-YYYY');