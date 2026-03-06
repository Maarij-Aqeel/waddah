import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_dashboard.dart'; // To allow returning to map
import 'lesson_videos_screen.dart';

class NodeProgressScreen extends StatelessWidget {
  final String nodeTitle;
  
  const NodeProgressScreen({
    super.key,
    required this.nodeTitle,
  });

  @override
  Widget build(BuildContext context) {
    final String userName = FirebaseAuth.instance.currentUser?.displayName ?? 'Noura khalid';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE9D4FF), // Light purple
              Color(0xFFB9F8CF), // Light mint green
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Right Back Button
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
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward, color: Color(0xFF00C853)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),

              // Header: Avatar Circle and User Pill
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Floating Logo Box
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/logo.png', // Fallback to provided logo
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.train, size: 50, color: Color(0xFF9000FF)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // User Info Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side: Stars
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF9C4), // Light yellow
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '0',
                                  style: GoogleFonts.cairo(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFE65100),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.star_border_rounded, color: Color(0xFFffb703), size: 18),
                              ],
                            ),
                          ),

                          // Right side: Avatar and Name
                          Row(
                            children: [
                              Text(
                                userName,
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF9000FF),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'مرحباً',
                                style: GoogleFonts.cairo(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF9000FF),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Small emoji avatar
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF3E8FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text('👦', style: TextStyle(fontSize: 18)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Main Content Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32), // In design it's rounded at bottom too before passing navbar
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Node Title Head
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.menu_book_rounded, color: Color(0xFF9000FF), size: 28),
                          const SizedBox(width: 12),
                          Text(
                            nodeTitle,
                            style: GoogleFonts.cairo(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Task List
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            // 1. Lesson (Unlocked)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LessonVideosScreen()),
                                );
                              },
                              child: _buildTaskItem(
                                number: '1',
                                title: 'الدرس',
                                subtitle: 'متاح ✓',
                                icon: Icons.chrome_reader_mode_outlined,
                                iconBgColor: const Color(0xFFE8F5E9),
                                iconColor: const Color(0xFF00C853),
                                pillColor: const Color(0xFF9000FF),
                                cardBgColor: Colors.white,
                                borderColor: const Color(0xFFF1F5F9),
                                isLocked: false,
                                subtitleColor: const Color(0xFF00C853),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 2. Quiz (Locked)
                            GestureDetector(
                              onTap: () => _showLockedDialog(context),
                              child: _buildTaskItem(
                                number: '2',
                                title: 'الاختبار',
                                subtitle: 'مقفل 🔒',
                                icon: Icons.help_outline_rounded,
                                iconBgColor: const Color(0xFFF1F5F9),
                                iconColor: const Color(0xFF94A3B8),
                                pillColor: const Color(0xFFB794F6), // Lighter purple for locked
                                cardBgColor: const Color(0xFFF8FAF9), // Light greenish-grey tint
                                borderColor: const Color(0xFFE2E8F0).withValues(alpha: 0.5),
                                isLocked: true,
                                subtitleColor: const Color(0xFF94A3B8),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // 3. AR Game (Locked)
                            GestureDetector(
                              onTap: () => _showLockedDialog(context),
                              child: _buildTaskItem(
                                number: '3',
                                title: 'لعبة الواقع\nالافتراضي',
                                subtitle: 'مقفل 🔒',
                                icon: Icons.smartphone_rounded,
                                iconBgColor: const Color(0xFFF1F5F9),
                                iconColor: const Color(0xFF94A3B8),
                                pillColor: const Color(0xFFB794F6),
                                cardBgColor: const Color(0xFFF8FAF9),
                                borderColor: const Color(0xFFE2E8F0).withValues(alpha: 0.5),
                                isLocked: true,
                                subtitleColor: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16), // space between bottom nav and card
            ],
          ),
        ),
      ),
      
      // Custom Bottom Navigation Bar matching the image
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomNavItem(
                title: 'الخريطة',
                icon: Icons.map_outlined,
                color: const Color(0xFF00C853), // Green
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainDashboard()),
                    (route) => false,
                  );
                },
              ),
              // Purple Home Center Button
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainDashboard()),
                    (route) => false,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9d4edd),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
                ),
              ),
              _buildBottomNavItem(
                title: 'الميداليات',
                icon: Icons.emoji_events_outlined,
                color: const Color(0xFFffb703), // Yellow/Orange
                onTap: () {
                  // Usually route to medals/progress screen tab
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem({
    required String number,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required Color pillColor,
    required Color cardBgColor,
    required Color borderColor,
    required bool isLocked,
    required Color subtitleColor,
  }) {
    // Note: Numbers in the design are written in Arabic numerals for 2 and 3.
    // However, the font might handle it, or we explicitly provide it.
    // The design shows: 1 for first (or an 'I' shape), ٢ for second, ٣ for third.
    String displayNum = number;
    if (number == '1') displayNum = '١'; // Wait, in the image it looks like the english 'I' or '1' but let's use Arabic numeral ١
    if (number == '2') displayNum = '٢';
    if (number == '3') displayNum = '٣';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: isLocked
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Icon Box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),

          // Center Texts
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isLocked ? const Color(0xFF64748B) : const Color(0xFF1E293B),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Circle Number Pill
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: pillColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                displayNum,
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2, // Fix vertical centering for Arabic numerals
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showLockedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                // Lock Icon
                const Icon(
                  Icons.lock_rounded,
                  size: 80,
                  color: Color(0xFFD4AF37), // Golden color like image
                ),
                const SizedBox(height: 24.0),

                // Title
                Text(
                  'اللعبة مغلقة!',
                  style: GoogleFonts.cairo(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Subtitle
                Text(
                  'يجب عليك إكمال الاختبار للوصول إلى اللعبة',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 32.0),

                // Got it Button
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9000FF), // Purple
                          Color(0xFF00C853), // Green
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C853).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      'فهمت!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
