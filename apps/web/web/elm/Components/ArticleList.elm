module Components.ArticleList exposing (..)

import Http
import Task
import Json.Decode as Json exposing ((:=))
import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Components.Article as Article exposing (..)


type alias Model =
    { articles : List Article.Model }


type SubPage
    = ListView
    | ShowView Article.Model


type Msg
    = NoOp
    | Fetch
    | FetchSucceed (List Article.Model)
    | FetchFail Http.Error
    | RouteToNewPage SubPage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Fetch ->
            ( model, fetchArticles )

        FetchSucceed articleList ->
            ( Model articleList, Cmd.none )

        FetchFail error ->
            case error of
                Http.UnexpectedPayload errorMessage ->
                    Debug.log errorMessage
                        ( model, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


articles : Model
articles =
    { articles =
        [ { title = "Article 1", url = "http://google.com", postedBy = "Author", postedOn = "06/20/16" }
        , { title = "Article 2", url = "http://google.com", postedBy = "Author 2", postedOn = "06/20/16" }
        , { title = "Article 3", url = "http://google.com", postedBy = "Author 3", postedOn = "06/20/16" }
        ]
    }


renderArticle : Article.Model -> Html Msg
renderArticle article =
    li []
        [ div [] [ Article.view article, articleLink article ]
        ]


renderArticles : Model -> List (Html Msg)
renderArticles articles =
    List.map renderArticle articles.articles


initialModel : Model
initialModel =
    { articles = [] }



-- View


view : Model -> Html Msg
view model =
    div [ class "article-list" ]
        [ h2 [] [ text "Article List" ]
        , button [ onClick Fetch, class "btn btn-primary" ] [ text "Fetch Articles" ]
        , ul [] (renderArticles model)
        ]


articleLink : Article.Model -> Html Msg
articleLink article =
    a
        [ href ("#article/" ++ article.title ++ "/show")
        , onClick (RouteToNewPage (ShowView article))
        ]
        [ text " (Show)" ]



-- HTTP calls


fetchArticles : Cmd Msg
fetchArticles =
    let
        url =
            "/api/articles"
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeArticleFetch url)



-- Fetch the articles out of the "data" key


decodeArticleFetch : Json.Decoder (List Article.Model)
decodeArticleFetch =
    Json.at [ "data" ] decodeArticleList



-- Then decode the "data" key into a List of Article.Models


decodeArticleList : Json.Decoder (List Article.Model)
decodeArticleList =
    Json.list decodeArticleData



-- Finally, build the decoder for each individual Article.Model


decodeArticleData : Json.Decoder Article.Model
decodeArticleData =
    Json.object4 Article.Model
        ("title" := Json.string)
        ("url" := Json.string)
        ("posted_by" := Json.string)
        ("posted_on" := Json.string)
