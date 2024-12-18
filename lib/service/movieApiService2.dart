import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBService2 {
  final String apiKey = '95ee854b0f49087b8cba3d741968713e';
  final String baseUrl = 'https://api.themoviedb.org/3';

  // Función para obtener un trailer de una película
  Future<String?> obtenerTrailerPelicula(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=es-ES');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      
      if (results.isNotEmpty) {
        // El primer trailer encontrado (si existe)
        return 'https://www.youtube.com/watch?v=${results[0]['key']}';
      }
    }
    
    return null;  // Si no se encuentra trailer
  }
}
