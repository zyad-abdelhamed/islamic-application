String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password is required!";
  }
  if (value.length < 8) {
    return "The password must be at least 8 characters long!";
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return "The password must contain at least one uppercase letter!";
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return "The password must contain at least one lowercase letter!";
  }
  if (!RegExp(r'[0-9]').hasMatch(value)) {
    return "The password must contain at least one number!";
  }
  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return "The password must contain at least one special character like @ or #!";
  }
  return null;
}
