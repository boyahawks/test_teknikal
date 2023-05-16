import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Api {
  static var basicAuth = 'Basic ' +
      base64Encode(utf8.encode(
          'sbanewapplication:0a308bd81a825501a0b753eb1d4befff22d47ab8a50aa4b33dca1e3667e1d1ab'));

  static var basicUrl = "https://newsapi.org/v2/";

  static Future connectionApi(
      String typeConnect, valFormData, String url) async {
    var getUrl = basicUrl + url;
    Map<String, String> headers = {
      'Authorization': basicAuth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    if (typeConnect == "post" ||
        typeConnect == "patch" ||
        typeConnect == "delete") {
      try {
        var url = Uri.parse(getUrl);
        if (typeConnect == "post") {
          var response =
              await post(url, body: jsonEncode(valFormData), headers: headers);
          print(response);
          return response;
        } else if (typeConnect == "patch") {
          var response =
              await patch(url, body: jsonEncode(valFormData), headers: headers);
          return response;
        } else if (typeConnect == "delete") {
          var response = await delete(url,
              body: jsonEncode(valFormData), headers: headers);
          return response;
        }
      } on SocketException catch (e) {
        print(e);
        return false;
      }
    } else {
      try {
        var url = Uri.parse(getUrl);
        var response = await get(url, headers: headers);
        return response;
      } on SocketException catch (e) {
        return false;
      }
    }
  }

  static Future connectionApiUploadFile(String url, File newFile) async {
    var getUrl = basicUrl + url;
    Map<String, String> headers = {
      'Authorization': basicAuth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final url = Uri.parse(getUrl);
      var request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('sampleFile', newFile.path),
      );
      request.headers.addAll(headers);
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      return respStr;
    } on SocketException catch (e) {
      return false;
    }
  }
}
