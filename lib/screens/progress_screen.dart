import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Light background
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // Top Header & Overlapping Card
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Gradient Background
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(0, 166, 62, 1),
                        Color.fromRGBO(152, 16, 250, 1),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 90.0),
                      child: Column(
                        children: [
                          // Back Button Row
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.arrow_forward, color: Color(0xFF00C853)),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Trophy Circle
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              color: Color(0xFFffb703),
                              size: 48,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Titles
                          Text(
                            'نجومي وميدالياتي',
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'رائع يا Noura khalid!',
                            style: GoogleFonts.cairo(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Overlapping White Card
                Positioned(
                  bottom: -50,
                  left: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              style: GoogleFonts.cairo(
                                color: const Color(0xFF00C853),
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.star_rounded, color: Color(0xFFffb703), size: 40),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'الوصول للتالي: 200 نجمة',
                          style: GoogleFonts.cairo(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '0%',
                              style: GoogleFonts.cairo(
                                color: const Color(0xFF00C853),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Spacer to avoid overlapping card
            const SizedBox(height: 80),
            
            // "My Medals" Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ميدالياتي',
                  style: GoogleFonts.cairo(
                    color: const Color(0xFF9000FF),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.emoji_events, color: Color(0xFFffb703), size: 28),
              ],
            ),
            const SizedBox(height: 24),
            
            // Medals List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildMedalCard(
                    title: 'ميدالية برونزية',
                    isLocked: false,
                    pointsLabel: '50+',
                    subText1: 'حصلت على 50+', // Following textual display exactly
                    subText2: 'البداية - 99 نجمة',
                  ),
                  const SizedBox(height: 16),
                  _buildMedalCard(
                    title: 'ميدالية فضية',
                    isLocked: true,
                    pointsLabel: '',
                    subText1: 'حصلت على 100+',
                    subText2: '100 - 199 نجمة',
                  ),
                  const SizedBox(height: 16),
                  _buildMedalCard(
                    title: 'ميدالية ذهبية',
                    isLocked: true,
                    pointsLabel: '',
                    subText1: 'حصلت على 200+',
                    subText2: '200+ نجمة',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedalCard({
    required String title,
    required bool isLocked,
    required String pointsLabel,
    required String subText1,
    required String subText2,
  }) {
    final bgColor = isLocked ? const Color(0xFFF0F4F8) : const Color(0xFFFFE0B2); // light grey-blue for locked, peach for bronze
    final borderColor = isLocked ? Colors.grey[300]! : const Color(0xFFE65100);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: isLocked
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [
                BoxShadow(
                  color: borderColor.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Content block (Right aligned in standard localized RTL)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? const Color(0xFF475569) : const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 8),
                if (!isLocked)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          pointsLabel,
                          style: GoogleFonts.cairo(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00C853),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star_rounded, color: Color(0xFFffb703), size: 16),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.lock_outline, color: Colors.grey, size: 16),
                  ),
                const SizedBox(height: 12),
                Text(
                  subText1,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: isLocked ? const Color(0xFF64748B) : Colors.grey[700],
                    height: 1.3,
                  ),
                ),
                Text(
                  subText2,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: isLocked ? const Color(0xFF64748B) : Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Icon block (Left aligned)
          if (isLocked)
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Icon(Icons.lock_outline, color: Colors.grey, size: 28),
            )
          else
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD87D4A), // Rich Bronze
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.military_tech, color: Colors.white, size: 36),
                  ),
                ),
                Positioned(
                  bottom: -1,
                  left: -1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9000FF), // Purple Notification pill
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '1',
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
