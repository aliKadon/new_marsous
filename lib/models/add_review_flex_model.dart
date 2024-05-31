import 'package:marsous1/models/add_surah_model.dart';

class AddReviewFlexModel {
  String? studentId;
  String? courseSessionId;
  AddSurahModel? sessionMemorize;
  AddSurahModel? nearReview;
  AddSurahModel? farReview;
  String? sessionTajweed;
  String? sessionTask;
  String? sessionTest;

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "courseSessionId": courseSessionId,
        "sessionMemorize": sessionMemorize,
        "nearReview": nearReview,
        "farReview": farReview,
        "sessionTajweed": sessionTajweed,
        "sessionTask": sessionTask,
        "sessionTest": sessionTest,
      };
}
