import 'package:prueba_ant_pack/models/models.dart';
import 'package:prueba_ant_pack/providers/providers.dart';

class UserRepository {
  UserRepository();

  UserProvider _userProvider = UserProvider();
  Future<List<UserModel>> get getUsers => _userProvider.getUsers();
}
