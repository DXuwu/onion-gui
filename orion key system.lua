local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Player = game.Players.LocalPlayer
local Window = OrionLib:MakeWindow({Name = "DX密钥", HidePremium = false, SaveConfig = false, IntroEnabled = false})

OrionLib:MakeNotification({
    Name = "用户",
    Content = "你已使用 : "..Player.Name.."登入了 ",
    Image = "rbxassetid://4483345998",
    Time = 5
})

_G.Key = "夜夜夜666123"
_G.KeyInput = "string"

function MakeScriptHub()
    print("EnteredCorrectKey")
end

function CorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "密钥正确",
        Content = "请稍等!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

function IncorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "错误",
        Content = "密钥错误!",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

local Tab = Window:MakeTab({
	Name = "密钥",
	Icon = "",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "输入密钥",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		_G.KeyInput = Value
	end	  
})

Tab:AddButton({
	Name = "检查密钥!",
	Callback = function()
      		if _G.KeyInput == _G.Key then
            MakeScriptHub()
            CorrectKeyNotification()
            wait()
             wait()
              wait()
               wait()
                wait()
                 wait()
                  wait()
                   wait()
                    wait()
                     wait()
                      wait()
                       wait()
                        wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/DXuwu/replicator-lol/main/obfuscated.txt"))()	
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()
                         wait()


                       
            OrionLib:Destroy()
            else
                IncorrectKeyNotification()
        end

  	end    
})


