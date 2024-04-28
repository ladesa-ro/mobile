import 'package:intl/intl.dart';

class DatasFormatadas {
  static String DiaAgora = DateFormat('dd').format(DateTime.now());
  static String MesAgora = DateFormat('MMMM', 'pt-br').format(DateTime.now());
  static String DiaExtenso = DateFormat('EEEE', 'pt-br').format(DateTime.now());

  static String DiaExtensoFormatado = DiaExtenso.replaceFirst('feira', '');
}
