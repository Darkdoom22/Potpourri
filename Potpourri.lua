_addon.name = "Potpourri"
_addon.author = "Darkdoom"

res	= require 'resources'
packets	= require 'packets'
files		= require 'files'
texts		= require 'texts'
          require 'strings'
config	= require('config')

potpourri = 0
no_spam = os.clock()

default_settings = {}
default_settings.pos = {}
default_settings.pos.x = 344
default_settings.pos.y = 544
default_settings.text = {}
default_settings.text.font = 'Segoe UI'
default_settings.text.size = 12
default_settings.text.alpha = 255
default_settings.text.red = 20
default_settings.text.green = 177
default_settings.text.blue = 250
default_settings.bg = {}
default_settings.bg.alpha = 205
default_settings.bg.red = 3
default_settings.bg.green = 1
default_settings.bg.blue = 1
settings = config.load('data\\settings.xml',default_settings)

text_box = texts.new(settings)

function CurrencyUpdate()
if os.clock() - no_spam > 10 then
  
windower.packets.inject_outgoing(0x115,'0000')
no_spam = os.clock()
end
end



windower.register_event("incoming chunk", function(id, data)
  
  if id == 0x118 then
  local p = packets.parse('incoming', data)
  potpourri = p['Potpourri']
end
end)

function DisplayBox()
  new_text = "Potpourri: " .. potpourri .. "\n"
  text_box:text(new_text)
  text_box:visible(true)
  end


windower.register_event('prerender', function()
    CurrencyUpdate()
    DisplayBox()
    end)
