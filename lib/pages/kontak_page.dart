import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

// Global storage untuk semua kontak
class KontakStorage {
  static List<Map<String, String>> kontakList = [
    {"nama": "Ambar", "nomor": "0857-2314-1182", "foto": "assets/images/kontak/ambar.jpg"},
    {"nama": "Alma", "nomor": "0822-5678-9401", "foto": "assets/images/kontak/alma.jpg"},
    {"nama": "Aulia", "nomor": "0813-7286-4420", "foto": "assets/images/kontak/aulia.jpg"},
    {"nama": "Cinta", "nomor": "0895-6123-8834", "foto": "assets/images/kontak/cinta.jpg"},
    {"nama": "Desi", "nomor": "0812-4402-9377", "foto": "assets/images/kontak/desi.jpg"},
    {"nama": "Dila", "nomor": "0821-7789-2205", "foto": "assets/images/kontak/dila.jpg"},
    {"nama": "Dina", "nomor": "0852-9034-1129", "foto": "assets/images/kontak/dina.jpg"},
    {"nama": "Fajar", "nomor": "0838-2114-7700", "foto": "assets/images/kontak/fajar.jpg"},
    {"nama": "Irna", "nomor": "0878-9901-2235", "foto": "assets/images/kontak/irna.jpg"},
    {"nama": "Nazwa", "nomor": "0896-3400-7294", "foto": "assets/images/kontak/nazwa.jpg"},
    {"nama": "Putri", "nomor": "0813-5099-8812", "foto": "assets/images/kontak/putri.jpg"},
    {"nama": "Raihan", "nomor": "0823-4991-6650", "foto": "assets/images/kontak/raihan.jpg"},
    {"nama": "Rara", "nomor": "0882-7124-5561", "foto": "assets/images/kontak/rara.jpg"},
    {"nama": "Risha", "nomor": "0812-9441-2543", "foto": "assets/images/kontak/risha.jpg"},
    {"nama": "Shintia", "nomor": "0831-8881-7724", "foto": "assets/images/kontak/shintia.jpg"},
    {"nama": "Tri", "nomor": "0853-6712-1986", "foto": "assets/images/kontak/tri.jpg"},
  ];
}

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  List<Map<String, String>> hasilFilter = [];
  TextEditingController cariController = TextEditingController();
  bool _fabVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    hasilFilter = List.from(KontakStorage.kontakList);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
          if (_fabVisible) setState(() => _fabVisible = false);
        } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
          if (!_fabVisible) setState(() => _fabVisible = true);
        }
      });
  }

  void searchKontak(String query) {
    setState(() {
      hasilFilter = KontakStorage.kontakList
          .where((c) =>
              c["nama"]!.toLowerCase().contains(query.toLowerCase()) ||
              c["nomor"]!.contains(query))
          .toList();
    });
  }

  void showTambahKontak() {
    TextEditingController nama = TextEditingController();
    TextEditingController nomor = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Tambah Kontak", style: GoogleFonts.poppins()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nama, decoration: const InputDecoration(labelText: "Nama")),
            TextField(controller: nomor, decoration: const InputDecoration(labelText: "Nomor")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                KontakStorage.kontakList.add({
                  "nama": nama.text,
                  "nomor": nomor.text,
                  "foto": "assets/images/kontak/${nama.text.toLowerCase()}.jpg"
                });
                searchKontak(cariController.text);
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  void showEditKontak(int index) {
    TextEditingController nama = TextEditingController(text: hasilFilter[index]["nama"]);
    TextEditingController nomor = TextEditingController(text: hasilFilter[index]["nomor"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Kontak", style: GoogleFonts.poppins()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nama),
            const SizedBox(height: 10),
            TextField(controller: nomor),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                int realIndex = KontakStorage.kontakList.indexWhere((item) =>
                    item["nama"] == hasilFilter[index]["nama"] &&
                    item["nomor"] == hasilFilter[index]["nomor"]);

                KontakStorage.kontakList[realIndex] = {
                  "nama": nama.text,
                  "nomor": nomor.text,
                  "foto": "assets/images/kontak/${nama.text.toLowerCase()}.jpg"
                };

                searchKontak(cariController.text);
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF55301),
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 200),
        offset: _fabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _fabVisible ? 1 : 0,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: showTambahKontak,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text(
              "Kontak Telepon",
              style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: cariController,
                        onChanged: searchKontak,
                        decoration: InputDecoration(
                          hintText: "Cari nama atau nomor...",
                          prefixIcon: const Icon(Icons.search),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: hasilFilter.length,
                        itemBuilder: (context, index) {
                          final c = hasilFilter[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(radius: 27, backgroundImage: AssetImage(c["foto"]!)),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(c["nama"]!, style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w600)),
                                      Text(c["nomor"]!, style: GoogleFonts.poppins(fontSize: 13, color: Colors.black54)),
                                    ],
                                  ),
                                ),
                                PopupMenuButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  onSelected: (value) {
                                    if (value == "edit") {
                                      showEditKontak(index);
                                    } else if (value == "hapus") {
                                      setState(() {
                                        int realIndex = KontakStorage.kontakList.indexWhere((item) =>
                                            item["nama"] == hasilFilter[index]["nama"] &&
                                            item["nomor"] == hasilFilter[index]["nomor"]);
                                        KontakStorage.kontakList.removeAt(realIndex);
                                        searchKontak(cariController.text);
                                      });
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(value: "edit", child: Text("Edit", style: GoogleFonts.poppins())),
                                    PopupMenuItem(value: "hapus", child: Text("Hapus", style: GoogleFonts.poppins(color: Colors.red))),
                                  ],
                                  child: const Icon(Icons.more_vert, color: Colors.black54),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
