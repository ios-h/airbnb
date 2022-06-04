package org.team4.airbnb.accommodation.dto;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
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
		List<Element> elements = new ArrayList<>();
		for (int i = 0; i < wishIds.size(); i++) {
			Element element = new Element(accommodations.get(i), wishIds.get(i));
			elements.add(element);
		}
		return new AccommodationForWishListResponse(elements);
	}

}
