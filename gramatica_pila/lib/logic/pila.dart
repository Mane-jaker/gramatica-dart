// Definición de tipos de token
enum TokenType {
  VT,
  V,
  E,
  STR,
  INT,
  BOOL,
  CHAR,
  IF,
  AP,
  CP,
  COND,
  AF,
  CF,
  FOR,
  CIC,
  FT,
  ERR,
  $,
}

class Token {
  final TokenType tipo;
  final String lexema;

  Token(this.tipo, this.lexema);
}

class Pila {
  List<Token> items = [];

  void push(Token token) {
    items.add(token);
  }

  Token pop() {
    if (items.isNotEmpty) {
      return items.removeLast();
    } else {
      throw StateError('La pila está vacía');
    }
  }

  Token peek() {
    if (items.isNotEmpty) {
      return items.last;
    } else {
      throw StateError('La pila está vacía');
    }
  }

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  List<TokenType> get tokenTypes {
    return items.map((token) => token.tipo).toList();
  }
}
