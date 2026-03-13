import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failures.dart';

Failure mapErrorToFailure(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(
          'Connection timed out. Please check your internet and try again.',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return const ServerFailure(
            'Server is currently unavailable. Please try again later.',
          );
        }
        if (statusCode == 404) {
          return const ServerFailure(
            'Could not find data for this request.',
          );
        }
        return const ServerFailure(
          'Request failed. Please try again.',
        );
      case DioExceptionType.cancel:
        return const ServerFailure(
          'Request was cancelled. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const ServerFailure(
          'No internet connection. Please check your network and try again.',
        );
      case DioExceptionType.unknown:
      default:
        return const ServerFailure(
          'Something went wrong while contacting the server. Please try again.',
        );
    }
  } else if (error is SocketException) {
    return const ServerFailure(
      'No internet connection. Please check your network and try again.',
    );
  } else if (error is TimeoutException) {
    return const ServerFailure(
      'Request took too long. Please check your internet and try again.',
    );
  } else {
    return const ServerFailure(
      'An unexpected error occurred. Please try again.',
    );
  }
}

