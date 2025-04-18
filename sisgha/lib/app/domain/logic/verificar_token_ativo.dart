import 'package:sisgha/app/domain/model/token.dart';

Future<bool> verificarTokenAtivo() async {
  if (Token.token != "") {
    return true;
  } else {
    return false;
  }
}
