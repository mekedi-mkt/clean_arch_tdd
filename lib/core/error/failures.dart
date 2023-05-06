import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // const Failure([List properties = const <dynamic>[]]) : super(properties);

  @override
  List<Object?> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}