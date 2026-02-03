// models/item_stats.dart

class ItemStats {
  final double flatHPPoolMod;
  final double flatMPPoolMod;
  final double percentHPPoolMod;
  final double percentMPPoolMod;
  final double flatHPRegenMod;
  final double percentHPRegenMod;
  final double flatMPRegenMod;
  final double percentMPRegenMod;
  final double flatArmorMod;
  final double percentArmorMod;
  final double flatPhysicalDamageMod;
  final double percentPhysicalDamageMod;
  final double flatMagicDamageMod;
  final double percentMagicDamageMod;
  final double flatMovementSpeedMod;
  final double percentMovementSpeedMod;
  final double flatAttackSpeedMod;
  final double percentAttackSpeedMod;
  final double percentDodgeMod;
  final double flatCritChanceMod;
  final double percentCritChanceMod;
  final double flatCritDamageMod;
  final double percentCritDamageMod;
  final double flatBlockMod;
  final double percentBlockMod;
  final double flatSpellBlockMod;
  final double percentSpellBlockMod;
  final double flatEXPBonus;
  final double percentEXPBonus;
  final double flatEnergyRegenMod;
  final double flatEnergyPoolMod;
  final double percentLifeStealMod;
  final double percentSpellVampMod;

  ItemStats({
    this.flatHPPoolMod = 0,
    this.flatMPPoolMod = 0,
    this.percentHPPoolMod = 0,
    this.percentMPPoolMod = 0,
    this.flatHPRegenMod = 0,
    this.percentHPRegenMod = 0,
    this.flatMPRegenMod = 0,
    this.percentMPRegenMod = 0,
    this.flatArmorMod = 0,
    this.percentArmorMod = 0,
    this.flatPhysicalDamageMod = 0,
    this.percentPhysicalDamageMod = 0,
    this.flatMagicDamageMod = 0,
    this.percentMagicDamageMod = 0,
    this.flatMovementSpeedMod = 0,
    this.percentMovementSpeedMod = 0,
    this.flatAttackSpeedMod = 0,
    this.percentAttackSpeedMod = 0,
    this.percentDodgeMod = 0,
    this.flatCritChanceMod = 0,
    this.percentCritChanceMod = 0,
    this.flatCritDamageMod = 0,
    this.percentCritDamageMod = 0,
    this.flatBlockMod = 0,
    this.percentBlockMod = 0,
    this.flatSpellBlockMod = 0,
    this.percentSpellBlockMod = 0,
    this.flatEXPBonus = 0,
    this.percentEXPBonus = 0,
    this.flatEnergyRegenMod = 0,
    this.flatEnergyPoolMod = 0,
    this.percentLifeStealMod = 0,
    this.percentSpellVampMod = 0,
  });

  factory ItemStats.fromJson(Map<String, dynamic> json) {
    return ItemStats(
      flatHPPoolMod: (json['FlatHPPoolMod'] ?? 0).toDouble(),
      flatMPPoolMod: (json['FlatMPPoolMod'] ?? 0).toDouble(),
      percentHPPoolMod: (json['PercentHPPoolMod'] ?? 0).toDouble(),
      percentMPPoolMod: (json['PercentMPPoolMod'] ?? 0).toDouble(),
      flatHPRegenMod: (json['FlatHPRegenMod'] ?? 0).toDouble(),
      percentHPRegenMod: (json['PercentHPRegenMod'] ?? 0).toDouble(),
      flatMPRegenMod: (json['FlatMPRegenMod'] ?? 0).toDouble(),
      percentMPRegenMod: (json['PercentMPRegenMod'] ?? 0).toDouble(),
      flatArmorMod: (json['FlatArmorMod'] ?? 0).toDouble(),
      percentArmorMod: (json['PercentArmorMod'] ?? 0).toDouble(),
      flatPhysicalDamageMod: (json['FlatPhysicalDamageMod'] ?? 0).toDouble(),
      percentPhysicalDamageMod: (json['PercentPhysicalDamageMod'] ?? 0).toDouble(),
      flatMagicDamageMod: (json['FlatMagicDamageMod'] ?? 0).toDouble(),
      percentMagicDamageMod: (json['PercentMagicDamageMod'] ?? 0).toDouble(),
      flatMovementSpeedMod: (json['FlatMovementSpeedMod'] ?? 0).toDouble(),
      percentMovementSpeedMod: (json['PercentMovementSpeedMod'] ?? 0).toDouble(),
      flatAttackSpeedMod: (json['FlatAttackSpeedMod'] ?? 0).toDouble(),
      percentAttackSpeedMod: (json['PercentAttackSpeedMod'] ?? 0).toDouble(),
      percentDodgeMod: (json['PercentDodgeMod'] ?? 0).toDouble(),
      flatCritChanceMod: (json['FlatCritChanceMod'] ?? 0).toDouble(),
      percentCritChanceMod: (json['PercentCritChanceMod'] ?? 0).toDouble(),
      flatCritDamageMod: (json['FlatCritDamageMod'] ?? 0).toDouble(),
      percentCritDamageMod: (json['PercentCritDamageMod'] ?? 0).toDouble(),
      flatBlockMod: (json['FlatBlockMod'] ?? 0).toDouble(),
      percentBlockMod: (json['PercentBlockMod'] ?? 0).toDouble(),
      flatSpellBlockMod: (json['FlatSpellBlockMod'] ?? 0).toDouble(),
      percentSpellBlockMod: (json['PercentSpellBlockMod'] ?? 0).toDouble(),
      flatEXPBonus: (json['FlatEXPBonus'] ?? 0).toDouble(),
      percentEXPBonus: (json['PercentEXPBonus'] ?? 0).toDouble(),
      flatEnergyRegenMod: (json['FlatEnergyRegenMod'] ?? 0).toDouble(),
      flatEnergyPoolMod: (json['FlatEnergyPoolMod'] ?? 0).toDouble(),
      percentLifeStealMod: (json['PercentLifeStealMod'] ?? 0).toDouble(),
      percentSpellVampMod: (json['PercentSpellVampMod'] ?? 0).toDouble(),
    );
  }

  // Método para obtener solo las stats que no son 0 (útil para mostrar)
  Map<String, double> getNonZeroStats() {
    Map<String, double> nonZero = {};
    
    if (flatHPPoolMod != 0) nonZero['HP'] = flatHPPoolMod;
    if (flatMPPoolMod != 0) nonZero['Mana'] = flatMPPoolMod;
    if (flatArmorMod != 0) nonZero['Armor'] = flatArmorMod;
    if (flatPhysicalDamageMod != 0) nonZero['Attack Damage'] = flatPhysicalDamageMod;
    if (flatMagicDamageMod != 0) nonZero['Ability Power'] = flatMagicDamageMod;
    if (flatMovementSpeedMod != 0) nonZero['Movement Speed'] = flatMovementSpeedMod;
    if (percentAttackSpeedMod != 0) nonZero['Attack Speed'] = percentAttackSpeedMod;
    if (flatCritChanceMod != 0) nonZero['Critical Strike Chance'] = flatCritChanceMod;
    if (percentLifeStealMod != 0) nonZero['Life Steal'] = percentLifeStealMod;
    if (flatSpellBlockMod != 0) nonZero['Magic Resist'] = flatSpellBlockMod;
    if (percentHPRegenMod != 0) nonZero['HP Regen'] = percentHPRegenMod;
    if (percentMPRegenMod != 0) nonZero['Mana Regen'] = percentMPRegenMod;
    
    return nonZero;
  }
  
  // Verificar si tiene alguna stat
  bool hasAnyStats() {
    return getNonZeroStats().isNotEmpty;
  }
}
