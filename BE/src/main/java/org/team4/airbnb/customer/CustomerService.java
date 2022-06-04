package org.team4.airbnb.customer;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.exception.NoDataFoundCustomerException;

@Service
@RequiredArgsConstructor
public class CustomerService {

	private final CustomerRepository customerRepository;
	private final AccommodationRepository accommodationRepository;

	@Transactional(readOnly = true)
	public void getWishListByCustomerId(Long customerId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new NoDataFoundCustomerException());

		List<Long> accommodationIds = customer.askAccommodationIdsOfwishes();

		List<Accommodation> accommodations = accommodationRepository.findByIdIn(accommodationIds);

	}
}
