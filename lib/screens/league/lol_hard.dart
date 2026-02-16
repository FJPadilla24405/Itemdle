import 'package:flutter/material.dart';
import '../../models/item_model.dart';
import 'lol_base.dart';

class HardLol extends StatelessWidget {
  const HardLol({super.key});
  
  @override
  Widget build(BuildContext context) {
    return HardModeScreen();
  }
}

class HardModeScreen extends BaseGameScreen {
  const HardModeScreen({super.key});

  @override
  String getGameMode() => 'Hard';

  @override
  String getTitle() => 'Hard Mode';

  @override
  List<GameField> getFields() {
    return [
      GameField(
        name: 'name',
        label: 'Name',
        inputType: TextInputType.name,
        getCorrectValue: (item) => item.name,
      ),
    ];
  }
  
  @override
  State<HardModeScreen> createState() => _HardModeScreenState();
}

class _HardModeScreenState extends BaseGameState<HardModeScreen> {
  // Lista dinámica de campos que cambia según el item
  List<GameField> _dynamicFields = [];
  
  // Guardar el snapshot de stats del item actual para validación
  Map<String, double> _currentItemStats = {};
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Future<void> loadItemByIndex(int index) async {
    await super.loadItemByIndex(index);
    
    // Después de cargar el item, actualizar los campos dinámicos
    if (currentItem != null) {
      _updateDynamicFields();
    }
  }
  
  void _updateDynamicFields() {
    // Obtener stats no cero del item actual
    _currentItemStats = currentItem!.stats.getNonZeroStats();
    
    print('🔍 Item: ${currentItem!.name}');
    print('🔍 Stats encontradas: $_currentItemStats');
    
    setState(() {
      _dynamicFields = _generateStatsFields();
      
      // Limpiar controladores viejos que ya no se necesitan
      controllers.keys.toList().forEach((key) {
        if (!_dynamicFields.any((field) => field.name == key) && key != 'name') {
          controllers[key]?.dispose();
          controllers.remove(key);
        }
      });
      
      // Crear nuevos controladores para los nuevos campos
      for (var field in _dynamicFields) {
        if (!controllers.containsKey(field.name)) {
          controllers[field.name] = TextEditingController();
        }
      }
    });
  }
  
  List<GameField> _generateStatsFields() {
    List<GameField> fields = [
      // Nombre siempre está primero
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
    
    // Crear un campo por cada stat
    _currentItemStats.forEach((statName, statValue) {
      final fieldName = statName.toLowerCase().replaceAll(' ', '_');
      
      fields.add(
        GameField(
          name: fieldName,
          label: statName,
          inputType: TextInputType.numberWithOptions(decimal: true, signed: true),
          getCorrectValue: (item) {
            // Usar el valor guardado del snapshot
            final value = _currentItemStats[statName];
            if (value == null) return '0';
            
            // Si es entero, mostrar sin decimales
            if (value == value.toDouble()) {
              return value.toDouble().toString();
            }
            return value.toString();
          },
        ),
      );
      
      print('📝 Campo creado: $statName = $statValue');
    });
    
    return fields;
  }
  
  @override
  List<GameField> getFieldsToDisplay() {
    return _dynamicFields.isEmpty ? widget.getFields() : _dynamicFields;
  }
}