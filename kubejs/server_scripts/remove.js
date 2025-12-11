// === REMOVE BY RECIPE ID ===
const removeRecipesById = [
  'simplyswords:sword_on_a_stick',
  'constructionstick:template_unbreakable',
  'multibeds:feather_pile',

  'create_aquatic_ambitions:crushing/prismarine_bricks_to_lapis_and_copper',
  'create_aquatic_ambitions:crushing/prismarine_to_lapis',
  'create_aquatic_ambitions:smelting/veridium',
  'minecraft:andesite',
  'create:crushing/tuff_recycling',
  'create:crushing/tuff',

  'bosses_of_mass_destruction:void_lily',

  // Recipe conflits
  'multibeds:feather_pile_uncraft',
  'create_sa:small_filling_tank_recipe',
  'simplyswords:iron_spear',
  'simplyswords:gold_spear',
  'simplyswords:diamond_spear',
  'culturalrecipes:corn_dough',
  'farmersdelight:bread_from_smelting',
  'farmersdelight:bread_from_smoking',
  'minecraft:cake',
  'handcrafted:terracotta_thin_pot'
];

// === REMOVE BY MOD ID ===
const removeByMod = [
  // 'endrem',
  // 'armoroftheages'
];

// === REMOVE BY INPUT ===
const removeByInput = [
  // 'minecraft:cobblestone'
];

// === REMOVE BY OUTPUT ===
const removeByOutput = [
  // 'minecraft:stone_sword'
];

// === REMOVE BY TAG ===
const removeByTag = [
  // '#forge:ingots/iron',
  // '#minecraft:logs'
];

ServerEvents.recipes(event => {
  // Remove by ID
  removeRecipesById.forEach(id => event.remove({id: id}));
  global.REMOVE_ITEMS.forEach(id => event.remove({id: id}));

  // Remove by mod ID
  removeByMod.forEach(modid => event.remove({ mod: modid }));

  // Remove by input only
  //removeByInput.forEach(item => event.remove({ input: item }));

  // Remove by output only
  //removeByOutput.forEach(item => event.remove({ output: item }));

  // Remove by tag
  /*removeByTag.forEach(tag => {
    event.remove({ input: tag });
    event.remove({ output: tag });
  });*/
});
