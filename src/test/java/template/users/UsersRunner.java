package template.users;

import com.intuit.karate.junit5.Karate;

/**
 * Runner for the Users domain.
 * Executes all feature files in the users package.
 *
 * Run: mvn test -Dtest=UsersRunner
 * Run smoke only: mvn test -Dtest=UsersRunner -Dkarate.options="--tags @smoke"
 */
class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run(
            "user_create",
            "user_get",
            "user_get_updated",
            "user_update",
            "user_delete"
        ).relativeTo(getClass());
    }
}
