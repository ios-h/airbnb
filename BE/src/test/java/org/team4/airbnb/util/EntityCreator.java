package org.team4.airbnb.util;

import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.wish.Wish;

public class EntityCreator {

	public static Wish createWish(CustomerRepository customerRepository, Long customerId,
		Long accommodationId) {
		Wish wish = new Wish();
		wish.setCustomer(customerRepository.findById(customerId).get());
		wish.setAccommodationId(accommodationId);

		return wish;
	}
}
