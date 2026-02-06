// utils/global_user.dart

class GlobalUser {
  static final GlobalUser _instance = GlobalUser._internal();
  
  factory GlobalUser() {
    return _instance;
  }
  
  GlobalUser._internal();
  
  // Variables globales del usuario
  String? _username;
  String? _userId;
  Map<String, dynamic>? _userData;
  
  // Getters
  String? get username => _username;
  String? get userId => _userId;
  Map<String, dynamic>? get userData => _userData;
  
  // Setters
  void setUser({
    required String username,
    required String userId,
    Map<String, dynamic>? userData,
  }) {
    _username = username;
    _userId = userId;
    _userData = userData;
  }
  
  // Limpiar usuario (logout)
  void clearUser() {
    _username = null;
    _userId = null;
    _userData = null;
  }
  
  // Verificar si hay usuario logueado
  bool get isLoggedIn => _username != null && _userId != null;
}
