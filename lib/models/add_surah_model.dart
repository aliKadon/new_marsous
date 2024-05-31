class AddSurahModel {
  int? surahId;
  int? startAyahNumber;
  int? endAyahNumber;

  Map<String, dynamic> toJson() => {
        "surahId": surahId,
        "startAyahNumber": startAyahNumber,
        "endAyahNumber": endAyahNumber,
      };
}
