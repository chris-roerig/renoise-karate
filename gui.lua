--[[============================================================================
gui.lua
============================================================================]]--
-- GUI implementation for the tool

-- Placeholder function to demonstrate GUI creation
function show_gui()
  local vb = renoise.ViewBuilder()

  local CONTENT_MARGIN = renoise.ViewBuilder.DEFAULT_CONTROL_MARGIN

  local dialog_content = vb:column {
    margin = CONTENT_MARGIN,

    vb:text {
      text = "Example Text Label"
    },

    vb:button {
      text = "Example Button",
      notifier = function()
        print("Button clicked")
      end
    },

    vb:slider {
      min = 0,
      max = 100,
      value = 50,
      notifier = function(value)
        print("Slider value: " .. value)
      end
    },

    vb:textfield {
      text = "Example Text Field",
      notifier = function(text)
        print("Text Field input: " .. text)
      end
    }
  }

  renoise.app():show_custom_dialog("Karate", dialog_content)
end

-- Call the GUI function to display it
show_gui()
