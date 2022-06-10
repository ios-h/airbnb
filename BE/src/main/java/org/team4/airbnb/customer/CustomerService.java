package org.team4.airbnb.customer;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.customer.dto.AccommodationForWishListResponse;
import org.team4.airbnb.exception.CustomerNotFoundException;

@Service
@RequiredArgsConstructor
public class CustomerService {

	private final CustomerRepository customerRepository;
	private final AccommodationRepository accommodationRepository;

	@Transactional(readOnly = true)
	public AccommodationForWishListResponse getWishListByCustomerId(Long customerId) {
		Customer customer = retrieveCustomer(customerId);

		List<Long> accommodationIds = customer.askAccommodationIdsOfWishes();
		List<Accommodation> accommodations = accommodationRepository.findAllWithImagesByIdIn(accommodationIds);

		List<Long> wishIds = customer.askWishIdsOfWishes();

		return AccommodationForWishListResponse.from(
			accommodations, wishIds);
	}

	private Customer retrieveCustomer(Long customerId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new CustomerNotFoundException());
		return customer;
	}
}
