import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fit_track/app/api/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:path_provider/path_provider.dart';

class Api {
  static final _api = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  );

  // Initialize the Dio api with interceptors. Method should be called in main, before
  // [runApp] is invoked.
  static Future<void> init() async {
    // Log requests.
    _api.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );

    // Enable persistent cookie storage.
    final path = (await getApplicationDocumentsDirectory()).path;
    final cookieJar = PersistCookieJar(
      storage: FileStorage("$path/.cookies/"),
    );
    _api.interceptors.add(
      CookieManager(
        cookieJar,
      ),
    );
  }

  /// Get user for the saved session.
  static Future<User> getUser() async {
    // Session cookie is automatically attached from
    final response = await _api.get('/users/');
    final user = User.fromJson(response.data);

    return user;
  }

  static Future<void> createUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required int age,
    required int weight,
    required int height,
  }) async {
    await _api.post(
      '/users/',
      data: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'age': age,
        'weight': weight,
        'height': height,
      },
    );
  }

  /// Create session for user with provided [email] and [password].
  static Future<void> createSession(String email, String password) async {
    // Successful responses will return session cookie, which is automatically parsed by
    // dio, and it is used for future requests as well.
    await _api.post(
      '/sessions/',
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  /// Delete session for user.
  static Future<void> deleteSession() async {
    await _api.delete(
      '/sessions/',
    );
  }

  static String createAvatarUrl(int id) {
    return "${dotenv.env['BASE_URL']!}/avatars/$id";
  }

  static Future<void> updateStats(int statIndex, int duration) async {
    await _api.patch(
      '/stats/$statIndex',
      data: {
        'duration': duration,
      },
    );
  }

  static Future<List<dynamic>> getLeaderboard() async {
    final users = await _api.get(
      '/users/leaderboard',
    );

    return users.data;
  }
}
