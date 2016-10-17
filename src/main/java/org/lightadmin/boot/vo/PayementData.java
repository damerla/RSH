package org.lightadmin.boot.vo;

public class PayementData {

	private String postUrl;
	private String title;
	private String pricing;
	private String[] advs;
	private String referer;

	public String getPostUrl() {
		return postUrl;
	}

	public void setPostUrl(String postUrl) {
		this.postUrl = postUrl;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPricing() {
		return pricing;
	}

	public void setPricing(String pricing) {
		this.pricing = pricing;
	}

	public String[] getAdvs() {
		return advs;
	}

	public void setAdvs(String[] list) {
		this.advs = list;
	}

	public String getReferer() {
		return referer;
	}

	public void setReferer(String referer) {
		this.referer = referer;
	}
}
