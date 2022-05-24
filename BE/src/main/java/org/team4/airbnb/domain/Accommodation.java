package org.team4.airbnb.domain;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Accommodation {

	@Id
	@GeneratedValue
	@Column(name = "accommodation_id")
	private Long id;

	private String name;

	@OneToMany(mappedBy = "accommodation")
	private List<Review> reviews = new ArrayList<>();

	@OneToMany(mappedBy = "accommodation")
	private List<Reservation> reservations = new ArrayList<>();

	private int price;

	@Embedded
	private Address address;

	@Embedded
	private Geolocation geolocation;

	private String type;

	private String hostName;

	@Embedded
	private RoomFeature roomFeature;

	private String description;

}
