CREATE TABLE "Theatre" (
  "name" varchar PRIMARY KEY,
  "address" varchar,
  "postcode" int CHECK("postcode" BETWEEN 800 AND 9999),
  "capacity" int,
  "description" varchar
);


CREATE TABLE "Customer" (
  "mobile_number" int PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "date_of_birth" date NOT NULL,
  "email_address" varchar
);




CREATE TABLE "Production" (
  "name" varchar PRIMARY KEY,
  "description" varchar,
  "production_date" date NOT NULL,
  "production_seat_cost" float CHECK(production_seat_cost > 0)
  
);

CREATE TABLE "Performance" (
  "performance_number" int PRIMARY KEY,
  "production" varchar ,
  "start_date" date NOT NULL,
  "start_time" time NOT NULL,
  "end_date" date NOT NULL,
  "end_time" time NOT NULL,
  "theatre" varchar,
  CONSTRAINT production_performed FOREIGN KEY ("production") REFERENCES "Production" ("name") ON DELETE CASCADE,
  CONSTRAINT theatre_performed FOREIGN KEY ("theatre") REFERENCES "Theatre" ("name") ON DELETE CASCADE
);



CREATE TABLE "Seat" (
  "seat_no" int PRIMARY KEY,
  "name" varchar,
  "theatre" varchar,
  "views" varchar,
  "comfort_level" int,
  "cost" float CHECK(cost > 0),
  CONSTRAINT theatre_seat FOREIGN KEY ("theatre") REFERENCES "Theatre" ("name") ON DELETE CASCADE
);

CREATE TABLE "Payment_method" (
  "payment_id" varchar PRIMARY KEY
);

CREATE TABLE "Card" (
  "payment_id" varchar,
  "card_number" varchar(16) PRIMARY KEY,
  "cardholder" varchar,
  "expiry_date" date NOT NULL,
  "CVV" int CHECK("CVV" BETWEEN 100 AND 999),
  CONSTRAINT "p_method_card" FOREIGN KEY ("payment_id") REFERENCES "Payment_method" ("payment_id")
);

CREATE TABLE "Gift_Card" (
  "payment_id" varchar ,
  "card_number" varchar(15) PRIMARY KEY,
  "PIN" int,
  CONSTRAINT "p_method_gift" FOREIGN KEY ("payment_id") REFERENCES "Payment_method" ("payment_id")
);

CREATE TABLE "Voucher" (
  "payment_id" varchar,
  "unique_code" varchar PRIMARY KEY,
  "expiry_date" date NOT NULL,
  CONSTRAINT "p_method_voucher" FOREIGN KEY ("payment_id") REFERENCES "Payment_method" ("payment_id")
);

CREATE TABLE "Booking" (
  "book_number" int PRIMARY KEY,
  "theatre_name" varchar ,
  "customer_number" int  ,
  "performance_number" int  ,
  "seat" int NOT NULL,
  "book_date" date NOT NULL,
  "total_cost" float CHECK(total_cost > 0),
  CONSTRAINT "theatre_booked" FOREIGN KEY ("theatre_name") REFERENCES "Theatre" ("name") ON DELETE CASCADE,
  CONSTRAINT "customer_booked" FOREIGN KEY ("customer_number") REFERENCES "Customer" ("mobile_number") ON DELETE CASCADE,
  CONSTRAINT "performer_booked" FOREIGN KEY ("performance_number") REFERENCES "Performance" ("performance_number") ON DELETE CASCADE,
  CONSTRAINT "seat_booked" FOREIGN KEY ("seat") REFERENCES "Seat" ("seat_no")
);

CREATE TABLE "Make" (
  "book_number" int,
  "payment_id" varchar,
  "fee" float,
  CONSTRAINT "make_payment_book_number" FOREIGN KEY ("book_number") REFERENCES "Booking" ("book_number") ON DELETE CASCADE,
  CONSTRAINT "make_payment_payment_id" FOREIGN KEY ("payment_id") REFERENCES "Payment_method" ("payment_id") ON DELETE CASCADE
);




INSERT INTO "Customer" VALUES (0420780507,'LIU','RUIXIAN','1999-04-29','786632711@qq.com');
INSERT INTO "Production" VALUES('Romeo','a love story','1999-01-01',100);
INSERT INTO "Theatre" VALUES('Waterloo','20 Odea ave','2017','200','new theatre');
INSERT INTO "Performance" VALUES(1,'Romeo','2021-4-20','14:20:00','2021-4-20','16:00:00','Waterloo');
INSERT INTO "Seat" VALUES (1,'vip','Waterloo','good',5,100);
INSERT INTO "Payment_method" VALUES('card1');
INSERT INTO "Payment_method" VALUES('gift_card1');
INSERT INTO "Payment_method" VALUES('voucher1');
INSERT INTO "Card" VALUES('card1','1208208820458904','liu','2022-02-02',784);
INSERT INTO "Gift_Card" VALUES('gift_card1','123456874583863',123);
INSERT INTO "Voucher" VALUES('voucher1','125454','2022-01-01');
INSERT INTO "Booking" VALUES(1,'Waterloo',0420780507,1,1,'2021-04-29', 200);
INSERT INTO "Make" VALUES(1,'card1',100);
INSERT INTO "Make" VALUES(1,'gift_card1',100);

