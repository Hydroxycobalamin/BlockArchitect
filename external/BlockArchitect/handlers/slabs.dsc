BA_is_slab:
    type: procedure
    debug: false
    definitions: material
    script:
    - if <[material].name.ends_with[_slab]>:
        - determine true
    - determine false
BA_place_slab:
    type: task
    debug: false
    definitions: item|location|spawn_location
    script:
    - define type <[location].material.type>
    - if <[type]> == TOP || <[type]> == DOUBLE:
        - define spawn_location <[location].center.add[0,0.5,0]>
    - if <[type]> == DOUBLE:
        - if <[location].has_flag[custom_block.entity]>:
            - remove <[location].flag[custom_block.entity]>
        - else:
            - determine cancelled
    - definemap properties:
        item: <[item].with[quantity=1]>
        brightness:
            sky: <[location].above.light.sky>
            block: <[location].above.light.blocks>
    - if <[type]> == DOUBLE:
        - define properties.scale 1.001,2.001,1.001
    - spawn <entity[BlockArchitect_custom_block].with_map[<[properties]>]> <[spawn_location]> save:custom
    - modifyblock <[location]> <[item].material.with[type=<[type]>]>
    - flag <[location]> custom_block.entity:<entry[custom].spawned_entity>
    - flag <[location]> custom_block.flood_fill:<[location].flood_fill[1].types[block]>
    - flag <[location].world> custom_blocks:->:<[location]>
    - flag <entry[custom].spawned_entity> custom_block.location:<[location]>
    - wait 1t
    - teleport <entry[custom].spawned_entity> <entry[custom].spawned_entity.location.with_yaw[270]>
    - stop