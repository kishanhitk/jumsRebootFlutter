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
}
