class User {
  final String email;
  final String id;

  final String password;

  const User({
    this.email,
    this.id,
    this.password,
  });

  static const empty = User(
    email: '',
    id: '',
    password: null,
  );
}
