@comments
Feature: Comments API tests

Background:
  * url baseUrl
  * header Authorization = authToken
  # QUITAMOS postID y commentID de aquí

@create_comment_on_post
Scenario: Create a comment on a specific post
  # postID ahora viene 100% del 'call'
  * print '--- Recibido postID para crear comentario:', postID
  
  Given path 'posts', postID, 'comments'
  And request { "name": "henrry coronado", "email": "henrry@gmail.com", "body": "holaaa" }
  When method POST
  Then status 201
  And match response.post_id == postID
  
  # commentID se define aquí, lo cual es correcto
  * def commentID = response.id
  * print 'Created comment with ID:', commentID

@get_comments_for_post
Scenario: Get all comments for the post
  # Este escenario ahora depende de que le pasen un postID
  Given path 'posts', postID, 'comments'
  When method GET
  Then status 200
  And match response != null