import 'package:clean_arch_tdd/core/usecase/usecase.dart';
import 'package:clean_arch_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_arch_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockRepository;

  setUp(() {
    mockRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');

  test('should get trivia for the number from the repository', () async {
    // arrange
    when(mockRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => const Right(tNumberTrivia));

    // act
    final result = await usecase(const Params(number: tNumber));

    // assert
    expect(result, const Right(tNumberTrivia));
    verify(mockRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockRepository);
  });
}
