import '../helpers/api.dart';
import '../model/inventaris.dart';

class InventarisBloc {
  Stream<List<Inventaris>> getInventaris() async* {
    final data = await Api.getInventaris();
    yield data.map<Inventaris>((json) => Inventaris.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> tambahInventaris(Inventaris item) async {
    final response = await Api.tambahInventaris({
      "judul": item.judul.toString(),
      "harga": item.harga.toString(),
      "jumlah": item.jumlah.toString(),
      "tanggal_masuk": item.tanggalMasuk.toString(),
      "volume": item.volume.toString(),
      "penulis": item.penulis.toString(),
      "penerbit": item.penerbit.toString(),
    });

    return response;
  }

  Future<Map<String, dynamic>> updateInventaris(Inventaris item) async {
    if (item.id == null) {
      throw Exception("ID Inventaris tidak boleh null untuk update");
    }
    final response = await Api.updateInventaris(item.id!, {
      "judul": item.judul ?? '',
      "harga": item.harga?.toString() ?? '0',
      "jumlah": item.jumlah?.toString() ?? '0',
      "tanggal_masuk": item.tanggalMasuk ?? '',
      "volume": item.volume?.toString() ?? '0',
      "penulis": item.penulis ?? '',
      "penerbit": item.penerbit ?? '',
    });

    return response;
  }

  Future<Map<String, dynamic>> deleteInventaris(int id) async {
    return await Api.hapusInventaris(id);
  }
}
