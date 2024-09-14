import 'package:intl/intl.dart';

class DatasFormatadas {
  static DateTime primeiroDiaDoAno = DateTime(DateTime.now().year, 1, 1);
  static DateTime ultimoDiaDoAno = DateTime(DateTime.now().year, 12, 31);

  static DateTime diaAtualEmNumero = DateTime.now();
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

  //primeiro dia da semana, segunda
  static String obterPrimeiroDiaSemana() {
    //Codigo onde se hoje for domingo, muda pra segunda
    if (diaAtualEmNumero.weekday == DateTime.sunday) {
      diaAtualEmNumero = diaAtualEmNumero.add(
        const Duration(days: 1),
      );
    }

    DateTime date = diaAtualEmNumero.add(
      Duration(days: 0 - diaAtualEmNumero.weekday),
    );
    final primeiroDiaDaSemana = DateFormat('dd').format(date);
    return primeiroDiaDaSemana;
  }

  //Último dia da semana, sábado
  static String obterUltimoDiaSemana() {
    //Codigo onde se hoje for domingo, muda pra segunda
    if (diaAtualEmNumero.weekday == DateTime.sunday) {
      diaAtualEmNumero = diaAtualEmNumero.add(
        const Duration(days: 1),
      );
    }

    DateTime date = diaAtualEmNumero.add(
      Duration(days: 6 - diaAtualEmNumero.weekday),
    );
    final ultimoDiaDaSemana = DateFormat('dd').format(date);
    return ultimoDiaDaSemana;
  }
}
