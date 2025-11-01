Platform.mods.kubejs.name = 'Create Chronicles: Orange-flavoured'

StartupEvents.modifyCreativeTab('kubejs:tab', event => {
  event.displayName = 'Create Chronicles: Orange-flavoured';
});

//Stack Sizes
ItemEvents.modification(event => {
    event.modify('minecraft:ender_pearl', item => {
      item.maxStackSize = 64
    })
    event.modify('minecraft:egg', item => {
        item.maxStackSize = 64
    })
    event.modify('deeperdarker:heart_of_the_deep', item => {
        item.maxStackSize = 64
    })
})


function applyModifiers(event, itemId, slot, attributes) {
  const modifiers = attributes.reduce((mod, attr) => {
    return mod.withModifierAdded(attr.attribute, {
      amount: attr.amount,
      id: attr.id,
      operation: attr.operation,
    }, slot);
  }, Item.of(itemId).attributeModifiers);

  event.modify(itemId, item => {
    item.setAttributeModifiersWithTooltip(modifiers.modifiers());
  });
}

StartupEvents.registry('item', event => {
  //Farmer's Stuff
  event.create('incomplete_barbecue_stick')
  event.create('incomplete_cod_roll')
  event.create('incomplete_kelp_roll')
  event.create('incomplete_melon_popsicle')
  event.create('incomplete_mutton_wrap')
  event.create('incomplete_salmon_roll')
  event.create('incomplete_stuffed_potato')
  event.create('incomplete_bacon_and_eggs')
  event.create('incomplete_grilled_salmon')
  event.create('incomplete_rice_roll_medley_block')
  event.create('incomplete_roast_chicken_block')
  event.create('incomplete_roasted_mutton_chops')
  event.create('incomplete_shepherds_pie_block')
  event.create('incomplete_steak_and_potatoes')
})

StartupEvents.registry("block", (event) => {
  event.create('incomplete_blackstone')
})
