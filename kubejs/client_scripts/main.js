// Hide Recipes
RecipeViewerEvents.removeEntriesCompletely('item', item =>{
  global.REMOVE_ITEMS.forEach(id => {
    item.remove(id)
  })

  const itemsToRemove = [
    'incomplete_barbecue_stick',
    'incomplete_cod_roll',
    'incomplete_kelp_roll',
    'incomplete_melon_popsicle',
    'incomplete_mutton_wrap',
    'incomplete_salmon_roll',
    'incomplete_stuffed_potato',
    'incomplete_bacon_and_eggs',
    'incomplete_grilled_salmon',
    'incomplete_rice_roll_medley_block',
    'incomplete_roast_chicken_block',
    'incomplete_roasted_mutton_chops',
    'incomplete_shepherds_pie_block',
    'incomplete_steak_and_potatoes',
    'incomplete_blackstone'
  ]

  itemsToRemove.forEach(id => {
    item.remove(`kubejs:${id}`)
  })
})

// Hide Categories
RecipeViewerEvents.removeCategories(event => {
  event.remove('ftbquests:loot_crate')
  event.remove('ftbquests:quest')
  event.remove('simplelootviewer:archaeology')
  event.remove('simplelootviewer:block')
  event.remove('simplelootviewer:dispenser')
  event.remove('simplelootviewer:fishing')
  event.remove('simplelootviewer:hero')
  event.remove('simplelootviewer:loot_chest')
  event.remove('simplelootviewer:misc')
})

RecipeViewerEvents.addInformation('item', item =>{

  //other
  item.add("simplyswords:soulstealer", "Drops from Death King")
  item.add("simplyswords:wraithfang", "Drops from Death King")

  item.add("simplyswords:brimstone_claymore", "Drops from Netherite Monstrosity")
  item.add("simplyswords:molten_edge", "Drops from Netherite Monstrosity")

  item.add("simplyswords:frostfall", "Drops from The Gauntlet")
  item.add("simplyswords:watcher_claymore", "Drops from The Gauntlet")

  item.add("simplyswords:emberlash", "Drops from Lunar Monstrosity")
  item.add("simplyswords:toxic_longsword", "Drops from Lunar Monstrosity")

  item.add("simplyswords:stormbringer", "Drops from Starlight Golem")
  item.add("simplyswords:mjolnir", "Drops from Lunar Starlight Golem")

  item.add("simplyswords:slumbering_lichblade", "Drops from The Lich")
  item.add("simplyswords:soulrender", "Drops from The Lich")

  item.add("simplyswords:emberblade", "Drops from The Harbinger")
  item.add("simplyswords:ribboncleaver", "Drops from The Harbinger")

  item.add("simplyswords:bramblethorn", "Drops from Void Blossom")
  item.add("simplyswords:twisted_blade", "Drops from Void Blossom")

  item.add("simplyswords:flamewind", "Drops from Obsidilith")
  item.add("simplyswords:watching_warglaive", "Drops from Obsidilith")

  item.add("simplyswords:tempest", "Drops from Echo of Tyros, First Flamebearer")
  item.add("simplyswords:soulpyre", "Drops from Echo of Tyros, First Flamebearer")

  item.add("simplyswords:whisperwind", "Drops from Ancient Remnant")
  item.add("simplyswords:waxweaver", "Drops from Ancient Remnant")

  item.add("simplyswords:hiveheart", "Drops from The Leviathan")
  item.add("simplyswords:caelestis", "Drops from The Leviathan")

  item.add("simplyswords:dormant_relic", "Drops from Scylla")
  item.add("simplyswords:thunderbrand", "Drops from Scylla ")

  item.add("simplyswords:enigma", "Drops from Ignis")
  item.add("simplyswords:wickpiercer", "Drops from Ignis")

  item.add("simplyswords:storms_edge", "Drops from Maledictus")
  item.add("simplyswords:stars_edge", "Drops from Maledictus")

  item.add("simplyswords:hearthflame", "Drops from Ender Dragon")
  item.add("simplyswords:soulkeeper", "Drops from Ender Dragon")
  item.add("simplyswords:icewhisper", "Drops from Ender Dragon")
  item.add("simplyswords:arcanethyst", "Drops from Ender Dragon")
  item.add("simplyswords:shadowsting", "Drops from Ender Dragon")
  item.add("simplyswords:livyatan", "Drops from Ender Dragon")

  item.add("garnished:vermilion_kelp", "Vermilion kelp be found in the Cold Ocean or Frozen Ocean")
  item.add("garnished:bok_choy", "Bok Choy can be found in Jungle Temples")

  // remove salt when fix recipe
  item.add('garnished:crushed_salt',"You need to use Mechanical Grindstone using Limestone")

  item.add('biomeswevegone:yucca_fruit',"Yuca grows on trees and can be found in biomes, such as Badlands variants, or Desert variants.")
  item.add('eternal_starlight:lunaris_cactus_fruit',"Grows on top of Lunaris Cactus. Can be found in the Crystallized Desert biome, and also grows on Twilight Sand in the Eternal Starlight dimension.")
  item.add('eternal_starlight:ether_bucket',"Found in Eternal Starlight dimension.")
  item.add('minecraft:brown_mushroom',"Grow using Warped or Crimson Nylium (farmable)")
})

const discs =[
  'gamediscs:game_disc_rabbit',
  'gamediscs:game_disc_flappy_bird',
  'gamediscs:game_disc_slime',
  'gamediscs:game_disc_blocktris',
  'gamediscs:game_disc_pong',
  'gamediscs:game_disc_froggie',
  'gamediscs:game_disc_tnt_sweeper',
]


// Tooltips with order
ItemEvents.modifyTooltips(event => {
  discs.forEach((disc) => {
    event.modify(disc, tooltip => {
      tooltip.insert(1, Text.of('§7You need a gaming console to play the game.'))
    })
  })
});
