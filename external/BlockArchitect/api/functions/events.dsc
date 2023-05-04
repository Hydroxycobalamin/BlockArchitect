BlockArchitect_event_handler:
    type: world
    debug: false
    events:
        after block physics location_flagged:custom_block:
        - ratelimit <context.location>/<context.location.switched> 1t
        - if !<context.location.material.supports[switched]>:
            - stop
        - define name blockarchitect_block_switched
        - definemap context:
            location: <context.location>
            switched: <context.location.switched>
            blockarchitect_id: <context.location.flag[custom_block.entity].item.script.name>
        - inject blockarchitect_custom_event_handler
BlockArchitect_custom_event_handler:
    type: task
    debug: false
    script:
    - customevent id:<[name]> context:<[context]> save:event
    - if <entry[event].was_cancelled>:
        - determine cancelled