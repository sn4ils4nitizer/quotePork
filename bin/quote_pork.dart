import 'package:quote_pork/quote_pork.dart' as quote_pork;

String formatQuote(String quote, String author, {int maxWidth = 40}) {
  // Wrap the quote text to the specified maxWidth
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
  lines.add(currentLine.trim()); // Add the last line

  // Combine the lines with line breaks
  String formattedQuote = lines.join('\n');

  // Format the attribution below the quote
  String formattedAttribution = '    - $author';

  return '$formattedQuote\n$formattedAttribution';
}

void displayQuoteWithPig(String quote, String author) {
  // Format the quote and attribution
  String formattedQuote = formatQuote(quote, author);

  // Split the formatted quote into lines to calculate the max line length
  List<String> lines = formattedQuote.split('\n');
  int maxLineLength =
      lines.map((line) => line.length).reduce((a, b) => a > b ? a : b);

  // Create the comic-style dialog box with sparkles
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

  print(dialogBox); // Print the dialog box with the piggy
}

void main() async {
  var quoteData = await quote_pork.getQuote();
  String quote = quoteData['quote'];
  String author = quoteData['author'];
  displayQuoteWithPig(quote, author);
}
