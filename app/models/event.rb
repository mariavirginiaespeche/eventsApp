class Event < ApplicationRecord
    belongs_to :worker, optional: true # Permite que worker_id sea nil
  
    validates :title, presence: true
    validates :start_time, presence: true
    validates :end_time, presence: true
    validates :location, presence: true
  end
  
