import 'dart:async';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  int _failedAttempts = 0;
  DateTime? _lockoutUntil;
  static const int maxAttempts = 5;
  static const Duration lockoutDuration = Duration(minutes: 1);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Check brute force lockout
    if (_lockoutUntil != null && DateTime.now().isBefore(_lockoutUntil!)) {
      final remaining = _lockoutUntil!.difference(DateTime.now()).inSeconds;
      return Left(BruteForceFailure("Too many attempts. Please try again in $remaining seconds."));
    }

    // Mock Backend Logic
    if (email == "admin@safevault.com" && password == "SecurePass123!") {
      _failedAttempts = 0;
      _lockoutUntil = null;
      return const Right(UserModel(
        id: "1",
        email: "admin@safevault.com",
        name: "Admin User",
      ));
    } else {
      _failedAttempts++;
      if (_failedAttempts >= maxAttempts) {
        _lockoutUntil = DateTime.now().add(lockoutDuration);
        _failedAttempts = 0; // Reset after setting lockout
        return const Left(BruteForceFailure("Too many failed attempts. Account locked for 1 minute."));
      }
      return const Left(AuthFailure("Invalid email or password."));
    }
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    return const Left(AuthFailure("No user logged in"));
  }
}
