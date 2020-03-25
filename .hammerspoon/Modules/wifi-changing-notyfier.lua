function notifyAboutWifiName()
  WifiName = hs.wifi.currentNetwork()

  if WifiName == nil or WifiName == "TedMosby" then
    return
  end

  hs.notify.new({ 
    title="Hammerspoon",
    informativeText="Connected to " .. WifiName
  }):send()
end

notifyAboutWifiName()

Watcher = hs.wifi.watcher.new(function (_w, _e, _i)
  notifyAboutWifiName()
end)

Watcher:start()

