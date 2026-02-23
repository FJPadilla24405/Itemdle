import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/local_storage_service.dart';
import '../utils/global_user.dart';

// Pantalla con las puntuaciones del jugador y su información
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final GlobalUser _globalUser = GlobalUser();
  final LocalStorageService _storage = LocalStorageService();

  Map<String, int> _easyStats = {};
  Map<String, int> _mediumStats = {};
  Map<String, int> _hardStats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final easy = await _storage.getStats('Easy');
    final medium = await _storage.getStats('Medium');
    final hard = await _storage.getStats('Hard');

    setState(() {
      _easyStats = easy;
      _mediumStats = medium;
      _hardStats = hard;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.kenia(fontSize: 40, letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/HomeBackground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Avatar + Username ─────────────────────────────
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.cyan,
                            child: Text(
                              (_globalUser.username ?? '?')
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: GoogleFonts.kenia(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            _globalUser.username ?? 'Unknown',
                            style: GoogleFonts.kenia(
                              fontSize: 32,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'ID: ${_globalUser.userId ?? '-'}',
                            style: GoogleFonts.balthazar(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 32),

                    // ─── Stats por modo ────────────────────────────────
                    Text(
                      'League of Legends',
                      style: GoogleFonts.kenia(fontSize: 26, letterSpacing: 2),
                    ),
                    SizedBox(height: 12),
                    _buildModeCard('Easy Mode', _easyStats, Colors.green),
                    SizedBox(height: 12),
                    _buildModeCard('Medium Mode', _mediumStats, Colors.orange),
                    SizedBox(height: 12),
                    _buildModeCard('Hard Mode', _hardStats, Colors.red),
                  ],
                ),
              ),
            ),
    );
  }

  // Construye un contenedor con las puntuaciones dependiendo del modo
  Widget _buildModeCard(String title, Map<String, int> stats, Color color) {
    final wins = stats['wins'] ?? 0;
    final attempts = stats['attempts'] ?? 0;
    final fails = stats['fails'] ?? 0;
    final winRate = attempts > 0
        ? '${((wins / attempts) * 100).toStringAsFixed(1)}%'
        : '-';

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.balthazar(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Win rate: $winRate',
                style: GoogleFonts.balthazar(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.emoji_events, '$wins', 'Wins', Colors.amber),
              _buildStatItem(
                Icons.replay,
                '$attempts',
                'Attempts',
                Colors.blue,
              ),
              _buildStatItem(Icons.close, '$fails', 'Fails', Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  // Devuelve un column con un icono distinto para cada puntuacion
  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.balthazar(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.balthazar(fontSize: 13, color: Colors.grey),
        ),
      ],
    );
  }
}
