import '../env/app_config.dart';

String posterUrl(String? path, {String size = 'w342'}) {
  if (path == null || path.isEmpty) return '';
  return '${AppConfig.imageBase}$size$path';
}