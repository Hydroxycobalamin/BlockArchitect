## <--[task]
## @name BlockArchitect_create_custom_block
## @input location:<LocationTag> item:ItemTag
## @description
## Creates a custom block at the location provided.
## @Usage
## Use to create a custom block at the players cursor.
## - run BlockArchitect_create_custom_block def.location:<player.cursor_on> def.item:custom_lasagna
## @Script BlockArchitect
## -->
BlockArchitect_create_custom_block:
    type: task
    debug: false
    definitions: location|item
    script:
    - if !<[item].proc[BA_item_is_valid]>:
        - stop
    - if !<[location].proc[BA_location_is_valid]>:
        - stop
    - define data <script[BlockArchitect_custom_block].data_key[mechanisms.display_entity_data]>
    - spawn BlockArchitect_custom_block[item=<[item].with[quantity=1]>;display_entity_data=<[data].include[brightness_sky=<[location].light.sky>;brightness_block=<[location].light.blocks>]>] <[location].center> save:custom
    - modifyblock <[location]> <[item].material>
    - flag <[location]> custom_block.entity:<entry[custom].spawned_entity>
    - flag <[location]> custom_block.flood_fill:<[location].flood_fill[1].types[block]>
    - flag <[location].world> custom_blocks:->:<[location]>
## <--[task]
## @name BlockArchitect_remove_custom_block
## @input location:<LocationTag>
## @description
## Creates a custom block at the location provided. Note: This does not remove the block itself.
## @Usage
## Use to remove custom block data above the players cursor.
## - run BlockArchitect_remove_custom_block def.location:<player.cursor_on.above>
## @Script BlockArchitect
## -->
BlockArchitect_remove_custom_block:
    type: task
    debug: false
    definitions: location
    script:
    - if !<[location].proc[ba_location_is_valid].context[true]>:
        - stop
    - remove <[location].flag[custom_block.entity]>
    - flag <[location]> custom_block:!
    - flag <[location].world> custom_blocks:<-:<[location]>