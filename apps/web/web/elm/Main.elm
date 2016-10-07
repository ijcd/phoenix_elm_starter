module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (class)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Components.Article as Article
import Components.ArticleList as ArticleList
import Components.ArticleShow as ArticleShow


-- MODEL


type Page
    = RootView
    | ArticleListView
    | ArticleShowView Article.Model


type alias Model =
    { articleListModel : ArticleList.Model
    , currentView : Page
    }


initialModel : Model
initialModel =
    { articleListModel = ArticleList.initialModel
    , currentView = RootView
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = UpdateView Page
    | ArticleListMsg ArticleList.Msg
    | ArticleShowMsg ArticleShow.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ArticleListMsg articleMsg ->
            case articleMsg of
                ArticleList.RouteToNewPage page ->
                    case page of
                        ArticleList.ShowView article ->
                            ( { model | currentView = (ArticleShowView article) }, Cmd.none )

                        _ ->
                            ( model, Cmd.none )

                _ ->
                    let
                        ( updatedModel, cmd ) =
                            ArticleList.update articleMsg model.articleListModel
                    in
                        ( { model | articleListModel = updatedModel }, Cmd.map ArticleListMsg cmd )

        UpdateView page ->
            case page of
                ArticleListView ->
                    ( { model | currentView = page }, Cmd.map ArticleListMsg ArticleList.fetchArticles )

                _ ->
                    ( { model | currentView = page }, Cmd.none )

        ArticleShowMsg articleMsg ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "elm-app" ]
        [ header, pageView model ]


pageView : Model -> Html Msg
pageView model =
    case model.currentView of
        RootView ->
            welcomeView

        ArticleListView ->
            articleListView model

        ArticleShowView article ->
            articleShowView article


header : Html Msg
header =
    div []
        [ h1 [] [ text "Elm Articles" ]
        , ul []
            [ li [] [ a [ href "#", onClick (UpdateView RootView) ] [ text "Home" ] ]
            , li [] [ a [ href "#articles", onClick (UpdateView ArticleListView) ] [ text "Articles" ] ]
            ]
        ]


welcomeView : Html Msg
welcomeView =
    h2 [] [ text "Welcome to Elm Articles!" ]


articleListView : Model -> Html Msg
articleListView model =
    Html.App.map ArticleListMsg (ArticleList.view model.articleListModel)


articleShowView : Article.Model -> Html Msg
articleShowView article =
    Html.App.map ArticleShowMsg (ArticleShow.view article)



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
