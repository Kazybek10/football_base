namespace :import do
  desc "Imports football data from an external API"
  task football_data: :environment do
    require 'httparty'

    # Замени на реальный URL API и свой API-ключ
    base_url = 'https://api.football-data.org/v4'
    api_key = ENV['FOOTBALL_API_KEY'] # Рекомендуется хранить ключ в переменных окружения

    puts "Начинаем импорт данных..."

    # Пример запроса к API для получения списка команд в лиге
    league_id = 2021 # ID Премьер-лиги
    response = HTTParty.get("#{base_url}/competitions/#{league_id}/teams", headers: { 'X-Auth-Token' => api_key })

    if response.success?
      data = JSON.parse(response.body)
      data['teams'].each do |team|
        # Ищем или создаем клуб
        club = Club.find_or_create_by!(name: team['name']) do |c|
          c.city = team['address']
          c.founded_year = team['founded']
          c.stadium_name = team['venue']
          c.league = League.find_by(name: 'Premier League') # Предполагаем, что лига уже создана
        end

        puts "Импортирован клуб: #{club.name}"

        # Пример запроса для получения игроков конкретной команды
        team['squad'].each do |player_data|
          Player.find_or_create_by!(first_name: player_data['name'].split.first, last_name: player_data['name'].split.last) do |p|
            p.nationality = player_data['nationality']
            p.position = player_data['position']
            p.birth_date = player_data['dateOfBirth']
            p.club = club
          end
        end
        puts "Импортированы игроки для #{club.name}"
      end
    else
      puts "Ошибка при получении данных: #{response.code} - #{response.body}"
    end

    puts "Импорт завершен!"
  end
end