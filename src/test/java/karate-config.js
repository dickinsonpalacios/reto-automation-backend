function fn() {
  var env = java.lang.System.getProperty('baseUrl');
  var config = { baseUrl: env ? env : 'https://serverest.dev' };
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 15000);
  return config;
}