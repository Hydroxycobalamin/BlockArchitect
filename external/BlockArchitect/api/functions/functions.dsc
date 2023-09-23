## <--[task]
## @name BlockArchitect_create_custom_block
## @input location:<LocationTag> item:ItemTag
## @description
## Creates a custom block at the location provided.
## @Usage
## # Use to create a custom block at the players cursor.
## - run BlockArchitect_create_custom_block def.location:<player.cursor_on> def.item:custom_lasagna
## @Script BlockArchitect
## -->
BlockArchitect_create_custom_block:
    type: task
    debug: false
    definitions: location|item
    script:
    - define item <player.item_in_hand>
    - if !<[item].proc[BA_item_is_valid]>:
        - stop
    - if !<[location].proc[BA_location_is_valid]>:
        - stop
    # Default
    - define spawn_location <[location].center>
    # Cake support
    - if <[item].material.proc[BA_is_cake]>:
        - define spawn_location <[location].center.with_yaw[270]>
    # Slab support
    - else if <[item].material.proc[BA_is_slab]>:
        - inject BA_place_slab
    - else if <[item].material.proc[BA_is_directional]>:
        - inject BA_place_directional
    - spawn BlockArchitect_custom_block[item=<[item].with[quantity=1]>;brightness=[sky=<[location].light.sky>;block=<[location].light.blocks>] <[spawn_location]> save:custom
    - modifyblock <[location]> <[item].material>
    - flag <[location]> custom_block.entity:<entry[custom].spawned_entity>
    - flag <[location]> custom_block.flood_fill:<[location].flood_fill[1].types[block]>
    - flag <[location].world> custom_blocks:->:<[location]>
    - wait 1t
    - teleport <entry[custom].spawned_entity> <entry[custom].spawned_entity.location.with_yaw[270]>
## <--[task]
## @name BlockArchitect_remove_custom_block
## @input location:<LocationTag>
## @description
## Creates a custom block at the location provided. Note: This does not remove the block itself.
## @Usage
## # Use to remove custom block data above the players cursor.
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
