local function createEmacsDaemon()
  local logger = hs.logger.new("emacs", "error")
  local result = hs.execute("/usr/local/bin/emacs --daemon")

  if (result == nil or result == "") then
    logger:i('error')
  else
    logger:i("successfully loaded")
  end

end

createEmacsDaemon()
