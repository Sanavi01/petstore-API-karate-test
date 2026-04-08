Feature: Petstore User - Get Updated User

  Background:
    * url petstoreBaseUrl
    * def createUserPayload = read('classpath:data/users/create-user-request.json')
    * def updateUserPayload = read('classpath:data/users/update-user-request.json')

  @smoke @users
  Scenario: Get updated user by username
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

    Given path 'user', createUserPayload.username
    When method get
    Then status 200
    And match response == read('classpath:schemas/users/user-detail-response.schema.json')
    And match response.firstName == updateUserPayload.firstName
    And match response.email == updateUserPayload.email
    And match response.username == createUserPayload.username