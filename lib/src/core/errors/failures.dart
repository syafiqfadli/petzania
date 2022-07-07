import 'package:equatable/equatable.dart';

abstract class Failure<T> extends Equatable {
  final T? cachedData;
  final String message;

  const Failure._({required this.cachedData, required this.message});

  @override
  List<Object> get props => [];
}

class ServerFailure<T> extends Failure<T> {
  const ServerFailure({String message = '', T? cachedData})
      : super._(cachedData: cachedData, message: message);
}

class CacheFailure<T> extends Failure {
  const CacheFailure({String message = '', T? cachedData})
      : super._(cachedData: cachedData, message: message);
}

class SystemFailure<T> extends Failure {
  const SystemFailure({String message = '', T? cachedData})
      : super._(cachedData: cachedData, message: message);

  @override
  List<Object> get props => [message];
}

class InvalidInputFailure extends Failure<dynamic> {
  const InvalidInputFailure({String message = ''})
      : super._(cachedData: null, message: message);
}
