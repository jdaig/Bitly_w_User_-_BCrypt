before '/secret' do
  if session[:email]
    erb :secret
  else
    redirect to '/logout'
  end
end

get '/' do 
  session.clear #limpia la secion en caso de que entre un foraneo en una computadora que fue utilizada por un usuario
  erb :principal #llama al env ruby de html de la pagina principal
end

get '/join_us' do
  erb :register_erb #llama al env ruby de html de la pagina con el formulario de registro
end

get '/join' do
  erb :login_erb #llama al env ruby de html de la pagina con el formulario de inicio de sesion
end