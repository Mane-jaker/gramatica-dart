import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gramatica_pila/logic/automata.dart';
import 'package:gramatica_pila/logic/lenguage.dart';
import 'package:gramatica_pila/logic/pila.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonPressed = false;

  ProcessResult? result;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void validateCode() {
    final String code = _textEditingController.text;
    setState(() {
      Pila pila = Lenguage().llenarPila(code);
      result = Automata().processPila(pila);
      _isButtonPressed = true;
    });
  }

  String evaluateState(String? state) {
    switch (state) {
      case 'q4':
      case 'q8':
      case 'q12':
      case 'q16':
      case 'q18':
      case 'q24':
      case 'q27':
      case 'q30':
        return 'valido';
      default:
        return 'error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ejemplo',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'if(1<7)->\n  bool t = T\n<-else->\n  bool f = F\n<-\nfor(i = 0 ; i to 5)->\n  str hola\n<-\nvoid hola()->\n  int migue\n<-',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: 600,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Ingresa tu código...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
                controller: _textEditingController,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isButtonPressed)
                  Text(
                    evaluateState(result!.currentState),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validateCode,
                  child: const Text('Validar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
