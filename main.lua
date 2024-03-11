--[[============================================================================
main.lua
============================================================================]]--
-- Main functionality of the tool

-- require("gui")

-- Function to show the GUI
function show_my_tool_gui()
  -- show_gui() -- This function is defined in gui.lua
end

-- Add menu entry
renoise.tool():add_menu_entry {
  name = "Main Menu:Tools:Karate",
  invoke = show_my_tool_gui
}

print("Hello from Karate!")

renoise.tool():add_menu_entry{
    name = "Sample Editor:Chop:4",
    invoke = function() slice_in_parts(4) end
}

renoise.tool():add_menu_entry{
    name = "Sample Editor:Chop:8",
    invoke = function() slice_in_parts(8) end
}

renoise.tool():add_menu_entry{
    name = "Sample Editor:Chop:12",
    invoke = function() slice_in_parts(12) end
}

renoise.tool():add_menu_entry{
    name = "Sample Editor:Chop:16",
    invoke = function() slice_in_parts(16) end
}

function slice_in_parts(num_slices)
    local song = renoise.song()
    local instrument = song.selected_instrument
    local sample = instrument.samples[1]  -- Targeting the first sample

    if not sample or not sample.sample_buffer.has_sample_data then
        renoise.app():show_status("No sample data found in the first slot.")
        return
    end

    -- Clear existing slice markers
    sample.slice_markers = {}

    local buffer = sample.sample_buffer
    local num_frames = buffer.number_of_frames

    -- Insert new slice markers at equidistant points
    sample:insert_slice_marker(1)
    for i = 1, num_slices - 1 do
        local slice_point = math.floor((num_frames / num_slices) * i)
        sample:insert_slice_marker(slice_point)
    end

    -- Assuming slices are subsequent samples, set their properties
    for i, slice_sample in ipairs(instrument.samples) do
        if i > 1 then -- Assuming the first sample is the original and not a slice
            --xoprint(slice_sample)
            slice_sample.oneshot = true
            slice_sample.mute_group = 1
            slice_sample.loop_mode = renoise.Sample.LOOP_MODE_OFF
        end
    end

    renoise.app():show_status("Hiya!")
end
