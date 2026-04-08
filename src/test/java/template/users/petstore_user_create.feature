Feature: Petstore User - Create

  Background:
    * url petstoreBaseUrl
    * def createUserPayload = read('classpath:data/users/create-user-request.json')

  @smoke @users
  Scenario: Create user with valid payload
    Given path 'user'
    And request createUserPayload
    When method post
    Then status 200
    And match response == read('classpath:schemas/users/user-response.schema.json')
    And match response.code == 200
    And match response.type == 'unknown'
    And match response.message == '1001'
