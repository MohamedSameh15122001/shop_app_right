import 'package:dio/dio.dart';

String mainLang = 'en';

class DioHelper {
  static late Dio dio;

  static init() {
    print('dioHelper Initialized');
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: false,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        sendTimeout: 4000,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'lang': mainLang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': mainLang,
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> postLoginData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': mainLang,
      'Content-Type': 'application/json',
    };

    return await dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      Map<String, dynamic>? data,
      String lang = 'en',
      String? token}) async {
    dio.options.headers = {
      'lang': mainLang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData(
      {required String url, String lang = 'en', String? token}) async {
    dio.options.headers = {
      'lang': mainLang,
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.delete(url);
  }
}






// import 'package:dio/dio.dart';

// class DioHelper {
//   static late Dio dio;

//   //initial the dio
//   static init() {
//     print('dioHelper Initialized');
//     dio = Dio(
//       BaseOptions(
//         baseUrl: 'https://student.valuxapps.com/api/',
//         receiveDataWhenStatusError: true,
//       ),
//     );
//   }

  // //send data
  // static Future<Response> postData({
  //   required String url,
  //   String lang = 'en',
  //   String? token,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  // }) async {
  //   dio.options.headers = {
  //     'lang': '$lang',
  //     'Content-Type': 'application/json',
  //     'Authorization': token ?? ''
  //   };
  //   return await dio.post(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }

  // //get data
  // static Future<Response> getData({
  //   required String url,
  //   String lang = 'en',
  //   String? token,
  //   Map<String, dynamic>? query,
  //   Map<String, dynamic>? data,
  // }) async {
  //   dio.options.headers = {
  //     'lang': '$lang',
  //     'Content-Type': 'application/json',
  //     'Authorization': '$token'
  //   };
  //   return await dio.get(
  //     url,
  //     queryParameters: query,
  //   );
  // }

  // //update data
  // static Future<Response> putData({
  //   required String url,
  //   String lang = 'en',
  //   String? token,
  //   Map<String, dynamic>? query,
  //   Map<String, dynamic>? data,
  // }) async {
  //   dio.options.headers = {
  //     'lang': '$lang',
  //     'Content-Type': 'application/json',
  //     'Authorization': '$token'
  //   };
  //   return await dio.put(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }

  // //delete data
  // static Future<Response> deleteData({
  //   required String url,
  //   String lang = 'en',
  //   String? token,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic>? data,
  // }) async {
  //   dio.options.headers = {
  //     'lang': '$lang',
  //     'Content-Type': 'application/json',
  //     'Authorization': '$token'
  //   };
  //   return await dio.delete(
  //     url,
  //     data: data,
  //     queryParameters: query,
  //   );
  // }
// }
