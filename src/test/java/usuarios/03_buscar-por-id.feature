Feature: Buscar usuarios por identificador

  Background:
    * url baseUrl

  Scenario: Se recupera el usuario exacto creado para la prueba
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * def created = call read('classpath:helpers/crear-usuario.feature') { payload: '#(user)' }
    Given path 'usuarios', created.userId
    When method get
    Then status 200
    And match response contains { nome: '#(user.nome)', email: '#(user.email)', administrador: 'false' }
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(created.userId)' }

  Scenario: Un ID inexistente retorna un error de negocio documentado
    * def missingId = 'missing' + java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 9)
    Given path 'usuarios', missingId
    When method get
    Then status 400
    And match response == { message: 'Usuário não encontrado' }
