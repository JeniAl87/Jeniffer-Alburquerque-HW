package steps;

import org.testng.Assert;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;

import static io.restassured.RestAssured.given;

import java.util.HashMap;
import java.util.Map;

public class Steps {
	
	String baseUrl;
	String endpoint;
	String requestBody;
	Map<String, String> headers = new HashMap<String, String>();
	Map<String, String> queryParams = new HashMap<String, String>();
	
	
	Response response;
	String resourceId;
	
	
	@Given("set base url | {string}")
	public void set_base_url(String url) {
		baseUrl = url;
	}

	@Given("set endpoint | {string}")
	public void set_url(String endpoint) {
		if (endpoint.contains(":id"))
			endpoint = endpoint.replace(":id", resourceId);
	    this.endpoint = endpoint;
	}

	@Given("set request body")
	public void set_request_body_create_templates(String body) {
	    requestBody = body;
	}

	@Given("set header | {string} {string}")
	public void set_header(String key, String value) {
	    headers.put(key, value);
	}

	@When("send request | {string}")
	public void send_request(String requestMethod) {
		requestMethod = requestMethod.toLowerCase();
	    
		String uri = baseUrl + endpoint;
		System.out.println(uri);
		
		if (requestMethod.equals("get")) {
			response = given()
							.headers(headers)
							.params(queryParams)
						.when()
							.get(uri)
						.then()
							.extract()
							.response();
		} else if (requestMethod.equals("post")) {
			response = given()
					.headers(headers)
					.params(queryParams)
					.body(requestBody)
				.when()
					.post(uri)
				.then()
					.extract()
					.response();
		} else if (requestMethod.equals("put")) {
			response = given()
					.headers(headers)
					.params(queryParams)
					.body(requestBody)
				.when()
					.put(uri)
				.then()
					.extract()
					.response();
		} else if (requestMethod.equals("patch")) {
			response = given()
					.headers(headers)
					.params(queryParams)
					.body(requestBody)
				.when()
					.patch(uri)
				.then()
					.extract()
					.response();
		} else if (requestMethod.equals("delete")) {
			response = given()
					.body("{}") // if we don't supply empty body, API returns 500
				.when()
					.delete(uri)
				.then()
					.extract()
					.response();
		} else {
			throw new IllegalArgumentException("Invalid request method");
		}
		
		String id = response.prettyPrint();
		resourceId = id;
		
		// Clean-up for the next request
		endpoint = null;
		requestBody = null;
		headers.clear();
		queryParams.clear();
	}

	@Then("verify status | {int}")
	public void status(Integer status) {
		System.out.println("Actual status code: " + response.statusCode());
	    int actStatus = response.statusCode();
	    Assert.assertEquals(actStatus, status);
	    
	    if (status == 200) {
	    	Assert.assertNotEquals(response.prettyPrint(), "NOT_FOUND", "NOT_FOUND return on success status code");
	    }
	}
	
	@Then("verify field from body | {string} {string} {string}")
	public void verify_field_from_body(String jpath, String op, String value) {
		JsonPath jsonPath = response.jsonPath();
		
		if (op.equalsIgnoreCase("contains")) {
			String actual = jsonPath.getString(jpath);
			Assert.assertTrue(actual.contains(value));
		} else if (op.equalsIgnoreCase("equals")) {
			String actual = jsonPath.getString(jpath);
			Assert.assertTrue(actual.equalsIgnoreCase(value));
		} else {
			throw new IllegalArgumentException("Invalid opeartion");
		}
		
	}
	
	@Then("verify body | {string} {string}")
	public void verify_body(String op, String value) {
		String body = response.asString();
		
		if (op.equalsIgnoreCase("contains")) {
			Assert.assertTrue(body.contains(value));
		} else if (op.equalsIgnoreCase("equals")) {
			Assert.assertTrue(body.equalsIgnoreCase(value));
		} else {
			throw new IllegalArgumentException("Invalid opeartion");
		}
	}

}
