require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

unless ENV['RACK_ENV'] == 'production'
  IRB.conf[:SAVE_HISTORY] = 200
  IRB.conf[:HISTORY_FILE] = '~/.irb-history'
end

if File.exist?(File.expand_path('~/.irbrc.local'))
  load File.expand_path('~/.irbrc.local')
end
