Feature: Petstore User - Update

  Background:
    * url petstoreBaseUrl
    * def createUserPayload = read('classpath:data/users/create-user-request.json')
    * def updateUserPayload = read('classpath:data/users/update-user-request.json')

  @regression @users
  Scenario: Update existing user
    Given path 'user'
    And request createUserPayload
    When method post
    Then status 200
    And match response == read('classpath:schemas/users/user-response.schema.json')

    Given path 'user', createUserPayload.username
    And request updateUserPayload
    When method put
    Then status 200
    And match response == read('classpath:schemas/users/user-response.schema.json')
    And match response.code == 200
    And match response.type == 'unknown'
    And match response.message == '1001'
