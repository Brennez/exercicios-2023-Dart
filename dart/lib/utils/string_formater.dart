class StringFormater {
  static removeHtmlTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  static getInitialName(List<dynamic> name) {
    List<String> separeteName = name[0].split(" ");

    String firstLetter = separeteName[0][0];
    String secondtLetter = separeteName[1][0];

    return firstLetter + secondtLetter;
  }
}
