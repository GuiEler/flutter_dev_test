part of 'errors.dart';

sealed class DomainError implements Exception {
  const DomainError({required this.message, required this.detail});

  final String message;
  final String detail;
}
