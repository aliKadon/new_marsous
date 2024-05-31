class SurahModel {
  int? id;
  String? name;
  int? totalAyah;

  SurahModel({this.id, this.name, this.totalAyah});

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        id: json["id"],
        name: json["name"],
        totalAyah: json["totalAyah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "totalAyah": totalAyah,
      };
}
