import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() => _BeritaPageState();
}

class _BeritaPageState extends State<BeritaPage> {
  bool sortTerbaru = true;
  String query = "";
  String selectedKategori = "Semua";

  final List<String> kategoriList = [
    "Semua",
    "Bencana",
    "Olahraga",
    "Teknologi",
    "Ekonomi",
    "Hiburan",
    "Kuliner"
  ];

  final List<Map<String, dynamic>> beritaList = [
    {
      "judul": "Gempa Bumi Guncang Jawa Barat",
      "tanggal": "10 November 2025",
      "gambar": "assets/images/berita/gempa.jpg",
      "deskripsi":
          "Gempa 5.8 SR mengguncang wilayah Jawa Barat. Warga diminta tetap waspada terhadap kemungkinan gempa susulan.",
      "isi":
          "Gempa berkekuatan 5.8 SR mengguncang wilayah Jawa Barat pada pagi hari. BMKG melaporkan gempa tidak berpotensi tsunami.",
      "kategori": "Bencana"
    },
    {
      "judul": "Digitalisasi Sekolah Dimulai Nasional",
      "tanggal": "9 November 2025",
      "gambar": "assets/images/berita/sekolah.jpg",
      "deskripsi":
          "Program digitalisasi sekolah mulai diterapkan di seluruh Indonesia.",
      "isi":
          "Pemerintah meluncurkan program digitalisasi sekolah nasional dengan perangkat digital dan pelatihan guru.",
      "kategori": "Teknologi"
    },
    {
      "judul": "Festival Kuliner Nusantara di Bandung",
      "tanggal": "8 November 2025",
      "gambar": "assets/images/berita/kuliner.jpg",
      "deskripsi":
          "Ratusan UMKM ikut serta dalam Festival Kuliner Nusantara di Bandung.",
      "isi":
          "Acara ini menjadi wadah promosi bagi UMKM kuliner lokal dan memperkenalkan cita rasa khas daerah.",
      "kategori": "Kuliner"
    },
    {
      "judul": "Timnas Indonesia Siap Hadapi Final AFF 2025",
      "tanggal": "7 November 2025",
      "gambar": "assets/images/berita/timnas.jpg",
      "deskripsi":
          "Pelatih Timnas menyatakan seluruh pemain siap tempur menghadapi laga final.",
      "isi":
          "Skuad Garuda dalam kondisi prima menjelang laga final Piala AFF melawan Thailand.",
      "kategori": "Olahraga"
    },
    {
      "judul": "Peluncuran Mobil Listrik Nasional",
      "tanggal": "6 November 2025",
      "gambar": "assets/images/berita/mobil.jpg",
      "deskripsi":
          "Pemerintah resmi memperkenalkan mobil listrik nasional buatan dalam negeri.",
      "isi":
          "Mobil listrik nasional dikembangkan bersama universitas dalam negeri dan memiliki jangkauan 350 km.",
      "kategori": "Teknologi"
    },
    {
      "judul": "Konser Musik Akbar di Jakarta",
      "tanggal": "5 November 2025",
      "gambar": "assets/images/berita/konser.jpg",
      "deskripsi":
          "Konser musik akbar dihadiri ribuan penggemar dari berbagai daerah.",
      "isi":
          "Konser ini menghadirkan musisi papan atas Indonesia dengan konsep outdoor megah.",
      "kategori": "Hiburan"
    },
    {
      "judul": "Harga BBM Turun Minggu Ini",
      "tanggal": "4 November 2025",
      "gambar": "assets/images/berita/bbm.jpg",
      "deskripsi": "Pemerintah menurunkan harga BBM untuk menstabilkan ekonomi.",
      "isi":
          "Harga BBM turun sebesar 500 rupiah per liter untuk semua jenis bahan bakar mulai pekan depan.",
      "kategori": "Ekonomi"
    },
    {
      "judul": "Pembukaan Mall Baru di Surabaya",
      "tanggal": "3 November 2025",
      "gambar": "assets/images/berita/mall.jpg",
      "deskripsi":
          "Mall terbesar di Jawa Timur resmi dibuka dengan konsep ramah lingkungan.",
      "isi":
          "Mall ini menggunakan sistem pendingin hemat energi dan area hijau luas di setiap lantainya.",
      "kategori": "Ekonomi"
    },
    {
      "judul": "Cuaca Ekstrem Landa Kalimantan",
      "tanggal": "2 November 2025",
      "gambar": "assets/images/berita/cuaca.jpg",
      "deskripsi":
          "BMKG memperingatkan warga Kalimantan untuk waspada terhadap hujan deras.",
      "isi":
          "Hujan deras dan angin kencang diperkirakan terjadi hingga akhir minggu ini.",
      "kategori": "Bencana"
    },
    {
      "judul": "Pameran Teknologi AI 2025",
      "tanggal": "1 November 2025",
      "gambar": "assets/images/berita/ai.jpg",
      "deskripsi":
          "Pameran teknologi kecerdasan buatan digelar di Jakarta Convention Center.",
      "isi":
          "Berbagai perusahaan menampilkan inovasi AI di bidang pendidikan, kesehatan, dan otomotif.",
      "kategori": "Teknologi"
    },
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }

  List<Map<String, dynamic>> get filteredBerita {
    List<Map<String, dynamic>> filtered = beritaList.where((b) {
      final matchesQuery = b["judul"].toLowerCase().contains(query.toLowerCase()) ||
          b["deskripsi"].toLowerCase().contains(query.toLowerCase());
      final matchesKategori =
          selectedKategori == "Semua" || b["kategori"] == selectedKategori;
      return matchesQuery && matchesKategori;
    }).toList();

    filtered.sort((a, b) {
      final tglA = DateFormat("d MMMM yyyy", "id_ID").parse(a["tanggal"]);
      final tglB = DateFormat("d MMMM yyyy", "id_ID").parse(b["tanggal"]);
      return sortTerbaru ? tglB.compareTo(tglA) : tglA.compareTo(tglB);
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6A00),
        title: Text("Berita",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: Colors.white),
            onPressed: () {
              setState(() => sortTerbaru = !sortTerbaru);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Cari berita...",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),

          // Dropdown kategori
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: selectedKategori,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
              items: kategoriList
                  .map((k) => DropdownMenuItem(
                        value: k,
                        child: Text(k),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedKategori = value!;
                });
              },
            ),
          ),

          // Jumlah artikel
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Menampilkan ${filteredBerita.length} artikel",
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.grey.shade700),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredBerita.length,
              itemBuilder: (context, index) {
                final berita = filteredBerita[index];
                return GestureDetector(
                  onTapDown: (_) => setState(() {}),
                  onTapUp: (_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => DetailBeritaPage(berita: berita)),
                    );
                  },
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: const Duration(milliseconds: 100),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 6,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(18)),
                            child: Image.asset(
                              berita["gambar"],
                              width: 110,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(berita["judul"],
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14)),
                                  const SizedBox(height: 4),
                                  Text(berita["deskripsi"],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[600])),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(berita["tanggal"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              color: Colors.orange.shade700)),
                                      Text(berita["kategori"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blueAccent)),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

// halaman detail
class DetailBeritaPage extends StatelessWidget {
  final Map<String, dynamic> berita;
  const DetailBeritaPage({super.key, required this.berita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF6A00),
        title: Text(berita["judul"],
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(berita["gambar"])),
            const SizedBox(height: 15),
            Text("${berita["tanggal"]} • ${berita["kategori"]}",
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.orange.shade700)),
            const SizedBox(height: 10),
            Text(berita["isi"],
                style:
                    GoogleFonts.poppins(fontSize: 15, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}
