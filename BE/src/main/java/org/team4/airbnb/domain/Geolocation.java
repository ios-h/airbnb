package org.team4.airbnb.domain;

import javax.persistence.Embeddable;

@Embeddable
public class Geolocation {

	private double longitude;
	private double latitude;
}
