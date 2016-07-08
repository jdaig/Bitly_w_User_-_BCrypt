#enable :sessions

before '/secret' do
  if session[:name]
    @message_name = session[:name]
    erb :secret
  else
    erb :index
  end
end

post '/register' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  @user_name = params[:Usuario]
  # p @user_name
  @user_mail = params[:Mail]
  # p @user_mail
  @user_pass = params[:Contraseña]
  # p @user_pass

  User.create(usuario: @user_name, mail: @user_mail, password: @user_pass)
  @bulean = true
  erb :principal
end

post '/login' do
  
  email = params[:Mail]
  password = params[:Contraseña]
#buscar si existe el usuario
  val_user = User.authenticate(email, password)
#   if user == nil
#     @error_message = "Usuario Inválido"
#     erb :index
#   else
# #obtener id y email para crear sesión
#     session[:name] = user.name
    
#     redirect to '/secret'
#   end
  if val_user
    session[:id] = val_user.id
    session[:email] = val_user.mail
    session[:user_name] = val_user.usuario
    redirect to '/secret' 
  else
    session[:error_message] = "No son correctos tus datos"
    redirect to '/join'
  end
end

get '/secret' do
  erb :secret
end

get '/logout' do
  session.clear
  @bulean2 = true
  erb :principal
end

get '/send' do
  session[:send] = @send
end
