@todos
Feature: Todos API tests

  Background:
    * url baseUrl
    * header Authorization = authToken
    * def userID = 0
    * def todoID = 0

  @create_user_and_todo
  Scenario: Create a user and a new todo
    # Create a user first
    Given path 'users'
    And request { "name": "Test User for Todos", "gender": "male", "email": "todos_test_user@gmail.com", "status": "active" }
    When method POST
    Then status 201
    * def userID = response.id
    * print 'Created user with ID:', userID

    # Now create a todo using the new user ID
    Given path 'users', userID, 'todos'
    And request { "title": "task 1", "status": "pending" }
    When method POST
    Then status 201
    And match response.title != ''
    And match response.status == 'pending'
    And match response.user_id == userID
    * def todoID = response.id
    * print 'Created todo with ID:', todoID

  @get_todos
  Scenario: Get all todos for the user
    # This scenario depends on the previous one.
    Given path 'users', userID, 'todos'
    When method GET
    Then status 200
    And match response != null
    And match each response !null
    And match response[0].user_id == userID