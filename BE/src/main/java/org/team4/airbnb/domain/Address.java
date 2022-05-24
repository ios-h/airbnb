package org.team4.airbnb.domain;

import javax.persistence.Embeddable;
import javax.persistence.Entity;

@Embeddable
public class Address {

	private String country;
	private String city;
	private String gu;
}
