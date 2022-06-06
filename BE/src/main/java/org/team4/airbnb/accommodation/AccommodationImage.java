package org.team4.airbnb.accommodation;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import lombok.Getter;

@Entity
@Getter
public class AccommodationImage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "accommodation_image_id")
	private Long id;

	private String url;

	private int imageSeq;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;

	public List<String> offerImagesUrls(List<AccommodationImage> accommodationImages) {
		List<String> imagesUrls = new ArrayList<>();
		for (AccommodationImage accommodationImage : accommodationImages) {
			imagesUrls.add(accommodationImage.url);
		}
		return imagesUrls;
	}
}
