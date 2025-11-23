import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:delivery_app/helper/api.dart';


class AddImageService {
  Future<bool> addImage({required String token, required File image}) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(image.path);

    var request =
        http.MultipartRequest('POST', Uri.parse('${Api().baseURL}/user/image'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("true in service");
      return true;
    } else {
      print("error in service the status is ${response.statusCode}");
      return false;
    }

  }
}
