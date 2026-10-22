Feature: Eliminar usuarios y verificar que ya no se pueden recuperar

  Background:
    * url baseUrl

  Scenario: DELETE elimina el usuario y GET confirma su ausencia
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * def created = call read('classpath:helpers/crear-usuario.feature') { payload: '#(user)' }
    Given path 'usuarios', created.userId
    When method delete
    Then status 200
    And match response == { message: 'Registro excluído com sucesso' }
    Given path 'usuarios', created.userId
    When method get
    Then status 400
    And match response == { message: 'Usuário não encontrado' }

  Scenario: Eliminar un ID que no existe no elimina ningún registro
    * def missingId = 'missing' + java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 9)
    Given path 'usuarios', missingId
    When method delete
    Then status 200
    And match response == { message: 'Nenhum registro excluído' }
