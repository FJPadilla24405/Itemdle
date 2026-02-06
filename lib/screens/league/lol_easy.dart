import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../themes/themes.dart';
import '../../models/item_model.dart';
import '../../services/item_service.dart';
import '../side_drawer.dart';

class EasyLol extends StatelessWidget {
  const EasyLol({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Mode',
      theme: Temas().Game(),
      home: EasyForm(),
    );
  }
}

class EasyForm extends StatefulWidget {
  const EasyForm({super.key});

  @override
  State<EasyForm> createState() => FormWidget();
}

class FormWidget extends State<EasyForm> {
  final _formKey = GlobalKey<FormState>();
  //final List<TextEditingController> _textEditingControllers = [];
  final TextEditingController _nameController = TextEditingController();
  final ItemService _itemService = ItemService();
  
  // Variables para el color dinámico
  Color _darkVibrantColor = Colors.cyan;
  Color _darkMutedColor = Colors.cyan;
  Color _lightVibrantColor = Colors.white;
  Color _vibrantColor = Colors.white;
  Color _lightMutedColor = Colors.grey;
  Color _mutedColor = Colors.grey;
  Color _dominantColor = Colors.black;
  bool _isLoadingColor = true;

  // Variables para el item de la API
  Item? _currentItem;
  bool _isLoadingItem = true;
  List<String> _allItemIds = [];
  int _currentItemIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadAllItems();
  }
  
  @override
  void dispose() {
    _nameController.dispose();
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
        await _loadItemByIndex(0);
      }
    } catch (e) {
      print('Error cargando items: $e');
      setState(() {
        _isLoadingItem = false;
      });
      _showErrorDialog('Error cargando items: $e');
    }
  }

  Future<void> _loadItemByIndex(int index) async {
    if (index >= _allItemIds.length) {
      // Ya terminó todos los items
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
          _currentItem = item;
          _isLoadingItem = false;
          _nameController.clear(); // Limpiar el campo
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

  // Extraer color dominante de la imagen
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
      final userInput = _nameController.text.trim().toLowerCase();
      final correctName = _currentItem?.name.toLowerCase() ?? '';

      if (userInput == correctName) {
        // ¡Correcto! Pasar al siguiente
        _showSuccessMessage();
        Future.delayed(Duration(milliseconds: 500), () {
          _loadItemByIndex(_currentItemIndex + 1);
        });
      } else {
        // Incorrecto
        _showErrorMessage();
      }
    }
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Correct! ${_currentItem?.name}', softWrap: true,),
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
        content: Text(
          'You have gotten all items right! (${_allItemIds.length} items)',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _loadItemByIndex(0); // Reiniciar
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
              _loadAllItems(); // Reintentar
            },
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  Column _createTextFormField(String fieldName, TextEditingController controller, TextInputType textType) {
    return Column (
      children: [
        Text(fieldName,
          style: GoogleFonts.balthazar(
            letterSpacing: 2,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _isLoadingColor ? _lightVibrantColor : _vibrantColor
          )
        ),
        TextFormField(
          style: GoogleFonts.balthazar(
            letterSpacing: 2.0,
            fontSize: 20,
            color: _isLoadingColor ? _mutedColor : _lightMutedColor,
          ),
          keyboardType: textType,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field must be completed';
            } 
            return null;
          },
          decoration: InputDecoration(
            labelStyle: GoogleFonts.balthazar(fontSize: 20, color: _isLoadingColor ? _mutedColor : _lightMutedColor),
            hintStyle: GoogleFonts.balthazar(fontSize: 20, color: _isLoadingColor ? _mutedColor : _lightMutedColor),
            hintText: "· · ·",
            labelText: fieldName,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: _isLoadingColor ? _lightVibrantColor : _vibrantColor, width: 2),
            ),
            filled: true,
            fillColor: Colors.black
          ),
          controller: controller,
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    String _imgUrl = _currentItem?.getImageUrl(ItemService.version) ?? '';
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Easy Mode",
          style: GoogleFonts.kenia(
            letterSpacing: 2.0,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: _isLoadingColor ? _lightVibrantColor : _vibrantColor
          ),
        ),
        centerTitle: true,
        backgroundColor: _isLoadingColor ? _darkMutedColor: _darkVibrantColor,
        actions: [
          // Mostrar progreso
          if (!_isLoadingItem && _allItemIds.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_currentItemIndex + 1}/${_allItemIds.length}',
                  style: GoogleFonts.balthazar(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isLoadingColor ? _mutedColor : _lightMutedColor
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
            disabledBackgroundColor: _isLoadingColor ? _darkMutedColor.withValues(alpha: 0.5) : _darkVibrantColor.withValues(alpha: 0.5),
          ),
          child: Text('Confirm',
            style: GoogleFonts.balthazar(
              letterSpacing: 2.0,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: _isLoadingColor ? _lightVibrantColor : _vibrantColor,
            )
          ),
        ),
      ),
      body: _isLoadingItem? Center(child: CircularProgressIndicator()) :
        Container( 
          decoration: BoxDecoration(
            color: _dominantColor.withValues(alpha: 0.12),
            image: DecorationImage(
              image: NetworkImage(_imgUrl),
              colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, 0.85), BlendMode.darken),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(4, 10, 4, 4),
                  margin: EdgeInsets.fromLTRB(125, 0, 125, 0),
                  decoration: BoxDecoration(
                    color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(25),
                  ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Imagen del item desde la API
                          Image.network(
                            _imgUrl,
                            scale: 0.5,
                            width: 100,
                            height: 100,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image_not_supported, size: 100);
                            },
                          ),
                          SizedBox(height: 5),
                          // ID del item desde la API
                          Text(
                            "Id: ${_currentItem?.id ?? '...'}",
                            style: GoogleFonts.balthazar(
                              letterSpacing: 2.0,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: _isLoadingColor ? _lightVibrantColor : _vibrantColor
                            )
                          )
                        ]
                      )
                    ),
                    Container(
                      width: 1,
                      height: 2,
                      color: _isLoadingColor ? _darkMutedColor : _darkVibrantColor,
                      margin: EdgeInsets.all(20),
                    ),
                    // Campos del formulario
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: _createTextFormField("Name", _nameController, TextInputType.name),
                    ),
                  ],
                ),
              ),
            ),
    )));
  }
}