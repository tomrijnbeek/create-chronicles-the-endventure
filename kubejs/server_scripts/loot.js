LootJS.modifiers((event) => {
  //event.addTableModifier("minecraft:chests/simple_dungeon").addLoot("minecraft:netherite_sword");
  //event.addTableModifier(/dungeons_arise:chests.*/).addLoot("minecraft:netherite_sword");


  //event.addTableModifier(/.*/).removeLoot("bosses_of_mass_destruction:blazing_eye");

  event
  .addTableModifier("bosses_of_mass_destruction:chests/gauntlet")
  .addLoot(LootEntry.of(`kubejs:cursed_eye_fragment_core`).setCount(1).randomChance(1.0))
  .addLoot(LootEntry.of(`simplyswords:frostfall`).setCount(1).randomChance(0.2))
  .addLoot(LootEntry.of(`simplyswords:watcher_claymore`).setCount(1).randomChance(0.2))
  .addLoot(LootEntry.of(`kubejs:boss_token`).setCount(1).randomChance(1.0));

  // Add Create Stuff to villages
  event
    .addTableModifier(/(revampedvillages:.*)/)
    .addLoot(LootEntry.of("create:belt_connector").setCount([1, 3]).randomChance(0.35))
    .addLoot(LootEntry.of("create:shaft").setCount([1, 4]).randomChance(0.35))
    .addLoot(LootEntry.of("create:zinc_ingot").setCount([1, 5]).randomChance(0.20))
    .addLoot(LootEntry.of("create:andesite_alloy").setCount([2, 10]).randomChance(0.40))
    .addLoot(LootEntry.of("create:gearbox").setCount([1, 3]).randomChance(0.20));
});
