-----------------------------------------------------------------
-- Visit https://docs.acscripts.dev/scoreboard for documentation
-----------------------------------------------------------------

return {
    settings = {
        title = {
            text = 'AC Scoreboard',
            logo = 'logo.svg',
        },

        side = 'right',

        showOverlay = false,

        closeOnEscape = true,

        closeOnOutsideClick = true,

        uppercaseNames = false,

        highlightEmptyGroups = true,

        compactPlayers = false,

        compactGroups = false,

        playerColumns = 1,

        groupColumns = 1,
    },

    visibleSections = {
        groups = true,
        groupCount = true,
        players = true,
        playerNames = true,
        playerIds = true,
        statusIndicators = true,
        footer = true,
    },

    -- Command name for opening the scoreboard
    commandName = 'scoreboard',

    -- Default keybind for the '/scoreboard' command
    commandKey = 'DELETE',

    -- Whether to include off-duty players in group count (if not defined in the group row itself)
    includeOffDuty = false,

    -- Group list shown in the scoreboard
    groups = {
        {
            label = 'Police',
            groups = {'police'},
            includeOffDuty = false,
            onDutyRequired = true,
            icon = 'ic:round-local-police',
        },
        {
            label = 'EMS',
            groups = {'ambulance'},
            includeOffDuty = false,
            onDutyRequired = true,
            icon = 'ic:round-local-hospital',
        },
        {
            label = 'Mechanics',
            groups = {'mechanic', 'mechanic2'},
            includeOffDuty = true,
            onDutyRequired = false,
            icon = 'mdi:wrench',
        },
        {
            label = 'Dealerships',
            groups = {'cardealer', 'cardealer2'},
            includeOffDuty = true,
            onDutyRequired = false,
            icon = 'mdi:car',
        },
    },

    -- Status indicators shown in the scoreboard
    statusIndicators = {
        -- {
        --     id = 'house_robbery',
        --     label = 'House robbery',
        --     icon = 'mdi:house',
        --     defaultState = true,
        -- },
        -- {
        --     id = 'store_robbery',
        --     label = 'Store robbery',
        --     icon = 'mdi:store',
        --     defaultState = false,
        -- },
        -- {
        --     id = 'bank_robbery',
        --     label = 'Bank robbery',
        --     icon = 'mdi:bank',
        --     groupTrigger = {
        --         groups = {'police', 'sheriff'},
        --         minimumCount = 12,
        --         includeOffDuty = true,
        --     },
        -- },
    },
}
