BA_is_directional:
    type: procedure
    debug: false
    definitions: material
    script:
    - if <[material].supports[direction]>:
        - determine true
    - determine false
BA_get_direction:
    type: procedure
    debug: false
    definitions: material
    script:
    - choose <[material].direction>:
        - case SOUTH:
            - determine 0
        - case WEST:
            - determine 90
        - case NORTH:
            - determine 180
        - case EAST:
            - determine 270
        - default:
            - debug error "<&[error]>Something went really wrong. Direction was: '<[material].direction.custom_color[emphasis]>'!"
BA_place_directional:
    type: task
    debug: false
    definitions: item|location|spawn_location
    script:
    - definemap properties:
        item: <[item].with[quantity=1]>
        brightness:
            sky: <[location].above.light.sky>
            block: <[location].above.light.blocks>
    - narrate <[location].material>
    - spawn BlockArchitect_custom_block[item=<[item].with[quantity=1]>;brightness=[sky=<[location].light.sky>;block=<[location].light.blocks>] <[spawn_location].with_yaw[<[location].material.proc[BA_get_direction]>]> save:custom
    - flag <[location]> custom_block.entity:<entry[custom].spawned_entity>
    - flag <[location]> custom_block.flood_fill:<[location].flood_fill[1].types[block]>
    - flag <[location].world> custom_blocks:->:<[location]>
    - flag <entry[custom].spawned_entity> custom_block.location:<[location]>
    - stop
# todo: handler for furnaces