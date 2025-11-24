class FormValidators {
  static String? validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  static String? validateECTS(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obligatorio';
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Debe ser un número';
    }
    if (number < 1 || number > 12) {
      return 'ECTS debe estar entre 1 y 12';
    }
    return null;
  }

  static String? validateNota(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Opcional
    }
    final number = double.tryParse(value);
    if (number == null) {
      return 'Debe ser un número';
    }
    if (number < 0 || number > 10) {
      return 'Nota debe estar entre 0 y 10';
    }
    return null;
  }
}
