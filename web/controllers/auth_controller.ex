defmodule Bandstock.AuthController do
	use Bandstock.Web, :controller
	plug Ueberauth

	alias Bandstock.User

	def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
		user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"} #TODO change to provider from params

		changeset = User.changeset(%User{}, user_params)

		signin(conn, changeset)
	end

	def signout(conn, _params) do
		conn
		|> configure_session(drop: true)
		|> redirect(to: homepath(conn))
	end

	defp homepath(conn) do
		sheet_path(conn, :index)
	end

	defp signin(conn, changeset) do
		case insert_or_update_user(changeset) do
			{:ok, user} ->
				conn
				|> put_flash(:info, "Welcome back!")
				|> put_session(:user_id, user.id)
				|> redirect(to: homepath(conn)) #TODO send them to where they were before they tried to log in
			{:error, _reason} ->
				conn
				|> put_flash(:error, "Error signing in")
				|> redirect(to: homepath(conn)) #TODO send themto where they were before they tried
		end
	end

	defp insert_or_update_user(changeset) do
		case Repo.get_by(User, email: changeset.changes.email) do
			nil ->
				Repo.insert(changeset)
			user ->
				{:ok, user}
		end
	end
end