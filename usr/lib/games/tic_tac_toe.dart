import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  bool isDraw = false;

  void _handleTap(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner(currentPlayer)) {
        winner = currentPlayer;
      } else if (!board.contains('')) {
        isDraw = true;
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  bool _checkWinner(String player) {
    const winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6]             // Diagonals
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStatusDisplay(),
          const SizedBox(height: 20),
          _buildBoard(),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _resetGame,
            icon: const Icon(Icons.refresh),
            label: const Text('Restart Game'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDisplay() {
    String message;
    Color color;

    if (winner != '') {
      message = 'Player $winner Wins!';
      color = Colors.greenAccent;
    } else if (isDraw) {
      message = 'It\'s a Draw!';
      color = Colors.orangeAccent;
    } else {
      message = 'Player $currentPlayer\'s Turn';
      color = Colors.white;
    }

    return Text(
      message,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildBoard() {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _handleTap(index),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2C),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Center(
                  child: Text(
                    board[index],
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: board[index] == 'X'
                          ? Colors.blueAccent
                          : Colors.redAccent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
