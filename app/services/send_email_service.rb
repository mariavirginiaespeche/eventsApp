class SendEmailService
  def self.send_event_created_email(worker, event)
    from = Email.new(email: 'virginia.espechekaram@gmail.com') # Cambia por tu email
    to = Email.new(email: worker.email)
    subject = 'Nuevo Evento Creado'
    content = Content.new(type: 'text/plain', value: <<~TEXT)
      Se ha creado un nuevo evento:
      Título: #{event.title}
      Fecha y hora: #{event.start_time}
      Ubicación: #{event.location}
      Clima: #{event.weather_info}
    TEXT

    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    Rails.logger.info(response.body) # Aquí es donde quieres ver la respuesta

    response.status_code
  rescue StandardError => e
    Rails.logger.error("Error al enviar correo: #{e.message}")
    nil
  end
end
