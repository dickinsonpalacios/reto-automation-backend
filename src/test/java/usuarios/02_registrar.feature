Feature: Registrar usuarios sin contaminar los datos de la siguiente prueba

  Background:
    * url baseUrl

  Scenario: El registro devuelve un ID y puede recuperarse
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    Given path 'usuarios'
    And request user
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def id = response._id
    Given path 'usuarios', id
    When method get
    Then status 200
    And match response contains { email: '#(user.email)', nome: '#(user.nome)' }
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(id)' }

  Scenario: Un correo ya registrado no puede duplicarse
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * def created = call read('classpath:helpers/crear-usuario.feature') { payload: '#(user)' }
    Given path 'usuarios'
    And request user
    When method post
    Then status 400
    And match response == { message: 'Este email já está sendo usado' }
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(created.userId)' }

  Scenario: Se rechaza un correo con formato inválido
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * set user.email = 'correo-sin-arroba'
    Given path 'usuarios'
    And request user
    When method post
    Then status 400
    And match response.email == '#string'
