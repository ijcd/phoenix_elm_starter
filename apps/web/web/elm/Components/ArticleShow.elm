module Components.ArticleShow exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Components.Article as Article exposing (..)


type Msg
    = NoOp


view : Article.Model -> Html a
view model =
    div []
        [ h3 [] [ text model.title ]
        , a [ href model.url ] [ text ("URL: " ++ model.url) ]
        , br [] []
        , span [] [ text ("Posted by: " ++ model.postedBy ++ " On: " ++ model.postedOn) ]
        ]
