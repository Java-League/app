import 'dart:convert';
import 'dart:io';

import 'package:java_league/config/rest_config.dart';
import 'package:java_league/models/team.dart';

class TeamService {
  Future<Team> getTeam() async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/team/current');
    final response = await RestJavaLeague.http.get(uri);
    dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(responseData['title']);
    }
    return Team.fromJson(responseData);
  }

  Future<List<Team>> getAllTeamsAvailable() async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/team/available');
    final response = await RestJavaLeague.http.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
      throw HttpException(responseData['title']);
    }
    List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));

    return List<Team>.from(responseData.map((model)=> Team.fromJson(model)));
  }

  Future<void> saveTeamCurrentUser(int teamId) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/team?teamId=$teamId');
    final response = await RestJavaLeague.http.post(uri);
    if (response.statusCode == 200) return;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
      throw HttpException(responseData['title']);
    }
  }

  Future<void> saveTeamPlayer(int id, int position) async {
    final uri = Uri.parse('${RestJavaLeague.serverApiUrl}/api/team/${id}/player?position=$position');
    final response = await RestJavaLeague.http.post(uri);
    if (response.statusCode == 200) return;
    if (response.statusCode < 200 || response.statusCode >= 300) {
    dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
      throw HttpException(responseData['title']);
    }
  }
}