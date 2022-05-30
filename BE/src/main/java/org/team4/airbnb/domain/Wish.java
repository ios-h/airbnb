package org.team4.airbnb.domain;

import javax.persistence.*;

@Entity
public class Wish extends BaseCreated {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "wish_id")
	private Long id;

	@ManyToOne
	@JoinColumn(name = "customer_id")
	private Customer customer;

	@ManyToOne
	@JoinColumn(name = "accommodation_id")
	private Accommodation accommodation;
}
