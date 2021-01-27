class CommonValidator {
  static String notEmpty(String value) {
    if (value.isEmpty) {
      return 'Feltet må ikke være tomt';
    }
    return null;
  }

  static String isRequiredAndMaxLength(String value, int maxLength) {
    if (value.length > maxLength) {
      return 'Feltet må maks være $maxLength bogstaver langt';
    }
    return null;
  }
}
