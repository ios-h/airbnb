package org.team4.airbnb.accommodation;

import javax.persistence.Embeddable;
import lombok.Getter;

@Embeddable
@Getter
public class RoomFeature {

	private Integer maxGuest;
	private Integer numberOfRoom;
	private Integer numberOfBed;
	private Integer numberOfBathroom;
}
