class SmartphoneModel {
  SmartphoneModel({
    required this.id,
    required this.nama,
    required this.warna,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.merek,
    required this.type,
  });

  int id;
  String nama;
  String warna;
  String deskripsi;
  int harga;
  String gambar;
  String merek;
  String type;

  factory SmartphoneModel.fromJson(Map<String, dynamic> json) => SmartphoneModel(
    id: json["id"],
    nama: json["nama"],
    warna: json["warna"],
    deskripsi: json["deskripsi"],
    harga: json["harga"],
    gambar: json["gambar"],
    merek: json["merek"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "warna": warna,
    "deskripsi": deskripsi,
    "harga": harga,
    "gambar": gambar,
    "merek": merek,
    "type": type,
  };
}
