BlockArchitect_event_handler:
    type: world
    debug: false
    events:
        ## <--[event]
        ## @Events
        ## blockarchitect_block_switched
        ##
        ## @Group BlockArchitect
        ##
        ## @Location true
        ##
        ## @Warning This event may fire very rapidly
        ##
        ## @Switch blockarchitect_id:<id> to only process the event if the block is a specific BlockArchitect block.
        ##
        ## @Triggers when a BlockArchitect block switches.
        ##
        ## @Context
        ## <context.location> returns a LocationTag of the block the physics is affecting.
        ## <context.switched> returns whether the block was switched or not.
        ## <context.blockarchitect_id> returns the BlockArchitectID of the block that was switched.
        ##
        ## @Example
        ## # Use to fire the event only if a custom_speaker was placed.
        ## after custom event id:blockarchitect_block_switched data:blockarchitect_id:custom_speaker:
        ## - announce "A <context.blockarchitect_id> was triggered!"
        ##
        ## @Script BlockArchitect
        ##
        ## -->
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
        - wait 1t
        - run BlockArchitect_reapply_light_range def.location:<context.location> def.range:10
BlockArchitect_custom_event_handler:
    type: task
    debug: false
    script:
    - customevent id:<[name]> context:<[context]> save:event
    - if <entry[event].was_cancelled>:
        - determine cancelled