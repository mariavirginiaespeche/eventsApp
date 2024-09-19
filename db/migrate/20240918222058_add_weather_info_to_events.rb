class AddWeatherInfoToEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :weather_info, :string
  end
end
