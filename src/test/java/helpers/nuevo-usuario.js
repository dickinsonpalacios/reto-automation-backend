function fn() {
  // UUID por escenario: evita choques entre ejecuciones simultaneas.
  var id = java.util.UUID.randomUUID().toString().replace(/-/g, '').substring(0, 14);
  return {
    nome: 'QA Contrato ' + id,
    email: 'qa.contrato.' + id + '@example.com',
    password: 'Prueba2026!',
    administrador: 'false'
  };
}