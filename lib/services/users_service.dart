import '../models/user.dart';

class UsersService {
  Future createUser(User user, String password) async {}

  Future authenticateUser(User user, String password) async {}

  Future recoverAccount(String email) async {}

  Future resetPassword(String code, String newPassword) async {}

  Future logout() async {}
}
