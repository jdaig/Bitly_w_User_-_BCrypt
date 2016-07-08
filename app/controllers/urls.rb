get '/send_url' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
   # Deja a los usuarios crear una URL reducida y despliega una lista de URLs. 
  erb :bitly_page
end

get '/correcto' do
  if logged_in?
    user_logged = current_user 
    @message = session[:message]
    @url_all = Url.where(user_id: user_logged.id) #current_user.urls
    p @url_all
    erb :new_url  


  else
    @message = session[:message]
    @url_all = Url.where(user_id: nil)
    p @url_all
    erb :new_url
  end
end


post '/send' do
  @new_url = params[:user_input]
  @validar = Url.new(user_id: session[:id] ,url_anterior: @new_url, click_count: 0)
  # @validar.save

  if @validar.save
    session[:message] = "Register saved" 
  else
    session[:message] = "Error register don't saved" 
  end

  redirect to ('/correcto')
end

# e.g., /q6bda
get '/send_url/:short_url' do
  # redirige a la URL original
 # @url_visitated
 user_input = params[:short_url]
 u = Url.find_by(url_nueva: user_input)
 u.update(click_count: u.click_count + 1)
  if u.url_anterior.include?('http')
    redirect to ("#{u.url_anterior}")
  else
    redirect to ("http://#{u.url_anterior}")
  end

end