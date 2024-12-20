import 'dart:convert';
//import 'package:http_parser/http_parser.dart' as http;
import 'package:http/http.dart' as http;

class TMDBService {
  // Tu token de autorización (API Key)
  final String apiKey = '95ee854b0f49087b8cba3d741968713e';
  final String baseUrl = 'https://api.themoviedb.org/3';

  // Función para obtener una lista de películas populares
  Future<List> obtenerPeliculasPopulares() async {
    final url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=es-ES&page=1');

    // Realizamos la solicitud HTTP
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, decodificamos la respuesta JSON
      final Map<String, dynamic> data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Error al cargar las películas');
    }
  }

  // Función para obtener los detalles de una película
  Future<Map<String, dynamic>> obtenerDetallesPelicula(int movieId) async {
    final url = Uri.parse('$baseUrl/movie/$movieId?api_key=$apiKey&language=es-ES');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los detalles de la película');
    }
  }
}