import 'package:flutter/material.dart';
import 'dart:async';

class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});

  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}

class CardItem {
  final int id;
  final IconData icon;
  bool isFaceUp;
  bool isMatched;

  CardItem({
    required this.id,
    required this.icon,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<CardItem> cards = [];
  CardItem? firstFlipped;
  bool isProcessing = false;
  int moves = 0;

  final List<IconData> icons = [
    Icons.star,
    Icons.favorite,
    Icons.lightbulb,
    Icons.ac_unit,
    Icons.rocket,
    Icons.music_note,
    Icons.pets,
    Icons.bolt,
  ];

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    List<CardItem> newCards = [];
    for (int i = 0; i < icons.length; i++) {
      // Add pairs
      newCards.add(CardItem(id: i, icon: icons[i]));
      newCards.add(CardItem(id: i, icon: icons[i]));
    }
    newCards.shuffle();
    setState(() {
      cards = newCards;
      moves = 0;
      firstFlipped = null;
      isProcessing = false;
    });
  }

  void _onCardTap(int index) {
    if (isProcessing || cards[index].isFaceUp || cards[index].isMatched) return;

    setState(() {
      cards[index].isFaceUp = true;
    });

    if (firstFlipped == null) {
      firstFlipped = cards[index];
    } else {
      // Second card flipped
      moves++;
      isProcessing = true;
      if (firstFlipped!.id == cards[index].id) {
        // Match found
        setState(() {
          firstFlipped!.isMatched = true;
          cards[index].isMatched = true;
          firstFlipped = null;
          isProcessing = false;
        });
        _checkWin();
      } else {
        // No match
        Timer(const Duration(milliseconds: 1000), () {
          setState(() {
            firstFlipped!.isFaceUp = false;
            cards[index].isFaceUp = false;
            firstFlipped = null;
            isProcessing = false;
          });
        });
      }
    }
  }

  void _checkWin() {
    if (cards.every((card) => card.isMatched)) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You won in $moves moves!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _initializeGame();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Moves: $moves',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _onCardTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: cards[index].isFaceUp || cards[index].isMatched
                            ? Colors.deepPurpleAccent
                            : const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: cards[index].isFaceUp || cards[index].isMatched
                            ? Icon(cards[index].icon, color: Colors.white, size: 32)
                            : const Icon(Icons.help_outline, color: Colors.grey, size: 32),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _initializeGame,
              icon: const Icon(Icons.refresh),
              label: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
