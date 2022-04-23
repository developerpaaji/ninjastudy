typedef Validator = String? Function(String? value);

String? createValidator(String? value, List<Validator> validators) {
  for (var validator in validators) {
    if (validator(value) != null) {
      return validator(value);
    }
  }
  return null;
}

Validator hasMinLength(int length) {
  return (String? value) =>
      (value ?? "").trim().length < length ? "Minimum Length of $length" : null;
}

Validator get isStrongPassword {
  return (String? value) => RegExp(
              "^(?=(.*[a-z]){1,})(?=(.*[0-9]){1,})(?=(.*[!@#\$%^&*()\\-__+.]){1,}).{5,}\$")
          .hasMatch(value!)
      ? null
      : "Please enter minimum 5 characters, at least one letter and one number and one special case .";
}

Validator get isAlphanumeric {
  return (value) => RegExp("^[a-zA-Z0-9_]*\$").hasMatch(value!)
      ? null
      : "Please enter alpha numeric";
}

Validator get isRequired =>
    (String? value) => (value?.isNotEmpty ?? false) ? null : "Required";

const userMinLength = 4;
const groupDescriptionLength = 10;
const groupUsernameLength = 4;
const groupNameLength = 4;
