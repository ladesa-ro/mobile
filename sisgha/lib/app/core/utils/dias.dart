import 'package:intl/intl.dart';

class DatasFormatadas {
  static DateTime primeiroDiaDoAno = DateTime(DateTime.now().year, 1, 1);
  static DateTime ultimoDiaDoAno = DateTime(DateTime.now().year, 12, 31);

  static DateTime diaAtualEmNumero = DateTime.now();
  //dia atual
  static String diaAtual = DateFormat('dd').format(DateTime.now());
  //mes atual
  static String mesAtual = DateFormat('MMMM', 'pt-br').format(diaAtualEmNumero);
  static String anoAtual = DateFormat('yyyy', 'pt-Br').format(diaAtualEmNumero);

  //dia atual por extenço
  static String diaExtenso = DateFormat('EEEE', 'pt-br').format(DateTime.now());
  //metodo que verifica se hoje é sabado ou domingo
  static String obterDiaFormatado() {
    String diaFormatado = diaExtenso[0].toUpperCase() + diaExtenso.substring(1);

    if (diaFormatado == 'Sábado' && diaFormatado == 'Domingo') {
      diaFormatado = diaFormatado.replaceFirst('-feira', '');
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

  // 00 a 00
  static String primeiroAUltimoDia =
      '${DatasFormatadas.mesAtual[0].toUpperCase() + DatasFormatadas.mesAtual.substring(1)} - ${DatasFormatadas.obterPrimeiroDiaSemana()} a ${DatasFormatadas.obterUltimoDiaSemana()}';
}
