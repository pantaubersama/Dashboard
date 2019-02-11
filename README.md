# README
#### Dashboard module
##### Setup
- `git clone git@github.com:pantaubersama/Dashboard.git`
- setup ur database (postgresql)
- create env variable files (.env.development , .env.test)
    - `.env.development`
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=dashboard_development
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```

 - `.env.test` 
```
    BASE_URL="http://0.0.0.0:3000"
    
    # database master
    DATABASE_NAME=dashboard_test
    DATABASE_USERNAME=postgres
    DATABASE_PASSWORD=namakualam
    DATABASE_HOSTNAME= localhost
    DATABASE_PORT="5432"
    RAILS_MAX_THREADS="5"
```
   
- `$ bundle install`
- `$ yarn install`
- `$ rails db:create db:migrate`
- `$ rails s`
- go to [`http://localhost:3000`](http://localhost:3000)
