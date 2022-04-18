class Validations {
  static bool isAValidEmailAddress(String input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-_]+\.[a-zA-Z0-9]+""";
    return RegExp(emailRegex).hasMatch(input);
  }

  static bool isAValidPassword(String input) {
    return input.length >= 6;
  }
}
