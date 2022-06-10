package org.team4.airbnb.accommodation;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import javax.persistence.Embeddable;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;

@Embeddable
public class AccommodationImages {

	@OneToMany(mappedBy = "accommodation", fetch = FetchType.LAZY)
	@OrderBy("imageSeq asc")
	private List<AccommodationImage> elements = new ArrayList<>();

	public List<String> getUrls() {
		return elements.stream()
			.map(AccommodationImage::getUrl)
			.collect(Collectors.toUnmodifiableList());
	}
}
