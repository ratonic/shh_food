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
      ..setSelfSigned(status: true); // Considera remover setSelfSigned(status: true) para producción

    _account = Account(_client);
    _database = Databases(_client);
  }

  Future<models.User?> registerUser({
    required String email,
    required String password,
    required String name,
    required String role,
    required String phone, // cliente o restaurante
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
          'phone': phone, // Asegúrate de guardar el teléfono si es necesario
        },
      );

      return user;
    } on AppwriteException catch (e) {
      print('Register error: ${e.message}');
      // Puedes añadir lógica aquí para manejar errores específicos, por ejemplo, si el usuario ya existe
      return null;
    }
  }

  Future<models.Session?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // *** CORRECCIÓN AQUÍ: Cambiado de createEmailSession a createEmailPasswordSession ***
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } on AppwriteException catch (e) {
      print('Login error: ${e.message}');
      // Puedes añadir lógica aquí para manejar errores de inicio de sesión (ej: credenciales inválidas)
      return null;
    }
  }

  Future<void> logout() async {
    try {
      // En Appwrite SDK v15+, deleteSession(sessionId: 'current') es más común para cerrar la sesión actual
      await _account.deleteSession(sessionId: 'current');
      // Si deleteSessions() funciona para cerrar todas las sesiones, también puedes dejarlo
      // await _account.deleteSessions();
    } on AppwriteException catch (e) {
       print('Logout error: ${e.message}');
       // Manejar errores de cierre de sesión si es necesario
    }
  }

  Future<models.User?> getCurrentUser() async {
    try {
      return await _account.get();
    } on AppwriteException catch (e) {
       // Si no hay usuario logueado, AppwriteException será lanzada.
       // Aquí simplemente retornamos null en caso de cualquier error.
       print('Get current user error: ${e.message}');
       return null;
    } catch (e) {
       // Otros posibles errores
       print('Unexpected error getting current user: $e');
       return null;
    }
  }
}