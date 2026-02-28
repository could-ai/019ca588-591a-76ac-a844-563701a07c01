import 'package:flutter/material.dart';
import 'dart:math';

class RockPaperScissorsGame extends StatefulWidget {
  const RockPaperScissorsGame({super.key});

  @override
  State<RockPaperScissorsGame> createState() => _RockPaperScissorsGameState();
}

class _RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
  String? userChoice;
  String? computerChoice;
  String result = 'Choose your weapon!';
  int userScore = 0;
  int computerScore = 0;

  final List<Map<String, dynamic>> choices = [
    {'name': 'Rock', 'icon': Icons.landscape, 'beats': 'Scissors'},
    {'name': 'Paper', 'icon': Icons.note, 'beats': 'Rock'},
    {'name': 'Scissors', 'icon': Icons.cut, 'beats': 'Paper'},
  ];

  void _play(String choice) {
    final random = Random();
    final computerPick = choices[random.nextInt(choices.length)];
    
    setState(() {
      userChoice = choice;
      computerChoice = computerPick['name'];
      
      if (userChoice == computerChoice) {
        result = "It's a Draw!";
      } else {
        final userWin = choices.firstWhere((e) => e['name'] == userChoice)['beats'] == computerChoice;
        if (userWin) {
          result = "You Win!";
          userScore++;
        } else {
          result = "Computer Wins!";
          computerScore++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rock Paper Scissors')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildScoreBoard(),
          _buildArena(),
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text('You', style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text('$userScore', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
        Column(
          children: [
            const Text('Computer', style: TextStyle(fontSize: 18, color: Colors.grey)),
            Text('$computerScore', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildArena() {
    return Column(
      children: [
        if (userChoice != null && computerChoice != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChoiceDisplay(userChoice!, true),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ),
              _buildChoiceDisplay(computerChoice!, false),
            ],
          ),
          const SizedBox(height: 30),
        ],
        Text(
          result,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: result.contains('Win') ? Colors.greenAccent : (result.contains('Draw') ? Colors.orangeAccent : Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceDisplay(String choiceName, bool isUser) {
    final choiceData = choices.firstWhere((e) => e['name'] == choiceName);
    return Column(
      children: [
        Icon(choiceData['icon'], size: 60, color: isUser ? Colors.blueAccent : Colors.redAccent),
        const SizedBox(height: 8),
        Text(choiceName, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: choices.map((choice) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () => _play(choice['name']),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: const Color(0xFF2C2C2C),
              ),
              child: Icon(choice['icon'], size: 30, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(choice['name']),
          ],
        );
      }).toList(),
    );
  }
}
