package org.team4.airbnb.util;

import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.wish.Wish;

public class EntityCreator {

	public static Wish createWish(CustomerRepository customerRepository,
		AccommodationRepository accommodationRepository) {
		Customer customer = customerRepository.findFirstBy();
		Accommodation accommodation = accommodationRepository.findFirstBy();

		Wish wish = new Wish();
		wish.setCustomer(customer);
		wish.setAccommodationId(accommodation.getId());

		return wish;
	}
}
