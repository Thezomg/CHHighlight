bind(player_chat, null, null, @event,
    assign(@players, @event['recipients'])
    assign(@highlight, array())
    assign(@normal, array())
    assign(@split, reg_split('[^A-Za-z0-9_]', @event['message']))
    foreach(@split, @word,
        foreach(@players, @p,
            if(equals(strip_colors(@p), @word),
                array_push(@highlight, @word)
            )
        )
    )

    foreach(@players, @p,
        assign(@sp, strip_colors(@p))
        if(not(array_contains_ic(@highlight, @sp)),
            array_push(@normal, @p)
        ,
            tmsg(@p, concat('<', @event['player'], '> ', reg_replace(array(@sp, 'i'), concat(color(GREEN), @sp, color(WHITE)), @event['message'])))
        )
    )
    modify_event('recipients', @normal)
)

