-- here we source this file by adding the path of this project such as the nix store path 
-- or the user lab path for development 
my_init.source_me()
-- import all modules from this project
require("misc").setup()
-- in here we extend the editor with more plugins based on the lab path such lualab or javalab. 
-- When changing to directories within the lab folder the editor will load the plugins lazyly 
my_init.extend_environment_from_lab()
