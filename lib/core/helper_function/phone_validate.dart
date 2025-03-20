String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number is required!";
  }

  // Regular expression to validate phone numbers (supports international format)
  String phonePattern = r'^(?:\+?[0-9]{10,15})$';
  RegExp regex = RegExp(phonePattern);

  if (!regex.hasMatch(value)) {
    return "Invalid phone number!";
  }

  return null;
}
