--运行UI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
--



local Window = OrionLib:MakeWindow({IntroText = "傻逼 Doors GUI ",Name = "Doors", HidePremium = false, SaveConfig = true, ConfigFolder = "Doors"})
if game.PlaceId == 6516141723 then
    OrionLib:MakeNotification({
        Name = "错误",
        Content = "请在局内运行,不要在大厅里.",
        Time = 2
    })
end
--结束UI区域
--游戏标签
local GameTab = Window:MakeTab({
	Name = "游戏",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--结束游戏标签区域
--人物标签
local CharTab = Window:MakeTab({
	Name = "人物",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
--结束人物标签区域
local TargetWalkspeed
CharTab:AddSlider({
	Name = "人物速度",
	Min = 0,
	Max = 50,
	Default = 5,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	Callback = function(Value)
		TargetWalkspeed = Value
	end    
})

local pcl = Instance.new("SpotLight")
pcl.Brightness = 1
pcl.Face = Enum.NormalId.Front
pcl.Range = 90
pcl.Parent = game.Players.LocalPlayer.Character.Head
pcl.Enabled = false


CharTab:AddToggle({
	Name = "自身光源",
	Default = false,
    Callback = function(Value)
        pcl.Enabled = Value
    end
})

GameTab:AddToggle({
	Name = "移除Seek追逐战末段手/障碍",
	Default = false,
    Flag = "NoSeek",
    Save = true
})

GameTab:AddToggle({
	Name = "立即互动",
	Default = false,
    Flag = "InstantToggle",
    Save = true
})
GameTab:AddButton({
	Name = "跳过房间",
	Callback = function()
        pcall(function()
            local HasKey = false
            local CurrentDoor = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Door")
            for i,v in ipairs(CurrentDoor.Parent:GetDescendants()) do
                if v.Name == "KeyObtain" then
                    HasKey = v
                end
            end
            if HasKey then
                game.Players.LocalPlayer.Character:PivotTo(CF(HasKey.Hitbox.Position))
                wait(0.3)
                fireproximityprompt(HasKey.ModulePrompt,0)
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                wait(0.3)
                fireproximityprompt(CurrentDoor.Lock.UnlockPrompt,0)
            end
            if LatestRoom == 50 then
                CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
            end
            game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
            wait(0.3)
            CurrentDoor.ClientOpen:FireServer()
        end)
  	end    
})

GameTab:AddToggle({
	Name = "自动跳过房间",
	Default = false,
    Save = false,
    Flag = "AutoSkip"
})

local AutoSkipCoro = coroutine.create(function()
        while true do
            task.wait()
            pcall(function()
            if OrionLib.Flags["AutoSkip"].Value == true and game:GetService("ReplicatedStorage").GameData.LatestRoom.Value < 100 then
                local HasKey = false
                local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value
                local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom)]:WaitForChild("Door")
                for i,v in ipairs(CurrentDoor.Parent:GetDescendants()) do
                    if v.Name == "KeyObtain" then
                        HasKey = v
                    end
                end
                if HasKey then
                    game.Players.LocalPlayer.Character:PivotTo(CF(HasKey.Hitbox.Position))
                    task.wait(0.3)
                    fireproximityprompt(HasKey.ModulePrompt,0)
                    game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                    task.wait(0.3)
                    fireproximityprompt(CurrentDoor.Lock.UnlockPrompt,0)
                end
                if LatestRoom == 50 then
                    CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
                end
                game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
                task.wait(0.3)
                CurrentDoor.ClientOpen:FireServer()
            end
        end)
        end
end)
coroutine.resume(AutoSkipCoro)

GameTab:AddButton({
	Name = "移除jumpscare",
	Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Bricks.Jumpscare:Destroy()
        end)
  	end    
})
GameTab:AddToggle({
	Name = "移除rush/ambush",
	Default = false,
    Flag = "AvoidRushToggle",
    Save = true
})
GameTab:AddToggle({
	Name = "移除screech",
	Default = false,
    Flag = "ScreechToggle",
    Save = true
})

GameTab:AddToggle({
	Name = "自动完成心跳游戏",
	Default = false,
    Flag = "HeartbeatWin",
    Save = true
})

GameTab:AddToggle({
	Name = "预测事件",
	Default = false,
    Flag = "PredictToggle" ,
    Save = true
})
GameTab:AddToggle({
	Name = "怪物生成提示",
	Default = false,
    Flag = "MobToggle" ,
    Save = true
})

GameTab:AddButton({
	Name = "跳过第50道门",
	Callback = function()
        local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
        game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
  	end    
})

-- 脚本区域（不要动）

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character.Humanoid.MoveDirection * TargetWalkspeed/50)
        end
    end)
end)

game:GetService("Workspace").CurrentRooms.DescendantAdded:Connect(function(descendant)
    if OrionLib.Flags["NoSeek"].Value == true and descendant.Name == ("Seek_Arm" or "ChandelierObstruction") then
        task.spawn(function()
            wait()
            descendant:Destroy()
        end)
    end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if OrionLib.Flags["InstantToggle"].Value == true then
        fireproximityprompt(prompt)
    end
end)

local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    
    if tostring(self) == 'Screech' and method == "FireServer" and OrionLib.Flags["ScreechToggle"].Value == true then
        args[1] = true
        return old(self,unpack(args))
    end
    if tostring(self) == 'ClutchHeartbeat' and method == "FireServer" and OrionLib.Flags["HeartbeatWin"].Value == true then
        args[2] = true
        return old(self,unpack(args))
    end
    
    return old(self,...)
end))

workspace.CurrentCamera.ChildAdded:Connect(function(child)
    if child.Name == "Screech" and OrionLib.Flags["ScreechToggle"].Value == true then
        child:Destroy()
    end
end)

local NotificationCoroutine = coroutine.create(function()
    LatestRoom.Changed:Connect(function()
        if OrionLib.Flags["PredictToggle"].Value == true then
            local n = ChaseStart.Value - LatestRoom.Value
            if 0 < n and n < 4 then
                OrionLib:MakeNotification({
                    Name = "注意!",
                    Content = "事件发生于 " .. tostring(n) .. " 房间.",
                    Time = 5
                })
            end
        end
        if OrionLib.Flags["BookToggle"].Value == true then
            if LatestRoom.Value == 50 then
                coroutine.resume(BookCoroutine)
            end
        end
        if OrionLib.Flags["FigureToggle"].Value == true then
            if LatestRoom.Value == 50 then
                coroutine.resume(EntityCoroutine)
            end
        end
    end)
    workspace.ChildAdded:Connect(function(inst)
        if inst.Name == "RushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "注意!",
                    Content = "正在避开rush. ",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()

                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "注意!",
                    Content = "rush已生成.",
                    Time = 5
                })
            end
        elseif inst.Name == "AmbushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "Wa注意rning!",
                    Content = " Ambush已生成.",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()
                
                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "注意!",
                    Content = "Ambush已生成.",
                    Time = 5
                })
            end
        end
    end)
end)

--// ok actual code ends here

local CreditsTab = Window:MakeTab({
	Name = "资料",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CreditsTab:AddParagraph("作者DX")

coroutine.resume(NotificationCoroutine)

OrionLib:Init()

task.wait(2)
