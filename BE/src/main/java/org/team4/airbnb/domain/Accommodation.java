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
public class Accommodation extends BaseCreated{

	@Id
	@GeneratedValue
	@Column(name = "accommodation_id")
	private Long id;

	private String name;

	private int price;

	@Embedded
	private Geolocation geolocation;

	@Embedded
	private Address address;

	@Column(name = "accommodation_type")
	private String type;

	private String hostName;

	private String description;

	private String primaryImageUrl;

	@Embedded
	private RoomFeature roomFeature;

	@OneToMany(mappedBy = "accommodation")
	private List<SecondaryImage> secondaryImages = new ArrayList<>();

	@OneToMany(mappedBy = "accommodation")
	private List<Review> reviews = new ArrayList<>();

	@OneToMany(mappedBy = "accommodation")
	private List<Reservation> reservations = new ArrayList<>();

	@OneToMany(mappedBy = "accommodation")
	private List<Wish> wishes = new ArrayList<>();

}
