import 'dart:convert';
import 'package:http/http.dart' as http;
import '../card_model.dart' as mymodel;

class ClashApi {
  final String _baseUrl = "https://api.clashroyale.com/v1";
  final String _token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImM4ZWNkNjUwLTRiZTAtNGExNi05YzI2LTk2NmRiZDJmNGM1NSIsImlhdCI6MTc1ODIzOTc2OSwic3ViIjoiZGV2ZWxvcGVyLzQ4MWE2NmFkLTJlZGMtNz M0OS0yODQ3LWRmNmNhNGI5NDU0ZiIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbe yJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRy cyI6WyIyMDAuMjUyLjE0OC4xMzAiXSwidHlwZSI6ImNsaWVudCJ9XX0.XJ9D9Kjwx1ab9W_ m-h2hHPlxU_GidDL_0bcyKyzxBCg3yxjGJTYYkjKob7DNzCgVOk9jrRifQpJ5bYqWJ-pgag";

  Future<List<mymodel.Card>> getCards() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/cards"),
      headers: {
        "Authorization": "Bearer $_token",
      },
    );
    

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  final cardsList = data['items'] as List;
  return cardsList.map((json) => mymodel.Card.fromJson(json)).toList();
} else {
  throw Exception("Erro ao carregar as cartas");
} 
  }
}