require 'sinatra'
require 'bcrypt'

# In-memory user store (for demonstration purposes only)
USERS = {
  'user@example.com' => BCrypt::Password.create('password123') # Password: password123
}

# Helper function to authenticate a user
def authenticate(email, password)
  USERS[email] && BCrypt::Password.new(USERS[email]) == password
end

# Route for the login form
get '/login' do
  <<-HTML
    <!DOCTYPE html>
    <html>
      <head>
        <title>Login Page</title>
      </head>
      <body>
        <h1>Login</h1>
        <form action="/login" method="post">
          <label for="email">Email:</label>
          <input type="text" name="email" id="email" required>
          <br>
          <label for="password">Password:</label>
          <input type="password" name="password" id="password" required>
          <br>
          <button type="submit">Log In</button>
        </form>
      </body>
    </html>
  HTML
end

# Route for processing login submissions
post '/login' do
  email = params[:email]
  password = params[:password]

  if authenticate(email, password)
    "Welcome, #{email}! You are now logged in."
  else
    "Invalid email or password. <a href='/login'>Try again</a>."
  end
end
