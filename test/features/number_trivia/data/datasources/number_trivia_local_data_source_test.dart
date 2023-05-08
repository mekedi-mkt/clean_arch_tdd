import 'dart:convert';

import 'package:clean_arch_tdd/core/constants/app_constants.dart';
import 'package:clean_arch_tdd/core/error/exception.dart';
import 'package:clean_arch_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_arch_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
      'should return NumberTrivia from SharedPreferences where there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(cachedNumberTriviaKey))
            .thenReturn(fixture('trivia_cached.json'));
        // act
        final result = await localDataSource.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString(cachedNumberTriviaKey));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw CacheException when there is no cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(cachedNumberTriviaKey)).thenReturn(null);
        // act
        final call = localDataSource.getLastNumberTrivia;
        // assert
        expect(call, throwsA(const TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');
    // fixme: cacheNumberTrivia test fails
    test('should call SharedPreferences to cache the data', () {
      // act
      localDataSource.cacheNumberTrivia(tNumberTriviaModel);
      // arrange
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(
        mockSharedPreferences.setString(
            cachedNumberTriviaKey, expectedJsonString),
      );
    });
  });
}
