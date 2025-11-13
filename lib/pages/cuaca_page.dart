import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cuaca_7hari_page.dart';

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;
  late AnimationController _floatController;
  late AnimationController _tapController;

  @override
  void initState() {
    super.initState();

    // animasi fade-in
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600))
          ..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    // animasi floating hanya untuk icon (awan & icon kecil)
    _floatController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
          ..repeat(reverse: true);

    // animasi scale tombol 7 hari
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
    )..value = 1.0;
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFFFE9D6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 40),
          physics: const BouncingScrollPhysics(),
          child: FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text("📍 Bandung",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFF55301))),
                Text("Senin, 10 November 2025",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.orange.shade300)),
                const SizedBox(height: 25),

                // 🔸 Kartu utama
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF55301),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 4))
                    ],
                  ),
                  child: Column(
                    children: [
                      // 🌤️ animasi hanya untuk gambar awan
                      AnimatedBuilder(
                        animation: _floatController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 6 * (1 - _floatController.value * 2)),
                            child: child,
                          );
                        },
                        child: Image.asset("assets/images/cuaca/cloudy.png",
                            height: 100),
                      ),
                      const SizedBox(height: 10),
                      Text("22°",
                          style: GoogleFonts.poppins(
                              fontSize: 70,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      Text("Cerah Berawan",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white)),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          infoItem(Icons.water_drop, "30%", "Kelembapan"),
                          infoItem(Icons.air, "12 km/h", "Angin"),
                          infoItem(Icons.umbrella, "20%", "Hujan"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 🔸 Bagian Hari Ini + tombol
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hari Ini",
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600)),

                      ScaleTransition(
                        scale: _tapController,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          splashColor: Colors.orange.withOpacity(0.2),
                          onTapDown: (_) => _tapController.reverse(),
                          onTapUp: (_) {
                            _tapController.forward();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Cuaca7HariPage()),
                            );
                          },
                          onTapCancel: () => _tapController.forward(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Row(
                              children: [
                                Text(
                                  "7 Hari ke Depan",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xFFF55301),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 4),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 14, color: Color(0xFFF55301))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // 🔸 Forecast jam-jam berikutnya (8 item)
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      animatedForecastCard("07:00", "20°", "assets/images/cuaca/sun.png"),
                      animatedForecastCard("09:00", "21°", "assets/images/cuaca/sun.png"),
                      animatedForecastCard("11:00", "23°", "assets/images/cuaca/cloudy.png"),
                      animatedForecastCard("13:00", "25°", "assets/images/cuaca/cloudy.png"),
                      animatedForecastCard("15:00", "24°", "assets/images/cuaca/rainy.png"),
                      animatedForecastCard("17:00", "22°", "assets/images/cuaca/rainy.png"),
                      animatedForecastCard("19:00", "21°", "assets/images/cuaca/moonrain.png"),
                      animatedForecastCard("21:00", "20°", "assets/images/cuaca/moonrain.png"),
                      animatedForecastCard("23:00", "19°", "assets/images/cuaca/moon.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget infoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 5),
        Text(value,
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70)),
      ],
    );
  }

  Widget animatedForecastCard(String time, String temp, String iconPath) {
    // hanya icon cuaca yang bergerak
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(time,
              style: GoogleFonts.poppins(
                  color: Colors.orange.shade600, fontSize: 13)),

          // 🌤️ ikon aja yang mengambang
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, 5 * (1 - _floatController.value * 2)),
                child: child,
              );
            },
            child: Image.asset(iconPath, height: 40),
          ),

          Text(temp,
              style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800)),
        ],
      ),
    );
  }
}
