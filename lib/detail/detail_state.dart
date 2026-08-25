enum DetailStatus {
  success,
  error,
  loading,
}

class DetailState {
  final DetailStatus status;
  final String errorMessage;

  const DetailState({
    required this.status,
    this.errorMessage = '',
  });

  DetailState copyWith({
    DetailStatus? status,
    String? errorMessage,
  }) {
    return DetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}