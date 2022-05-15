class User {
  late String? id;
  late String? name;
  late String? email;
  late String? deviceToken;
  late String? accessToken;
  late String? refreshToken;

  User({
    this.id,
    this.email,
    this.name,
    this.deviceToken,
    this.accessToken,
    this.refreshToken,
  });
}
