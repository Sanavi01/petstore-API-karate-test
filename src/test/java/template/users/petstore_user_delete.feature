Feature: Petstore User - Delete

  Background:
    * url petstoreBaseUrl
    * def createUserPayload = read('classpath:data/users/create-user-request.json')

  @regression @users
  Scenario: Delete existing user
    Given path 'user'
    And request createUserPayload
    When method post
    Then status 200
    And match response == read('classpath:schemas/users/user-response.schema.json')

    Given path 'user', createUserPayload.username
    When method delete
    Then status 200
    And match response == read('classpath:schemas/users/user-response.schema.json')
    And match response.code == 200
    And match response.type == 'unknown'
    And match response.message == createUserPayload.username