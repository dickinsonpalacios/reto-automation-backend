Feature: Consultar el directorio de usuarios
  El volumen cambia continuamente en un ambiente compartido; se valida el contrato y no un total fijo.

  Background:
    * url baseUrl
    * def usuarioSchema = call read('classpath:schemas/usuario.js')

  Scenario: La lista tiene una cantidad coherente con los elementos retornados
    Given path 'usuarios'
    When method get
    Then status 200
    And match response == { quantidade: '#number', usuarios: '#[]' }
    And match response.usuarios == '#[] usuarioSchema'
    And assert response.quantidade == response.usuarios.length

  Scenario: El filtro por correo devuelve exclusivamente al usuario creado
    * def user = call read('classpath:helpers/nuevo-usuario.js')
    * def created = call read('classpath:helpers/crear-usuario.feature') { payload: '#(user)' }
    Given path 'usuarios'
    And param email = user.email
    When method get
    Then status 200
    And match response.quantidade == 1
    And match response.usuarios[0] contains { _id: '#(created.userId)', email: '#(user.email)' }
    * call read('classpath:helpers/borrar-usuario.feature') { userId: '#(created.userId)' }
