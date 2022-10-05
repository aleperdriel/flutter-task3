import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final inputController = TextEditingController();

  String input = '';
  String inputPrev = '';
  bool showError0 = false;
  bool hasPressedEqual = false;
  String error0 = 'Cannot divide by zero';

  void updateInput(String value) {
    setState(() {
      if (input.contains(error0)) {
        input = input.replaceAll('÷0', '÷').replaceAll(error0, inputPrev);
        showError0 = false;
      }

      switch (value) {
        case '=':
          if (compute(input) == 'error0') {
            showError0 = true;
            input = error0;
            inputController.selection = TextSelection.fromPosition(
                TextPosition(offset: inputController.text.length));
          } else if (!isOperator(input[input.length - 1])) {
            inputPrev = input.replaceAll('=', '');
            input = '=' + compute(input);
            hasPressedEqual = true;
          }
          break;

        case 'C':
          clear();
          break;

        case '⌫':
          erase();
          break;

        case '.':
          var splitInput =
              input.split(RegExp(r"['+', '\-', 'x', '*', '/', '÷', '%', '=']"));
          debugPrint(splitInput[splitInput.length - 1]);
          if (splitInput[splitInput.length - 1].contains('.')) {
            break;
          } else {
            input += value;
          }
          break;
        default:
          //Check if last value was already an operator and replace it by new operator
          if (isOperator(value) && input.isNotEmpty) {
            if (isOperator(input[input.length - 1]) ||
                input[input.length - 1] == ' ') {
              input = input.substring(0, input.length - 1);
            }
            input += value;
          } else {
            input = hasPressedEqual ? value : input + value;
            inputPrev = input.replaceAll('=', '');
          }
          hasPressedEqual = false;

          break;
      }
    });
  }

  void clear() {
    setState(() {
      inputPrev = '';
      input = '';
    });
  }

  void erase() {
    if (input.isNotEmpty) {
      input = input.substring(0, input.length - 1);
    }
  }

  @override
  void initState() {
    super.initState();
    inputController.text = input;
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // inputController.text = '$inputPrev\n$input';
    inputController.text = input;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child:
                TextField(
                    expands: true,
                    minLines: null,
                    maxLines: null,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 2, 36, 53),
                      filled: true,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.none,
                    controller: inputController,
                    textAlign: TextAlign.right,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 64,
                    )),
              
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 4, 56, 88),
                    Color.fromARGB(255, 2, 36, 53)
                  ],
                  center: Alignment.topLeft,
                  radius: 0.8,
                )),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NewTile(
                              text: 'C',
                              type: 'special',
                              onTap: (text) {
                                updateInput(text);
                              }),
                          NewTile(
                              text: '⌫',
                              type: 'special',
                              onTap: (text) {
                                updateInput(text);
                              }),
                          NewTile(
                              text: '%',
                              type: 'special',
                              onTap: (text) {
                                updateInput(text);
                              }),
                          NewTile(
                              text: '÷',
                              type: 'special',
                              onTap: (text) {
                                updateInput(text);
                              }),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NewTile(
                            text: '1',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '2',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '3',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: 'x',
                            type: "operation",
                            onTap: (text) {
                              updateInput(text);
                            },
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NewTile(
                            text: '4',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '5',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '6',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '+',
                            type: "operation",
                            onTap: (text) {
                              updateInput(text);
                            },
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NewTile(
                            text: '7',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '8',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '9',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '-',
                            type: "operation",
                            onTap: (text) {
                              updateInput(text);
                            },
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          NewTile(text: ' ', type: 'none', onTap: (text) {}),
                          NewTile(
                            text: '0',
                            type: 'number',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '.',
                            type: 'operation',
                            onTap: (text) {
                              updateInput(text);
                            },
                            controller: inputController,
                          ),
                          NewTile(
                            text: '=',
                            type: "operation",
                            onTap: (text) {
                              updateInput(text);
                            },
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewTile extends StatelessWidget {
  const NewTile(
      {super.key,
      required this.text,
      required this.onTap,
      required this.type,
      this.controller});

  final String text;
  final Function onTap;
  final TextEditingController? controller;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: SizedBox(
          width: double.maxFinite,
          child: TextButton(
            onPressed: () {
              onTap(text);
            },
            child: Text(text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}

isOperator(value) {
  return value == '+' ||
      value == '-' ||
      value == '÷' ||
      value == 'x' ||
      value == '%';
}

compute(input) {
  String equation = input.replaceAll('x', '*').replaceAll('÷', '/');

  //Delete all spaces, linebreak and equals sign
  equation = equation.replaceAll(RegExp(r"['\n', '=', ' ']"), '');
  if (equation.contains('/0')) {
    debugPrint('Cannot divide by zero');
    return 'error0';
  } else {
    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    double computed = exp.evaluate(EvaluationType.REAL, cm);

    // TO REPLACE : rounding the numbers
    // String result = computed.toStringAsFixed(computed.truncateToDouble() == computed ? 0 : 1);
    String result = computed
        .toString()
        .replaceAll(RegExp(r"/(^\d+\.\d*[1-9])(0+$)|(\.0+$)"), "");

    return result;
  }
}
