local replicated_storage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local fade_event = replicated_storage:WaitForChild("FadeEvent")
local screen_gui = script.Parent
local fade_frame = screen_gui:WaitForChild("Frame")

local fade_time = 1

local local_player = game.Players.LocalPlayer
local player_gui = local_player:WaitForChild("PlayerGui")

local FadeInTween = TweenService:Create(
    fade_frame,
	TweenInfo.new(
		fade_time,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut),
	{BackgroundTransparency = 0}
)

local FadeOutTween = TweenService:Create(
	fade_frame,
	TweenInfo.new(
		fade_time,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut),
		{BackgroundTransparency = 1}
)

fade_event.OnClientEvent:Connect(function(currentPage, newPage)
	FadeInTween:Play()
	FadeInTween.Completed:Wait()
	local page_to_hide = player_gui:WaitForChild(currentPage)
	page_to_hide.Enabled = false
	local page_to_show = player_gui:WaitForChild(newPage)
	page_to_show.Enabled = true
	if page_to_show.Name == "RequestPage" then
		page_to_show.ScrollingFrame.Visible = true 
	end
	wait()
	FadeOutTween:Play()
end)