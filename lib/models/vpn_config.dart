enum ConfigStatus { unknown, ok, failed }

class VpnConfig {
  final String id;
  final DateTime date;
  final String title;
  final bool selected;
  final String configString;
  final ConfigStatus connection;

  final String? city;
  final String? region;
  final double? lat;
  final double? lon;

  VpnConfig({
    required this.id,
    required this.date,
    required this.title,
    required this.selected,
    required this.configString,
    this.connection = ConfigStatus.unknown,
    this.city,
    this.region,
    this.lat,
    this.lon,
  });

  factory VpnConfig.fromJson(Map<String, dynamic> json) => VpnConfig(
    id: json['id'],
    date: DateTime.parse(json['date']),
    title: json['title'],
    selected: json['selected'] ?? false,
    configString: json['configString'],
    connection: ConfigStatus.values.firstWhere(
          (e) => e.toString() == 'ConfigStatus.${json['connection']}',
      orElse: () => ConfigStatus.unknown,
    ),
    city: json['city'],
    region: json['region'],
    lat: (json['lat'] != null) ? (json['lat'] as num).toDouble() : null,
    lon: (json['lon'] != null) ? (json['lon'] as num).toDouble() : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'title': title,
    'selected': selected,
    'configString': configString,
    'connection': connection.toString().split('.').last,
    'city': city,
    'region': region,
    'lat': lat,
    'lon': lon,
  };
}