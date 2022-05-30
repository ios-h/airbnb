package org.team4.airbnb.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "customer_id")
	private Long id;

	private String userId;

	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
	private List<Reservation> reservations = new ArrayList<>();

	@OneToMany(mappedBy = "customer", fetch = FetchType.LAZY)
	private List<Wish> wishes = new ArrayList<>();
}
