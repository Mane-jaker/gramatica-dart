import 'package:gramatica_pila/logic/pila.dart';

class ProcessResult {
  final String? acceptedState;
  final String currentState;
  final List<Token?> statesHistory;

  ProcessResult(this.acceptedState, this.currentState, this.statesHistory);
}

class Automata {
  static const String initialState = 'q0';
  static const String acceptState = 'q4';
  static const String errorState = 'qe';

  final Map<String, Map<TokenType, String>> transitions = {
    initialState: {
      TokenType.INT: 'q1',
      TokenType.BOOL: 'q5',
      TokenType.STR: 'q9',
      TokenType.CHAR: 'q13',
      TokenType.V: 'q17',
      TokenType.CF: 'q19',
    },
    'q1': {TokenType.E: 'q2'},
    'q2': {TokenType.V: 'q3'},
    'q3': {TokenType.VT: 'q4'},
    'q4': {},
    'q5': {TokenType.E: 'q6'},
    'q6': {TokenType.V: 'q7'},
    'q7': {TokenType.VT: 'q8'},
    'q8': {},
    'q9': {TokenType.E: 'q10'},
    'q10': {TokenType.V: 'q11'},
    'q11': {TokenType.VT: 'q12'},
    'q12': {},
    'q13': {TokenType.E: 'q14'},
    'q14': {TokenType.V: 'q15'},
    'q15': {TokenType.VT: 'q16'},
    'q16': {},
    'q17': {TokenType.VT: 'q18'},
    'q18': {},
    'q19': {TokenType.AF: 'q20'},
    'q20': {TokenType.CP: 'q21'},
    'q21': {
      TokenType.COND: 'q22',
      TokenType.CIC: 'q25',
    },
    'q22': {TokenType.AP: 'q23'},
    'q23': {TokenType.IF: 'q24'},
    'q24': {},
    'q25': {TokenType.AP: 'q26'},
    'q26': {TokenType.FOR: 'q27'},
    'q27': {},
    errorState: {},
  };

  ProcessResult processPila(Pila pila) {
    String currentState = initialState;

    while (pila.isNotEmpty) {
      print(pila.tokenTypes);
      final lastToken = pila.pop();

      print(lastToken.tipo);

      if (transitions.containsKey(currentState) &&
          transitions[currentState]!.containsKey(lastToken.tipo)) {
        currentState = transitions[currentState]![lastToken.tipo]!;

        if (currentState == acceptState) {
          break; // Aceptamos el estado y terminamos la lectura
        }
      } else {
        currentState = errorState;
        break;
      }
    }

    return ProcessResult(
      currentState == acceptState ? currentState : null,
      currentState,
      [],
    );
  }
}
