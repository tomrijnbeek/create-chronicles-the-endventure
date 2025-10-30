ServerEvents.recipes(event => {

  event.replaceInput({}, 'farmersdelight:wheat_dough', 'create:dough')

  //conf
  event.replaceInput({id:'another_furniture:cherry_table'}, 'minecraft:cherry_planks', 'minecraft:cherry_slab')
  event.replaceInput({id:'another_furniture:warped_table'}, 'minecraft:warped_planks', 'minecraft:warped_slab')
  event.replaceInput({id:'another_furniture:spruce_table'}, 'minecraft:spruce_planks', 'minecraft:spruce_slab')
  event.replaceInput({id:'another_furniture:acacia_table'}, 'minecraft:acacia_planks', 'minecraft:acacia_slab')
  event.replaceInput({id:'another_furniture:bamboo_table'}, 'minecraft:bamboo_planks', 'minecraft:bamboo_slab')
  event.replaceInput({id:'another_furniture:jungle_table'}, 'minecraft:jungle_planks', 'minecraft:jungle_slab')
  event.replaceInput({id:'another_furniture:mangrove_table'}, 'minecraft:mangrove_planks', 'minecraft:mangrove_slab')
  event.replaceInput({id:'another_furniture:dark_oak_table'}, 'minecraft:dark_oak_planks', 'minecraft:dark_oak_slab')
  event.replaceInput({id:'another_furniture:crimson_table'}, 'minecraft:crimson_planks', 'minecraft:crimson_slab')
  event.replaceInput({id:'another_furniture:birch_table'}, 'minecraft:birch_planks', 'minecraft:birch_slab')
  event.replaceInput({id:'another_furniture:oak_table'}, 'minecraft:oak_planks', 'minecraft:oak_slab')
  event.replaceInput({id:'handcrafted:wood_plate'}, '#minecraft:wooden_slabs', '#minecraft:wooden_pressure_plates')

  event.smoking('minecraft:andesite', 'minecraft:gravel').cookingTime(6000)
  event.smoking('minecraft:leather', 'minecraft:rotten_flesh').cookingTime(900)

  event.custom({
    "type": "create_enchantment_industry:grinding",
    "ingredients": [
      {
        "item": "minecraft:redstone"
      }
    ],
    "results": [
      {
        "amount": 120,
        "id": "kubejs:fluid_redstone"
      }
    ]
  })

  // Simply Swords book
  event.custom({
    "type": "minecraft:crafting_shapeless",
    "ingredients": [
      {
        "item": "minecraft:book"
      },
      {
        "item": "simplyswords:runic_tablet"
      }
    ],
    "result": {
      "id": "patchouli:guide_book",
      "components": {
        "patchouli:book": "simplyswords:runic_grimoire"
      },
      "count": 1
    }
  });

  // Recipe conflicts
  event.shaped('create_sa:vault_component', [
      ' B ',
      ' A ',
      '   '
  ], {
      B: '#create:toolboxes',
      A: 'create:item_vault',
  })

  event.shaped('create_sa:small_filling_tank', [
      ' B ',
      ' A ',
      '   '
  ], {
      B: 'create_sa:hydraulic_engine',
      A: 'create:fluid_tank',
  })

  event.shaped('multibeds:feather_pile', [
      'SS ',
      'SS ',
      'SS '
  ], {
      S: 'minecraft:feather',
  })
  event.shapeless('6x minecraft:feather', 'multibeds:feather_pile');

  event.shaped('simplyswords:iron_spear', [
      ' CB',
      ' AC',
      'A  '
  ], {
      A: 'minecraft:stick',
      B: 'minecraft:iron_ingot',
      C: 'minecraft:iron_nugget',
  })

  event.shaped('simplyswords:gold_spear', [
      ' CB',
      ' AC',
      'A  '
  ], {
      A: 'minecraft:stick',
      B: 'minecraft:gold_ingot',
      C: 'minecraft:gold_nugget',
  })

  event.shaped('simplyswords:diamond_spear', [
      ' CB',
      ' AC',
      'A  '
  ], {
      A: 'minecraft:stick',
      B: 'minecraft:diamond',
      C: 'createaddition:diamond_grit',
  })

  event.shaped('handcrafted:terracotta_thin_pot', [
      ' A ',
      ' A ',
      ' A '
  ], {
      A: 'minecraft:terracotta',
  })
});
