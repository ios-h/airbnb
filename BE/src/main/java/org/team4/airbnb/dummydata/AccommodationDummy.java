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
}
