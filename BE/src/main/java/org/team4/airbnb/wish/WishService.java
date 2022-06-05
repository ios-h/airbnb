package org.team4.airbnb.wish;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.customer.Customer;
import org.team4.airbnb.customer.CustomerRepository;
import org.team4.airbnb.exception.CustomerNotFoundException;
import org.team4.airbnb.wish.dto.WishRequest;
import org.team4.airbnb.wish.dto.WishResponse;

@Service
@RequiredArgsConstructor
public class WishService {

	private final WishRepository wishRepository;
	private final CustomerRepository customerRepository;

	@Transactional
	public WishResponse addWishList(WishRequest wishRequest) {
		Customer customer = customerRepository.findById(wishRequest.getCustomerId())
			.orElseThrow(() -> new CustomerNotFoundException());

		Wish wish = Wish.from(customer, wishRequest);
		Wish savedWish = wishRepository.save(wish);

		return new WishResponse(true);
	}

	@Transactional
	public WishResponse deleteWishInSearchList(Long customerId, Long AccommodationId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new CustomerNotFoundException());

		Wish wish = Wish.from(customer, AccommodationId);
		wishRepository.deleteByCustomerIdAndAccommodationId(customer.getId(),
			wish.getAccommodationId());

		return new WishResponse(true);
	}

	@Transactional
	public WishResponse deleteWishInWishList(Long wishId, Long customerId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new CustomerNotFoundException());

		wishRepository.deleteById(wishId);

		return new WishResponse(true);
	}
}
