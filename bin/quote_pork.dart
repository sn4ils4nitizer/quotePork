import 'package:quote_pork/quote_pork.dart' as quote_pork;

String formatQuote(String quote, String author, {int maxWidth = 40}) {
  List<String> words = quote.split(' ');
  List<String> lines = [];
  String currentLine = '';

  for (String word in words) {
    if ((currentLine + word).length > maxWidth) {
      lines.add(currentLine.trim());
      currentLine = '';
    }
    currentLine += '$word ';
  }
  lines.add(currentLine.trim());

  String formattedQuote = lines.join('\n');

  String formattedAttribution = '    - $author';

  return '$formattedQuote\n$formattedAttribution';
}

void displayQuoteWithPig(String quote, String author) {
  String formattedQuote = formatQuote(quote, author);

  List<String> lines = formattedQuote.split('\n');
  int maxLineLength =
      lines.map((line) => line.length).reduce((a, b) => a > b ? a : b);

  String dialogBox = '''\x1B[1;93m
   ★ ${'_' * (maxLineLength + 2)} ★
  < ${lines[0]} >
${lines.skip(1).map((line) => ' $line ').join('\n')}
   ☆ ${'-' * (maxLineLength + 2)} ☆
      \   /      __,---.__
       \ /  __,-'         `-.
        \  /_ /_,'           \&
          _,''               \
         (")            .    |
           ``--|__|--..-'`.__|
  ''';

  print(dialogBox);
}

void main() async {
  var quoteData = await quote_pork.getQuote();
  String quote = quoteData['quote'];
  String author = quoteData['author'];
  displayQuoteWithPig(quote, author);
}
