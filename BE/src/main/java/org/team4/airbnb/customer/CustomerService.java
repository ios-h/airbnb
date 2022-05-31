package org.team4.airbnb.customer;

import java.util.ArrayList;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationRepository;
import org.team4.airbnb.exception.CustomException;
import org.team4.airbnb.exception.ErrorCode;
import org.team4.airbnb.wish.Wish;

@Service
@RequiredArgsConstructor
public class CustomerService {

	private final CustomerRepository customerRepository;
	private final AccommodationRepository accommodationRepository;

	public void getWishListByCustomerId(Long customerId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new CustomException(ErrorCode.NO_DATA_FOUND_CUSTOMER));

		List<Wish> wishes = customer.getWishes();
		List<Long> accommodationIds = new ArrayList<>();
		for (Wish wish : wishes) {
			accommodationIds.add(wish.getId());
		}

		List<Accommodation> accommodations = accommodationRepository.findByIdIn(accommodationIds);

	}
}
