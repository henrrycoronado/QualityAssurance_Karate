@users
Feature: User API tests

  Background:
    * url baseUrl
    * header Authorization = authToken
    * def userID = 0
    * def userName = ''
    * def userEmail = ''

  @create_user
  Scenario: Create a new user
    Given path 'users'
    And request { "name": "Juan Carlos Justiniano Mendez", "gender": "male", "email": "carlitus@gmail.com", "status": "active" }
    When method POST
    Then status 201
    And match response.name != ''
    And match response.email != ''
    And match response.status == 'active'
    * def userID = response.id
    * def userName = response.name
    * def userEmail = response.email
    * print 'User created with ID:', userID, 'and name:', userName

  @list_users
  Scenario: List all users
    Given path 'users'
    When method GET
    Then status 200
    And match response != null
    And match each response !null
    And match response[0].id == '#number'

  @update_user
  Scenario: Update a user
    * print 'Updating user with ID:', userID
    Given path 'users', userID
    And request { "name": "Carlos Juan Justiniano Mendez", "email": "juanitus@gmail.com" }
    When method PATCH
    Then status 200
    And match response.id == userID
    And match response.name != userName
    And match response.email != userEmail

  @delete_user
  Scenario: Delete a user
    * print 'Deleting user with ID:', userID
    Given path 'users', userID
    When method DELETE
    Then status 204