class WorkerEventsController < ApplicationController
  def index
    @worker = Worker.find(params[:worker_id])
    @events = @worker.events # Asegúrate de que el modelo Worker tiene la relación
  end
end

