import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

// Pantalla de registro de usuario
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _database = FirebaseDatabase.instance.ref();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Metodo que se encarga de validar que puede crearse ese usuario
  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Verificar que el username no exista ya
      final snapshot = await _database.child('Users').get();

      if (snapshot.exists) {
        final users = snapshot.value as Map<dynamic, dynamic>;
        final usernameTaken = users.values.any(
          (user) =>
              (user as Map<dynamic, dynamic>)['Username']
                  ?.toString()
                  .toLowerCase() ==
              _usernameController.text.trim().toLowerCase(),
        );

        if (usernameTaken) {
          if (!mounted) return;
          setState(() => _isLoading = false);
          _showError('Username already taken');
          return;
        }
      }

      // Crear nuevo usuario con estructura de tu base de datos
      final newUserRef = _database.child('Users').push();
      await newUserRef.set({
        'Username': _usernameController.text.trim(),
        'Password': _passwordController.text,
        'Scores': {
          'Lol': {
            'Easy': 0,
            'Medium': 0,
            'Hard': 0,
          }
        }
      });

      if (!mounted) return;
      setState(() => _isLoading = false);

      // Mostrar éxito y volver al login
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text('Account created! You can now log in.'),
        ]),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      Future.delayed(Duration(seconds: 2), () {
        if (mounted) Navigator.pop(context);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      _showError('Error creating account: $e');
    }
  }

  // Metodo que muestra un snackbar si hay un error
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        Icon(Icons.error, color: Colors.white),
        SizedBox(width: 8),
        Expanded(child: Text(message)),
      ]),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/HomeBackground.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40),

                  // Logo
                  Column(
                    children: [
                      Text("Itemdle",
                          style: GoogleFonts.kenia(fontSize: 50),
                          textAlign: TextAlign.center),
                      Image.asset("assets/images/ItemSquareWorld_Atlas.png",
                          width: 200),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Formulario
                  Container(
                    width: screenWidth * 0.9,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      border: Border.all(
                          width: 10,
                          color: Color.fromRGBO(255, 255, 255, 0.15)),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      children: [
                        Text("Create Account",
                            style: GoogleFonts.kenia(
                                fontSize: 32, letterSpacing: 2),
                            textAlign: TextAlign.center),
                        SizedBox(height: 24),

                        // Username
                        _buildLabel("Username"),
                        SizedBox(height: 8),
                        _buildField(
                          controller: _usernameController,
                          hint: "Enter username",
                          icon: Icons.person,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Username is required';
                            }
                            if (v.trim().isEmpty) {
                              return 'At least 1 character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Password
                        _buildLabel("Password"),
                        SizedBox(height: 8),
                        _buildField(
                          controller: _passwordController,
                          hint: "Enter password",
                          icon: Icons.lock,
                          obscure: _obscurePassword,
                          toggleObscure: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Password is required';
                            }
                            if (v.isEmpty) {
                              return 'At least 1 character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Confirm Password
                        _buildLabel("Confirm Password"),
                        SizedBox(height: 8),
                        _buildField(
                          controller: _confirmPasswordController,
                          hint: "Repeat password",
                          icon: Icons.lock_outline,
                          obscure: _obscureConfirm,
                          toggleObscure: () => setState(
                              () => _obscureConfirm = !_obscureConfirm),
                          validator: (v) {
                            if (v != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30),

                        // Botón Register
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan,
                              disabledBackgroundColor:
                                  Colors.cyan.withValues(alpha: 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : Text("Register",
                                    style: GoogleFonts.balthazar(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                        color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Volver al login
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Already have an account? Log in",
                              style: GoogleFonts.balthazar(
                                  fontSize: 15, color: Colors.white70)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Devuelve el label con el texto que se introduzca
  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: GoogleFonts.balthazar(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 2)),
    );
  }

  // Encargado de construir el textformfield para cada campo
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    VoidCallback? toggleObscure,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: !_isLoading,
      obscureText: obscure,
      style: GoogleFonts.balthazar(fontSize: 18, letterSpacing: 1.5),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.balthazar(fontSize: 16),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                    obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70),
                onPressed: toggleObscure,
              )
            : null,
      ),
    );
  }
}