require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'form_data.html.erb')
server.mount('/input_database.cgi', WEBrick::HTTPServlet::CGIHandler, 'input_database.rb')
server.mount('/show_result.cgi', WEBrick::HTTPServlet::ERBHandler, 'show_result.html.erb')
server.start