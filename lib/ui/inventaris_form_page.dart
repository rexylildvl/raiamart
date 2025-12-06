import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../bloc/inventaris_bloc.dart';
import '../model/inventaris.dart';

class InventarisFormPage extends StatefulWidget {
  final Inventaris? item;

  InventarisFormPage({this.item});

  @override
  _InventarisFormPageState createState() => _InventarisFormPageState();
}

class _InventarisFormPageState extends State<InventarisFormPage> {
  final judulC = TextEditingController();
  final hargaC = TextEditingController();
  final jumlahC = TextEditingController();
  final tanggalC = TextEditingController();
  final volumeC = TextEditingController();
  final penulisC = TextEditingController();
  final penerbitC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final bloc = InventarisBloc();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.item != null) {
      judulC.text = widget.item!.judul ?? '';
      hargaC.text = widget.item!.harga?.toString() ?? '';
      jumlahC.text = widget.item!.jumlah?.toString() ?? '';
      tanggalC.text = widget.item!.tanggalMasuk ?? '';
      volumeC.text = widget.item!.volume?.toString() ?? '';
      penulisC.text = widget.item!.penulis ?? '';
      penerbitC.text = widget.item!.penerbit ?? '';
    }
  }

  @override
  void dispose() {
    judulC.dispose();
    hargaC.dispose();
    jumlahC.dispose();
    tanggalC.dispose();
    volumeC.dispose();
    penulisC.dispose();
    penerbitC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E2723),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFFF5F5DC)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEdit ? "Edit Inventaris RaiaMart" : "Tambah Inventaris RaiaMart",
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
              padding: const EdgeInsets.symmetric(vertical: 25),
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
                    width: 80,
                    height: 80,
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
                      isEdit ? Icons.edit_note_rounded : Icons.add_box_rounded,
                      size: 40,
                      color: Color(0xFFF5F5DC),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isEdit ? "Perbarui Data Buku" : "Tambah Data Buku",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD7CCC8),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: judulC,
                      label: "Judul Buku",
                      hint: "Masukkan judul buku",
                      icon: Icons.book_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: hargaC,
                      label: "Harga",
                      hint: "Masukkan harga",
                      icon: Icons.attach_money_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Harga harus angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: jumlahC,
                      label: "Jumlah Stok",
                      hint: "Masukkan jumlah stok",
                      icon: Icons.inventory_2_outlined,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Jumlah tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Jumlah harus angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: tanggalC,
                      label: "Tanggal Masuk",
                      hint: "YYYY-MM-DD",
                      icon: Icons.calendar_today_rounded,
                      readOnly: true,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Color(0xFF6D4C41),
                                  onPrimary: Color(0xFFF5F5DC),
                                  surface: Color(0xFFF5F5DC),
                                  onSurface: Color(0xFF3E2723),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (date != null) {
                          tanggalC.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tanggal tidak boleh kosong';
                        }
                        // Validasi format tanggal
                        final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                        if (!dateRegex.hasMatch(value)) {
                          return 'Format tanggal: YYYY-MM-DD';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: volumeC,
                      label: "Volume",
                      hint: "Masukkan volume",
                      icon: Icons.numbers_rounded,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Volume tidak boleh kosong';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Volume harus angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: penulisC,
                      label: "Penulis",
                      hint: "Masukkan nama penulis",
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Penulis tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _buildTextField(
                      controller: penerbitC,
                      label: "Penerbit",
                      hint: "Masukkan nama penerbit",
                      icon: Icons.business_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Penerbit tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,
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
                            color: Color(0xFF4E342E).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFFF5F5DC),
                          ),
                        )
                            : Text(
                          isEdit ? "UPDATE DATA" : "SIMPAN DATA",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFF5F5DC),
                            letterSpacing: 1.2,
                          ),
                        ),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4E342E),
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFFD7CCC8),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF6D4C41).withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xFFBCAAA4),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                icon,
                color: Color(0xFF6D4C41),
                size: 22,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF3E2723),
            ),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            readOnly: readOnly,
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        final item = Inventaris(
          id: widget.item?.id,
          judul: judulC.text.trim(),
          harga: int.parse(hargaC.text),
          jumlah: int.parse(jumlahC.text),
          tanggalMasuk: tanggalC.text.trim(),
          volume: int.parse(volumeC.text),
          penulis: penulisC.text.trim(),
          penerbit: penerbitC.text.trim(),
        );

        if (widget.item == null) {
          await bloc.tambahInventaris(item);
        } else {
          await bloc.updateInventaris(item);
        }

        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menyimpan data"),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}