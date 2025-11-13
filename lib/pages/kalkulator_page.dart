import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String input = "";
  String output = "";
  bool sudahEvaluasi = false;

  void tambahAngka(String value) {
    setState(() {
      if (sudahEvaluasi) {
        input = value;
        output = "";
        sudahEvaluasi = false;
      } else {
        input += value;
      }
    });
  }

  void hapusSatu() {
    setState(() {
      if (!sudahEvaluasi && input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    });
  }

  void clearAll() {
    setState(() {
      input = "";
      output = "";
      sudahEvaluasi = false;
    });
  }

  void tambahKuadrat() {
    setState(() {
      if (input.isEmpty) return;
      int i = input.length - 1;
      while (i >= 0 && "0123456789.".contains(input[i])) i--;
      String angkaTerakhir = input.substring(i + 1);
      input = input.substring(0, i + 1) + angkaTerakhir + "^2";
    });
  }

  void tambahAkar() {
    setState(() {
      if (input.isEmpty) return;
      int i = input.length - 1;
      while (i >= 0 && "0123456789.".contains(input[i])) i--;
      String angkaTerakhir = input.substring(i + 1);
      input = input.substring(0, i + 1) + "√" + angkaTerakhir;
    });
  }

  void evaluasi() {
    try {
      String ekspresi = input.replaceAll('×', '*').replaceAll('÷', '/');

      // Ganti √angka menjadi sqrt(angka)
      RegExp regexAkar = RegExp(r'√(\d+(\.\d+)?)');
      ekspresi = ekspresi.replaceAllMapped(regexAkar, (match) {
        return 'sqrt(${match[1]})';
      });

      Parser p = Parser();
      Expression exp = p.parse(ekspresi);
      ContextModel cm = ContextModel();
      double hasil = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        output = hasil % 1 == 0 ? hasil.toInt().toString() : hasil.toString();
        sudahEvaluasi = true;
      });
    } catch (e) {
      setState(() {
        output = "Error";
        sudahEvaluasi = true;
      });
    }
  }

  Widget tombol(String label,
      {Color? bgColor, Color? textColor, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () => tambahAngka(label),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFF55301);

    return Scaffold(
      backgroundColor: orange,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Kalkulator",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      input,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    output,
                    style: GoogleFonts.poppins(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Hitung ukuran tombol agar pas di layar tanpa scroll
                    final double buttonHeight = constraints.maxHeight / 5 - 12;
                    final double buttonWidth = constraints.maxWidth / 4 - 12;
                    final double aspectRatio = buttonWidth / buttonHeight;

                    return GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: aspectRatio,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        tombol("C",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: clearAll),
                        tombol("⌫",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: hapusSatu),
                        tombol("x²",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: tambahKuadrat),
                        tombol("√",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: tambahAkar),
                        tombol("7"),
                        tombol("8"),
                        tombol("9"),
                        tombol("÷",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: () => tambahAngka("÷")),
                        tombol("4"),
                        tombol("5"),
                        tombol("6"),
                        tombol("×",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: () => tambahAngka("×")),
                        tombol("1"),
                        tombol("2"),
                        tombol("3"),
                        tombol("-",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: () => tambahAngka("-")),
                        tombol("0"),
                        tombol("."),
                        tombol("+",
                            bgColor: orange,
                            textColor: Colors.white,
                            onTap: () => tambahAngka("+")),
                        tombol("=",
                            bgColor: Colors.black,
                            textColor: Colors.white,
                            onTap: evaluasi),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
