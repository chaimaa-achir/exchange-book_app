String? pwdValidationFct(String? value) {
  const pattern = r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[@#&*~]).{8,}$';
  final regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return "Password can't be empty";
  } else if (!regex.hasMatch(value)) {
    return 'The password must be at least 8 characters,\ncontain an uppercase letter,\na number, and a special character (@#&*~)';
  }
  return null;
}


 String? pwdConfirmValidationFct(String? val, String pwdtext) {
  if (val == null || val.isEmpty) {
    return 'Please confirm your password';
  }
  if (val != pwdtext) {
    return 'Passwords do not match';
  }
  return null;
}
