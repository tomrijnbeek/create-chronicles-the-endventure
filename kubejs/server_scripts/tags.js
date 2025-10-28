ServerEvents.tags('block', event => {
    event.add("ftbchunks:interact_whitelist", [
        'minecraft:crafting_table',
        '#minecraft:doors',
        '#minecraft:beds',
        "minecraft:bell",
        "create:desk_bell",
        'create_things_and_misc:card_reader',
        'refurbished_furniture:post_box',
        'create:contraption_controls',
        '#create:table_cloths',
        '#waystones:waystones',
        '#waystones:sharestones',
        '#lootr:containers',
        'farmingforblockheads:market',
    ]);

    const vents= [
        'molten_vents:dormant_molten_asurine',
        'molten_vents:active_molten_asurine',
        'molten_vents:dormant_molten_veridium',
        'molten_vents:active_molten_veridium',
        'molten_vents:dormant_molten_crimsite',
        'molten_vents:active_molten_crimsite',
        'molten_vents:dormant_molten_ochrum',
        'molten_vents:active_molten_ochrum',
    ]
    event.add("buildinggadgets2:deny", vents);
    event.add("forge:relocation_not_supported", vents);
})

ServerEvents.tags('item', event => {
    event.add("ftbchunks:right_click_whitelist", [
        'create:shopping_list',
    ]);
})
