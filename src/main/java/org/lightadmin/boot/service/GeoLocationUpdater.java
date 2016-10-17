package org.lightadmin.boot.service;

import java.net.URLEncoder;
import java.util.Arrays;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.lightadmin.boot.domain.Jobseeker;
import org.lightadmin.boot.domain.Recruiter;
import org.lightadmin.boot.repository.JobseekerRepository;
import org.lightadmin.boot.repository.RecruiterRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class GeoLocationUpdater {
	private static final Logger logger = LoggerFactory.getLogger(GeoLocationUpdater.class);

	@Autowired
	private RecruiterRepository recruiterRepository;

	@Autowired
	private JobseekerRepository jobseekerRepository;

	public void updateGeoLocationAsync(Recruiter recruiter) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				updateGeoLocation(recruiter);
			}
		}).start();
	}

	public void updateGeoLocation(Recruiter recruiter) {
		try {
			String url = "https://maps.googleapis.com/maps/api/geocode/json?address="
					+ URLEncoder.encode(getGeocodableAddress(recruiter), "UTF-8")
					+ "&key=AIzaSyAR7Z9uuIcLIDiOp1YNMQc_rm_M9mZ7MYg";

			HttpClient client = HttpClientBuilder.create().build();
			HttpGet get = new HttpGet(url);

			HttpResponse response = client.execute(get);
			logger.info("Response Code : " + response.getStatusLine().getStatusCode());

			JsonParser parser = new JsonParser();
			JsonElement parse = parser.parse(IOUtils.toString(response.getEntity().getContent(), "UTF-8"));
			JsonObject geoResp = parse.getAsJsonObject();
			String status = geoResp.get("status").getAsString();
			if ("Ok".equalsIgnoreCase(status)) {
				JsonObject location = geoResp.get("results").getAsJsonArray().get(0).getAsJsonObject().get("geometry")
						.getAsJsonObject().get("location").getAsJsonObject();
				recruiter.setLat(location.get("lat").getAsDouble());
				recruiter.setLng(location.get("lng").getAsDouble());
				recruiterRepository.save(recruiter);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getGeocodableAddress(Recruiter recruiter) {
		StringBuffer sb = new StringBuffer();
		if (recruiter.getLine1() != null && !recruiter.getLine1().isEmpty()) {
			Arrays.stream(recruiter.getLine1().trim().split(",")).forEach(w -> {
				Arrays.stream(w.split(" ")).forEach(s -> {
					sb.append("+");
					sb.append(s);
				});
			});
		}
		if (recruiter.getLine2() != null && !recruiter.getLine1().isEmpty()) {
			Arrays.stream(recruiter.getLine2().trim().split(",")).forEach(w -> {
				Arrays.stream(w.split(" ")).forEach(s -> {
					sb.append("+");
					sb.append(s);
				});
			});
		}
		if (recruiter.getCity() != null) {
			sb.append("+");
			sb.append(recruiter.getCity().getName());
		}
		if (recruiter.getPinCode() != null && !recruiter.getPinCode().isEmpty()) {
			sb.append("+");
			sb.append(recruiter.getPinCode());
		}
		if (recruiter.getState() != null) {
			sb.append("+");
			sb.append(recruiter.getState().getName());
		}
		if (recruiter.getCountry() != null) {
			sb.append("+");
			sb.append(recruiter.getCountry().getName());
		}
		String geocodedString = sb.toString();
		logger.info(geocodedString);
		return geocodedString;
	}

	public void updateGeoLocationAsync(Jobseeker jobseeker) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				updateGeoLocation(jobseeker);
			}
		}).start();
	}

	public void updateGeoLocation(Jobseeker jobseeker) {
		try {
			String url = "https://maps.googleapis.com/maps/api/geocode/json?address="
					+ URLEncoder.encode(getGeocodableAddress(jobseeker), "UTF-8")
					+ "&key=AIzaSyAR7Z9uuIcLIDiOp1YNMQc_rm_M9mZ7MYg";

			HttpClient client = HttpClientBuilder.create().build();
			HttpGet get = new HttpGet(url);

			HttpResponse response = client.execute(get);
			logger.info("Response Code : " + response.getStatusLine().getStatusCode());

			JsonParser parser = new JsonParser();
			JsonElement parse = parser.parse(IOUtils.toString(response.getEntity().getContent(), "UTF-8"));
			JsonObject geoResp = parse.getAsJsonObject();
			String status = geoResp.get("status").getAsString();
			if ("Ok".equalsIgnoreCase(status)) {
				JsonObject location = geoResp.get("results").getAsJsonArray().get(0).getAsJsonObject().get("geometry")
						.getAsJsonObject().get("location").getAsJsonObject();
				jobseeker.setLat(location.get("lat").getAsDouble());
				jobseeker.setLng(location.get("lng").getAsDouble());
				jobseekerRepository.save(jobseeker);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getGeocodableAddress(Jobseeker jobseeker) {
		StringBuffer sb = new StringBuffer();
		if (jobseeker.getLine1() != null && !jobseeker.getLine1().isEmpty()) {
			Arrays.stream(jobseeker.getLine1().trim().split(",")).forEach(w -> {
				Arrays.stream(w.split(" ")).forEach(s -> {
					sb.append("+");
					sb.append(s);
				});
			});
		}
		if (jobseeker.getLine2() != null && !jobseeker.getLine1().isEmpty()) {
			Arrays.stream(jobseeker.getLine2().trim().split(",")).forEach(w -> {
				Arrays.stream(w.split(" ")).forEach(s -> {
					sb.append("+");
					sb.append(s);
				});
			});
		}
		if (jobseeker.getCity() != null) {
			sb.append("+");
			sb.append(jobseeker.getCity().getName());
		}
		if (jobseeker.getPinCode() != null && !jobseeker.getPinCode().isEmpty()) {
			sb.append("+");
			sb.append(jobseeker.getPinCode());
		}
		if (jobseeker.getState() != null) {
			sb.append("+");
			sb.append(jobseeker.getState().getName());
		}
		if (jobseeker.getCountry() != null) {
			sb.append("+");
			sb.append(jobseeker.getCountry().getName());
		}
		String geocodedString = sb.toString();
		logger.info(geocodedString);
		return geocodedString;
	}
}
