local function notifyAboutWifiName()
  local wifiName = hs.wifi.currentNetwork()

  if wifiName == nil or wifiName == "TedMosby" then
    return
  end

  hs.notify.new({ 
    title="Hammerspoon",
    informativeText="Connected to " .. wifiName
  }):send()
end

notifyAboutWifiName()

local watcher = hs.wifi.watcher.new(function (_w, _e, _i)
  notifyAboutWifiName()
end)

watcher:start()

