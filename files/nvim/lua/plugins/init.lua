-- load LSP, treesister and blink cmp
require("plugins.stage_1")
-- Load Basic plugin such as mason, comform(formatter) and statusline
require("plugins.stage_2")
-- Load appearance such as Colorizer, Icons/Themes and Git things
-- *OR* plugin that depend on filetype *OR* per projects
require("plugins.stage_3")
