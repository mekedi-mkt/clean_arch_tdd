import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    final value = int.tryParse(str);
    if (value == null || value.isNegative) return Left(InvalidInputFailure());
    return Right(value);

    // Or use int.parse(str) wrapped in a try catch
  }
}

class InvalidInputFailure extends Failure {}
