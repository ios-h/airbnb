package org.team4.airbnb.dummydata;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class AccommodationBulkInsertRepository {

	private final JdbcTemplate jdbcTemplate;

	public void bulkInsertAccommodations(List<AccommodationDummy> list) {
		String sql = "INSERT INTO accommodation "
			+ "(name,  latitude, longitude, address, accommodation_type,  "
			+ "number_of_room, number_of_bed, number_of_bathroom, "
			+ "price, host_name, description, max_guest) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		int numberOfRoom = getRandomNumber(10, 1);
		int numberOfBed = getRandomNumber(10, 1);
		int numberOfBathroom = getRandomNumber(10, 1);
		int maxGuest = getRandomNumber(10, 1);
		int price = getRandomNumber(100_000_000, 15_000);

		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement stmt, int idx) throws SQLException {
				AccommodationDummy accommodationDummy = list.get(idx);
				stmt.setString(1, accommodationDummy.getName());
				stmt.setDouble(2, accommodationDummy.getLatitude());
				stmt.setDouble(3, accommodationDummy.getLongitude());
				stmt.setString(4, accommodationDummy.getAddress());
				stmt.setString(5, accommodationDummy.getType());
				stmt.setInt(6, numberOfRoom);
				stmt.setInt(7, numberOfBed);
				stmt.setInt(8, numberOfBathroom);
				stmt.setInt(9, price);
				stmt.setString(10, "홍길동");
				stmt.setString(11, "해수욕장 도보 500m, 10분 거리에 위치한 숙소입니다.");
				stmt.setInt(12, maxGuest);

				System.out.println(stmt);
			}

			@Override
			public int getBatchSize() {
				return list.size();
			}
		});
	}

	private int getRandomNumber(int maxNumber, int startNumber) {
		return (int) (Math.random() * maxNumber + startNumber);
	}
}
