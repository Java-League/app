import 'dart:convert';
import 'dart:io';

import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/bid.dart';

class BidService {
  Future<void> bid(Bid bid) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/bid');
    try {
      final response = await RestJavaLeague.http.post(uri, body: json.encode(bid));
      dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw HttpException(responseData['title']);
      }
    }catch(e) {
      throw e;
    }
  }
}