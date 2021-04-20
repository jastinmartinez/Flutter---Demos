class AuthenticationValidator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static isValidEmail(String email) {
    return email.isEmpty
        ? 'correo vacio'
        : !_emailRegExp.hasMatch(email)
            ? 'correo invalido'
            : null;
  }

  static isValidPassword(String password) {
    return password.isEmpty
        ? 'contraseña vacia'
        : password.length < 4
            ? 'minimo 4 digitos'
            : null;
  }

  static isPasswordSame(String password, String confirmationPassowrd) {
    return confirmationPassowrd.isEmpty
        ? 'contraseña vacia'
        : confirmationPassowrd.length < 4
            ? 'minimo 4 digitos'
            : confirmationPassowrd == password
                ? null
                : 'contraseña no coinciden';
  }

  static isValidUser(String user) {
    return user.isEmpty
        ? 'usuario vacio'
        : user.length < 4
            ? 'minimo 4 digitos'
            : null;
  }
}
