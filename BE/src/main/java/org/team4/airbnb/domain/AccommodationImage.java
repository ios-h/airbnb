package org.team4.airbnb.domain;

import javax.persistence.*;

@Entity
public class AccommodationImage {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "secondary_image_id")
	private Long id;

	private String url;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;
}
