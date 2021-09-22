local Job = require("plenary.job")

local pip_install = function(package_name)
    print("Checking for " .. package_name)

    Job:new(
        {
            command = "type",
            args = {package_name},
            on_exit = function(_, return_val)
                if return_val ~= 0 then
                    Job:new(
                        {
                            command = "pip",
                            args = {"install", package_name},
                            on_exit = function(_, r)
                                if r ~= 0 then
                                    print("plugins.lua: " .. package_name .. " install failed!")
                                else
                                    print("plugins.lua: " .. package_name .. " installed.")
                                end
                            end
                        }
                    ):sync()
                end
            end
        }
    ):start()
end

local npm_install = function(package_name)
    print("Checking for " .. package_name)

    Job:new(
        {
            command = "type",
            args = {package_name},
            on_exit = function(_, return_val)
                if return_val ~= 0 then
                    Job:new(
                        {
                            command = "npm",
                            args = {"install", "-g", package_name},
                            on_exit = function(_, r)
                                if r ~= 0 then
                                    print("plugins.lua: " .. package_name .. " install failed!")
                                else
                                    print("plugins.lua: " .. package_name .. " installed.")
                                end
                            end
                        }
                    ):sync()
                end
            end
        }
    ):start()
end

local brew_install = function(package_name)
    print("Checking for " .. package_name)

    Job:new(
        {
            command = "type",
            args = {package_name},
            on_exit = function(_, return_val)
                if return_val ~= 0 then
                    Job:new(
                        {
                            command = "brew",
                            args = {"install", package_name},
                            on_exit = function(_, r)
                                if r ~= 0 then
                                    print("plugins.lua: " .. package_name .. " install failed!")
                                else
                                    print("plugins.lua: " .. package_name .. " installed.")
                                end
                            end
                        }
                    ):sync()
                end
            end
        }
    ):start()
end

local gem_install = function(package_name)
    print("Checking for " .. package_name)

    Job:new(
        {
            command = "gem",
            args = {"install", package_name},
            on_exit = function(_, r)
                if r ~= 0 then
                    print("plugins.lua: " .. package_name .. " install failed!")
                else
                    print("plugins.lua: " .. package_name .. " installed.")
                end
            end
        }
    ):start()
end

return {
    brew_install = brew_install,
    gem_install = gem_install,
    npm_install = npm_install,
    pip_install = pip_install
}
