@posts
Feature: Post API tests

  Background:
    * url baseUrl
    * header Authorization = authToken
    * def userID = 0
    * def postID = 0

  @create_user_and_post
  Scenario: Create a new user and a post
    # Create a user first
    Given path 'users'
    And request { "name": "Test User for Posts", "gender": "male", "email": "posts_test_user@gmail.com", "status": "active" }
    When method POST
    Then status 201
    * def userID = response.id
    * print 'Created user with ID:', userID

    # Now create a post using the new user ID
    Given path 'users', userID, 'posts'
    And request { "title": "Creacion de un post random", "body": "random random random random" }
    When method POST
    Then status 201
    And match response.title != ''
    And match response.body != ''
    And match response.user_id == userID
    * def postID = response.id
    * print 'Created post with ID:', postID

  @get_posts
  Scenario: Get all posts for the user
    # This scenario depends on the previous one.
    Given path 'users', userID, 'posts'
    When method GET
    Then status 200
    And match response != null
    And match each response !null
    And match response[0].user_id == userID