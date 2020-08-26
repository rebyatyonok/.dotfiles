hs.hotkey.bind({"cmd", "alt", "ctrl"}, "T", function()
  hs.application.enableSpotlightForNameSearches(true);
  hs.application.open("Terminal.app");
end)
