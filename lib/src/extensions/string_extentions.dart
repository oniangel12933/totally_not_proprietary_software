bool stringToBool(String? str) {
  if (str == "1" || str?.toLowerCase() == "true") {
    return true;
  } else {
    return false;
  }
}

extension StringToBoolExtension on String {
  bool get toBool {
    return stringToBool(this);
  }
}