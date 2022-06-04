package org.team4.airbnb.customer.dto;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.team4.airbnb.accommodation.Accommodation;
import org.team4.airbnb.accommodation.AccommodationImage;

@RequiredArgsConstructor
@Getter
public class AccommodationForWishListResponse {

	private final List<Element> data;

	@Getter
	private static class Element {
		private final Long accommodationId;
		private final String name;
		private final Integer price;
		private final List<String> accommodationImages;
		//		private final Review review;
		private final Long wishId;
		private final Boolean isWish;

		Element(Accommodation accommodation, Long wishId) {
			this.accommodationId = accommodation.getId();
			this.name = accommodation.getName();
			this.price = accommodation.getPrice();
			this.accommodationImages = accommodation.getAccommodationImages()
				.stream()
				.map(AccommodationImage::getUrl)
				.collect(Collectors.toList());
			this.wishId = wishId;
			this.isWish = true;
		}
	}

	public static AccommodationForWishListResponse from(List<Accommodation> accommodations,
		List<Long> wishIds) {

		List<Element> elements = IntStream.range(0, wishIds.size())
			.mapToObj(i -> new Element(accommodations.get(i), wishIds.get(i)))
			.collect(Collectors.toList());

		return new AccommodationForWishListResponse(elements);
	}
}
