import 'package:intl/intl.dart';

class FormatterJavaLeague {
  static String formatarJavalis(int? campo) {
    if (campo == null) {
      return '0.0';
    }
    final formatter = NumberFormat("#,###", "pt_BR");
    return formatter.format(campo.toInt());
  }
}
