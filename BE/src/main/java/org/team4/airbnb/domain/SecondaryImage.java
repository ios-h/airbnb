package org.team4.airbnb.domain;

import javax.persistence.*;

@Entity
public class SecondaryImage {

	@Id
	@GeneratedValue
	@Column(name = "secondary_image_id")
	private Long id;

	private String url;

	@ManyToOne
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;
}
