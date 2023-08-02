Feature: Employee Post Functionality

	@smoke7
  Scenario: Retrive employee by id
    * def endpoint = 'https://hr-sit.noortecktraining.com/employee/one'
    * def result = call read('classpath:com/noorteck/qa/karateApi/features/US4Part1.feature@createNewEmp')
    * def emp_id = result.response.id 
    * print result.response
    * print result.response.id
    * print result.response.message
    * print result.token
    #Given params {id: '#(result.response.id)'}
    Given params {id: '#(emp_id)'}
    And header Authorization = result.token
    And url endpoint
    When method GET
    * print response
    Then status 200



# we are trying to call another feature file scenario 



