import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final value = int.parse(str);
      if (value.isNegative) return Left(InvalidInputFailure());
      return Right(value);
    } catch (e) {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
