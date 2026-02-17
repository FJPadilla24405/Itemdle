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
        return {'success': false, 'message': 'No users found in database'};
      }

      // Recorrer todos los usuarios para encontrar el username
      final users = snapshot.value as Map<dynamic, dynamic>;

      for (var entry in users.entries) {
        final userId = entry.key.toString();
        final userData = entry.value as Map<dynamic, dynamic>;

        // Verificar si el username coincide
        if (userData['Username']?.toString().toLowerCase() ==
            username.toLowerCase()) {
          // Verificar la contraseña
          if (userData['Password']?.toString() == password) {
            // Obtener scores
            Map<String, dynamic> scores = {'Easy': 0, 'Medium': 0, 'Hard': 0};

            if (userData['Scores'] != null) {
              final scoresData = userData['Scores'] as Map<dynamic, dynamic>;
              if (scoresData['Lol'] != null) {
                final lolScores = scoresData['Lol'] as Map<dynamic, dynamic>;
                scores = {
                  'Easy': lolScores['Easy'] ?? 0,
                  'Medium': lolScores['Medium'] ?? 0,
                  'Hard': lolScores['Hard'] ?? 0,
                };
              }
            }

            // Login exitoso - guardar en variable global
            _globalUser.setUser(
              username: userData['Username'].toString(),
              userId: userId,
              userData: {
                'Password': userData['Password'].toString(),
                'Scores': {'Lol': scores},
              },
            );

            return {
              'success': true,
              'message': 'Login successful',
              'userId': userId,
              'username': userData['Username'],
              'scores': scores,
            };
          } else {
            return {'success': false, 'message': 'Incorrect password'};
          }
        }
      }

      // Usuario no encontrado
      return {'success': false, 'message': 'Username not found'};
    } catch (e) {
      print('Login error details: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Logout
  void logout() {
    _globalUser.clearUser();
  }

  // Obtener scores del usuario actual
  Map<String, dynamic>? getCurrentUserScores() {
    if (_globalUser.userData != null &&
        _globalUser.userData!['Scores'] != null) {
      return _globalUser.userData!['Scores']['Lol'] as Map<String, dynamic>?;
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

      // Actualizar también en la variable global
      if (_globalUser.userData != null) {
        if (_globalUser.userData!['Scores'] == null) {
          _globalUser.userData!['Scores'] = {'Lol': {}};
        }
        if (_globalUser.userData!['Scores']['Lol'] == null) {
          _globalUser.userData!['Scores']['Lol'] = {};
        }
        _globalUser.userData!['Scores']['Lol'][gameMode] = newScore;
      }

      return true;
    } catch (e) {
      print('Error updating score: $e');
      return false;
    }
  }

  // Obtener un score específico
  int getScore(String gameMode) {
    if (_globalUser.userData != null &&
        _globalUser.userData!['Scores'] != null &&
        _globalUser.userData!['Scores']['Lol'] != null) {
      return _globalUser.userData!['Scores']['Lol'][gameMode] ?? 0;
    }
    return 0;
  }
}
