import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cuaca7HariPage extends StatefulWidget {
  const Cuaca7HariPage({super.key});

  @override
  State<Cuaca7HariPage> createState() => _Cuaca7HariPageState();
}

class _Cuaca7HariPageState extends State<Cuaca7HariPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> forecast7Hari = [
    {"hari": "Senin", "tanggal": "10 Nov", "kondisi": "Cerah Berawan", "suhu": "27° / 19°", "ikon": "assets/images/cuaca/sun.png"},
    {"hari": "Selasa", "tanggal": "11 Nov", "kondisi": "Hujan Ringan", "suhu": "25° / 18°", "ikon": "assets/images/cuaca/rainy.png"},
    {"hari": "Rabu", "tanggal": "12 Nov", "kondisi": "Berawan", "suhu": "26° / 17°", "ikon": "assets/images/cuaca/cloudy.png"},
    {"hari": "Kamis", "tanggal": "13 Nov", "kondisi": "Cerah", "suhu": "28° / 19°", "ikon": "assets/images/cuaca/sun.png"},
    {"hari": "Jumat", "tanggal": "14 Nov", "kondisi": "Gerimis", "suhu": "24° / 18°", "ikon": "assets/images/cuaca/rainy.png"},
    {"hari": "Sabtu", "tanggal": "15 Nov", "kondisi": "Cerah Berawan", "suhu": "27° / 20°", "ikon": "assets/images/cuaca/cloudy.png"},
    {"hari": "Minggu", "tanggal": "16 Nov", "kondisi": "Hujan Petir", "suhu": "23° / 17°", "ikon": "assets/images/cuaca/rainy.png"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..forward();
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE9D6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF55301),
        elevation: 0,
        title: Text(
          "Cuaca 7 Hari ke Depan",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemCount: forecast7Hari.length,
            itemBuilder: (context, index) {
              final item = forecast7Hari[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(item["ikon"], height: 50, fit: BoxFit.contain),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item["hari"]}, ${item["tanggal"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF55301),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item["kondisi"],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      item["suhu"],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF55301),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
