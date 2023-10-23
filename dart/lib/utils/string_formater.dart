class StringFormater {
  static removeHtmlTags(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  static getInitialName(List<dynamic> name) {
    String iniciais = '';

    for (var latter in name) {
      if (latter is String) {
        List<String> palavras = latter.split(' ');
        for (var palavra in palavras) {
          if (palavra.isNotEmpty) {
            iniciais += palavra[0];
          }
        }
      }
    }

    return iniciais;
  }
}
