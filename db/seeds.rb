# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Очистка базы данных для избежания дубликатов
Player.destroy_all
Club.destroy_all
League.destroy_all

# Создание лиг
premier_league = League.create!(name: 'Premier League', country: 'England')
laliga = League.create!(name: 'La Liga', country: 'Spain')

# Создание клубов и их привязка к лигам
manchester_city = Club.create!(name: 'Manchester City', city: 'Manchester', country: 'England', founded_year: 1880, stadium_name: 'Etihad Stadium', league: premier_league)
real_madrid = Club.create!(name: 'Real Madrid', city: 'Madrid', country: 'Spain', founded_year: 1902, stadium_name: 'Santiago Bernabéu', league: laliga)

# Создание игроков и их привязка к клубам
Player.create!(first_name: 'Erling', last_name: 'Haaland', nationality: 'Norway', birth_date: '2000-07-21', position: 'Forward', club: manchester_city)
Player.create!(first_name: 'Kevin', last_name: 'De Bruyne', nationality: 'Belgium', birth_date: '1991-06-28', position: 'Midfielder', club: manchester_city)
Player.create!(first_name: 'Kylian', last_name: 'Mbappé', nationality: 'France', birth_date: '1998-12-20', position: 'Forward', club: real_madrid)
