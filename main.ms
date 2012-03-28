bind(player_chat, null, null, @event,
    assign(@players, @event['recipients'])
    assign(@highlight, array())
    assign(@normal, array())
    assign(@split, reg_split('[^A-Za-z0-9_]', @event['message']))
    foreach(@split, @word,
        if(array_contains_ic(@players, @word),
            if(not(array_contains_ic(@highlight, @word)),
                array_push(@highlight, @word)
            )
        )
    )

    foreach(@players, @p,
        if(not(array_contains_ic(@highlight, @p)),
            array_push(@normal, @p)
        ,
            tmsg(@p, concat('<', @event['player'], '> ', reg_replace(array(@p, 'i'), concat(color(GREEN), @p, color(WHITE)), @event['message'])))
        )
    )
    modify_event('recipients', @normal)
)

