import 'dart:convert';
import 'package:http/http.dart' as http;

class Notify {
  Future<bool> productNotification(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/product",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAza81tZ4:APA91bGHFwBTj_pNblJ1G94hbMPTLyEMb3s6Xium-OTdtS5wVsPZFEpAMI4So6ZHDAJuISS4VxWSvS9r-jL9cjmIXSqaTqZUzVSPXuAbfgY3HAYWUqJuWiP1x9uIsyWxtBOhe6SUNzyN' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      // print('test ok push CFM');
      return true;
    } else {
      // print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  Future<bool> orderNotification(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": "/topics/order",
      "notification": {
        "title": title,
        "body": body,
      },
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAza81tZ4:APA91bGHFwBTj_pNblJ1G94hbMPTLyEMb3s6Xium-OTdtS5wVsPZFEpAMI4So6ZHDAJuISS4VxWSvS9r-jL9cjmIXSqaTqZUzVSPXuAbfgY3HAYWUqJuWiP1x9uIsyWxtBOhe6SUNzyN' // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      // print('test ok push CFM');
      return true;
    } else {
      // print(' CFM error');
      // on failure do sth
      return false;
    }
  }
}
