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
	public String name;
	@JsonProperty("REFINE_LOTNO_ADDR")
	public String address;
	@JsonProperty("SANITTN_BIZCOND_NM")
	public String type;
	@JsonProperty("REFINE_WGS84_LOGT")
	public String longitude;
	@JsonProperty("REFINE_WGS84_LAT")
	public String latitude;

}
