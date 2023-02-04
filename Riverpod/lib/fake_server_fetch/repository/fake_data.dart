
class FakeData{
  int id;
  String title;
  String content;
  bool checked;

  FakeData({
    required this.id,
    required this.title,
    required this.content,
    required this.checked,
  });

  FakeData copyWith({
    String? title,
    String? content,
    bool? checked,
  }){
    return FakeData(
      id: id,
      title: title??this.title,
      content: content??this.content,
      checked: checked??this.checked,
    );
  }

}