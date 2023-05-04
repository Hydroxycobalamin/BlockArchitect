BlockArchitect_create_custom_block:
    type: task
    debug: false
    definitions: location|item
    script:
    - if !<[item].proc[BA_item_is_valid]>:
        - stop
    - define data <script[BlockArchitect_custom_block].data_key[mechanisms.display_entity_data]>
    - spawn BlockArchitect_custom_block[item=<[item].with[quantity=1]>;display_entity_data=<[data].include[brightness_sky=<[location].light.sky>;brightness_block=<[location].light.blocks>]>] <[location].center> save:custom
    - flag <[location]> custom_block.entity:<entry[custom].spawned_entity>
    - flag <[location]> custom_block.flood_fill:<[location].flood_fill[1].types[block]>
    - flag <[location].world> custom_blocks:->:<[location]>
BlockArchitect_remove_custom_block:
    type: task
    debug: false
    definitions: location
    script:
    - remove <[location].flag[custom_block.entity]>
    - flag <[location]> custom_block:!
    - flag <[location].world> custom_blocks:<-:<[location]>