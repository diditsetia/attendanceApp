abstract class AuthRepository {
  Future<String> checkAuth();
  Future<String> signUp(
    String email,
    String password,
    String name,
  );
  Future signIn(
    String username,
    String password,
  );

  Future<void> signOut();
}
