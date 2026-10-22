@ignore
Feature: Preparar un usuario descartable para un escenario

  Scenario:
    Given url baseUrl
    And path 'usuarios'
    And request payload
    When method post
    Then status 201
    And match response == { message: 'Cadastro realizado com sucesso', _id: '#string' }
    * def userId = response._id
