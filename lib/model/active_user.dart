class ActiveUser {
  late String email;
  late String password;

  ActiveUser({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

  ActiveUser.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    password = map['password'];
  }
}
