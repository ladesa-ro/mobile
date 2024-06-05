import 'package:intl/intl.dart';

class DatasFormatadas {
  //dia atual
  static String diaAtual = DateFormat('dd').format(DateTime.now());
  //mes atual
  static String mesAtual = DateFormat('MMMM', 'pt-br').format(DateTime.now());
  //dia atual por extenço
  static String diaExtenso = DateFormat('EEEE', 'pt-br').format(DateTime.now());
  //dia atual por extenço formatando 'Feira'
  static String diaExtensoFormatado = diaExtenso.replaceFirst('feira', 'Feira');
  //dia atual por extenço formatando ' - '
  static String diaExtensoFormatado1 =
      diaExtensoFormatado.replaceFirst('-', ' - ');

  //metodo que verifica se hoje é sabado ou domingo
  static String obterDiaFormatado() {
    String diaFormatado = diaExtensoFormatado1[0].toUpperCase() +
        diaExtensoFormatado1.substring(1);

    if (diaFormatado == 'Sábado' && diaFormatado == 'Domingo') {
      diaFormatado = diaFormatado.replaceFirst(' - Feira', '');
    }
    return diaFormatado;
  }
}
