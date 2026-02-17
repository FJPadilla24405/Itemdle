// models/item_stats.dart

class ItemStats {
  final double health;
  final double mana;
  final double healthRegen;
  final double armor;
  final double attackDmg;
  final double abilityPwr;
  final double movementSpeed;
  final double percentMovementSpeed;
  final double attackSpeed;
  final double critChance;
  final double magicResistance;
  final double lifeSteal;

  ItemStats({
    this.health = 0,
    this.mana = 0,
    this.healthRegen = 0,
    this.armor = 0,
    this.attackDmg = 0,
    this.abilityPwr = 0,
    this.movementSpeed = 0,
    this.percentMovementSpeed = 0,
    this.attackSpeed = 0,
    this.critChance = 0,
    this.magicResistance = 0,
    this.lifeSteal = 0,
  });

  factory ItemStats.fromJson(Map<String, dynamic> json) {
    return ItemStats(
      health: (json['FlatHPPoolMod'] ?? 0).toDouble(),
      mana: (json['FlatMPPoolMod'] ?? 0).toDouble(),
      healthRegen: (json['FlatHPRegenMod'] ?? 0).toDouble(),
      armor: (json['FlatArmorMod'] ?? 0).toDouble(),
      attackDmg: (json['FlatPhysicalDamageMod'] ?? 0).toDouble(),
      abilityPwr: (json['FlatMagicDamageMod'] ?? 0).toDouble(),
      movementSpeed: (json['FlatMovementSpeedMod'] ?? 0).toDouble(),
      percentMovementSpeed: ((json['PercentMovementSpeedMod'] ?? 0).toDouble()),
      attackSpeed: ((json['PercentAttackSpeedMod'] ?? 0).toDouble()),
      critChance: ((json['FlatCritChanceMod'] ?? 0).toDouble()),
      magicResistance: (json['FlatSpellBlockMod'] ?? 0).toDouble(),
      lifeSteal: ((json['PercentLifeStealMod'] ?? 0).toDouble()),
    );
  }

  // Método para obtener solo las stats que no son 0
  Map<String, double> getNonZeroStats() {
    Map<String, double> nonZero = {};

    if (health != 0) nonZero['HP'] = health;
    if (mana != 0) nonZero['Mana'] = mana;
    if (healthRegen != 0) nonZero['HP Regen'] = healthRegen;
    if (armor != 0) nonZero['Armor'] = armor;
    if (attackDmg != 0) nonZero['Attack Damage'] = attackDmg;
    if (abilityPwr != 0) nonZero['Ability Power'] = abilityPwr;
    if (movementSpeed != 0) nonZero['Movement Speed'] = movementSpeed;
    if (percentMovementSpeed != 0) nonZero['Movement Speed (%)'] = percentMovementSpeed * 100;
    if (attackSpeed != 0) nonZero['Attack Speed (%)'] = attackSpeed * 100;
    if (critChance != 0) nonZero['Critical Strike Chance (%)'] = critChance * 100;
    if (magicResistance != 0) nonZero['Magic Resistance'] = magicResistance;
    if (lifeSteal != 0) nonZero['Life Steal (%)'] = lifeSteal * 100;

    return nonZero;
  }

  // Verificar si tiene alguna stat
  bool hasAnyStats() {
    return getNonZeroStats().isNotEmpty;
  }
}
