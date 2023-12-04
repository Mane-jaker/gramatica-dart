import 'package:gramatica_pila/logic/pila.dart';

class Lenguage {
  late RegExp regexVT;
  late RegExp regexV;
  late RegExp regexE;
  late RegExp regexSTR;
  late RegExp regexINT;
  late RegExp regexBOOL;
  late RegExp regexCHAR;
  late RegExp regexIF;
  late RegExp regexAP;
  late RegExp regexCP;
  late RegExp regexCOND;
  late RegExp regexAF;
  late RegExp regexCF;
  late RegExp regexFOR;
  late RegExp regexCIC;

  Lenguage() {
    regexVT = RegExp(r'(int|bool|str|char|void)');
    regexV = RegExp(r'(?:^|[\s])\b([a-z][a-z0-9_]*)\b');
    regexE = RegExp(r'=');
    regexSTR = RegExp(r'".*?"');
    regexINT = RegExp(r'-?\d+');
    regexBOOL = RegExp(r'[TF]');
    regexCHAR = RegExp(r'"(.)"');
    regexIF = RegExp(r'if');
    regexAP = RegExp(r'\(');
    regexCP = RegExp(r'\)');
    regexCOND = RegExp(
        r'((([a-z][a-z0-9_]*)|(-?\d+))\s*((<|>)|==|!=)\s*(([a-z][a-z0-9_]*)|(-?\d+)))|((([a-z][a-z0-9_]*)|("([a-z]+)")|(T|F))\s*(==|!=)\s*(([a-z][a-z0-9_]*)|("([a-z]+)")|(T|F)))');
    regexAF = RegExp(r'->');
    regexCF = RegExp(r'<-');
    regexFOR = RegExp(r'for');
    regexCIC = RegExp(r'(\w+)\s*=\s*(-?\d+)\s*;\s*\1\s*to\s*(-?\d+)');
  }

  Pila llenarPila(String code) {
    // Inicializar la pila
    Pila pila = Pila();

    pila.push(Token(TokenType.$, ''));

    // Analizar la cadena y agregar tokens a la pila
    while (code.isNotEmpty) {
      if (regexVT.hasMatch(code)) {
        var match = regexVT.firstMatch(code)!;
        pila.push(Token(TokenType.VT, match.group(0)!));

        code = code.substring(match.end);
      } else if (regexFOR.hasMatch(code)) {
        var match = regexFOR.firstMatch(code)!;
        pila.push(Token(TokenType.FOR, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexIF.hasMatch(code)) {
        var match = regexIF.firstMatch(code)!;
        pila.push(Token(TokenType.IF, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexAP.hasMatch(code)) {
        var match = regexAP.firstMatch(code)!;
        pila.push(Token(TokenType.AP, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexCOND.hasMatch(code)) {
        var match = regexCOND.firstMatch(code)!;
        pila.push(Token(TokenType.COND, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexCIC.hasMatch(code)) {
        var match = regexCIC.firstMatch(code)!;
        pila.push(Token(TokenType.CIC, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexV.hasMatch(code)) {
        var match = regexV.firstMatch(code)!;
        pila.push(Token(TokenType.V, match.group(0)!));

        code = code.substring(match.end);
      } else if (regexE.hasMatch(code)) {
        var match = regexE.firstMatch(code)!;
        pila.push(Token(TokenType.E, match.group(0)!));

        code = code.substring(match.end);
      } else if (regexSTR.hasMatch(code)) {
        var match = regexSTR.firstMatch(code)!;
        pila.push(Token(TokenType.STR, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexINT.hasMatch(code)) {
        var match = regexINT.firstMatch(code)!;
        pila.push(Token(TokenType.INT, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexBOOL.hasMatch(code)) {
        var match = regexBOOL.firstMatch(code)!;
        pila.push(Token(TokenType.BOOL, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexCHAR.hasMatch(code)) {
        var match = regexCHAR.firstMatch(code)!;
        pila.push(Token(TokenType.CHAR, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexCP.hasMatch(code)) {
        var match = regexCP.firstMatch(code)!;
        pila.push(Token(TokenType.CP, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexAF.hasMatch(code)) {
        var match = regexAF.firstMatch(code)!;
        pila.push(Token(TokenType.AF, match.group(0)!));
        code = code.substring(match.end);
      } else if (regexCF.hasMatch(code)) {
        var match = regexCF.firstMatch(code)!;
        pila.push(Token(TokenType.CF, match.group(0)!));
        code = code.substring(match.end);
      } else {
        pila.push(Token(TokenType.ERR, code[0]));
        code = code.substring(1);
      }
    }

    // Retornar la pila
    return pila;
  }
}
