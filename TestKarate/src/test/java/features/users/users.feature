@users
Feature: User API tests
Background:
  * url baseUrl 
  * header Authorization = authToken
  * def random_suffix = java.lang.System.currentTimeMillis()
  * def nombre = 'Pepe Usuario ' + random_suffix
  * def email = 'pepe_usuario_'+ random_suffix +'@gmail.com'
  * def nombre2 = 'V2_Pepe Usuario ' + random_suffix
  * def email2 = 'V2_pepe_usuario_'+ random_suffix +'@gmail.com'

@create_user
Scenario: Create a new user
  Given path 'users'
  And request { "name": "#(nombre)" , "gender": "male", "email": "#(email)" , "status": "active" }
  When method POST
  Then status 201
  And match response.name != ''
  # Estas variables 'def' se devuelven al 'call'
  * def userID = response.id
  * def userName = response.name
  * def userEmail = response.email
  * print 'User created with ID:', userID

@list_users
Scenario: List all users
  Given path 'users'
  When method GET
  Then status 200
  And match response != null

@update_user
Scenario: Update a user
  # Ahora recibimos userID, userName, y userEmail del 'call'
  * print 'Updating user with ID:', userID
  Given path 'users', userID
  # Usamos las variables 'userName' y 'userEmail' que vinieron del call
  And request { "name": "#(nombre2)", "email": "#(email2)" }
  When method PATCH
  Then status 200
  And match response.id == userID
  # Estas validaciones ahora sí funcionarán
  And match response.name != nombre
  And match response.email != email

@delete_user
Scenario: Delete a user
  # Este escenario ahora espera recibir 'userID' del 'call'
  * print 'Deleting user with ID:', userID
  Given path 'users', userID
  When method DELETE
  Then status 204