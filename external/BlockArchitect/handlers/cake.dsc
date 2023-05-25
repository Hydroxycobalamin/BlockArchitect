## <--[information]
## @name Custom Cakes
## @group BlockArchitect
## @description
## As for now, cake models require the max-y value of 8.001 to prevent flickering on top.
## "elements": [
##     {   "from": [ 0, 0, 0 ],
##         "to": [ 16, 8.001, 16 ],
##         "faces": {
##             "down":  { "texture": "#bottom", "cullface": "down" },
##             "up":    { "texture": "#top" },
##             "north": { "texture": "#side" },
##             "south": { "texture": "#side" },
##             "west":  { "texture": "#side" },
##             "east":  { "texture": "#side" }
##         }
##     }
## ]
## -->
BlockArchitect_cake_handler:
    type: world
    debug: false
    events:
        after player right clicks cake location_flagged:custom_block:
        - define level <context.location.material.level.if_null[null]>
        - define entity <context.location.flag[custom_block.entity]>
        - define custom_model_data <[entity].item.custom_model_data.add[1]>
        - if <[level]> == null:
            - run BlockArchitect_remove_custom_block def.location:<context.location>
            - stop
        - adjust <[entity]> item:<[entity].item.with[custom_model_data=<[custom_model_data]>]>
        after generic game event type:BLOCK_DESTROY location_flagged:custom_block:
        - run BlockArchitect_remove_custom_block def.location:<context.location>