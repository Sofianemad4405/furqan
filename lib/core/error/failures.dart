import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  @override
  List<Object?> get props => [message];
}

///server failure
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

///cahce failure
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
