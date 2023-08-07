import 'dart:convert';
import 'dart:io';

import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/bid.dart';
import 'package:java_league/models/player.dart';

class BidService {
  Future<void> bid(int id, int value) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/player/${id}/bid?bidValue=$value');
    final response = await RestJavaLeague.http.patch(uri);
    if (response.statusCode == 200) return;
    dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(responseData['title']);
    }
  }
}