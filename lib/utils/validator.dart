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

Validator get isRequired =>
    (String? value) => (value?.isNotEmpty ?? false) ? null : "Required";

Validator get isDouble => (String? value) => (value != null && value.isNotEmpty)
    ? double.tryParse(value) == null
        ? "Please enter decimal value."
        : null
    : null;

Validator get isPositive => (String? value) =>
    isDouble(value) ??
    (value != null
        ? double.parse(value) <= 0
            ? "Please enter a positive value"
            : null
        : null);

const userMinLength = 4;
const groupDescriptionLength = 10;
const groupUsernameLength = 4;
const groupNameLength = 4;
