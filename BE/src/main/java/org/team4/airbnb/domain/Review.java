package org.team4.airbnb.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Review {

	@Id
	@GeneratedValue
	@Column(name = "review_id")
	private Long id;

	private Integer score;

	private String comment;

	@ManyToOne
	@JoinColumn(name = "accommodation_id")
	private Accommodation accomodation;
}
