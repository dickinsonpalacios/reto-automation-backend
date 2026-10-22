Feature: Actualizar los datos y comprobar que persisten

  Background:
    * url baseUrl

  Scenario: PUT modifica los datos del usuario existente
    * def original = call read('classpath:helpers/nuevo-usuario.js')
    * def created = call read('classpath:helpers/crear-usuario.feature') { payload: '#(original)' }
    * copy updated = original
    * remove updated.nome
    * set updated.nome = 'Usuario Actualizado'
    Given path 'usuarios', created.userId
    * print 'JSON enviado al PUT:', updated
    And request updated
    When method put
    Then status 200
    And match response == { message: 'Registro alterado com sucesso' }
    Given path 'usuarios', created.userId
    When method get
    Then status 200
    And match response contains { nome: '#(updated.nome)', email: '#(original.email)' }
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(created.userId)' }

  Scenario: PUT con un ID inexistente realiza un nuevo registro según contrato de ServeRest
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * def missingId = 'missing' + java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 9)
    Given path 'usuarios', missingId
    And request user
    When method put
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def realId = response._id
    Given path 'usuarios', realId
    When method get
    Then status 200
    And match response.email == user.email
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(realId)' }
