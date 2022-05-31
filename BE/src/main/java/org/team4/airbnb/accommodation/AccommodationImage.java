package org.team4.airbnb.accommodation;

import javax.persistence.*;

@Entity
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
}
