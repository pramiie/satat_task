import 'package:dio/dio.dart';
import 'api_end_point.dart';

class DioClient {

  DioClient._();
  static DioClient dioClient = DioClient._();
  static Dio dio = Dio();

  BaseOptions baseUrl = BaseOptions(baseUrl:APIEndPoint.baseUrl);

  Future<Response> getAPI({required String endPoint})async{
    dio.options = baseUrl;
    return dio.get(endPoint);
  }
}