package org.team4.airbnb.reservation;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Embeddable
@Getter
@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Invoice {

	private int pricePerDay;
	private int total;
	private int discount;
	private int cleaningFee;
	private int serviceFee;
	private int vat;

}
