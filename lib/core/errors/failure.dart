abstract class Failure {
  const Failure({required this.errorMessage});
  final String errorMessage;
}

class SeverFailure extends Failure {
  SeverFailure({required super.errorMessage});
}
