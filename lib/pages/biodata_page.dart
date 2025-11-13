import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Global storage untuk biodata
class Biodata {
  static String nama = "Zahra Cahya Dewi Selviana";
  static String nrp = "152022131";
  static String prodi = "Informatika";
  static String ttl = "Bandung, 31 Agustus 2004";
  static String? kelas;
  static String gender = "Perempuan";
}

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nrpController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();

  final FocusNode namaFocus = FocusNode();
  final FocusNode nrpFocus = FocusNode();
  final FocusNode prodiFocus = FocusNode();
  final FocusNode ttlFocus = FocusNode();

  DateTime? selectedDate;
  String? kelas;
  String gender = "Perempuan";

  @override
  void initState() {
    super.initState();
    // Set nilai awal dari global Biodata
    namaController.text = Biodata.nama;
    nrpController.text = Biodata.nrp;
    prodiController.text = Biodata.prodi;
    ttlController.text = Biodata.ttl;
    kelas = Biodata.kelas;
    gender = Biodata.gender;

    // Listener untuk animasi fokus
    namaFocus.addListener(() => setState(() {}));
    nrpFocus.addListener(() => setState(() {}));
    prodiFocus.addListener(() => setState(() {}));
    ttlFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    namaController.dispose();
    nrpController.dispose();
    prodiController.dispose();
    ttlController.dispose();
    namaFocus.dispose();
    nrpFocus.dispose();
    prodiFocus.dispose();
    ttlFocus.dispose();
    super.dispose();
  }

  Future<void> pickTanggal() async {
    final DateTime? pick = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime(2004, 8, 31),
      firstDate: DateTime(1990),
      lastDate: DateTime(2030),
    );

    if (pick != null) {
      setState(() {
        selectedDate = pick;
        ttlController.text =
            "Bandung, ${pick.day}-${pick.month}-${pick.year}";
      });
    }
  }

  void simpanBiodata() {
    setState(() {
      Biodata.nama = namaController.text;
      Biodata.nrp = nrpController.text;
      Biodata.prodi = prodiController.text;
      Biodata.ttl = ttlController.text;
      Biodata.kelas = kelas;
      Biodata.gender = gender;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Data berhasil disimpan!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF55301),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Biodata",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Foto Profil
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/profile1.jpg",
                  width: 200,
                  height: 240,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),

              // Informasi Biodata
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    infoText("Nama", Biodata.nama),
                    infoText("NRP", Biodata.nrp),
                    infoText("Prodi", Biodata.prodi),
                    infoText("TTL", Biodata.ttl),
                    if (Biodata.kelas != null)
                      infoText("Kelas", Biodata.kelas!),
                    infoText("Jenis Kelamin", Biodata.gender),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              Text(
                "Edit Biodata",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),

              // Form Edit Biodata
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    animatedField("Nama", namaController, namaFocus),
                    animatedField("NRP", nrpController, nrpFocus),
                    animatedField("Prodi", prodiController, prodiFocus),
                    animatedField("TTL", ttlController, ttlFocus),
                    const SizedBox(height: 10),
                    buttonBlack("Pilih Tanggal", pickTanggal),
                    const SizedBox(height: 15),

                    // Dropdown kelas
                    Text("Kelas", style: GoogleFonts.poppins()),
                    DropdownButton<String>(
                      value: kelas,
                      isExpanded: true,
                      hint: const Text("Pilih kelas"),
                      items: ["IF - A", "IF - B", "IF - C"]
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => kelas = v),
                    ),
                    const SizedBox(height: 15),

                    // Radio gender (fix overflow)
                    Text("Jenis Kelamin", style: GoogleFonts.poppins()),
                    Wrap(
                      spacing: 20,
                      runSpacing: 8,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: 'Perempuan',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() => gender = value!);
                              },
                            ),
                            Text(
                              'Perempuan',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              value: 'Laki-laki',
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() => gender = value!);
                              },
                            ),
                            Text(
                              'Laki-laki',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Center(child: buttonBlack("Simpan", simpanBiodata)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget tampil data
  Widget infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: $value",
        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  // Widget field dengan animasi fokus
  Widget animatedField(
      String label, TextEditingController controller, FocusNode focusNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins()),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  focusNode.hasFocus ? Colors.orange : Colors.grey.shade300,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // Tombol hitam custom
  Widget buttonBlack(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: GoogleFonts.poppins(color: Colors.white)),
    );
  }
}
