import 'package:intl/intl.dart';

class DatasFormatadas {
  // ignore: non_constant_identifier_names
  static String DiaAgora = DateFormat('dd').format(DateTime.now());
  // ignore: non_constant_identifier_names
  static String MesAgora = DateFormat('MMMM', 'pt-br').format(DateTime.now());
  // ignore: non_constant_identifier_names
  static String DiaExtenso = DateFormat('EEEE', 'pt-br').format(DateTime.now());
  // ignore: non_constant_identifier_names
  static String DiaExtensoFormatado = DiaExtenso.replaceFirst('feira', '');
}
