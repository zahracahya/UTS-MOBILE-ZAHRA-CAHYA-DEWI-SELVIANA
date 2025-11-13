import 'package:flutter/material.dart';
import 'biodata_page.dart';
import 'kontak_page.dart';
import 'kalkulator_page.dart';
import 'cuaca_page.dart';
import 'berita_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    BiodataPage(),
    KontakPage(),
    KalkulatorPage(),
    CuacaPage(),
    BeritaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // 🔸 latar putih polos
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white, // 🔸 biar sama putih
              selectedItemColor: const Color(0xFFF55301), // 🔸 oranye utama
              unselectedItemColor: const Color(0xFFF55301), // 🔸 tetap oranye tapi sama rata
              showUnselectedLabels: true,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Biodata",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_phone),
                  label: "Kontak",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calculate),
                  label: "Kalkulator",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: "Cuaca",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: "Berita",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
