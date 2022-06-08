package org.team4.airbnb.util;

import java.util.ArrayList;
import java.util.List;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.customer.Wish;

public class EntityCreator {

	private static String userIdForTest = "test";
	private static int listSize = 3;

	public static Wish 한개의_Wish_생성_요청(CustomerRepository customerRepository,
		AccommodationRepository accommodationRepository) {

		Customer savedCustomer = createCustomer(customerRepository);
		Accommodation accommodation = accommodationRepository.findFirstBy();

		Wish wish = Wish.from(savedCustomer, accommodation.getId());

		return wish;
	}

	public static List<Wish> 세개의_Wish_생성_요청(CustomerRepository customerRepository,
		AccommodationRepository accommodationRepository) {

		Customer customer = createCustomer(customerRepository);
		List<Accommodation> accommodations = accommodationRepository.findTop3ByOrderById();

		List<Wish> wishes = new ArrayList<>();
		for (int i = 0; i < listSize; i++) {
			Wish wish = Wish.from(customer, accommodations.get(i).getId());

			wishes.add(wish);
		}

		return wishes;
	}

	private static Customer createCustomer(CustomerRepository customerRepository) {
		Customer customer = Customer.of(userIdForTest);
		Customer savedCustomer = customerRepository.save(customer);

		return savedCustomer;
	}
}
