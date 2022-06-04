-- -----------------------------------------------------
-- customer
-- -----------------------------------------------------
insert into customer(user_id) values('terry');
insert into customer(user_id) values('sammy');

-- -----------------------------------------------------
-- wishlist
-- -----------------------------------------------------

insert into wish(accommodation_id, customer_id) values(1,1);

-- -----------------------------------------------------
-- reservation
-- -----------------------------------------------------

INSERT INTO reservation(check_in_date, check_out_date, number_of_guest, number_of_infant,
                        price_per_day, total, discount, cleaning_fee, service_fee, vat,
                        accommodation_id, customer_id)
VALUES
    ('2022-03-05', '2022-03-07', 3, 4, 123, 1324, 13, 34, 353, 353, 5, 1),
    ('2022-04-20', '2022-04-25', 1, 0, 234, 2345, 23, 24, 25, 26, 11, 1),
    ('2022-05-11', '2022-05-13', 4, 2, 345, 34556, 34, 34, 34, 35, 16, 2),
    ('2022-06-13', '2022-06-22', 3, 1, 456, 45555, 45, 43, 42, 44, 33, 2);


-- -----------------------------------------------------
-- accommodation_image
-- -----------------------------------------------------

insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,1);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok832',2,1);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,1);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z9L',4,1);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,2);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok833',2,2);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,2);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z10L',4,2);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,3);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok834',2,3);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,3);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z11L',4,3);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,4);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok835',2,4);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,4);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z9L',4,4);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,5);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok836',2,5);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,5);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z10L',4,5);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/rtEuIAh',1,6);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/h6Ok837',2,6);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/GUWrNUJ',3,6);
insert into accommodation_image(url,image_seq,accommodation_id) values('https://imgur.com/a/9CZ7Z11L',4,6);
