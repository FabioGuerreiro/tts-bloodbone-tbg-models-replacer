require("vscode/console")

-- Loading all unique zones and hunt board
big_play_area_GUID = '0ad353'
start_zone_GUID = 'c4d0fd'
campaign_start_zone_GUID = 'a8429c'
hunt_board_GUID = '66b398'
enemies_zone_GUID = '1af64d'
chapter_deck_zone_GUID = 'b5a4c1'
upgrade_shop_zone_GUID = 'cfd454'
upgrade_deck_zone_GUID = '7ca31d'
rewards_deck_zone_GUID = '4db3f7'
firearm_deck_zone_GUID = '822ff6'
consumables_deck_zone_GUID = '877472'
consumables_discard_zone_GUID = '1b3553'
random_monster_zone_GUID = 'a61d5f'
map_tiles_zone_GUID = '8450a1'
extra_tiles_zone_GUID = 'ab0549'
enemy_action_deck_zone_GUID = '756be8'
enemy_action_discard_zone_GUID = 'cac3a5'
hunt_mission_zone_GUID = 'a732ce'
insight_mission_zone1_GUID = 'f62a92'
insight_mission_zone2_GUID = 'cb3491'
insight_mission_zone3_GUID = '2d2571'
all_monsters_zone_GUID = '18ee2c'
extra_tiles_zone_GUID = '7d3f3f'
playing_zone_GUID = '7d3f3f'
the_box_GUID = '941153'

-- GUIDs to bags with all the elements
the_long_hunt_GUID = '081372'
fall_of_old_yarnham_GUID = '489295'
secrets_of_the_church_GUID = '9c7e44'
growing_madness_GUID = 'a5caa4'
chalice_rite_GUID = '89659e'
birth_of_madness_GUID = 'd99659'
celestial_truths_GUID = 'fbbcab'
the_forsaken_castle_GUID = '29ff40'
martyrs_legacy_GUID = 'dfdc50'
queens_legacy_GUID = '17528c'
dark_rites_GUID = '088372'
den_of_vipers_GUID = 'b91fc8'
the_eldritch_truth_GUID = 'a94b69'
the_unseen_village_GUID = '8a3e27'
forbidden_woods_GUID = '3cda53'
forsaken_legacy_GUID = '37a760'
the_hunts_end_GUID = '19437c'

-- GUIDs to hunters dashboards
red_hunter_zone_GUID = "5789d8"
blue_hunter_zone_GUID = "b6e10c"
purple_hunter_zone_GUID = "cffe86"
green_hunter_zone_GUID = "c66ed7"


-- useful locations
hunt_mission_location = {-18.4,11,-62}
enemy_one_location = {21.73,10.46,-64.21}

campaign_bag = nil
campaign = nil
chapter = nil
chapter_deck = nil
map_tiles = nil
random_monster_bag = nil

campaign_buttons_position_initial = true

function set_campaign_decks ()
  campaigns = {
    ["The Long Hunt"] = {
      {
        enemies = {"Hunter Mob", "Huntsman's Minion", "Scourge Beast"},
        starting_tile = "Central Lamp",
        starting_tiles = {"Courtyard Lamp", "Occupied House", "Oedon Chapel", "Ransacked House"},
        hunt_mission = {"1","2","3","4"},
        introduction = "Of the monsters created by the Beast Plague, the Scourge Beasts are the most reviled. Once Human, these terrible monstrosities are fast, agile, and lethal. As of late, more and more of these beasts have begun appearing in Central Yharnam, and thus we have been tasked with discovering the source of their increasing numbers, as well eliminating as many as possible.",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        insight_missions = {{"5","6","7"},{"8","9","10","11"},{"12","13","14","15","16"}}
      },
      {
        enemies = {"Hunter Mob", "Huntsman's Minion", "Scourge Beast"},
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard", "Iosefka's Clinic", "Oedon Chapel", "The Great Bridge", "Tomb of Oedon"},
        extra_cards = {"17"},
        hunt_mission = {"18","19","20","21","22","23"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        insight_missions = {{"24","25","26","27","28"},{"29","30","31","32","33","34"},{"35","36","37","38","39"}}
      },
      {
        enemies = {"Hunter Mob", "Huntsman's Minion", "Scourge Beast"},
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard", "Iosefka's Clinic", "Oedon Chapel", "The Great Bridge", "Tomb of Oedon"},
        extra_cards = {"17"},
        hunt_mission = {"40","41","42","43","44"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        insight_missions = {{"45","46","47","48","49","50","51","52"},{"53","54","55"},{"56","57","58","59","60"}}
      }
    },
    ["Fall of Old Yharnam"] = {
      {
        hunt_mission = {"2","3","4","5","6","7","8","9"},
        introduction = "Spiraling below the Cathedral Ward lies the hamlet known as Old Yharnam. Far removed, the town lies isolated from the greater city. Recently, however, rumors have emerged of a strange sickness, different from that of the Beast Plague, spreading through its streets. A group of hunters, notably those of the Powder Kegs covenant, were sent to investigate. Time has passed, and none have returned, thus we have been dispatched to discover what fate has befallen them.",
        starting_tile = "Central Lamp",
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        starting_tiles = {"Alleyway","Courtyard Lamp", "Graveyard", "Occupied House", "Ransacked House"},
        extra_cards = {"1"},
        insight_missions = {{"10","11","12"},{"13","14"},{"15","16","17"}}
      },
      {
        hunt_mission = {"18","19","20","21","22","23","24","25"},
        introduction = "TODO",
        starting_tile = "Central Lamp",
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        starting_tiles = {"Alleyway","Barred Window", "Courtyard Lamp", "Graveyard", "Occupied House"},
        extra_cards = {"1"},
        insight_missions = {{"26","27"},{"28","29","30","31","32","33"},{"34","35"}}
      },
      {
        hunt_mission = {"36","37","38","39","40","41","42","43","44"},
        introduction = "TODO",
        starting_tile = "Central Lamp",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tiles = {"Alleyway","Barred Window", "Church of the Good Chalice", "Ransacked House"},
        excluded_tiles = {"Grand Cathedral"},
        extra_cards = {"1"},
        insight_missions = {{"45","46","47"},{"48","49","50"},{"51","52","53","54"}},
      }
    },
    ["Secrets of the Church"] = {
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "The Healing Church, while not formally affiliated with the Hunters, remains one of our strongest allies. Located in the district known as the Cathedral Ward, access is often barred on nights when the Hunt is called. This night, however, the great bells of the Grand Cathedral toll without end. Ominous, as all communication from within the Ward has ceased. With such strange events, you have been dispatched by the Workshop to investigate.",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Alleyway","Courtyard Lamp", "The Great Bridge", "Tomb of Oedon"},
        excluded_tiles = {"Grand Cathedral", "Oedon Chapel"},
        enemies_random = 3,
        excluded_enemies = {"Church Servant"},
        insight_missions = {{"6","7","8","9"},{"10","11","12"},{"13","14"}},
      },
      {
        hunt_mission = {"16","17","18","19","20","21","22","23"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard","Occupied House"},
        excluded_tiles = {"Grand Cathedral", "Oedon Chapel", "The Great Bridge", "Tomb of Oedon"},
        enemies_random = 3,
        excluded_enemies = {"Church Giant"},
        insight_missions = {{"24","25"},{"26","27","28","29"},{"30","31","32","33","34"}},
        extra_cards = {"15"},
      },
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        enemies = {"Church Giant", "Church Servant"},
        enemies_random = 1,
        starting_tile = "Central Lamp",
        starting_tiles = {"Courtyard Lamp","Graveyard", "Ransacked House", "Oedon Chapel"},
        excluded_tiles = {"Grand Cathedral"},
        insight_missions = {{"6","7","8","9"},{"10","11","12"},{"13","14"}},
      }
    },
    ["Growing Madness"] = {
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "This night, a grand Hunt has been called: Hunter and townsfolk alike have taken to the streets to join in the great purging. Among them, the renowned Hunter, Father Gascoigne, has joined you in your task. Yet, something about this Hunt feels different... The scent of blood is heavy in the air. From above, the rays of the Blood Moon bathe the streets in a crimson red. All the while, an unnerving feeling lies just below the surface, as if something terrible is waiting to, be unleashed...",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard","The Great Bridge", "Occupied House", "Oedon Chapel"},
        --enemies = {"Hunter Mob"},
        enemies_random = 2,
        insight_missions = {{"6","7","8","9","10"},{"11","12","13"},{"14","15"}},
      },
      {
        hunt_mission = {"17","18","19","20","21"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard","The Great Bridge", "Occupied House", "Oedon Chapel"},
        enemies = {"Hunter Mob"},
        enemies_random = 2,
        insight_missions = {{"22","23","24","25"},{"26","27","28","29","30"},{"31","32","33","34","35","36","37","38"}},
        extra_cards = {"16"},
      },
      {
        hunt_mission = {"39","40","41","42"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard","The Great Bridge", "Occupied House", "Oedon Chapel"},
        enemies = {"Hunter Mob"},
        enemies_random = 2,
        extra_cards = {"20","23","38"},
        insight_missions = {{"43","44","45","46","47","48","49"},{"50","51","52","53","54"},{"55","56","57","58"}},
      }
    },
    ["Chalice Rites"] = {
      {
        hunt_mission = {},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = #getSeatedPlayers()+4,
        enemies_random = 3,
        starting_tile = "Chalice Entrance",
        starting_tiles = {"Arena Gate","Arena Gate Lever","Arena Gate Lever"},
      }
    },
    ["Birth of Madness"] = {
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        starting_tiles = {"Barred Window","Courtyard Lamp", "Iosefka's Clinic", "Ransacked House"},
        --enemies = {"Hunter Mob"},
        enemies_random = 2,
        excluded_enemies = {"Mergo's Attendant", "Mergo's Chief Attendant"},
        insight_missions = {{"6","7","8"},{"9","10","11"},{"12","13"}}
      },
      {
        hunt_mission = {"16","17","18","19","20","21","22"},
        introduction = "TODO",
        starting_tile = "Central Lamp",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tiles = {"Barred Window","Iosefka's Clinic", "Oedon Chapel", "Tomb of Oedon"},
        --enemies = {"Mergo's Attendant", "Mergo's Chief Attendant"},
        enemies_random = 1,
        insight_missions = {{"23","24","25"},{"26","27"},{"28","29","30","31","32","6","7","8"}},
        extra_cards = {"14","15"},
      },
      {
        hunt_mission = {"35","36","37","38"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,7),
        starting_tile = "Central Lamp",
        starting_tiles = {"Grand Cathedral", "Iosefka's Clinic", "Oedon Chapel"},
        --enemies = {"Mergo's Attendant", "Mergo's Chief Attendant"},
        enemies_random = 1,
        insight_missions = {{"39","40","41","42","43"},{"44","45"},{"46","47","48","49","50","51","52"}},
        extra_cards = {"33","34"},
      },
    },
    ["Celestial Truths"] = {
      {
        enemies = {"Celestial Emissary", "Church Giant", "Church Servant"},
        starting_tiles = {"Graveyard", "Iosefka's Clinic", "Oedon Chapel", "Tomb of Oedon"},
        extra_cards = {"1","2"},
        hunt_mission = {"3","4","5","6","7","8","9","10"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        starting_tile = "Central Lamp",
        insight_missions = {{"11","12"},{"13","14","15"},{"16","17","18"}},
        excluded_tiles = {"Altar of Despair Tile","Grand Cathedral", "The Great Bridge"},
      },
      {
        enemies = {"Brainsucker", "Celestial Emissary", "Church Servant"},
        starting_tiles = {"Graveyard", "Iosefka's Clinic", "Ransacked House", "Tomb of Oedon"},
        extra_cards = {"2","4","19","20"},
        hunt_mission = {"21","22","23","24","25","26","27","28","29","30","31"},
        introduction = "TODO",
        starting_tile = "Central Lamp",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        insight_missions = {{"32","33","34","35","36",},{"37","38","39","40","41"},{"42","43","44","45","46","13","14","15"}},
        excluded_tiles = {"Grand Cathedral", "The Great Bridge"},
      },
      {
        enemies = {"Brainsucker", "Celestial Emissary", "Church Giant"},
        starting_tiles = {"Barred Window", "Grand Cathedral", "Occupied House", "Ransacked House"},
        extra_cards = {"20","47","48"},
        hunt_mission = {"49","50","51","52","53","54","56","57","58","59"},
        introduction = "TODO",
        random_tiles = math.min(#getSeatedPlayers()*2,6),
        insight_missions = {{"60","61","62","63"},{"64","65","66","67","68"},{}},
        starting_tile = "Central Lamp",
        excluded_tiles = {"Oedon Chapel", "The Orphanage"},
      },
    },
    ["The Forsaken Castle"] = {
      {
        hunt_mission = {"1","2","3","4","5","6","7","8","12"},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        enemies_random = 3,
        starting_tile = "Central Lamp",
        starting_tiles = {"Courtyard Lamp","Graveyard","Grand Cathedral","Iosefka's Clinic","Oedon Chapel"},
        insight_missions = {{"9"},{"10"},{"11"}},

      }
    },
    ["Martyr's Legacy"] = {},
    ["Queen's Legacy"] = {},
    ["Dark Rites"] = {
      {
        hunt_mission = {"2","3","4","5","6","7"},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = math.min(#getSeatedPlayers()*3,7),
        enemies_random = 0,
        starting_tile = "Passageway Lamp",
        starting_tiles = {""},
        excluded_tiles = {"Mud Pit", "Witch's Abode"},
        insight_missions = {{"8","9"},{"10","11","12","13","14"},{"15","16",}},
        extra_cards = {"1"},
      }
    },
    ["The Eldritch Truth"] = {
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "This mode is not yet fully scripted.",
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        insight_missions = {{"6","7","8","9"},{"10","11"},{"12","13","14"}},
        random_tiles = #getSeatedPlayers()+4,
        enemies_random = 3,
        starting_tile = "Central Lamp",
        starting_tiles = {"Courtyard Lamp","Grand Cathedral","Iosefka's Clinic","Occupied House", "Ransacked House"},
        excluded_tiles = {"Byrgenwerth Tile"},
      }
    },
    ["Den of Vipers"] = {
      {
        hunt_mission = {"1","2","3","4","5"},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {{"6","7","8",},{"9","10",},{"11","12",}},
        random_tiles = math.min(#getSeatedPlayers()*3,11),
        enemies_random = 0,
        starting_tile = "Passageway Lamp",
        starting_tiles = {"Decrepit Shack", "Mud Pit",},
        excluded_tiles = {"Forbidden Graveyard"},
      }
    },
    ["The Unseen Village"] = {
      {
        hunt_mission = {"1","2","3","4","5","6","7","8","9"},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {{"10","11","12","13","14","15","16",},{"17","18","19"},{"20","21","22"}},
        random_tiles = math.min(#getSeatedPlayers()*2,5),
        enemies_random = 3,
        starting_tile = "Central Lamp",
        starting_tiles = {"Graveyard","Iosefka's Clinic","Occupied House","Oedon Chapel","Tomb of Oedon"},
        excluded_tiles = {"Yahar'gul Tile"},

      }
    },
    ["Forbidden Woods"] = {
      {
        hunt_mission = {},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = #getSeatedPlayers()+4,
        enemies_random = 3,
        starting_tile = "Passageway Lamp",
        starting_tiles = {"Arena Gate","Arena Gate Lever","Arena Gate Lever"},
      }
    },
    ["Forsaken Legacy"] = {
      {
        hunt_mission = {},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = #getSeatedPlayers()+4,
        enemies_random = 3,
        starting_tile = "Passageway Lamp",
        starting_tiles = {"Arena Gate","Arena Gate Lever","Arena Gate Lever"},
      }
    },
    ["The Hunt's End"] = {
      {
        hunt_mission = {},
        introduction = "This mode is not yet fully scripted.",
        insight_missions = {},
        random_tiles = #getSeatedPlayers()+4,
        enemies_random = 3,
        starting_tile = "Passageway Lamp",
        starting_tiles = {"Arena Gate","Arena Gate Lever","Arena Gate Lever"},
      }
    }
  }
end

campaign_button_parameters = {
  click_function = 'load_campaign',
  function_owner = nil,
  label = 'Start\nCampaign',
  position = {0,0.3,1},
  rotation = {0,0,0},
  width = 500,
  height = 500,
  font_size = 100,
}

card_button_parameters = {
  click_function = 'flip_mission_card',
  function_owner = nil,
  label = 'Flip Card',
  position = {-0.65,-0.2,0},
  --position = {0,0,0},
  rotation = {0,-90,0},
  scale = {.8,.8,.8},
  width = 500,
  height = 170,
  font_size = 100,
}

enemy_action_button_parameters = {
  click_function = 'flip_enemy_action_card',
  function_owner = nil,
  label = 'Enemy Action',
  position = {-0.65,.5,1},
  rotation = {0,180,0},
  scale = {1,1,1},
  width = 750,
  height = 170,
  font_size = 100,
}

next_chapter_button_parameters = {
  click_function = 'next_chapter',
  function_owner = nil,
  label = 'Next Chapter',
  position = {-0.5,-0.5,0},
  rotation = {0,180,0},
  scale = {1,1,1},
  width = 700,
  height = 170,
  font_size = 100
}

start_button_parameters = {
  click_function = 'init_all_campaingns',
  function_owner = nil,
  label = 'Start',
  position = {-0.5,-0.5,0},
  rotation = {0,180,0},
  scale = {1,1,1},
  width = 350,
  height = 170,
  font_size = 100
}

function onLoad(save_state)
  broadcastToAll("When all players are seated and have selected their Hunters click \"Start\"")
  zone = getObjectFromGUID(start_zone_GUID)
  zone.createButton(start_button_parameters)
end

function init_all_campaingns()
  zone.clearButtons()

  set_campaign_decks()
  add_campaign_buttons()
  add_mission_buttons()
  
  o = getObjectFromGUID(enemy_action_deck_zone_GUID)
  o.createButton(enemy_action_button_parameters)
end

function next_chapter(x)
  if campaign[chapter + 1] == nil then
    chapter = nil
    return false
  else
    chapter = chapter + 1
  end

  load_campaign(campaign_bag)
  
  -- log("Starting next Chapter...")
  -- chapter_deck_zone = getObjectFromGUID(chapter_deck_zone_GUID)
  -- the_box = getObjectFromGUID(the_box_GUID)
  -- map_tiles_zone = getObjectFromGUID(map_tiles_zone_GUID)
  -- map_tiles = {}

  -- zone = getObjectFromGUID(enemies_zone_GUID)
  -- random_monster_zone = getObjectFromGUID(random_monster_zone_GUID)
  -- for _,o in ipairs(zone.getObjects()) do
  --   if o.getName() != "Hunt Board" and (o.tag == "Card" or o.tag == "Deck") then
  --     o.setPosition(the_box.getPosition())
  --     --bag = spawnObject({type = "Bag", sound = false})
  --     for _,b in ipairs(random_monster_zone.getObjects()) do
  --       if b.tag == "Infinite" then
  --         b.setPosition(the_box.getPosition())
  --       end
  --     end
  --   end
  -- end
  -- --random_monster_bag.setPosition(random_monster_zone.getPosition())
  -- for _,o in ipairs(map_tiles_zone.getObjects()) do
  --   if o.tag == "Deck" then
  --     map_tiles = o
  --   end
  -- end
  -- for _,o in ipairs(chapter_deck_zone.getObjects()) do
  --   if o.tag == "Card" and o.getName() != "Hunt Board" then
  --     the_box.putObject(o)
  --   end
  -- end
  -- for _,z in ipairs({extra_tiles_zone_GUID,playing_zone_GUID}) do
  --   zone = getObjectFromGUID(z)
  --   for _,o in ipairs(zone.getObjects()) do
  --     if o.tag == "Card" and o.getName() != "Central Lamp" then
  --       o.flip()
  --       map_tiles.putObject(o)
  --     elseif o.tag == "Deck" then
  --       map_tiles.putObject(o)
  --     end
  --   end
  -- end
  -- card = chapter_deck.takeObject()
  -- card.flip()
  -- for _,z in ipairs({mission_discard_zone_GUID,campaign_start_zone_GUID}) do
  --   zone = getObjectFromGUID(z)
  --   for _,o in ipairs(zone.getObjects()) do
  --     if o.tag == "Deck" or o.tag == "Card" then
  --       o.setRotation({0,180,0})
  --       chapter_deck.putObject(o)
  --     end
  --   end
  -- end
  -- zone = getObjectFromGUID(upgrade_shop_zone_GUID)
  -- dest = getObjectFromGUID(upgrade_deck_zone_GUID)
  -- for _,o in ipairs(zone.getObjects()) do
  --   if o.tag == "Card" and o.getName() != "Hunt Board" then
  --     o.flip()
  --     o.setPosition(dest.getPosition())
  --   end
  -- end
  -- zone = getObjectFromGUID(enemy_action_discard_zone_GUID)
  -- dest = getObjectFromGUID(enemy_action_deck_zone_GUID)
  -- for _,o in ipairs(zone.getObjects()) do
  --   if o.tag == "Card" or o.tag == "Deck" then
  --     o.flip()
  --     o.setPosition(dest.getPosition())
  --   end
  -- end

  -- --Wait.time(function() return true; end,2)
  -- start_campaign(chapter_deck, campaign)
  -- Wait.time(initialize_decks,2.5)
end
-- Adds buttons to campaigns
function add_campaign_buttons()
  c = {}
  c['the_long_hunt'] = getObjectFromGUID(the_long_hunt_GUID)
  c['fall_of_old_yarnham'] = getObjectFromGUID(fall_of_old_yarnham_GUID)
  c['secrets_of_the_church'] = getObjectFromGUID(secrets_of_the_church_GUID)
  c['growing_madness'] = getObjectFromGUID(growing_madness_GUID)
  c['chalice_rite'] = getObjectFromGUID(chalice_rite_GUID)
  c['birth_of_madness'] = getObjectFromGUID(birth_of_madness_GUID)
  c['celestial_truths'] = getObjectFromGUID(celestial_truths_GUID)
  c['the_forsaken_castle'] = getObjectFromGUID(the_forsaken_castle_GUID)
  --c['martyrs_legacy'] = getObjectFromGUID(martyrs_legacy_GUID)
  --c['queens_legacy'] = getObjectFromGUID(queens_legacy_GUID)
  c['dark_rites'] = getObjectFromGUID(dark_rites_GUID)
  c['den_of_vipers'] = getObjectFromGUID(den_of_vipers_GUID)
  c['the_eldritch_truth'] = getObjectFromGUID(the_eldritch_truth_GUID)
  c['the_unseen_village'] = getObjectFromGUID(the_unseen_village_GUID)
  --c['forbidden_woods'] = getObjectFromGUID(forbidden_woods_GUID)
  --c['forsaken_legacy'] = getObjectFromGUID(forsaken_legacy_GUID)
  --c['the_hunts_end'] = getObjectFromGUID(the_hunts_end_GUID)

  for k,v in pairs(c) do
    log("Initiliazing Campaign: "..v.getName())
    c[k].createButton(campaign_button_parameters)
  end
end

-- Adds buttons to mission Decks
function add_mission_buttons()
  for _,l in ipairs({hunt_mission_zone_GUID, insight_mission_zone1_GUID, insight_mission_zone2_GUID, insight_mission_zone3_GUID}) do
    o = getObjectFromGUID(l)
    o.createButton(card_button_parameters)
  end
end

-- Moves campaign bag to Hunt Board, initializes and shuffles decks, calls init_campaign
function load_campaign(c)
  campaign_bag = c

  clear_table()
   
  hunt_board = getObjectFromGUID(hunt_board_GUID)
  --Hide campaigns
  if campaign_buttons_position_initial == true then
    move_campaign_buttons()
  end
  log("Loading Campaign: "..c.getName())

  --Move the bag to the hunt board
  bag = c.takeObject({position=hunt_board.getPosition()})
  --Wait 2.5s for animations to finish
  Wait.time(init_campaign,2.5)
  Wait.time(initialize_decks,5)

  zone = getObjectFromGUID(start_zone_GUID)
  zone.createButton(next_chapter_button_parameters)
end

function select_enemies(cmpn)
  random_monster_zone = getObjectFromGUID(random_monster_zone_GUID)
  objs = random_monster_zone.getObjects()
  all_monsters = {}
  possible_enemies = {}
  random_enemies = nil
  log("selecting enemies")
  for _,obj in ipairs(objs) do
    if obj.getName() == "Random Enemies" then
      random_enemies = obj
      break
    end
  end
  eb1 = {21.73,10.46,-64.21}
  if random_enemies != nil then
    random_enemies.shuffle()
  else
    return true
  end
  random_enemies.setPosition({-119.41,11,-74.45})
  if cmpn["enemies_random"] > 0 then
    for i=1,cmpn.enemies_random,1 do
      eb = random_enemies.takeObject({position={-99.41,10.53,-74.45-(8*i)}})
      if cmpn["excluded_enemies"] then
        found = false
        for _,excluded in ipairs(cmpn["excluded_enemies"]) do
          --log(eb.getName())
          if eb.getName() == excluded then
            found = true
            log("skipping "..eb.getName())
          end
        end
        if found then
          --eb.destruct()
          eb = random_enemies.takeObject({position={-99.41,10.53,-74.45-(8*i)}})
        end
      end
      e = eb.takeObject({position={-9.41,10.53,-74.45}})
      eb2 = eb.takeObject({position={21.73+5*i,10.46,-64.21}})
      eb.destruct()
    end
  end
  if cmpn.enemies then
    for _,included in ipairs(cmpn.enemies) do
      for _,enemy in ipairs(objs) do
        --log(enemy.getName())
        if enemy.getName() == included then
          log("including "..enemy.getName())
          e = enemy.takeObject({position={-9.41,10.53,-74.45}}).rotate({0,0,180})
          enemy.takeObject()
          enemy.destruct()
        end
      end
    end
  end

  return true
end

-- Flips intro card, calls campaign start method with params
function init_campaign()
  chapter_deck_zone = getObjectFromGUID(chapter_deck_zone_GUID)
  objs = chapter_deck_zone.getObjects()
  chapter_deck = nil
  for _,obj in ipairs(objs) do
    if obj.tag == "Deck" then
      chapter_deck = obj
      break
    end
  end

  if chapter == nil then
    chapter = 1
  end
  
  intro_card = chapter_deck.takeObject({position={-18.25,11,-99},flip=true})
  
  if chapter > 1 then
    for i=1,(chapter - 1) do
      previous_chapter_card = chapter_deck.takeObject({position={-19.25,11,-99},flip=true})
    end
  end
  
  chapter_card = chapter_deck.takeObject({position=chapter_deck.getPosition(),flip=true})
  -- log(campaigns[chapter_deck.getName()])
  campaign = campaigns[chapter_deck.getName()]
  

  start_campaign(chapter_deck, campaign)
  return true
end

-- Moves the campaign buttons and bags far to the left
function move_campaign_buttons()
  log("Removing Campaign Setups...")
  objs = getObjectFromGUID(campaign_start_zone_GUID).getObjects()
  for _,o in ipairs(objs) do
    o.translate({0,0,256})
  end
  campaign_buttons_position_initial = false
end

-- Gets releveant decks from bag, shuffles them, and deals them
function initialize_decks()
  log("Shuffling Decks...")
  shuffle_named_deck_in_zone_guid(consumables_deck_zone_GUID, "Consumable Deck")
  shuffle_named_deck_in_zone_guid(enemy_action_deck_zone_GUID, "Enemy Action Deck")

  enemies = shuffle_named_deck_in_zone_guid(enemies_zone_GUID, "Enemies")
  if not enemies then
    zone = getObjectFromGUID(enemies_zone_GUID)
    objs = zone.getObjects()
    for _,o in ipairs(objs) do
      if o.tag == 'Deck' then
        enemies = o
      end
    end
  end
  if enemies then
    e3 = enemies.takeObject({position={9.5,11,-74.5}})
    e2 = enemies.takeObject({position={0,11,-74.5}})
    e1 = enemies.takeObject({position=enemies.getPosition()})

    -- 50% chance of each enemy flipping to opposite side
    for _,e in ipairs({e1, e2, e3}) do
      e.setRotation({180,0,0}) --Ensure proper orientation
      if (math.random() > 0.5) then
        e.rotate({0,0,180})
      end
    end
  end
  --upgrades = shuffle_named_deck_in_zone_guid(upgrade_deck_zone_GUID, "Upgrade Stat Deck")
  --u4 = upgrades.takeObject({position={10.7,11,-86.85},flip=true})
  --u3 = upgrades.takeObject({position={6,11,-86.85},flip=true})
  --u2 = upgrades.takeObject({position={1.5,11,-86.85},flip=true})
  --u1 = upgrades.takeObject({position={-3.1,11,-86.85},flip=true})
end

-- Find and shuffle a Deck by name in a zone by guid
function shuffle_named_deck_in_zone_guid(guid, name)
  --log("... "..name)
  deck = nil
  zone = getObjectFromGUID(guid)
  objs = zone.getObjects()
  for _,o in ipairs(objs) do
    if o.getName() == name then
      deck = o
      break
    end
  end
  if deck then
    deck.randomize()
    return deck
  end
  return false
end

function create_map_tiles_deck(starting_tile, required, random, excluded)
  tiles = {}
  map_tiles = {}
  random_tiles = {}
  excluded_tiles = {}
  map_tiles_zone = getObjectFromGUID(map_tiles_zone_GUID)
  for _,m in ipairs(required) do
    map_tiles[m] = true
  end
  if excluded then
    for _,m in ipairs(excluded) do
      excluded_tiles[m] = true
    end
  end
  objs = map_tiles_zone.getObjects()
  for _,obj in ipairs(objs) do
    if obj.tag == "Deck" then
      tiles = obj
      break
    end
  end
  for _,tile in ipairs(tiles.getObjects()) do
    if tile["name"] == starting_tile then
      tiles.takeObject({guid=tile["guid"],position={0,11,20},flip=true})
    elseif not map_tiles[tile["name"]] then
      if excluded and excluded_tiles[tile["name"]] then
        log("Excluding tile: "..tile["name"])
        tiles.takeObject({guid=tile["guid"],position={117,11,-83}})
      else
        table.insert(random_tiles, tile)
      end
    end
  end
  for i=1,random,1 do
    table.remove(random_tiles,math.floor(math.random(1,#random_tiles)))
  end
  for _,t in ipairs(random_tiles) do
    log(t["name"].." - "..t["guid"])
    tiles.takeObject({guid=t["guid"],position={142,11,-83}})
  end
  shuffle_named_deck_in_zone_guid(map_tiles_zone_GUID, "Map Tiles")
end

function find_card_in_deck(deck, name)
  local cards = deck.getObjects()
  for _,card in ipairs(cards) do
    if card["name"] == name then
      return card
    end
  end
  return false
end

function flip_mission_card(a)
  local pos = a.getPosition()
  pos[2] = pos[2] + 0.5
  objs = a.getObjects()
  log(objs)
  for _,o in ipairs(objs) do
    if o.tag == "Card" then
      local rot = o.getRotation()
      if rot[3] < 178 then
        o.flip({smooth=false})
      else
        o.translate({-6.25,0,0})
      end
    end
    if o.tag == "Deck" then
      o.takeObject({position=pos,flip=true})
    end
  end
end

function flip_enemy_action_card(a)
  enemy_action_zone = getObjectFromGUID(enemy_action_deck_zone_GUID)
  discard_zone = getObjectFromGUID(enemy_action_discard_zone_GUID)
  local src = enemy_action_zone.getPosition()
  local dest = discard_zone.getPosition()
  local flipped = false
  local zone_items = enemy_action_zone.getObjects()
  for _,zone_item in ipairs(zone_items) do
    if zone_item.tag == "Deck" then
      zone_item.takeObject({position=dest,flip=true})
      flipped = true
    elseif zone_item.tag == "Card" then
      zone_item.flip()
      zone_item.setPositionSmooth(dest)
      flipped = true
    end
  end
  if not flipped then
    discards = discard_zone.getObjects()
    for _,zone_item2 in ipairs(discards) do
      if zone_item2.tag == "Deck" then
        zone_item2.flip()
        zone_item2.shuffle()
        zone_item2.setPosition(src)
        zone_item2.takeObject({position=dest})
      end
    end
  end
end

function start_campaign(deck, campaign)
  params = campaign[chapter];

  hunt_board = getObjectFromGUID(hunt_board_GUID)
  local cards = deck.getObjects()
  hunt_cards = {}
  insight_cards = {}
  for _,v in ipairs(params["hunt_mission"]) do
    table.insert(hunt_cards, find_card_in_deck(deck,v))
  end
  for i,m in ipairs(params["insight_missions"]) do
    table.insert(insight_cards, {})
    for _,v in ipairs(m) do
      if type(v) == "table" then
        for _,v2 in ipairs(v) do
          table.insert(insight_cards[i], find_card_in_deck(deck,v2))
        end
      else
        table.insert(insight_cards[i], find_card_in_deck(deck,v))
      end
    end
  end
  for i,c in ipairs(hunt_cards) do
    flip = false
    if i == 1 then
      flip = true
    end
    card = deck.takeObject({guid=c["guid"],position={-18.4,13+(3-(.6*i)),-62},flip=flip})
  end
  hunt_mission_zone = getObjectFromGUID(hunt_mission_zone_GUID)
  hunt_mission_zone.createButton(card_button_parameters)
  for i,group in ipairs(insight_cards) do
    for i2,c in ipairs(group) do
      deck.takeObject({guid=c["guid"],position={-18.4,12+(3-(.5*i2)),-71.2-(i-1)*9.2}})
    end
  end
  if params.extra_cards then
    i=0
    for _,extra in ipairs(params.extra_cards) do
      for _,card in ipairs(deck.getObjects()) do
        if card["name"] == extra then
          deck.takeObject({guid=card["guid"],position={-12+(6.25*i),11,-99},flip=true})
          i = i+1
        end
      end
    end
  end
  create_map_tiles_deck(params.starting_tile,params.starting_tiles,params.random_tiles,params.excluded_tiles)
  select_enemies(params)
  broadcastToAll(params.introduction, Table)
end

function clear_table()
  -- needs to clear all items scattered on the table
  log("Clearing Table...")

  playArea = getObjectFromGUID(big_play_area_GUID)
  zoneObjects = playArea.getObjects()
  for k, obj in pairs(zoneObjects) do
    if obj.getDescription() == "Hunter" then  
      log(obj.getColorTint())
      log(obj.getPosition())
      hunter_zone = getObjectFromGUID(red_hunter_zone_GUID)
      hunter = obj.takeObject({position=hunter_zone.getPosition()})
      -- if obj.getColorTint() == "Red" then
      --   -- obj.takeObject({position={-65,5,-96.98069}})
      -- end
    elseif obj.getLock() ~= true then
      obj.destruct()
    end
    -- log(obj.getName())
    -- log(obj.getDescription())
    -- log("------------------------------")
  end

end