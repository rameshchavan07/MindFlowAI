import 'package:firebase_auth/firebase_auth.dart';
import 'user_model.dart';

abstract class AuthRepository {
  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;

  /// Get the current authenticated user
  User? get currentUser;

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);

  /// Sign up with email and password, and create a user profile in Firestore
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    UserModel profile,
  );

  /// Sign in with Google credentials
  Future<UserCredential> signInWithGoogle();

  /// Sign out current user from Firebase and Google Sign-in
  Future<void> signOut();

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Fetch user profile details from Firestore
  Future<UserModel?> getUserProfile(String uid);

  /// Update/create user profile details in Firestore
  Future<void> updateUserProfile(UserModel profile);
}
