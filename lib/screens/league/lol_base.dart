import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../services/auth_service.dart';
import '../../models/item_model.dart';
import '../../services/item_service.dart';
import '../../services/local_storage_service.dart';
import '../screens.dart';

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
  final bool showHint;

  GameField({
    required this.name,
    required this.label,
    required this.inputType,
    required this.getCorrectValue,
    this.showHint = false,
  });
}

abstract class BaseGameState<T extends BaseGameScreen> extends State<T> {
  final AuthService _authService = AuthService();
  final ItemService _itemService = ItemService();
  final LocalStorageService _storage = LocalStorageService();
  final _formKey = GlobalKey<FormState>();

  // Controladores accesibles por subclases
  final Map<String, TextEditingController> controllers = {};

  // ─── Colores ────────────────────────────────────────────
  Color _darkVibrantColor = Colors.cyan;
  Color _darkMutedColor = Colors.cyan;
  Color _lightVibrantColor = Colors.white;
  Color _vibrantColor = Colors.white;
  Color _lightMutedColor = Colors.grey;
  Color _mutedColor = Colors.grey;
  Color _dominantColor = Colors.black;
  bool _isLoadingColor = true;

  // ─── Estado del juego ───────────────────────────────────
  Item? currentItem;
  bool _isLoadingItem = true;
  List<String> _allItemIds = [];
  int _currentItemIndex = 0;

  // ─── Vidas ──────────────────────────────────────────────
  static const int maxLives = 10;
  int _lives = maxLives;

  // ─── INIT / DISPOSE ─────────────────────────────────────

  @override
  void initState() {
    super.initState();
    // Inicializar solo los campos base; las subclases añaden los suyos
    for (var field in widget.getFields()) {
      controllers[field.name] = TextEditingController();
    }
    _initGame();
  }

  @override
  void dispose() {
    // Guardar antes de salir
    _storage.saveProgress(widget.getGameMode(), _lives, _currentItemIndex);
    // Limpiar todos los controladores que existan en ese momento
    for (var c in controllers.values) {
      c.dispose();
    }
    controllers.clear();
    super.dispose();
  }

  // ─── INICIALIZACIÓN ─────────────────────────────────────

  Future<void> _initGame() async {
    setState(() => _isLoadingItem = true);

    try {
      final items = await _itemService.getAllItems();
      _allItemIds = items.keys.toList();
      if (_allItemIds.isEmpty) return;

      final saved = await _storage.loadProgress(widget.getGameMode());
      if (saved != null) {
        // Restaurar vidas ANTES de llamar loadItemByIndex
        _lives = saved['lives']!.clamp(0, maxLives);
        final savedIndex = saved['itemIndex']!.clamp(0, _allItemIds.length - 1);
        await loadItemByIndex(savedIndex);
      } else {
        _lives = maxLives;
        await loadItemByIndex(0);
      }
    } catch (e) {
      setState(() => _isLoadingItem = false);
      _showErrorDialog('Error loading items: $e');
    }
  }

  // ─── CARGA DE ITEMS (sobreescribible por subclases) ─────

  Future<void> loadItemByIndex(int index) async {
    if (index >= _allItemIds.length) {
      await _onGameCompleted();
      return;
    }

    if (!mounted) return;
    setState(() {
      _isLoadingItem = true;
      _currentItemIndex = index;
    });

    try {
      final item = await _itemService.getItemById(_allItemIds[index]);

      if (!mounted)
        return; // El widget puede haberse desmontado mientras esperaba

      if (item != null) {
        setState(() {
          currentItem = item;
          _isLoadingItem = false;
          for (var c in controllers.values) {
            c.clear();
          }
        });

        await _extractDominantColor(item.getImageUrl(ItemService.version));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingItem = false);
    }
  }

  // ─── VALIDACIÓN ─────────────────────────────────────────

  void _validateAndNext() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    String? incorrectFieldLabel;
    String? hint;

    for (var field in getFieldsToDisplay()) {
      if (!controllers.containsKey(field.name)) continue;

      final userInput = controllers[field.name]!.text.trim();
      final correctValue = field.getCorrectValue(currentItem!);
      final isNumeric = field.inputType.toString().contains('number');

      bool isCorrect;

      if (isNumeric) {
        final userNum = double.tryParse(userInput);
        final correctNum = double.tryParse(correctValue);
        if (userNum != null && correctNum != null) {
          isCorrect = (userNum - correctNum).abs() < 0.01;
          if (!isCorrect && field.showHint && hint == null) {
            hint = userNum < correctNum
                ? '${field.label}: too low ↑'
                : '${field.label}: too high ↓';
          }
        } else {
          isCorrect = false;
        }
      } else {
        isCorrect = userInput.toLowerCase() == correctValue.toLowerCase();
      }

      if (!isCorrect) {
        incorrectFieldLabel ??= field.label;
        break;
      }
    }

    if (incorrectFieldLabel == null) {
      _onCorrectAnswer();
    } else {
      _onWrongAnswer(incorrectFieldLabel, hint);
    }
  }

  // ─── ACIERTO ────────────────────────────────────────────

  void _onCorrectAnswer() {
    setState(() => _lives = (_lives + 1).clamp(0, maxLives));
    // Guardar inmediatamente con el índice siguiente
    _storage.saveProgress(widget.getGameMode(), _lives, _currentItemIndex + 1);
    _showSuccessSnackbar();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) loadItemByIndex(_currentItemIndex + 1);
    });
  }

  // ─── FALLO ──────────────────────────────────────────────

  void _onWrongAnswer(String fieldLabel, String? hint) {
    setState(() => _lives = (_lives - 1).clamp(0, maxLives));
    _storage.addFail(widget.getGameMode());
    // Guardar inmediatamente con las vidas actualizadas
    _storage.saveProgress(widget.getGameMode(), _lives, _currentItemIndex);

    if (_lives == 0) {
      _showGameOverDialog();
    } else {
      _showErrorSnackbar(fieldLabel, hint);
    }
  }

  // ─── COMPLETAR ──────────────────────────────────────────

  Future<void> _onGameCompleted() async {
    _saveScore();
    await _authService.updateScore(
      widget.getGameMode(),
      _authService.getScore(widget.getGameMode()) + 1,
    );
    await _storage.addWin(widget.getGameMode());
    await _storage.clearProgress(widget.getGameMode());
    if (!mounted) return;
    _showCompletionDialog();
  }

  Future<void> _restartGame() async {
    await _storage.clearProgress(widget.getGameMode());
    await _storage.addAttempt(widget.getGameMode());
    setState(() => _lives = maxLives);
    await loadItemByIndex(0);
  }

  // ─── COLOR DINÁMICO ─────────────────────────────────────

  Future<void> _extractDominantColor(String imageUrl) async {
    try {
      final palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(imageUrl),
        maximumColorCount: 30,
      );
      if (!mounted) return;
      setState(() {
        _darkVibrantColor = palette.darkVibrantColor?.color ?? Colors.cyan;
        _darkMutedColor = palette.darkMutedColor?.color ?? Colors.cyan;
        _lightVibrantColor = palette.lightVibrantColor?.color ?? Colors.white;
        _lightMutedColor = palette.lightMutedColor?.color ?? Colors.grey;
        _vibrantColor = palette.vibrantColor?.color ?? Colors.white;
        _mutedColor = palette.mutedColor?.color ?? Colors.grey;
        _dominantColor = palette.dominantColor?.color ?? Colors.black;
        _isLoadingColor = false;
      });
    } catch (_) {
      if (!mounted) return;
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

  // ─── SOBREESCRIBIBLE POR SUBCLASES ──────────────────────

  List<GameField> getFieldsToDisplay() => widget.getFields();

  // ─── SNACKBARS ──────────────────────────────────────────

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text('Correct! ${currentItem?.name}')),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 800),
      ),
    );
  }

  void _showErrorSnackbar(String fieldLabel, String? hint) {
    String message = 'Wrong: $fieldLabel.';
    if (hint != null) message += '  $hint.';
    message += '  Lives: $_lives';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // ─── DIÁLOGOS ───────────────────────────────────────────

  void _showGameOverDialog() {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.heart_broken, color: Colors.red, size: 32),
            SizedBox(width: 8),
            Text('Game Over'),
          ],
        ),
        content: Text(
          'You ran out of lives on item ${_currentItemIndex + 1}/${_allItemIds.length}.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _restartGame();
            },
            child: Text('Retry'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _restartGame();
              navigator.pop();
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
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
            Text('You got all ${_allItemIds.length} items right!'),
            SizedBox(height: 8),
            Text(
              'Lives remaining: $_lives / $maxLives',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _restartGame();
            },
            child: Text('Restart'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              navigator.pop();
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
      builder: (ctx) => AlertDialog(
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
              Navigator.pop(ctx);
              _initGame();
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Guarda la puntuacion en la base de datos
  Future<void> _saveScore() async {
    int currentScore = _authService.getScore(widget.getGameMode());
    int newScore = currentScore + 1;
    await _authService.updateScore(widget.getGameMode(), newScore);
  }

  // ─── WIDGETS ────────────────────────────────────────────

  // Barra de vida
  Widget _buildLivesBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxLives, (i) {
        final filled = i < _lives;
        return Icon(
          filled ? Icons.favorite : Icons.favorite_border,
          color: filled ? Colors.red : Colors.grey,
          size: 20,
        );
      }),
    );
  }

  // Devuelve una column con los labels y textformfields de cada campo
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
          validator: (v) =>
              (v == null || v.isEmpty) ? 'Field must be completed' : null,
          decoration: InputDecoration(
            labelStyle: GoogleFonts.balthazar(
              fontSize: 20,
              color: _isLoadingColor ? _mutedColor : _lightMutedColor,
            ),
            hintStyle: GoogleFonts.balthazar(
              fontSize: 20,
              color: _isLoadingColor ? _mutedColor : _lightMutedColor,
            ),
            hintText: '· · ·',
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

  // ─── BUILD ──────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final imgUrl = currentItem?.getImageUrl(ItemService.version) ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.getTitle(),
          style: GoogleFonts.kenia(
            letterSpacing: 2.0,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
        actions: [
          if (!_isLoadingItem && _allItemIds.isNotEmpty)
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                '${_currentItemIndex + 1}/${_allItemIds.length}',
                style: GoogleFonts.balthazar(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _isLoadingColor ? _mutedColor : _lightMutedColor,
                ),
              ),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(36),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: _buildLivesBar(),
          ),
        ),
      ),
      drawer: SideDrawer(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
        child: ElevatedButton(
          onPressed: _isLoadingItem ? null : _validateAndNext,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isLoadingColor
                ? _darkMutedColor
                : _darkVibrantColor,
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
                            color: _isLoadingColor
                                ? _darkMutedColor
                                : _darkVibrantColor,
                            border: Border.all(
                              color: Color.fromARGB(0, 0, 0, 0),
                            ),
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
                                errorBuilder: (_, __, ___) =>
                                    Icon(Icons.image_not_supported, size: 100),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Id: ${currentItem?.id ?? '...'}',
                                style: GoogleFonts.balthazar(
                                  letterSpacing: 2.0,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: _isLoadingColor
                                      ? _lightVibrantColor
                                      : _vibrantColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 2,
                          color: _isLoadingColor
                              ? _darkMutedColor
                              : _darkVibrantColor,
                          margin: EdgeInsets.all(20),
                        ),
                        ...getFieldsToDisplay().map(
                          (field) => Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: _createTextFormField(field),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}