// class CategoriesModel {
//   bool? status;
//   Data? data;

//   CategoriesModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
// }

// class CategoriesDataModel {
//   int? currentPage;
//   List<DataModel>? data;

//   CategoriesDataModel.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];

//     json['data'].forEach(
//       (v) {
//         data!.add(
//           DataModel.fromJson(
//             v,
//           ),
//         );
//       },
//     );
//   }
// }

// class DataModel {
//   int? id;
//   String? name;
//   String? image;

//   DataModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//   }
// }

class CategoriesModel {
  bool? status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  late List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach(
      (element) {
        data.add(
          DataModel.fromJson(
            element,
          ),
        );
      },
    );
  }
}

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
