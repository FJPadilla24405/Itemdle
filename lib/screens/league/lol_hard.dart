import 'package:flutter/material.dart';
import '../screens.dart';

class HardLol extends StatelessWidget {
  const HardLol({super.key});
  @override
  Widget build(BuildContext context) => HardModeScreen();
}

class HardModeScreen extends BaseGameScreen {
  const HardModeScreen({super.key});

  @override
  String getGameMode() => 'Hard';

  @override
  String getTitle() => 'Hard Mode';

  @override
  List<GameField> getFields() => [
    GameField(
      name: 'name',
      label: 'Name',
      inputType: TextInputType.name,
      getCorrectValue: (item) => item.name,
      showHint: false,
    ),
  ];

  @override
  State<HardModeScreen> createState() => _HardModeScreenState();
}

class _HardModeScreenState extends BaseGameState<HardModeScreen> {
  List<GameField> _dynamicFields = [];

  // Snapshot de stats del item actual - clave para validación correcta
  Map<String, double> _currentItemStats = {};

  @override
  Future<void> loadItemByIndex(int index) async {
    // Primero limpiar campos dinámicos anteriores de forma segura
    _clearDynamicControllers();

    // Llamar al padre para cargar el item y actualizar currentItem
    await super.loadItemByIndex(index);

    // Después de que el padre cargó el item, generar nuevos campos
    if (currentItem != null) {
      _buildDynamicFields();
    }
  }

  void _clearDynamicControllers() {
    // Solo eliminar los controladores que NO son 'name'
    // No hacemos dispose aquí porque dispose() del padre los maneja todos
    controllers.keys
        .where((k) => k != 'name')
        .toList()
        .forEach((k) => controllers.remove(k));
  }

  void _buildDynamicFields() {
    _currentItemStats = currentItem!.stats.getNonZeroStats();

    final newFields = <GameField>[
      GameField(
        name: 'name',
        label: 'Name',
        inputType: TextInputType.name,
        getCorrectValue: (item) => item.name,
        showHint: false,
      ),
      GameField(
        name: 'total_gold',
        label: 'Total Gold',
        inputType: TextInputType.number,
        getCorrectValue: (item) => item.gold.total.toString(),
        showHint: true,
      ),
      GameField(
        name: 'tier',
        label: 'Tier',
        inputType: TextInputType.text,
        getCorrectValue: (item) => item.depth.toString(),
        showHint: false,
      ),
    ];

    _currentItemStats.forEach((statName, statValue) {
      final key = 'stat_${statName.toLowerCase().replaceAll(' ', '_')}';

      // Crear el controlador solo si no existe ya
      if (!controllers.containsKey(key)) {
        controllers[key] = TextEditingController();
      }

      newFields.add(
        GameField(
          name: key,
          label: statName,
          inputType: TextInputType.numberWithOptions(
            decimal: true,
            signed: true,
          ),
          showHint: true,
          getCorrectValue: (_) {
            // Usar el snapshot guardado, no recalcular
            final v = _currentItemStats[statName];
            if (v == null) return '0';
            return v == v.toInt() ? v.toInt().toString() : v.toString();
          },
        ),
      );
    });

    setState(() {
      _dynamicFields = newFields;
    });
  }

  @override
  List<GameField> getFieldsToDisplay() =>
      _dynamicFields.isEmpty ? widget.getFields() : _dynamicFields;
}
