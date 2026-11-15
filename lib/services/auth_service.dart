import 'seed_service.dart';

class AuthService {
  bool validateId(String value) {
    return value.trim().toUpperCase() == SeedService.prototypeUserId;
  }

  bool validatePassword(String value) {
    return value == SeedService.prototypePassword;
  }

  String displayNameFor(String userId) => SeedService.prototypeUserName;
}
