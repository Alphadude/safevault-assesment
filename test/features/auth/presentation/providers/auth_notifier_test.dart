import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:safe_vault/features/auth/domain/entities/user_entity.dart';
import 'package:safe_vault/features/auth/domain/repositories/auth_repository.dart';
import 'package:safe_vault/features/auth/presentation/providers/auth_provider.dart';
import 'package:safe_vault/features/auth/presentation/providers/auth_state.dart';
import 'package:safe_vault/core/error/failures.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthNotifier authNotifier;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authNotifier = AuthNotifier(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'Password123!';
  const tUser = UserEntity(id: '1', email: tEmail, name: 'Test User');

  test('initial state should be AuthInitial', () {
    expect(authNotifier.state, equals(const AuthInitial()));
  });

  group('login', () {
    test('should emit [AuthLoading, AuthAuthenticated] when login is successful', () async {
      // arrange
      when(() => mockAuthRepository.login(any(), any()))
          .thenAnswer((_) async => const Right(tUser));

      // act
      final future = authNotifier.login(tEmail, tPassword);

      // assert
      expect(authNotifier.state, equals(const AuthLoading()));
      await future;
      expect(authNotifier.state, equals(const AuthAuthenticated(tUser)));
      verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
    });

    test('should emit [AuthLoading, AuthError] when login fails', () async {
      // arrange
      when(() => mockAuthRepository.login(any(), any()))
          .thenAnswer((_) async => const Left(AuthFailure('Invalid credentials')));

      // act
      final future = authNotifier.login(tEmail, tPassword);

      // assert
      expect(authNotifier.state, equals(const AuthLoading()));
      await future;
      expect(authNotifier.state, equals(const AuthError('Invalid credentials')));
    });

    test('should emit [AuthLoading, AuthError] with lockout message when brute-force detected', () async {
      // arrange
      when(() => mockAuthRepository.login(any(), any()))
          .thenAnswer((_) async => const Left(AuthFailure('Too many attempts. Please try again in 60 seconds.')));

      // act
      await authNotifier.login(tEmail, tPassword);

      // assert
      expect(authNotifier.state, equals(const AuthError('Too many attempts. Please try again in 60 seconds.')));
    });
  });
}
