import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/core/flatform/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

void main() {
  late NetworkInfo networkInfo;
  late MockInternetConnectionChecker mockConnectionChecker;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(connectionChecker:mockConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      //arrange
      when(() => mockConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      //act
      final result = await networkInfo.isConnected;

      //assert
      verify(() => mockConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
