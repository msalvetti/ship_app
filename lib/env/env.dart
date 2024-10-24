/// Helper class to access the environment variables defined with --dart-define

class Env {
  static String get sentryDsn => const String.fromEnvironment('SENTRY_DSN');

}