local function sit_on_stair(pos, node, player)
  -- Get opposite horizontal rotation
  local rotation = emote.util.facedir_to_look_horizontal((node.param2 + 2) % 4)
  player:set_look_horizontal(rotation)
  
  -- Teleport player to adjusted position
  local sit_pos = {
    x = pos.x,
    y = pos.y,
    z = pos.z
  }
  player:set_pos(sit_pos)
  -- Trigger sit emote
  minetest.after(0.25, function()
    emote.start(player, "sit")
end)

end



-- Override all stair-like nodes
minetest.register_on_mods_loaded(function()
  for name, def in pairs(minetest.registered_nodes) do
    if def.description and def.description:lower():find("stair") then
      minetest.override_item(name, {
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
          sit_on_stair(pos, node, clicker)
          return itemstack
        end
      })
    end
  end
end)
