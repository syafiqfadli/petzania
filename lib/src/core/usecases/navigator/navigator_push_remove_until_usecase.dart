import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/errors/failures.dart';
import 'package:pet_care_flutter_app/src/core/usecases/usecase.dart';

class NavigatorPushRemoveUntilUseCase
    implements UseCase<dynamic, NavigatorPushRemoveUntilParam> {
  @override
  Future<Either<Failure, dynamic>> call(
      NavigatorPushRemoveUntilParam params) async {
    return await Navigator.pushAndRemoveUntil(
      params.context,
      params.route,
      (route) => false,
    );
  }
}

class NavigatorPushRemoveUntilParam {
  final Route route;
  final BuildContext context;

  const NavigatorPushRemoveUntilParam({
    required this.route,
    required this.context,
  });
}
