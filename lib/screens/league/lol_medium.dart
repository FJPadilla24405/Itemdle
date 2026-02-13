import 'package:flutter/material.dart';
import 'lol_base.dart';

class MediumLol extends StatelessWidget {
  const MediumLol({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MediumModeScreen();
  }
}

class MediumModeScreen extends BaseGameScreen {
  const MediumModeScreen({super.key});

  @override
  String getGameMode() => 'Medium';

  @override
  String getTitle() => 'Medium Mode';

  @override
  List<GameField> getFields() {
    return [
      GameField(
        name: 'name',
        label: 'Name',
        inputType: TextInputType.name,
        getCorrectValue: (item) => item.name,
      ),
      GameField(
        name: 'total_gold',
        label: 'Total Gold',
        inputType: TextInputType.number,
        getCorrectValue: (item) => item.gold.total.toString(),
      ),
      GameField(
        name: 'tier',
        label: 'Tier',
        inputType: TextInputType.text,
        getCorrectValue: (item) => item.depth.toString(),
      ),
    ];
  }

  @override
  State<MediumModeScreen> createState() => _MediumModeScreenState();
}

class _MediumModeScreenState extends BaseGameState<MediumModeScreen> {
  // Toda la lógica heredada de BaseGameState
}