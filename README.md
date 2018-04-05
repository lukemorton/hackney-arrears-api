# Hackney API for Arrears

At the moment this is an experience to test connecting with Universal Housing from Ruby.

More coming soon...

## Running the example

Firstly you need to install this library:

```
git clone https://github.com/lukemorton/hackney-arrears-api.git
cd hackney-arrears-api
bundle
```

Now get your `.env` file from Luke Morton <luke@madetech.com> and place in the root directory of this repo (next to this README.md you are reading).

You should now have a copy of the Hackney Arrears API ruby library on your local machine. You will also have installed the dependencies this library requires to function. Finally, you will have secret information in your .env file that the library will use to know how to communicate with Universal Housing.

You are now ready to run the example:

```
bundle exec ruby lib/hackney_api/arrears/test.rb
```

If you have any problems, speak to Luke Morton <luke@madetech.com>.
