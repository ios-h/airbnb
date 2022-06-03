package org.team4.airbnb.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class TargetArea {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "target_area_id")
	private Long id;

	private String address;

	private Geolocation geolocation;
}
