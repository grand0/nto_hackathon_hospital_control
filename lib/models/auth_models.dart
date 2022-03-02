class UserModel {
  final String username;
  final String password;

  UserModel(this.username, this.password);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}

class AuthStatus {
  late final Status status;

  AuthStatus(this.status);

  AuthStatus.fromJson(Map<String, dynamic> json) {
    switch (json['status']) {
      case 'admin':
        status = Status.admin;
        break;
      case 'user':
        status = Status.user;
        break;
      default:
        status = Status.noUser;
        break;
    }
  }
}

class RegisterStatus {
  late final bool registered;

  RegisterStatus(this.registered);

  RegisterStatus.fromJson(Map<String, dynamic> json) {
    registered = json['registered'];
  }
}

enum Status {
  admin, user, noUser,
}