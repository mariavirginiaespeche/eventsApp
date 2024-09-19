require 'sendgrid-ruby'
include SendGrid

# Configura el cliente de SendGrid
SENDGRID_API_KEY = ENV['SENDGRID_API_KEY']

if SENDGRID_API_KEY.nil?
  raise "Por favor establece la variable de entorno SENDGRID_API_KEY"
end

# Método para obtener el cliente de SendGrid
def sendgrid_client
  @sendgrid_client ||= SendGrid::API.new(api_key: SENDGRID_API_KEY)
end

