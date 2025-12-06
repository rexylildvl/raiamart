import 'package:flutter/material.dart';
import '../bloc/inventaris_bloc.dart';
import '../bloc/logout_bloc.dart';
import '../model/inventaris.dart';
import 'inventaris_detail_page.dart';
import 'inventaris_form_page.dart';
import 'login_page.dart';

class InventarisPage extends StatefulWidget {
  @override
  _InventarisPageState createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  final inventarisBloc = InventarisBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E2723),
        elevation: 0,
        title: Text(
          "Inventaris Buku RaiaMart",
          style: TextStyle(
            color: Color(0xFFF5F5DC),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFF5F5DC),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4E342E),
              Color(0xFF6D4C41),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF4E342E).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => InventarisFormPage()),
            );
            if (result == true) {
              setState(() {});
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add_rounded, color: Color(0xFFF5F5DC), size: 28),
        ),
      ),
      body: StreamBuilder<List<Inventaris>>(
        stream: inventarisBloc.getInventaris(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6D4C41),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Color(0xFFD7CCC8),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Belum ada data inventaris",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF6D4C41),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap tombol + untuk menambah",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, i) {
              final item = data[i];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFD7CCC8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6D4C41).withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InventarisDetailPage(inventaris: item),
                      ),
                    );
                    if (result == true) {
                      setState(() {});
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF6D4C41).withOpacity(0.2),
                                Color(0xFF8D6E63).withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.menu_book_rounded,
                            color: Color(0xFF6D4C41),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.judul ?? "-",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF3E2723),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Rp ${_formatCurrency(item.harga)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6D4C41),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xFF8D6E63),
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFF5F5DC),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Column(
        children: [
        Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3E2723),
              Color(0xFF4E342E),
            ],
          ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF6D4C41),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFF5F5DC),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.store_mall_directory_rounded,
                size: 40,
                color: Color(0xFFF5F5DC),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "RaiaMart",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFFF5F5DC),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Inventory System",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFD7CCC8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _buildMenuItem(
                context,
                icon: Icons.inventory_rounded,
                title: "Inventaris Buku",
                onTap: () {
                  Navigator.pop(context);
                },
                isSelected: true,
              ),
              const SizedBox(height: 8),
              _buildMenuItem(
                context,
                icon: Icons.info_outline_rounded,
                title: "Tentang Aplikasi",
                onTap: () {
                  Navigator.pop(context);
                  _showAboutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFD32F2F).withOpacity(0.1),
              Color(0xFFD32F2F).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFD32F2F).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
            _showLogoutConfirmation(context);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Icon(
            Icons.logout_rounded,
            color: Color(0xFFD32F2F),
            size: 22,
          ),
          label: Text(
            "Keluar",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFD32F2F),
            ),
          ),
        ),
      ),
    ),
    Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
    "v1.0.0 • © 2024 RaiaMart",
    style: TextStyle(
    fontSize: 11,
    color: Color(0xFF8D6E63),
    ),
    ),
    ),
    ],
    ),
    );
    }

  Widget _buildMenuItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required VoidCallback onTap,
        bool isSelected = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Color(0xFF3E2723).withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: Color(0xFF3E2723).withOpacity(0.2))
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Color(0xFF3E2723) : Color(0xFF6D4C41),
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? Color(0xFF3E2723) : Color(0xFF4E342E),
                ),
              ),
              if (isSelected) ...[
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Color(0xFF3E2723),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFFD32F2F).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                size: 36,
                color: Color(0xFFD32F2F),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Keluar dari Akun?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Anda perlu login kembali untuk mengakses inventaris.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6D4C41),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF8D6E63)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Batal",
                      style: TextStyle(
                        color: Color(0xFF6D4C41),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await LogoutBloc.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD32F2F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Ya, Keluar",
                      style: TextStyle(
                        color: Color(0xFFF5F5DC),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF3E2723).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store_mall_directory_rounded,
                size: 36,
                color: Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "RaiaMart",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3E2723),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Inventory Management System",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF6D4C41),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Divider(color: Color(0xFFD7CCC8)),
            const SizedBox(height: 16),
            Text(
              "Aplikasi manajemen inventaris buku yang memudahkan pengelolaan stok, harga, dan informasi produk toko buku RaiaMart.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF4E342E),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "v1.0.0",
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF8D6E63),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "© 2024 RaiaMart. All rights reserved.",
              style: TextStyle(
                fontSize: 10,
                color: Color(0xFF8D6E63),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3E2723),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  "Tutup",
                  style: TextStyle(
                    color: Color(0xFFF5F5DC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(dynamic value) {
    if (value == null) return "0";
    final price = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    if (price.isEmpty) return "0";
    final number = int.parse(price);
    final formatted = number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
    );
    return formatted;
  }
}
