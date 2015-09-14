class GiveTeamAShortName < ActiveRecord::Migration
  def change
    add_column :teams, :short_name, :string
    Team.reset_column_information

    {"England" => "ENG",
      "Fiji" => "FJI",
      "Tonga" => "TON",
      "Georgia" => "GEO",
      "Ireland" => "IRE",
      "Canada" => "CAN",
      "South Africa" => "ZAF",
      "Japan" => "JAP",
      "France" => "FRA",
      "Italy" => "ITA",
      "Samoa" => "SAM",
      "USA" => "USA",
      "Wales" => "WAL",
      "Uruguay" => "URY",
      "New Zealand" => "NZL",
      "Argentina" => "ARG",
      "Scotland" => "SCO",
      "Australia" => "AUS",
      "Romania" => "ROM",
      "Namibia" => "NAM",
      "Russia" => "RUS",
    }.each do |name, short_name|
      Team.find_by(name: name).update_attributes!(short_name: short_name)
    end
  end
end
