import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../services/auth_service.dart';
import '../../models/item_model.dart';
import '../../services/item_service.dart';
import '../side_drawer.dart';

// Clase abstracta base que contiene toda la lógica común
abstract class BaseGameScreen extends StatefulWidget {
  const BaseGameScreen({super.key});
  
  String getGameMode();
  String getTitle();
  List<GameField> getFields();
}

class GameField {
  final String name;
  final String label;
  final TextInputType inputType;
  final String Function(Item) getCorrectValue;

  GameField({
    required this.name,
    required this.label,
    required this.inputType,
    required this.getCorrectValue,
  });
}

abstract class BaseGameState<T extends BaseGameScreen> extends State<T> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final ItemService _itemService = ItemService();
  
  late Map<String, TextEditingController> controllers;
  
  Color _darkVibrantColor = Colors.cyan;
  Color _darkMutedColor = Colors.cyan;
  Color _lightVibrantColor = Colors.white;
  Color _vibrantColor = Colors.white;
  Color _lightMutedColor = Colors.grey;
  Color _mutedColor = Colors.grey;
  Color _dominantColor = Colors.black;
  bool _isLoadingColor = true;

  Item? currentItem;
  bool _isLoadingItem = true;
  List<String> _allItemIds = [];
  int _currentItemIndex = 0;

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var field in widget.getFields())
        field.name: TextEditingController()
    };
    _loadAllItems();
  }
  
  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _loadAllItems() async {
    setState(() {
      _isLoadingItem = true;
    });
    
    try {
      final items = await _itemService.getAllItems();
      _allItemIds = items.keys.toList();
      
      if (_allItemIds.isNotEmpty) {
        await loadItemByIndex(0);
      }
    } catch (e) {
      print('Error cargando items: $e');
      setState(() {
        _isLoadingItem = false;
      });
      _showErrorDialog('Error cargando items: $e');
    }
  }

  Future<void> loadItemByIndex(int index) async {
    if (index >= _allItemIds.length) {
      _showCompletionDialog();
      return;
    }

    setState(() {
      _isLoadingItem = true;
      _currentItemIndex = index;
    });
    
    try {
      final item = await _itemService.getItemById(_allItemIds[index]);
      if (item != null) {
        setState(() {
          currentItem = item;
          _isLoadingItem = false;
          controllers.values.forEach((controller) => controller.clear());
        });
        await _extractDominantColor(item.getImageUrl(ItemService.version));
      }
    } catch (e) {
      print('Error cargando item: $e');
      setState(() {
        _isLoadingItem = false;
      });
    }
  }

  Future<void> _extractDominantColor(String imageUrl) async {
    try {
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
        maximumColorCount: 30,
      );
      
      setState(() {
        _darkVibrantColor = paletteGenerator.darkVibrantColor?.color ?? Colors.cyan;
        _darkMutedColor = paletteGenerator.darkMutedColor?.color ?? Colors.cyan;
        _lightVibrantColor = paletteGenerator.lightVibrantColor?.color ?? Colors.white;
        _lightMutedColor = paletteGenerator.lightMutedColor?.color ?? Colors.grey;
        _vibrantColor = paletteGenerator.vibrantColor?.color ?? Colors.white;
        _mutedColor = paletteGenerator.mutedColor?.color ?? Colors.grey;
        _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
        _isLoadingColor = false;
      });
    } catch (e) {
      setState(() {
        _darkVibrantColor = Colors.cyan;
        _darkMutedColor = Colors.cyan;
        _lightVibrantColor = Colors.white;
        _vibrantColor = Colors.white;
        _mutedColor = Colors.grey;
        _lightMutedColor = Colors.grey;
        _dominantColor = Colors.black;
        _isLoadingColor = false;
      });
    }
  }

  void _validateAndNext() {
    if (_formKey.currentState?.validate() ?? false) {
      bool allCorrect = true;
      String incorrectField = '';
      
      final fieldsToValidate = getFieldsToDisplay();
      
      for (var field in fieldsToValidate) {
        if (!controllers.containsKey(field.name)) continue;
        
        final userInput = controllers[field.name]!.text.trim();
        final correctValue = field.getCorrectValue(currentItem!);
        
        print('🔍 Validando ${field.label}:');
        print('   Usuario: "$userInput"');
        print('   Correcto: "$correctValue"');
        
        bool isCorrect = false;
        
        // Detectar si es campo numérico
        final isNumericField = field.inputType == TextInputType.number || 
            field.inputType.toString().contains('number');
        
        if (isNumericField) {
          final userNum = double.tryParse(userInput);
          final correctNum = double.tryParse(correctValue);
          
          if (userNum != null && correctNum != null) {
            isCorrect = (userNum - correctNum).abs() < 0.01;
            print('   Numérico: $userNum vs $correctNum = $isCorrect');
          }
        } else {
          isCorrect = userInput.toLowerCase() == correctValue.toLowerCase();
          print('   Texto: $isCorrect');
        }
        
        if (!isCorrect) {
          allCorrect = false;
          incorrectField = field.label;
          print('   ❌ Incorrecto');
          break;
        } else {
          print('   ✅ Correcto');
        }
      }

      if (allCorrect) {
        _showSuccessMessage();
        Future.delayed(Duration(milliseconds: 500), () {
          loadItemByIndex(_currentItemIndex + 1);
        });
      } else {
        _showErrorMessage();
      }
    }
  }

  List<GameField> getFieldsToDisplay() {
    return widget.getFields();
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Correct! ${currentItem?.name}', softWrap: true),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Text('Incorrect. Try again.'),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showCompletionDialog() {
    _saveScore();
    int currentScore = _authService.getScore(widget.getGameMode());
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber, size: 32),
            SizedBox(width: 8),
            Text('Completed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You have gotten all items right! (${_allItemIds.length} items)',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '${widget.getGameMode()} Score: $currentScore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              loadItemByIndex(0);
            },
            child: Text('Restart'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadAllItems();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveScore() async {
    int currentScore = _authService.getScore(widget.getGameMode());
    int newScore = currentScore + 1;
    await _authService.updateScore(widget.getGameMode(), newScore);
  }

  Widget _createTextFormField(GameField field) {
    return Column(
      children: [
        Text(
          field.label,
          style: GoogleFonts.balthazar(
            letterSpacing: 2,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
          ),
        ),
        TextFormField(
          style: GoogleFonts.balthazar(
            letterSpacing: 2.0,
            fontSize: 20,
            color: _isLoadingColor ? _mutedColor : _lightMutedColor,
          ),
          keyboardType: field.inputType,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field must be completed';
            }
            return null;
          },
          decoration: InputDecoration(
            labelStyle: GoogleFonts.balthazar(
              fontSize: 20,
              color: _isLoadingColor ? _mutedColor : _lightMutedColor,
            ),
            hintStyle: GoogleFonts.balthazar(
              fontSize: 20,
              color: _isLoadingColor ? _mutedColor : _lightMutedColor,
            ),
            hintText: "· · ·",
            labelText: field.label,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.black,
          ),
          controller: controllers[field.name],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String imgUrl = currentItem?.getImageUrl(ItemService.version) ?? '';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.getTitle(),
          style: GoogleFonts.kenia(
            letterSpacing: 2.0,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
        actions: [
          if (!_isLoadingItem && _allItemIds.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_currentItemIndex + 1}/${_allItemIds.length}',
                  style: GoogleFonts.balthazar(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isLoadingColor ? _mutedColor : _lightMutedColor,
                  ),
                ),
              ),
            ),
        ],
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 35),
        child: ElevatedButton(
          onPressed: _isLoadingItem ? null : _validateAndNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
            disabledBackgroundColor: _isLoadingColor
                ? _darkMutedColor.withValues(alpha: 0.5)
                : _darkVibrantColor.withValues(alpha: 0.5),
          ),
          child: Text(
            'Confirm',
            style: GoogleFonts.balthazar(
              letterSpacing: 2.0,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
            ),
          ),
        ),
      ),
      body: _isLoadingItem
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                color: _dominantColor.withValues(alpha: 0.12),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  colorFilter: ColorFilter.mode(
                    Color.fromRGBO(0, 0, 0, 0.5),
                    BlendMode.darken,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                          margin: EdgeInsets.fromLTRB(115, 0, 115, 0),
                          decoration: BoxDecoration(
                            color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
                            border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                imgUrl,
                                scale: 0.5,
                                width: 100,
                                height: 100,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.image_not_supported, size: 100);
                                },
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Id: ${currentItem?.id ?? '...'}",
                                style: GoogleFonts.balthazar(
                                  letterSpacing: 2.0,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 2,
                          color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
                          margin: EdgeInsets.all(20),
                        ),
                        ...getFieldsToDisplay().map((field) {
                          return Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: _createTextFormField(field),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}