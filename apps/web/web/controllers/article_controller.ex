defmodule Web.ArticleController do
  use Web.Web, :controller

  def index(conn, _params) do
    json conn, %{
      data:
      [ %{ title: "Article Title1", url: "Article URL1", posted_by: "Author1", posted_on: "Timestamp1" },
        %{ title: "Article Title2", url: "Article URL2", posted_by: "Author2", posted_on: "Timestamp2" },
        %{ title: "Article Title3", url: "Article URL3", posted_by: "Author3", posted_on: "Timestamp3" }
      ]
    }
  end
end
