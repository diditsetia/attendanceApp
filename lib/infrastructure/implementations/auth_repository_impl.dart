import 'package:attendance/application/bloc/auth_bloc.dart';
import 'package:attendance/infrastructure/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String> checkAuth() async {
    final resp = await FirebaseAuth.instance.currentUser();
    var ab = resp;
    print(ab);
    String user = resp.uid;
    return user;
  }

  static FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> signUp(String email, String password, String name) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = result.user;
    FirebaseUser userUpdate = await FirebaseAuth.instance.currentUser();

    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;
    userUpdate.updateProfile(userUpdateInfo);
    String uId = user.uid;
    if (uId != null) {
      await _auth.signOut();
    }
    String resp = 'register success';
    return resp;
  }

  Future signIn(String username, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: username, password: password);
    FirebaseUser user = result.user;
    return user;
  }

  Future<void> signOut() async {
    final res = await _auth.signOut();
    return res;
  }
}
