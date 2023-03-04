class CustomException implements Exception {
  const CustomException({
    this.code,
    this.message,
  });

  final String? code;
  final String? message;
}