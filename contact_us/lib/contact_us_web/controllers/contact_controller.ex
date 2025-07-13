defmodule ContactUsWeb.ContactController do
  use ContactUsWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def create(conn, %{"contact" => _contact_params}) do
    conn
    |> put_flash(:info, "Thank you for your message! We'll get back to you soon.")
    |> redirect(to: ~p"/contact")
  end
end