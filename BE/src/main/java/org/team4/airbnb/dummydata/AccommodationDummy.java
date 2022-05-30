package org.team4.airbnb.dummydata;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class AccommodationDummy {

	@JsonProperty("BIZPLC_NM")
	private String name;
	@JsonProperty("REFINE_LOTNO_ADDR")
	private String address;
	@JsonProperty("SANITTN_BIZCOND_NM")
	private String type;
	@JsonProperty("REFINE_WGS84_LOGT")
	private double longitude;
	@JsonProperty("REFINE_WGS84_LAT")
	private double latitude;

	private int numberOfRoom;
	private int numberOfBed;
	private int numberOfBathroom;
	private int maxGuest;
	private int price;

	private String hostName;
	private String description;

	public AccommodationDummy() {
		numberOfRoom = getRandomNumber(10, 1);
		numberOfBed = getRandomNumber(10, 1);
		numberOfBathroom = getRandomNumber(10, 1);
		maxGuest = getRandomNumber(10, 1);
		price = getRandomNumber(100_000_000, 15_000);

		hostName = "홍길동";
		description =  "해수욕장 도보 500m, 10분 거리에 위치한 숙소입니다.";
	}

	private int getRandomNumber(int maxNumber, int startNumber) {
		return (int) (Math.random() * maxNumber + startNumber);
	}
}
