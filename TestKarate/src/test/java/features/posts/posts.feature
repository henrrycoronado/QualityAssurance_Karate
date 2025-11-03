@posts
Feature: Post API tests

Background:
    * url baseUrl
    * header Authorization = authToken
    # QUITAMOS las definiciones de userID y postID de aquí

@create_post
Scenario: Create a post for a specific user
    # La variable 'userID' ahora SÓLO existe porque el 'call' del máster se la pasó.
    * print '--- Recibido userID para crear post:', userID
    
    Given path 'users', userID, 'posts'
    And request { "title": "Creacion de un post random", "body": "random random random random" }
    When method POST
    Then status 201
    And match response.user_id == userID
    
    # Definimos postID aquí para devolverlo al máster
    * def postID = response.id
    * print 'Created post with ID:', postID

@get_posts_for_user
Scenario: Get all posts for the user
    # Este escenario fallará si lo ejecutas solo, lo cual es correcto
    # porque espera que le pasen un 'userID'.
    Given path 'users', userID, 'posts'
    When method GET
    Then status 200
    And match response != null