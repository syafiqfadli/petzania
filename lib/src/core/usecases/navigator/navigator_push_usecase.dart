import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';

import '../usecase.dart';

class NavigatorPushUseCase<T> implements UseCase<T, NavigatorPushParam<T>> {
  @override
  Future<Either<Failure, T>> call(NavigatorPushParam<T> params) async {
    final value = await Navigator.push<T>(params.context, params.route);

    return Right(value as T);
  }
}

class NavigatorPushParam<T> {
  final Route<T> route;
  final BuildContext context;

  const NavigatorPushParam({
    required this.route,
    required this.context,
  });
}
