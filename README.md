# NGX-P1backend

# Setting up your enviroment

## How to setup your database.yml file
    -go to config > database.yml
    -Paste this under development
    adapter: postgresql
    database: postgres
    username: {Role name}
    password: {Role password}
    host: localhost
    port: 5432
    timeout: 5000
    pool: 10

## How to create reimbursement Model and Database:
    -rails g model reimbursement status:string comment:string approval_date:timestamp
    -rails db:migrate

## How to create reimbursement controller:
    -rails g model reimbursement
