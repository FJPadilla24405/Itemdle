// services/auth_service.dart

import 'package:firebase_database/firebase_database.dart';
import '../utils/global_user.dart';

class AuthService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final GlobalUser _globalUser = GlobalUser();

  // Login del usuario
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Obtener referencia a los usuarios
      final usersRef = _database.child('Users');
      
      // Buscar el usuario por username
      final snapshot = await usersRef.get();
      
      if (!snapshot.exists) {
        return {
          'success': false,
          'message': 'No users found in database'
        };
      }

      // Recorrer todos los usuarios para encontrar el username
      final users = snapshot.value as Map<dynamic, dynamic>;
      
      for (var entry in users.entries) {
        final userId = entry.key;
        final userData = entry.value as Map<dynamic, dynamic>;
        
        // Verificar si el username coincide
        if (userData['Username']?.toString().toLowerCase() == username.toLowerCase()) {
          // Verificar la contraseña
          if (userData['Password']?.toString() == password) {
            // Login exitoso - guardar en variable global
            _globalUser.setUser(
              username: userData['Username'].toString(),
              userId: userId.toString(),
              userData: {
                'Scores': userData['Scores'] ?? {},
              },
            );
            
            return {
              'success': true,
              'message': 'Login successful',
              'userId': userId,
              'username': userData['Username'],
              'scores': userData['Scores'] ?? {},
            };
          } else {
            return {
              'success': false,
              'message': 'Incorrect password'
            };
          }
        }
      }
      
      // Usuario no encontrado
      return {
        'success': false,
        'message': 'Username not found'
      };
      
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e'
      };
    }
  }

  // Logout
  void logout() {
    _globalUser.clearUser();
  }

  // Obtener scores del usuario actual
  Map<String, dynamic>? getCurrentUserScores() {
    if (_globalUser.userData != null) {
      return _globalUser.userData!['Scores'] as Map<String, dynamic>?;
    }
    return null;
  }

  // Actualizar score en Firebase
  Future<bool> updateScore(String gameMode, int newScore) async {
    try {
      if (!_globalUser.isLoggedIn) return false;
      
      await _database
          .child('Users')
          .child(_globalUser.userId!)
          .child('Scores')
          .child('Lol')
          .child(gameMode)
          .set(newScore);
      
      return true;
    } catch (e) {
      print('Error updating score: $e');
      return false;
    }
  }
}
