class GeneralNetworkException implements Exception {
  final String errorMessage;

  const GeneralNetworkException({this.errorMessage = "Something went wrong"});
}
