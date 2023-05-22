import 'login.dart';
import 'repository.dart';

class LoginService {
  final LoginRepository repository;
  LoginService(this.repository);

  Future<Login> sendAccess(String user, String password) async {
    final resp = await repository.requestAccess(user: user, password: password);
    return resp;
  }
}
