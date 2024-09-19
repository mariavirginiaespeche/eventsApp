# require 'httparty'

# class EventsController < ApplicationController
#   def index
#     @events = Event.all
#   end

#   def new
#     @event = Event.new
#     @workers = Worker.all
#   end

#   def create
#     @event = Event.new(event_params)

#     if @event.save
#       # Consultar el clima usando el servicio
#       weather_service = WeatherService.new
#       weather_response = weather_service.get_weather(@event.location) if @event.location.present?

#       if weather_response.success?
#         @event.weather_info = weather_response['weather'].first['description']
#       else
#         @event.weather_info = 'Información del clima no disponible'
#       end

#       @event.save

#       # Enviar correo usando el servicio
#       @workers = Worker.all # Asegúrate de cargar a los trabajadores
#       @workers.each do |worker|
#         SendEmailService.send_event_created_email(worker, @event)
#       end

#       redirect_to events_path, notice: 'Evento creado exitosamente.'
#     else
#       render :new
#     end
#   end

#   private

#   def event_params
#     params.require(:event).permit(:title, :description, :start_time, :end_time, :location, :worker_id)
#   end
# end
class EventsController < ApplicationController
  def index
     @events = Event.order(start_time: :asc)
  end

  def new
    @event = Event.new
    @workers = Worker.all
  end

  def create
    @event = Event.new(event_params)

    # Si se selecciona "Ninguno", establecer worker_id como nil
    if params[:event][:worker_id].blank?
      @event.worker_id = nil
    end

    if @event.save
      # Consultar el clima usando el servicio
      weather_service = WeatherService.new(ENV['OPENWEATHER_API_KEY']) # Asegúrate de pasar la API key
      weather_response = weather_service.get_weather(@event.location) if @event.location.present?

      if weather_response.success?
        @event.weather_info = weather_response['weather'].first['description']
      else
        @event.weather_info = 'Información del clima no disponible'
      end

      @event.save

      # Enviar correo usando el servicio
      @workers = Worker.all
      @workers.each do |worker|
        SendEmailService.send_event_created_email(worker, @event)
      end

      redirect_to events_path, notice: 'Evento creado exitosamente.'
    else
      render :new
    end
  end

  def fetch_weather
    weather_service = WeatherService.new(ENV['OPENWEATHER_API_KEY'])
    weather_response = weather_service.get_weather(params[:location])

    if weather_response.success?
      render json: { success: true, weather: weather_response['weather'].first['description'] }
    else
      render json: { success: false, message: 'Información del clima no disponible' }
    end
  end

  # Método para eliminar el evento
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'Evento eliminado exitosamente.'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :location, :worker_id)
  end
end
