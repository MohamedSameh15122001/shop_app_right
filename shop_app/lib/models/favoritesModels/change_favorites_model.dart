// class ChangeToFavoritesModel {
//   bool? status;
//   String? message;

//   ChangeToFavoritesModel.fromjson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//   }
// }

class ChangeToFavoritesModel {
  bool? status;
  String? message;

  ChangeToFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
