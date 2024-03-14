# Get Started

## Setup:

* Clone/download the repo
* Run `bundle install` to install the required gems. If install fails on mac/linux machine, please delete gemfile.lock and try again.
* Run following
```
rails db:create
rails db:migrate
rails db:seed
```

* Start server: `rails s`

## API endpoints

* **Retrieve Employees:** GET `http://localhost:3000/api/v1/employees`  
  This will retrieve all the Employees. User can also filter the employees by providing query params.
  E.g: `.../api/v1/employees?province=Quebec` will filter the result by showing only
  Quebec based employee.  
  Available filter params:
    * employee


* **Create Employee:** POST `http://localhost:3000/api/v1/employees`  
  Post request with body:
    * name - required field
    * image - image of the employee - optional field
    * target_amount - required field - amount to be raised
    * province - required field - province of the employee

* **Retrieve Funds:** GET `http://localhost:3000/api/v1/funds`  
  This will retrieve all the Funds. User can also filter the funds by providing query params.
  E.g: `.../api/v1/funds?employee_id=1` will filter the result by showing only
  funds collected by employee_id 1.  
  Available filter params:
  * employee_id

* **Create Fund:** POST `http://localhost:3000/api/v1/funds`  
  Post request with body:
  * donor_name - required field
  * phone_number - required field
  * donation_amount - required field
  * employee_id - required field - id of employee who is collecting this donation

After creating a fund, it will change the value of `percentage_raised` for the specific employee in employee table

* The apis are accessible through any REST client, e.g: Postman, Rapid API CURL commands on cli.  

## Tests - Rspec

* `rake db:prepare`
* Run all specs: `bundle exec rspec`
