import 'package:flutter/material.dart';
import '../screens.dart';

// Pantalla de juego del modo facil
class EasyLol extends StatelessWidget {
  const EasyLol({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyModeScreen();
  }
}

class EasyModeScreen extends BaseGameScreen {
  const EasyModeScreen({super.key});

  @override
  String getGameMode() => 'Easy';

  @override
  String getTitle() => 'Easy Mode';

  @override
  List<GameField> getFields() {
    return [
      GameField(
        name: 'name',
        label: 'Name',
        inputType: TextInputType.name,
        getCorrectValue: (item) => item.name,
        showHint: false,
      ),
    ];
  }

  @override
  State<EasyModeScreen> createState() => _EasyModeScreenState();
}

class _EasyModeScreenState extends BaseGameState<EasyModeScreen> {

}
