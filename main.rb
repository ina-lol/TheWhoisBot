require 'discordrb'
require 'whois'

bot = Discordrb::Commands::CommandBot.new token: 'your token here :)', prefix: ','


   # The magic begin!
   bot.command(:whois, help_available: true) do |event, *args|
      bot.send_message(event.channel.id, 'Um momento...')
      res = Whois.whois("#{args.join}")
      File.open("data/whois_result.txt", "w") { |f| f.write "WHOIS RESULT BY POOOORYGON BOT\n\n#{res}\n\nWHOIS RESULT BY POOOORYGON BOT" }
    
      event.user.pm.send_embed do |embed|
         embed.title = '🔎 | Whois encontrado!'
         embed.description = "#{args.join} foi encontrado! aqui está o arquivo, mais opções nesse embed!"
         embed.add_field name: "Resultado do BuiltWith!", value: "[Clique aqui!](https://builtwith.com/#{args.join})", inline: true
         embed.add_field name: 'Resultado no Google!', value: "[Clique aqui!](https://www.google.com/search?q=#{args.join})", inline: true
         embed.color = '#5865F2'
      end
      event.user.pm.send_file(File.open('data/whois_result.txt', 'r'))
   end
bot.run
