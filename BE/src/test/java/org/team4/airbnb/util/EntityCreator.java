package org.team4.airbnb.util;

import java.util.ArrayList;
import java.util.List;
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

	public static List<Wish> create3Wishes(CustomerRepository customerRepository,
		AccommodationRepository accommodationRepository) {
		Customer customer = customerRepository.findFirstBy();
		List<Accommodation> accommodations = accommodationRepository.findTop3ByOrderById();

		List<Wish> wishes = new ArrayList<>();
		for (int i = 0; i < 3; i++) {
			Wish wish = new Wish();
			wish.setCustomer(customer);
			wish.setAccommodationId(accommodations.get(i).getId());

			wishes.add(wish);
		}

		return wishes;
	}
}
