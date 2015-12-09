# Constructeev 
[![Inline docs](http://inch-ci.org/github/bmalum/constructeev_Elixir.svg?branch=develop)](http://inch-ci.org/github/bmalum/constructeev_Elixir)
[![Build Status](https://travis-ci.org/bmalum/Constructeev_Elixir.svg?branch=develop)](https://travis-ci.org/bmalum/Constructeev_Elixir)

Minimum System Requirements:
	
	* 100MB RAM
	* Internet Connection
	* 500Mhz CPU (x64, x64, 64bit ARM, 32bit ARM, MIPS)

Prerequisites for self compiled and hosted Service: 

  * Prostgres or MySQL
  * Erlang 18
  * Elixir 1.1

To start the Constructeev Server in Development:

  1. Get the Frontend with `git submodule init && git submodule update
  2. Install dependencies with `mix deps.get`
  3. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  4. Start Phoenix endpoint with `mix phoenix.server`

To start the Constructeev Server in Production:

	1. Setup Development Server
	2. Create a prod.secret.exs File in config/ (example)
	3. Create an Elixir Release
		* Precompile the static Assets `MIX_ENV=prod mix phoenix.digest`
		* Compile the Release `MIX_ENV=prod mix release`
		* start the Release `rel/hello_phoenix/bin/constructeev start`
		* Do not forget to add it to you systemd, upstart or rc.conf 


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
