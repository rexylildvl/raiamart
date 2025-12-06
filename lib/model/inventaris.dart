class Inventaris {
  int? id;
  String? judul;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  int? volume;
  String? penulis;
  String? penerbit;

  Inventaris({
    this.id,
    this.judul,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.volume,
    this.penulis,
    this.penerbit,
  });

  factory Inventaris.fromJson(Map<String, dynamic> json) {
    return Inventaris(
      id: int.tryParse(json["id"].toString()),
      judul: json["judul"],
      harga: int.tryParse(json["harga"].toString()),
      jumlah: int.tryParse(json["jumlah"].toString()),
      tanggalMasuk: json["tanggal_masuk"],
      volume: int.tryParse(json["volume"].toString()),
      penulis: json["penulis"],
      penerbit: json["penerbit"],
    );
  }
}
