--Blue Hunter Dashboard
HP_MIN_VALUE = 0
HP_MAX_VALUE = 6

ECHOES_MIN_VALUE = 0
ECHOES_MAX_VALUE = 3

zone_GUID = "b6e10c"

playerColor = "Blue"

function updateSave()
    local data_to_save = {HP_CURRENT_VALUE, ECHOES_CURRENT_VALUE,hunter_GUID}
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function onload(saved_data)
    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        HP_CURRENT_VALUE = loaded_data[1]
        ECHOES_CURRENT_VALUE = loaded_data[2]
        hunter_GUID = loaded_data[3]
        hunter = getObjectFromGUID(hunter_GUID)
    end
    zone = getObjectFromGUID(zone_GUID)
    generateBtnParams()
    createBtns(hp_display_params)
    createBtns(echoes_display_params)
    createBtns(transform_params)
end

--Beginning Setup

function generateBtnParams()
  hp_display_params = {position = {-0.69,.3,-.4},
    click_function = 'hp_add_subtract',
    label = tostring(HP_CURRENT_VALUE),
    bg_color = {0,0,0,0},
    h = 100,
    w = 100,
    f_size = 100,
    f_color = {1,1,1,255}
}
echoes_display_params = {position = {-0.13,.3,-.4},
  click_function = 'echoes_add_subtract',
  label = tostring(ECHOES_CURRENT_VALUE),
  bg_color = {0,0,0,0},
  h = 100,
  w = 100,
  f_size = 100,
  f_color = {1,1,1,255}
}
transform_params = {position = {.7,.3,1.15},
  click_function = 'transform',
  label = "Transform",
  bg_color = playerColor,
  h = 50,
  w = 300,
  f_size = 50,
  scale = {x=.65, y=.65, z=.65},
  f_color = "White"
}
end
--Make setup button
function createBtns(params)
	local rot = {0,0,0}
	--center display
	self.createButton({
  label= params.label,
  click_function=params.click_function,
  function_owner=self,
  position=params.position,
  rotation=rot,
  height=params.h,
  width=params.w,
  scale=params.scale,
  font_size=params.f_size,
  font_color=params.f_color,
  color=params.bg_color
})

end

function hp_add_subtract(_obj, _color, alt_click)
  mod = alt_click and -1 or 1
  new_value = math.min(math.max(HP_CURRENT_VALUE + mod, HP_MIN_VALUE), HP_MAX_VALUE)
  if HP_CURRENT_VALUE ~= new_value then
    HP_CURRENT_VALUE = new_value
    hp_update_display()
    updateSave()
  end
end

function echoes_add_subtract(_obj, _color, alt_click)
  mod = alt_click and -1 or 1
  new_value = math.min(math.max(ECHOES_CURRENT_VALUE + mod, ECHOES_MIN_VALUE), ECHOES_MAX_VALUE)
  if ECHOES_CURRENT_VALUE ~= new_value then
    ECHOES_CURRENT_VALUE = new_value
    echoes_update_display()
    updateSave()
  end
end

function hp_update_display(params)
    if params == nil then
        hp = {value = HP_CURRENT_VALUE}
        self.editButton({
        index = 0,
        label = tostring(HP_CURRENT_VALUE)})
        if hunter == nil then
            print("Sync with Hunter")
        else
            hunter.call("updateHP", hp)
        end

    else
        HP_CURRENT_VALUE = params.value
        updateSave()
        self.editButton({
        index = 0,
        label = tostring(HP_CURRENT_VALUE)})
    end
end
function onCollisionEnter(a)
    local obj = a.collision_object
    if obj.getDescription() == "Hunter" then
        hunter_GUID = obj.getGUID()
        hunter = getObjectFromGUID(hunter_GUID)
    end
end

function echoes_update_display()
  	self.editButton({
    index = 1,
    label = tostring(ECHOES_CURRENT_VALUE),
  })
end

function transform()
    local discardPos = {}
    local selfPos = self.getPosition()

    for _, obj in pairs(zone.getObjects()) do
        if obj.tag == "Card" then
            if obj.getDescription() == "" then
                discardPos = {selfPos.x - 13.3, selfPos.y + .42, selfPos.z - 4.95}
                obj.setPosition(discardPos)
            end
            if obj.getDescription() == "Trick Weapon" then
                obj.flip()
            end
        end--end if statement
    end--end for
end--end function