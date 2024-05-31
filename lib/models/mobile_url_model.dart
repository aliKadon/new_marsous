class MobileUrlModel {
  String? id;
  String? androidUrl;
  String? iosUrl;

  MobileUrlModel({this.id, this.androidUrl, this.iosUrl});

  factory MobileUrlModel.fromJson(Map<String, dynamic> json) => MobileUrlModel(
        id: json["id"],
        androidUrl: json["androidUrl"],
        iosUrl: json["iosUrl"],
      );
}
