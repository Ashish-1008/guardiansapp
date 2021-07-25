import 'package:guardiansapp/providers/authentication_provider.dart';
import 'package:meta/meta.dart';

class UserRepository {
  final authProvider = new AuthenticationProvider();
  Future authenticate({
    @required phone,
    @required password,
  }) async {
    var response = await authProvider.authenticate(phone, password);
    return response;
  }

  // Future logout({@required token}) async {
  //   var response = await authProvider.logout(token);
  //   return response;
  // }
}
