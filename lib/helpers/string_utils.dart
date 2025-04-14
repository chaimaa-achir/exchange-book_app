String limitWords(String text, int wordLimit) {
  List<String> words = text.split(' ');
  if (words.length <= wordLimit) return text;
  return words.sublist(0, wordLimit).join(' ') + '...';
}