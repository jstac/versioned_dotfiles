-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'nord'

config.window_background_image = '/home/john/rsync_dir/misc/wallpapers/terminator.png'
-- config.window_background_image = '/home/john/rsync_dir/misc/wallpapers/riding_motorcycle-t2.jpg'

config.window_background_image_hsb = {
  -- Darken the background image 
  brightness = 0.02,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can adjust the saturation also.
  saturation = 1.0,
}

config.text_background_opacity = 0.7




-- and finally, return the configuration to wezterm
return config

