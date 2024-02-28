import 'dart:convert';

import 'package:http/http.dart';

const baseUrl = "https://hacker-news.firebaseio.com/v0/";

Future<List<int>> getTopStories() async {
  var resp = await get(Uri.parse("${baseUrl}topstories.json"));
  var array = resp.body.substring(1, resp.body.length - 1).split(',');
  List<int> newsID = [];
  for (int i = 0; i < array.length; ++i) {
    newsID.add(int.parse(array[i].substring(0, array[i].length - 1)));
  }
  return newsID;
}

class NewDTO {
  final int id;
  final bool? deleted;
  final String type;
  final String? by;
  final int? time;
  final String? text;
  final bool? dead;
  final int? parent;
  final int? poll;
  final List<int>? kids;
  final String? url;
  final int? score;
  final String? title;
  final List<int>? parts;
  final int? descendants;

  NewDTO({
    required this.id,
    required this.deleted,
    required this.type,
    required this.by,
    required this.time,
    required this.text,
    required this.dead,
    required this.parent,
    required this.poll,
    required this.kids,
    required this.url,
    required this.score,
    required this.title,
    required this.parts,
    required this.descendants,
  });

  factory NewDTO.fromJson(Map<String, dynamic> json) {
    return NewDTO(
      id: json['id'],
      deleted: json['deleted'],
      type: json['type'],
      by: json['by'],
      time: json['time'],
      text: json['text'],
      dead: json['dead'],
      parent: json['parent'],
      poll: json['poll'],
      kids: json['kids'] != null ? List<int>.from(json['kids']) : null,
      url: json['url'],
      score: json['score'],
      title: json['title'],
      parts: json['parts'] != null ? List<int>.from(json['parts']) : null,
      descendants: json['descendants'],
    );
  }

}

Future<NewDTO> getNew(int id) async {
  var resp = await get(Uri.parse("${baseUrl}item/$id.json"));
  Map<String, dynamic> jsonMap = json.decode(resp.body);
  return NewDTO.fromJson(jsonMap);
}
