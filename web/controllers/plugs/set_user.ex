defmodule Bandstock.Plugs.SetUser do
	import Plug.Conn
	import Phoenix.Controller


	alias Bandstock.Repo
	alias Bandstock.User
	alias Bandstock.Router.Helpers

	def init(_params) do
		
	end

	def call(conn, _params) do
		user_id = get_session(conn, :user_id)

		cond do
			user = user_id && Repo.get(User, user_id) ->    #assigns User to user var, and if Repo.get returns, then && is truth so this line executes
				assign(conn, :user, user) #conn.assigns.user
			true ->
				assign(conn, :user, nil)
		end
	end
end