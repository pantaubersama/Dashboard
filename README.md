# README
####sorry no doc, need help call me at `namakukingkong@gmail.com`
#####Setup
- git clone git@github.com:namakukingkong/whale_hunter.git
- cd whale_hunter
- rails g rename:into <new_name>
- cd ../<new_name>
- setup ur database (postgresql)
- create env variable files (.env.development , .env.test)
    - .env.development 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=whale_hunter_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
```

 - .env.test 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=whale_hunter_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5433"
    RAILS_MAX_THREADS="5"
```
   
- $ bundle install
- $ rails db:create db:migrate
- $ rails s
- new console tab $ bundle exec guard
- go to `http://localhost:3000`

#####What do you get
- npm
- vuejs
- postgres using uuid
- respec (factory_bot, shulda_matcher,faker)
- etc