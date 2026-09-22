import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unishare/shared/models/models.dart';

final mockCurrentUser = UniUser(
  id: 'usr_1',
  name: 'Anup Sharma',
  email: 'anup@campus.edu',
  college: 'IIT Delhi',
  department: 'CS',
  joinedAt: DateTime.now(),
);

enum AuthStatus { initial, unauthenticated, verifying, authenticated }

class AuthState {
  final AuthStatus status;
  final UniUser? user;
  final String? error;

  const AuthState({
    required this.status,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    UniUser? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(status: AuthStatus.authenticated, user: mockCurrentUser));

  void login(String email, String password) {
    state = state.copyWith(status: AuthStatus.authenticated, user: mockCurrentUser);
  }

  void logout() {
    state = state.copyWith(status: AuthStatus.unauthenticated, user: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
