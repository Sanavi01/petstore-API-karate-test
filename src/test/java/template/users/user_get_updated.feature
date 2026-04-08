Feature: Petstore User - Get Updated User

  Background:
    * def baseUrl = petstoreBaseUrl
    * url baseUrl
    * def createUserPayload = read('classpath:data/users/create-user-request.json')
    * def updateUserPayload = read('classpath:data/users/update-user-request.json')

  @smoke @users
  Scenario: Get updated user by username
    * match createUserPayload == { id: 1001, username: 'user_test_123', firstName: 'Santiago', lastName: 'Test', email: 'test@mail.com', password: '123456', phone: '123456789', userStatus: 1 }
    * match updateUserPayload == { id: 1001, username: 'user_test_123', firstName: 'UpdatedName', lastName: 'Test', email: 'updated@mail.com', password: '123456', phone: '123456789', userStatus: 1 }
    * print 'Create request payload:', createUserPayload
    Given path 'user'
    And request createUserPayload
    When method post
    Then status 200
    * print 'Create response:', response
    And match response == read('classpath:schemas/users/user-response.schema.json')

    * print 'Update request payload:', updateUserPayload
    Given path 'user', createUserPayload.username
    And request updateUserPayload
    When method put
    Then status 200
    * print 'Update response:', response
    And match response == read('classpath:schemas/users/user-response.schema.json')

    Given path 'user', createUserPayload.username
    When method get
    Then status 200
    * print 'Get updated user response:', response
    And match response == read('classpath:schemas/users/user-detail-response.schema.json')
    And match response.firstName == updateUserPayload.firstName
    And match response.email == updateUserPayload.email
    And match response.username == createUserPayload.username