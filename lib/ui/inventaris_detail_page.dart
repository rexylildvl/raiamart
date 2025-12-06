import 'package:flutter/material.dart';
import '../bloc/inventaris_bloc.dart';
import '../model/inventaris.dart';
import 'inventaris_form_page.dart';

class InventarisDetailPage extends StatelessWidget {
  final Inventaris inventaris;
  final inventarisBloc = InventarisBloc();

  InventarisDetailPage({required this.inventaris});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E2723),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFF5F5DC)),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: Text(
          "Detail Inventaris RaiaMart",
          style: TextStyle(
            color: Color(0xFFF5F5DC),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Color(0xFF3E2723),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Color(0xFF6D4C41),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6D4C41).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 45,
                      color: Color(0xFFF5F5DC),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      inventaris.judul ?? "-",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF5F5DC),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoCard(
                    icon: Icons.attach_money_rounded,
                    label: "Harga",
                    value: "Rp ${_formatCurrency(inventaris.harga)}",
                    iconColor: Color(0xFF6D4C41),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.inventory_2_outlined,
                    label: "Jumlah Stok",
                    value: "${inventaris.jumlah ?? 0} buah",
                    iconColor: Color(0xFF8D6E63),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.calendar_today_rounded,
                    label: "Tanggal Masuk",
                    value: inventaris.tanggalMasuk ?? "-",
                    iconColor: Color(0xFF6D4C41),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.book_outlined,
                    label: "Volume",
                    value: inventaris.volume?.toString() ?? "-",
                    iconColor: Color(0xFF8D6E63),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.person_outline,
                    label: "Penulis",
                    value: inventaris.penulis ?? "-",
                    iconColor: Color(0xFF6D4C41),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(
                    icon: Icons.business_outlined,
                    label: "Penerbit",
                    value: inventaris.penerbit ?? "-",
                    iconColor: Color(0xFF8D6E63),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF4E342E),
                                Color(0xFF6D4C41),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF4E342E).withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => InventarisFormPage(item: inventaris),
                                ),
                              );

                              if (result == true) {
                                Navigator.pop(context, true);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(
                              Icons.edit_rounded,
                              color: Color(0xFFF5F5DC),
                              size: 20,
                            ),
                            label: Text(
                              "EDIT",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF5F5DC),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 54,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFFD32F2F),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFD32F2F).withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showDeleteConfirmation(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(
                              Icons.delete_outline_rounded,
                              color: Color(0xFFD32F2F),
                              size: 20,
                            ),
                            label: Text(
                              "HAPUS",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFD32F2F),
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8D6E63),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3E2723),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    // Simpan context utama sebelum masuk ke dialog
    final pageContext = context;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Color(0xFFF5F5DC),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFD32F2F),
              size: 28,
            ),
            const SizedBox(width: 12),
            Text(
              "Konfirmasi Hapus",
              style: TextStyle(
                color: Color(0xFF3E2723),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Text(
          "Apakah Anda yakin ingin menghapus \"${inventaris.judul}\"?\n\nData yang dihapus tidak dapat dikembalikan.",
          style: TextStyle(
            color: Color(0xFF6D4C41),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              "Batal",
              style: TextStyle(
                color: Color(0xFF8D6E63),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // 1. Tutup dialog konfirmasi terlebih dahulu
              Navigator.pop(dialogContext);

              // 2. Tampilkan dialog loading menggunakan context halaman
              showDialog(
                context: pageContext,
                barrierDismissible: false,
                builder: (loadingContext) => Center(
                  child: CircularProgressIndicator(color: Color(0xFF6D4C41)),
                ),
              );

              try {
                await inventarisBloc.deleteInventaris(inventaris.id!);

                // 3. Tutup dialog loading
                Navigator.pop(pageContext);

                // 4. Tutup halaman detail dan kirim hasil 'true' ke halaman inventaris
                Navigator.pop(pageContext, true);

                // 5. Tampilkan SnackBar di halaman sebelumnya (InventarisPage)
                ScaffoldMessenger.of(pageContext).showSnackBar(
                  SnackBar(
                    content: Text("Data berhasil dihapus"),
                    backgroundColor: Color(0xFF6D4C41),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              } catch (e) {
                // Jika gagal, tutup dialog loading
                Navigator.pop(pageContext);

                // Tampilkan pesan error
                ScaffoldMessenger.of(pageContext).showSnackBar(
                  SnackBar(
                    content: Text("Gagal menghapus data: ${e.toString()}"),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD32F2F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Hapus",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
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