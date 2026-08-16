
---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "de",
        kb_variant = "nodeadkeys", -- is mine. set it to yours however you like
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})
-- need this for switching workspace. 
-- will add some for 3 fingers vertical = toggle full screen
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})