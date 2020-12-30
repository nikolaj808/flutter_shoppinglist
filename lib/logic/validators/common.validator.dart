class CommonValidator {
  static String notEmpty(String value) {
    if (value.isEmpty) {
      return 'Feltet må ikke være tomt';
    }
    return null;
  }

  static String betweenValuesAndNotEmpty(String value,
      {int min = 1, int max = 999}) {
    if (value.isEmpty) {
      return 'Feltet må ikke være tomt';
    }

    final intValue = int.tryParse(value);

    if (intValue == null) {
      return 'Feltet skal indeholde et nummer';
    }

    if (intValue < min || intValue > max) {
      return 'Nummeret skal være mellem $min og $max';
    }

    return null;
  }
}
