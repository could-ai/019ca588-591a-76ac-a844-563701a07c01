import 'package:flutter/material.dart';
import 'package:couldai_user_app/screens/home_screen.dart';
import 'package:couldai_user_app/games/tic_tac_toe.dart';
import 'package:couldai_user_app/games/rock_paper_scissors.dart';
import 'package:couldai_user_app/games/memory_match.dart';

void main() {
  runApp(const GameZoneApp());
}

class GameZoneApp extends StatelessWidget {
  const GameZoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Zone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.cyanAccent,
          surface: Color(0xFF1E1E1E),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF2C2C2C),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/tictactoe': (context) => const TicTacToeGame(),
        '/rps': (context) => const RockPaperScissorsGame(),
        '/memory': (context) => const MemoryMatchGame(),
      },
    );
  }
}
