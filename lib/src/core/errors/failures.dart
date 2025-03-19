import 'package:equatable/equatable.dart';

abstract class Failure<T> extends Equatable {
  final T? cachedData;
  final String message;

  const Failure._({required this.cachedData, required this.message});

  @override
  List<Object> get props => [];
}

class ServerFailure<T> extends Failure<T> {
  const ServerFailure({super.message = '', super.cachedData})
      : super._();
}

class CacheFailure<T> extends Failure {
  const CacheFailure({super.message = '', T? super.cachedData})
      : super._();
}

class SystemFailure<T> extends Failure {
  const SystemFailure({super.message = '', T? super.cachedData})
      : super._();

  @override
  List<Object> get props => [message];
}

class InvalidInputFailure extends Failure<dynamic> {
  const InvalidInputFailure({super.message = ''})
      : super._(cachedData: null);
}
