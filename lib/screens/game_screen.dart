import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class GameScreen extends StatefulWidget {
  final String nodeTitle;

  const GameScreen({super.key, required this.nodeTitle});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const _channel = MethodChannel('com.capstone.waddah/unity');

  bool _permissionGranted = false;
  bool _launching = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (mounted) {
      setState(() => _permissionGranted = status.isGranted);
      if (status.isGranted) _launchUnity();
    }
  }

  Future<void> _launchUnity() async {
    if (_launching) return;
    setState(() => _launching = true);
    try {
      await _channel.invokeMethod('launchUnity');
    } on PlatformException catch (e) {
      debugPrint('Failed to launch Unity: ${e.message}');
    } finally {
      if (mounted) setState(() => _launching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE9D4FF), Color(0xFFB9F8CF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Color(0xFF00C853)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'لعبة الواقع الافتراضي',
                  style: GoogleFonts.cairo(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF9000FF),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: _permissionGranted
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.view_in_ar, size: 80, color: Color(0xFF9000FF)),
                            const SizedBox(height: 24),
                            Text(
                              _launching ? 'جاري تشغيل اللعبة...' : 'اضغط لبدء اللعبة',
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                color: const Color(0xFF1E293B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (!_launching)
                              ElevatedButton.icon(
                                onPressed: _launchUnity,
                                icon: const Icon(Icons.play_arrow),
                                label: Text(
                                  'تشغيل اللعبة',
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9000FF),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              )
                            else
                              const CircularProgressIndicator(color: Color(0xFF9000FF)),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.camera_alt_outlined, size: 64, color: Color(0xFF9000FF)),
                              const SizedBox(height: 16),
                              Text(
                                'يحتاج إذن الكاميرا لتشغيل لعبة الواقع الافتراضي',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.cairo(fontSize: 16, color: const Color(0xFF1E293B)),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _requestCameraPermission,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9000FF),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  'منح الإذن',
                                  style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
