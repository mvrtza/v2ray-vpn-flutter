enum ConfigStatus { unknown, ok, failed }

class VpnConfig {
  final String id;
  final DateTime date;
  final String title;
  final bool selected;
  final String configString;
  final ConfigStatus connection;

  VpnConfig({
    required this.id,
    required this.date,
    required this.title,
    required this.selected,
    required this.configString,
    this.connection = ConfigStatus.unknown,
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
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'title': title,
    'selected': selected,
    'configString': configString,
    'connection': connection.toString().split('.').last,
  };
}
