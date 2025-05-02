import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

class AuthService {
  late Client _client;
  late Account _account;
  late Databases _database;

  final String endpoint = 'https://cloud.appwrite.io/v1';
  final String projectId = '68103b22002e884766ae';
  final String databaseId = '68103b8500095ab74bf0';
  final String usersCollectionId = 'users';

  AuthService() {
    _client = Client()
      ..setEndpoint(endpoint)
      ..setProject(projectId)
      ..setSelfSigned(status: true);

    _account = Account(_client);
    _database = Databases(_client);
  }

  Future<models.User?> registerUser({
    required String email,
    required String password,
    required String name,
    required String role, required String phone, // cliente o restaurante
  }) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      // Guardamos el rol en la base de datos
      await _database.createDocument(
        databaseId: databaseId,
        collectionId: usersCollectionId,
        documentId: user.$id,
        data: {
          'name': name,
          'email': email,
          'role': role,
        },
      );

      return user;
    } on AppwriteException catch (e) {
      print('Register error: ${e.message}');
      return null;
    }
  }

  Future<models.Session?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return session;
    } on AppwriteException catch (e) {
      print('Login error: ${e.message}');
      return null;
    }
  }

  Future<void> logout() async {
    await _account.deleteSessions();
  }

  Future<models.User?> getCurrentUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }
}
