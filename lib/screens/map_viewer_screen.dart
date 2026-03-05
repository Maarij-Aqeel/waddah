import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapViewerScreen extends StatefulWidget {
  const MapViewerScreen({super.key});

  @override
  State<MapViewerScreen> createState() => _MapViewerScreenState();
}

class _MapViewerScreenState extends State<MapViewerScreen> {
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(_onScaleChanged);
  }

  @override
  void dispose() {
    _transformationController.removeListener(_onScaleChanged);
    _transformationController.dispose();
    super.dispose();
  }

  void _onScaleChanged() {
    // Extract the scale from the transformation matrix
    final scale = _transformationController.value.getMaxScaleOnAxis();
    if (scale != _currentScale) {
      setState(() {
        _currentScale = scale;
      });
    }
  }

  void _zoom(double factor) {
    if (_transformationController.value == Matrix4.identity() && factor < 1.0) {
      return; // Already min
    }
    
    final currentMatrix = _transformationController.value;
    final scale = currentMatrix.getMaxScaleOnAxis();
    
    double newScale = scale * factor;
    newScale = newScale.clamp(1.0, 5.0); // Assuming 1.0 is min and 5.0 is max

    final double scaleFactor = newScale / scale;
    // ignore: deprecated_member_use
    final scaledMatrix = currentMatrix.clone()..scale(scaleFactor, scaleFactor, scaleFactor);
    _transformationController.value = scaledMatrix;
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    // 100% scaled as integer String
    String scalePercentage = '${(_currentScale * 100).toInt()}%';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFDCCDF3), // Soft purple top
              Color(0xFFC7EBE6), // Seafoam green bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar (Back button, Logo)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Empty space for flex alignment
                    const SizedBox(width: 48),

                    // Center Avatar Box
                    Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // Using fallback image if the specific avatar doesn't exist
                        child: Image.asset(
                          'assets/logo.png', // Fallback to provided logo
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.person, size: 50, color: Color(0xFF9000FF)),
                        ),
                      ),
                    ),

                    // Back Button (Conceptual right -> points left but in RTL context it's right pointing arrow)
                    Container(
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
                  ],
                ),
              ),

              // Title
              Text(
                'خريطة مترو الرياض',
                style: GoogleFonts.cairo(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF9d4edd),
                ),
              ),

              const SizedBox(height: 16),

              // Instruction Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4),
                    ],
                  ),
                  child: Text(
                    'استخدم أزرار التكبير والتصغير لاستكشاف\nالخريطة',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      color: const Color(0xFF333333),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Map Container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EED5), // Beige backdrop
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      children: [
                        // The Interactive Map Image
                        Center(
                          child: InteractiveViewer(
                            transformationController: _transformationController,
                            minScale: 1.0,
                            maxScale: 5.0,
                            child: Image.asset(
                              'assets/map.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Text(
                                    'Map image missing (assets/map.png)',
                                    style: GoogleFonts.cairo(color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Percentage Pill (Top visual left -> in RTL, Left)
                        Positioned(
                          left: 16,
                          top: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFB794F6), width: 2),
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Text(
                              scalePercentage,
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ),
                        ),

                        // Floating Action Controls (Middle visual right)
                        Positioned(
                          right: 16,
                          top: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildMapControlButton(
                                icon: Icons.add,
                                color: const Color(0xFF00C853), // Green for zoom in
                                onTap: () => _zoom(1.5),
                              ),
                              const SizedBox(height: 12),
                              _buildMapControlButton(
                                icon: Icons.remove,
                                color: const Color(0xFF9d4edd), // Purple for zoom out
                                onTap: () => _zoom(0.5),
                              ),
                              const SizedBox(height: 12),
                              _buildMapControlButton(
                                icon: Icons.open_in_full_rounded,
                                color: const Color(0xFF1565C0), // Blue for reset zoom
                                onTap: _resetZoom,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Bottom Legend
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 24.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 6),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem(label: 'الخط البنفسجي', color: const Color(0xFFA855F7)), // Purple
                          _buildLegendItem(label: 'الخط الأصفر', color: const Color(0xFFF59E0B)),  // Yellow
                          _buildLegendItem(label: 'الخط الأزرق', color: const Color(0xFF3B82F6)),  // Blue
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem(label: 'الخط الأحمر', color: const Color(0xFFEF4444)), // Red
                          _buildLegendItem(label: 'الخط البرتقالي', color: const Color(0xFFF97316)), // Orange
                          _buildLegendItem(label: 'الخط الأخضر', color: const Color(0xFF10B981)), // Green
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapControlButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 28),
      ),
    );
  }

  // To properly render the text on the right and line on the left or top-line style
  Widget _buildLegendItem({required String label, required Color color}) {
    // According to the image, the color line is displayed above the text
    return Column(
      children: [
        Container(
          width: 32,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: const Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}
