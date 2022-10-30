import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constans/strings.dart';

class CharactersWebService {
  late Dio dio;

  CharactersWebService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, // 20 seconds
      receiveTimeout: 20 * 1000,
    );

  

    dio = Dio(options);
  }
    Future<List<dynamic>> getAllCharacters() async {
      try {
        Response response = await dio.get('characters');
        if(kDebugMode) print(response.data.toString());
        return response.data;
      } catch (e) {
        if(kDebugMode) print(e.toString());
        return [];
      }
    }
  

    Future<List<dynamic>> getCharacterQuotes(String charName) async { 
      try {
        Response response = await dio.get('quote', queryParameters: {'author' : charName}); 
         if(kDebugMode) print(response.data.toString());
        return response.data;
      } catch (e) {
        if(kDebugMode) print(e.toString());
        return [];
      }
    }
  
  
  }

