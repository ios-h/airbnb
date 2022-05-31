package org.team4.airbnb.dummydata;

import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlRootElement;
import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JacksonXmlRootElement
public class StayingGeneralHotel {
	private List<String> head;

	@JacksonXmlElementWrapper(useWrapping = false)
	private List<AccommodationDummy> row;
}
