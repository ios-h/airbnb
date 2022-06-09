package org.team4.airbnb.customer;

import lombok.RequiredArgsConstructor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team4.airbnb.customer.dto.WishRequest;
import org.team4.airbnb.customer.dto.WishResponse;
import org.team4.airbnb.exception.CustomerNotFoundException;
import org.team4.airbnb.exception.WishNotFoundException;

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
		Long resultCount = wishRepository.deleteByCustomerIdAndAccommodationId(customer.getId(),
			wish.getAccommodationId());

		if (resultCount == 0) {
			throw new WishNotFoundException();
		}

		return new WishResponse(true);
	}

	@Transactional
	public WishResponse deleteWishInWishList(Long wishId, Long customerId) {
		Customer customer = customerRepository.findById(customerId)
			.orElseThrow(() -> new CustomerNotFoundException());

		try {
			wishRepository.deleteById(wishId);
		}catch(EmptyResultDataAccessException e) {
			throw new WishNotFoundException();
		}

		return new WishResponse(true);
	}
}
