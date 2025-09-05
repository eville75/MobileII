import 'dart:convert';
import 'package:http/http.dart' as http;

class ClashApi {
  final String _baseUrl = "https://api.clashroyale.com/v1";
  final String _token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjdmZTQ4YzFkLTU1MGEtNGQwNy1hNjVmLTM1MDI0MTIwZmJlMyImlhdCI6MTc1NzAzMjk0MSwic3ViIjoiZGV2ZWxvcGVyLzQ4MWE2NmFkLTJlZGMtNz M0OS0yODQ3LWRmNmNhNGI5NDU0ZiIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbe yJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRy cyI6WyIyMDAuMjUyLjE0OC4xMzAiXSwidHlwZSI6ImNsaWVudCJ9XX0.oWUQfc_FnHnXJbH s593wkz66tc1QU3zDAjraYGpMb3rn1PwTf_rtSj2s0z6VrT3_Ro9PmeEUjQq8UWChHSYxw";

  Future<List<dynamic>> getCards() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/cards"),
      headers: {
        "Authorization": "Bearer $_token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['items']; // cards vem em 'items'
    } else {
      throw Exception("Erro ao carregar as cartas");
    }
  }
}
