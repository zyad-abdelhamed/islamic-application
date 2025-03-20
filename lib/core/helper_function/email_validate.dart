String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email is required!";
  }

  String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(emailPattern);

  if (!regex.hasMatch(value)) {
    return "Invalid email address!";
  }

  return null; // ✅ لا يوجد خطأ، يجب أن يعود `null`
}