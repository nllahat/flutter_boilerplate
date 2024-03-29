class ValidatorUtil {
  static String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateName(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a name.';
    else
      return null;
  }

  static String validatePhoneNumber(String value) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{10,11}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid phone number.';
    else
      return null;
  }

  static String validateTextInput(String value) {
    if (value.isEmpty) {
      return 'Please provide a value.';
    }

    return null;
  }

  static String validateNumberInput(String value) {
    if (value.isEmpty) {
      return 'Please enter a number.';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }

    if (int.parse(value) <= 0) {
      return 'Please enter a number greater than zero.';
    }
    return null;
  }
}
