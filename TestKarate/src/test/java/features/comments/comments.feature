@comments
Feature: Comments API tests

  Background:
    * url baseUrl
    * header Authorization = authToken
    * def userID = 0
    * def postID = 0
    * def commentID = 0

  @create_user_post_and_comment
  Scenario: Create a user, a post, and a comment
    # Create a user first
    Given path 'users'
    And request { "name": "Test User for Comments", "gender": "male", "email": "comments_test_user@gmail.com", "status": "active" }
    When method POST
    Then status 201
    * def userID = response.id
    * print 'Created user with ID:', userID

    # Now create a post using the new user ID
    Given path 'users', userID, 'posts'
    And request { "title": "Post for comments test", "body": "This post is for creating comments." }
    When method POST
    Then status 201
    * def postID = response.id
    * print 'Created post with ID:', postID

    # Finally, create a comment for the new post
    Given path 'posts', postID, 'comments'
    And request { "name": "henrry coronado", "email": "henrry@gmail.com", "body": "holaaa" }
    When method POST
    Then status 201
    And match response.name != ''
    And match response.email != ''
    And match response.body != ''
    * def commentID = response.id
    * print 'Created comment with ID:', commentID

  @get_comments
  Scenario: Get all comments for the post
    # This scenario depends on the previous one.
    Given path 'posts', postID, 'comments'
    When method GET
    Then status 200
    And match response != null
    And match each response !null
    And match response[0].post_id == postID