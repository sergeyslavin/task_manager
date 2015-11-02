# Task Manager


### Add role to user

```ruby
rake manager:add_role email=test@test.com role=admin
```


### Rest accesss to application

*Some Example:*

*Sign In:* `curl -X POST -H "Accept: application/json" --data 'user[email]=example@mail.com&user[password]=password' localhost:3000/users/sign_in`


*Sign Out:* `curl -X DELETE -H "Accept: application/json" --data 'user_email=example@mail.com&user_token=token' localhost:3000/users/sign_out`


*Get Items:* `curl -X GET -H "Accept: application/json" --data 'user_email=example@mail.com&user_token=token' localhost:3000/items`


---

Slavin Sergey (c) 2015