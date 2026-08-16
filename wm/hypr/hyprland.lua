-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})


-------------------
---- AUTOSTART ----
-------------------

require("hyprconfigs/startup")

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

require("hyprconfigs/permissions")

--------------------------
---   looks and feel   ---
--------------------------
require("hyprconfigs/looks")
-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
require("hyperconfigs/animations")

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 1,    -- we do not want that attrocity
        disable_hyprland_logo   = true, -- logo wouldnt be a problem but anime? Nöööö. :(
    },
})


---------------
---- INPUT ----
---------------

require("hyprconfigs/input")


---------------------
---- KEYBINDINGS ----
---------------------
require("hyprconfigs/input")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("hyprconfigs/spaces")