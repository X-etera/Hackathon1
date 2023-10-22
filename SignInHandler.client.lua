local starter_gui = script.Parent.Parent
local screen_gui = script.Parent
local main_background = screen_gui:WaitForChild("MainBackground")
local sign_in_button = main_background:WaitForChild("SignInButton")
local main_page = starter_gui:WaitForChild("MainPage")

local correct_email = "ARay@clarku.edu"
local correct_password = "clarkathon2023"

sign_in_button.Activated:Connect(function()
    local email = main_background.EmailBox.Text
    local password = main_background.PasswordBox.Text
    local error_message = main_background.ErrorMessage

    if email ~= correct_email or password ~= correct_password then
        error_message.Visible = true
    end

    if email == correct_email and password == correct_password then
        main_page.Enabled = true
        screen_gui.Enabled = false
    end

end)