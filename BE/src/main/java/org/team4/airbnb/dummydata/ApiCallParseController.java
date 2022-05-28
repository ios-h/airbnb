package org.team4.airbnb.dummydata;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URLEncoder;

import lombok.RequiredArgsConstructor;
import org.apache.tomcat.util.json.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@PropertySource(value = "classpath:api.properties", ignoreResourceNotFound = true)
@RequiredArgsConstructor
public class ApiCallParseController {

	private final AccommodationBulkInsertRepository accommodationBulkInsertRepository;

	@Value("${accommodation.api.serviceKey}")
	private String serviceKey;

	@GetMapping("/dummydata")
	public String getDummyData()
		throws ParseException, UnsupportedEncodingException, JsonProcessingException {
		String url = prepareRequestUrl();
		ResponseEntity<String> responseEntity = callApi(url);
		String xmlResponse = responseEntity.getBody();

		StayingGeneralHotel resultOfDeserialize = parseXmlString(xmlResponse);
		accommodationBulkInsertRepository.bulkInsertAccommodations(resultOfDeserialize.getRow());

		return "accommodation data insert success";
	}

	private String prepareRequestUrl() throws UnsupportedEncodingException {
		String url = "";

		StringBuilder urlBuilder = new StringBuilder("https://openapi.gg.go.kr/StayingGeneralHotel"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("KEY", "UTF-8") + "=" + serviceKey); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("Type", "UTF-8") + "=" + URLEncoder.encode( "xml","UTF-8")); /*호출 문서(xml, json)*/
		urlBuilder.append("&" + URLEncoder.encode("pSize", "UTF-8") + "=" + URLEncoder.encode("600","UTF-8")); /*페이지 크기(기본100)*/
		urlBuilder.append("&" + URLEncoder.encode("pIndex", "UTF-8") + "=" + URLEncoder.encode("1","UTF-8")); /*시작 페이지(기본1)*/

		url = urlBuilder.toString();
		return url;
	}

	private ResponseEntity<String> callApi(String url) {
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
//		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setContentType(MediaType.TEXT_XML);
		HttpEntity<HttpHeaders> entity = new HttpEntity<>(headers);

		ResponseEntity<String> response = restTemplate.exchange(URI.create(url), HttpMethod.GET,
			entity, String.class);

		return response;
	}

	private StayingGeneralHotel parseXmlString(String xmlResponse) throws JsonProcessingException {
		XmlMapper xmlMapper = new XmlMapper();
		StayingGeneralHotel resultOfDeserialize = xmlMapper.readValue(xmlResponse, StayingGeneralHotel.class);

		return resultOfDeserialize;
	}
}
