import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

///  Takes a JSON as input, decodes it into a list of ModelEndpoint
List<ModelEndpoint> fipeApiFromJson(String string) =>
    List<ModelEndpoint>.from(json.decode(string).map(ModelEndpoint.fromJson));

/// Takes a list of ModelEndpoint objects, converts them into a JSON of string
String fipeApiToJson(List<ModelEndpoint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

/// Create instances from JSON data and convert instances to JSON,
class BrandEndpoint {
  /// A unique code associated with the brand.
  final String? code;

  /// The name of the brand.
  final String? name;

  /// Create a constructor for [code] and [name].
  BrandEndpoint({
    this.code,
    this.name,
  });

  /// Create a JSON map  where [code] and [nome] are expected to be keys.
  factory BrandEndpoint.fromJson(Map<String, dynamic> json) => BrandEndpoint(
        code: json['codigo'],
        name: json['nome'],
      );

  /// Convert the Map to JSON.
  Map<String, dynamic> toJson() => {
        'codigo': code,
        'nome': name,
      };

  @override
  String toString() {
    return name!;
  }
}

/// create instances of the class, convert them to JSON,
/// and obtain a custom string.
class ModelEndpoint {
  /// A unique code associated with the model.
  final String? code;

  /// The name of the model.
  final String? name;

  /// Create a constructor for [code] and [name].
  ModelEndpoint({
    this.code,
    this.name,
  });

  /// Create a JSON map where [code] and [nome] are expected to be keys.
  factory ModelEndpoint.fromJson(Map<String, dynamic> json) => ModelEndpoint(
        code: json['codigo'].toString(),
        name: json['nome'],
      );

  /// Convert the Map to JSON.
  Map<String, dynamic> toJson() => {
        'codigo': code,
        'nome': name,
      };

  @override
  String toString() {
    return name!;
  }
}

/// This function performs an asynchronous HTTP GET request to a URL,
/// retrieves a list of car brands in JSON format.
Future<List<BrandEndpoint>?> getCarBrands() async {
  const url = 'https://parallelum.com.br/fipe/api/v1/carros/marcas/';
  final uri = Uri.parse(url);

  final response = await http.get(uri);

  final decodeResult = jsonDecode(response.body);

  final result = <BrandEndpoint>[];

  for (final item in decodeResult) {
    result.add(
      BrandEndpoint.fromJson(item),
    );
  }
  return result;
}

/// This function performs an HTTP GET request to a specific URL,
/// retrieves a JSON response
Future<List<ModelEndpoint>?> getCarModel(String brandName) async {
  final listOfBrands = await getCarBrands();

  var brand = listOfBrands!.firstWhere(
    (element) => element.name == brandName,
    orElse: () => BrandEndpoint(code: null),
  );

  if (brand.code != null) {
    final url =
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/${brand.code}/modelos/';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    final decodeResult = jsonDecode(response.body);
    log(decodeResult['modelos'].toString());

    final result = <ModelEndpoint>[];

    for (final item in decodeResult['modelos']) {
      result.add(
        ModelEndpoint.fromJson(item),
      );
    }
    return result;
  } else {
    return null;
  }
}
