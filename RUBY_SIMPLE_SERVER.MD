

créer un fichier simple-server.rb dans un repertoire: ~/app

```
require 'sinatra'
get '/ping' do
  'pong'
end
get '/' do
  'Hello world !'
end

```

Puis lancer l'image docker ruby-sinatra:

```
sudo docker run --name frank -v /home/[moi]/app:/usr/src/app -p 80:80 -e MAIN_APP_FILE=simple-server.rb -d erikap/ruby-sinatra
```
