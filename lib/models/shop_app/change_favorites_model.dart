class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesModel.fromJason(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
