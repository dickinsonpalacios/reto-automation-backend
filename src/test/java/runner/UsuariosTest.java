package runner;

import com.intuit.karate.junit5.Karate;

class UsuariosTest {
    @Karate.Test
    Karate usuarios() {
        return Karate.run("classpath:usuarios");
    }
}
