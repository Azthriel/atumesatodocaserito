import 'package:cloud_firestore/cloud_firestore.dart';

class MenuPriceItem {
  final String label;
  final String price;
  const MenuPriceItem({required this.label, required this.price});

  factory MenuPriceItem.fromMap(Map<String, dynamic> m) =>
      MenuPriceItem(label: m['label'] ?? '', price: m['price'] ?? '');
}

class MenuItemModel {
  final String name;
  final String subtitle;
  final int order;
  final List<MenuPriceItem> prices;
  const MenuItemModel({
    required this.name,
    required this.subtitle,
    required this.order,
    required this.prices,
  });

  factory MenuItemModel.fromMap(Map<String, dynamic> m) => MenuItemModel(
    name: m['name'] ?? '',
    subtitle: m['subtitle'] ?? '',
    order: m['order'] ?? 0,
    prices: (m['prices'] as List<dynamic>? ?? [])
        .map((p) => MenuPriceItem.fromMap(Map<String, dynamic>.from(p)))
        .toList(),
  );
}

class MenuService {
  static final _db = FirebaseFirestore.instance;

  static Future<List<MenuItemModel>> fetchMenu() async {
    final doc = await _db.collection('config').doc('menu').get();
    if (!doc.exists) return [];
    final raw = doc.data()?['items'] as List<dynamic>? ?? [];
    final items =
        raw
            .map((e) => MenuItemModel.fromMap(Map<String, dynamic>.from(e)))
            .toList()
          ..sort((a, b) => a.order.compareTo(b.order));
    return items;
  }
}
