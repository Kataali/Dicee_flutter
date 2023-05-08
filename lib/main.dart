import 'dart:math';
import 'package:flutter/material.dart';

void main() =>runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Colors.red,
          title: const Text("Dicee"),
        ),
        body: const DicePage(),
      ),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int lDiceNum = 1;
  int rDiceNum = 1;
  String message1 = 'Tap on the respective buttons to roll dice.';
  String message2 = "";
  String winner = "";
  bool _d1active = true;
  bool _d2active = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              message1 = 'Tap on the respective buttons to roll dice.';
              lDiceNum = 1;
              rDiceNum = 1;
              _d1active = true;
              _d2active = true;
              message2 = "";
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.wifi_protected_setup, color: Colors.white, size: 50),
              Text('Reset', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        Text(
          message1,
          textAlign: TextAlign.center,
          //overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        Text(
          message2,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        Center(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/dice$lDiceNum.png'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/dice$rDiceNum.png'),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.redAccent)),
              onPressed: _d1active
                  ? () {
                      setState(() {
                        lDiceNum = Random().nextInt(6) + 1;
                      });
                      _d1active = false;
                    }
                  : null,
              child: const Text('Player 1 to Roll'),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.redAccent)),
              onPressed: _d2active
                  ? () {
                      setState(() {
                        rDiceNum = Random().nextInt(6) + 1;
                      });
                      if (lDiceNum > rDiceNum) {
                        setState(() {
                          winner = 'Player 1';
                        });
                        message1 = '🎉🎉$winner won!!';
                      } else if (lDiceNum < rDiceNum) {
                        setState(() {
                          winner = 'Player 2';
                        });
                        message1 = '🎉🎉$winner won!!';
                      } else {
                        setState(() {
                          message1 = "It's a Tie Go Again!!";
                        });
                      }
                      _d2active = false;
                      message2 = 'Tap on Reset to Play Again';
                    }
                  : null,
              child: const Text('Player 2 to Roll'),
            ),
          ],
        ),
      ],
    );
  }
}
