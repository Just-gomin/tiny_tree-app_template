import 'package:fpdart/fpdart.dart';

import '../../domain/entities/user.dart';
import '../../domain/failures/auth_failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../datasources/auth_local_datasource.dart';
import '../exceptions/exceptions.dart';

/// AuthRepository 구현체
///
/// DataSource를 조합하여 Repository 인터페이스를 구현합니다.
class AuthRepositoryImpl implements AuthRepository {
  /// AuthRepositoryImpl 생성자
  const AuthRepositoryImpl({
    required AuthDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<AuthFailure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );

      // 로컬에 사용자 정보 저장
      await _localDataSource.saveUser(userModel);

      return Right(userModel.toEntity());
    } on InvalidCredentialsException {
      return const Left(InvalidCredentialsFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, User>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userModel = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );

      // 로컬에 사용자 정보 저장
      await _localDataSource.saveUser(userModel);

      return Right(userModel.toEntity());
    } on UserAlreadyExistsException {
      return const Left(UserAlreadyExistsFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      await _remoteDataSource.signOut();

      // 로컬 데이터 삭제
      await _localDataSource.deleteUser();
      await _localDataSource.deleteToken();

      return const Right(null);
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, User?>> getCurrentUser() async {
    try {
      // 먼저 로컬에서 조회
      final cachedUser = await _localDataSource.getUser();
      if (cachedUser != null) {
        return Right(cachedUser.toEntity());
      }

      // 로컬에 없으면 원격에서 조회
      final userModel = await _remoteDataSource.getCurrentUser();
      if (userModel != null) {
        // 로컬에 저장
        await _localDataSource.saveUser(userModel);
        return Right(userModel.toEntity());
      }

      return const Right(null);
    } on SessionExpiredException {
      return const Left(SessionExpiredFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<AuthFailure, void>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _remoteDataSource.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on UserNotFoundException {
      return const Left(UserNotFoundFailure());
    } on NetworkException {
      return const Left(NetworkFailure());
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _remoteDataSource.authStateChanges.map(
      (userModel) => userModel?.toEntity(),
    );
  }
}
