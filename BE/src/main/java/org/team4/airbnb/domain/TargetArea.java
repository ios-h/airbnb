package org.team4.airbnb.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class TargetArea {

	@Id
	@GeneratedValue
	@Column(name = "target_area_id")
	private Long id;

	private Address address;

	private Geolocation geolocation;
}
