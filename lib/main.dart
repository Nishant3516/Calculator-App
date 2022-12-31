import 'package:flutter/material.dart';
import 'indbutton.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main(List<String> args) {
  runApp(const Calculator());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var equation = "";
  var answer = "0";
  var prevAns = "";

  final buttonList = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(20),
                        child: AutoSizeText(
                          equation,
                          overflow: TextOverflow.fade,
                          minFontSize: 14,
                          maxLines: 1,
                          style: answer == "0"
                              ? const TextStyle(fontSize: 80)
                              : const TextStyle(fontSize: 60),
                        )),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.all(20),
                        child: AutoSizeText(
                          answer,
                          overflow: TextOverflow.visible,
                          minFontSize: 14,
                          maxLines: 1,
                          style: answer == "0"
                              ? const TextStyle(fontSize: 30)
                              : const TextStyle(fontSize: 50),
                        ))
                  ]),
            )),
            Expanded(
                flex: 2,
                child: Container(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: buttonList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return MyButton(
                          buttonTap: () {
                            setState(() {
                              equation = "";
                              answer = "0";
                            });
                          },
                          buttonText: buttonList[0],
                        );
                      } else if (index == 1) {
                        return MyButton(
                          buttonTap: () {
                            setState(() {
                              equation =
                                  equation.substring(0, equation.length - 1);
                            });
                          },
                          buttonText: buttonList[1],
                        );
                      }
                      //else if (index == buttonList.length - 2) {
                      //   return MyButton(
                      //     buttonTap: () {
                      //       setState(() {
                      //         equation += answer;
                      //       });
                      //     },
                      //     buttonText: buttonList[index],
                      //   );
                      // }
                      else if (index == (buttonList.length - 1)) {
                        return MyButton(
                          buttonTap: () {
                            setState(() {
                              // equalpressed();
                              String question = equation;
                              question = question.replaceAll('x', '*');
                              question = question.replaceAll('ANS', prevAns);
                              Parser p = Parser();
                              Expression exp = p.parse(question);
                              ContextModel cm = ContextModel();
                              double eval =
                                  exp.evaluate(EvaluationType.REAL, cm);
                              double l = double.parse(eval.toStringAsFixed(4));
                              answer = l.toString();
                              prevAns = answer;
                            });
                          },
                          buttonText: buttonList[index],
                        );
                      } else {
                        return MyButton(
                          buttonTap: () {
                            setState(() {
                              equation += buttonList[index];
                            });
                          },
                          buttonText: buttonList[index],
                        );
                      }
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void equalpressed() {}
}
