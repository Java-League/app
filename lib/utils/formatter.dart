import 'package:intl/intl.dart';

class FormatterJavaLeague {
  static String formatarJavalis(double? campo) {
    if (campo == null) {
      return 'R\$ 0,00';
    }
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    return 'J\$ ${formatter.format(campo)}';
  }
}
