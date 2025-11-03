@e2e-flow
Feature: Flujo E2E Orquestado: User -> Post -> Comment -> Todo -> Delete

Background:
  * url baseUrl
  * header Authorization = authToken

Scenario: Ejecutar el flujo de dependencia completo

  # ------------------------------------------------------------------
  # PASO 1: CREAR USUARIO
  # ------------------------------------------------------------------
  * print '--- (MASTER) PASO 1: Creando usuario principal ---'
  * def userResult = call read('users/users.feature@create_user')
  
  # Capturamos las variables del usuario creado
  * def mainUserID = userResult.userID
  * def mainUserName = userResult.userName
  * def mainUserEmail = userResult.userEmail
  * print '--- (MASTER) Usuario principal creado con ID:', mainUserID

  # ------------------------------------------------------------------
  # PASO 2: CREAR POST (usando el userID)
  # ------------------------------------------------------------------
  * print '--- (MASTER) PASO 2: Creando post para el usuario', mainUserID
  * def postResult = call read('posts/posts.feature@create_post') { userID: "#(mainUserID)" }
  
  # Capturamos el ID del post creado
  * def mainPostID = postResult.postID
  * print '--- (MASTER) Post creado con ID:', mainPostID

  # ------------------------------------------------------------------
  # PASO 3: CREAR COMMENT (usando el postID)
  # ------------------------------------------------------------------
  * print '--- (MASTER) PASO 3: Creando comentario para el post', mainPostID
  * call read('comments/comments.feature@create_comment_on_post') { postID: "#(mainPostID)" }

  # ------------------------------------------------------------------
  # PASO 4: CREAR TODO (usando el userID)
  # ------------------------------------------------------------------
  * print '--- (MASTER) PASO 4: Creando todo para el usuario', mainUserID
  * call read('todos/todos.feature@create_todo') { userID: "#(mainUserID)" }

  # ------------------------------------------------------------------
  # PASO 5: ACTUALIZAR Y BORRAR EL USUARIO PRINCIPAL
  # ------------------------------------------------------------------
  * print '--- (MASTER) PASO 5: Actualizando usuario principal ID:', mainUserID
  * call read('users/users.feature@update_user') { userID: "#(mainUserID)" }

  * print '--- (MASTER) PASO 6: Borrando usuario principal ID:', mainUserID
  * call read('users/users.feature@delete_user') { userID: "#(mainUserID)" }