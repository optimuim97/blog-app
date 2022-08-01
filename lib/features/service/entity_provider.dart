import 'dart:convert';
import 'dart:developer';

import 'package:blogapp/constant.dart';
import 'package:blogapp/models/api_response.dart';
import 'package:blogapp/models/entity_model.dart';
import 'package:blogapp/services/user_service.dart';

import 'package:http/http.dart' as http;
class EntityApiProvider{
  Future<ApiResponse> getEntity() async {
    log('reading...');
  ApiResponse apiResponse = ApiResponse();
  try {
   String token = await getToken();

    final response = await http.get(Uri.parse(entityUrl), headers: {
      'Accept': 'application/json',
       'Authorization': 'Bearer $token'
     
    });
log('reading...');
 log(jsonDecode(response.body)['data'].toString());
 log('+++++++++');
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data'].map((p) => EntityModel.fromJson(p)).toList();
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
   
  }
  return apiResponse;
}
}