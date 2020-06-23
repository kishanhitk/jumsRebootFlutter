import 'dart:convert';

class SemButtons {
  final String text;
  final String link;
  SemButtons({this.link, this.text});
  factory SemButtons.fromJson(Map<String, dynamic> json) {
    return SemButtons(
      text: json['text'],
      link: json['link'],
    );
  }
  static Map<String, dynamic> toMap(SemButtons obj) => {
        'text': obj.text,
        'link': obj.link,
      };
  static String encodeButtons(List<SemButtons> semButtons) => json.encode(
        semButtons
            .map<Map<String, dynamic>>((button) => SemButtons.toMap(button))
            .toList(),
      );
  static List<SemButtons> decodeButtons(String buttons) =>
      (json.decode(buttons) as List<dynamic>)
          .map<SemButtons>((button) => SemButtons.fromJson(button))
          .toList();
}
