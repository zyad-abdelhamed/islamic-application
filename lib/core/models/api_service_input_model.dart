class ApiServiceInputModel {
  final String url;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? apiHeaders;
  ApiServiceInputModel({required this.url, this.body, this.apiHeaders});
}
