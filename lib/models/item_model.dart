import 'item_stats.dart';

class ItemImage {
  final String full;
  final String sprite;
  final String group;
  final int x;
  final int y;
  final int w;
  final int h;

  ItemImage({
    required this.full,
    required this.sprite,
    required this.group,
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  factory ItemImage.fromJson(Map<String, dynamic> json) {
    return ItemImage(
      full: json['full'] ?? '',
      sprite: json['sprite'] ?? '',
      group: json['group'] ?? '',
      x: json['x'] ?? 0,
      y: json['y'] ?? 0,
      w: json['w'] ?? 0,
      h: json['h'] ?? 0,
    );
  }
}

class ItemGold {
  final int base;
  final bool purchasable;
  final int total;
  final int sell;

  ItemGold({
    required this.base,
    required this.purchasable,
    required this.total,
    required this.sell,
  });

  factory ItemGold.fromJson(Map<String, dynamic> json) {
    return ItemGold(
      base: json['base'] ?? 0,
      purchasable: json['purchasable'] ?? false,
      total: json['total'] ?? 0,
      sell: json['sell'] ?? 0,
    );
  }
}

class Item {
  final String id;
  final String name;
  final ItemImage image;
  final ItemGold gold;
  final List<String> tags;
  final ItemStats stats;
  final String depth;

  Item({
    required this.id,
    required this.name,
    required this.image,
    required this.gold,
    required this.tags,
    required this.stats,
    required this.depth
  });

  factory Item.fromJson(String id, Map<String, dynamic> json) {
    return Item(
      id: id,
      name: json['name'] ?? '',
      image: ItemImage.fromJson(json['image'] ?? {}),
      gold: ItemGold.fromJson(json['gold'] ?? {}),
      tags: List<String>.from(json['tags'] ?? []),
      stats: ItemStats.fromJson(json['stats'] ?? {}),
      depth: getTier(json),
    );
  }

  static String getTier(Map<String, dynamic> json) {
    int depth = json['depth'] ?? 0;
    String tier = '';

    if (depth <= 1) {
      tier = 'basic';
    } else if (depth == 2) {
      tier = 'epic';
    } else {
      tier = 'legendary';
    }

    return tier;
  }

  // Método helper para obtener la URL completa de la imagen
  String getImageUrl(String version) {
    return 'https://ddragon.leagueoflegends.com/cdn/$version/img/item/${image.full}';
  }
}
