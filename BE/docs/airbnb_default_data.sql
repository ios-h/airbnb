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
