import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

Future getQuote() async {
  var url = Uri.https("zenquotes.io", "api/quotes/");

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    var quote = jsonResponse[0]['q'];
    var author = jsonResponse[0]['a'];
    return {'quote': quote, 'author': author};
  } else {
    return {'quote': "SHAME!", 'author': "- Pork"};
  }
}
