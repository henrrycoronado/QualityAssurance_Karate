@todos
Feature: Todos API tests

Background:
  * url baseUrl
  * header Authorization = authToken
  # QUITAMOS userID y todoID de aquí

@create_todo
Scenario: Create a new todo for a specific user
  # userID ahora viene 100% del 'call'
  * print '--- Recibido userID para crear todo:', userID

  Given path 'users', userID, 'todos'
  And request { "title": "task 1", "status": "pending" }
  When method POST
  Then status 201
  And match response.user_id == userID
  
  # todoID se define aquí, lo cual es correcto
  * def todoID = response.id
  * print 'Created todo with ID:', todoID

@get_todos_for_user
Scenario: Get all todos for the user
  # Este escenario ahora depende de que le pasen un userID
  Given path 'users', userID, 'todos'
  When method GET
  Then status 200
  And match response != null