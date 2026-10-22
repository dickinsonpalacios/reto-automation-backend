@ignore
Feature: Limpieza de usuarios creados durante las pruebas

  Scenario:
    Given url baseUrl
    And path 'usuarios', userId
    When method delete
    Then status 200
    And match response.message == 'Registro excluído com sucesso'
