module Main where

import FRP.Helm
import FRP.Helm.Signal (constant)
import FRP.Helm.Color
import qualified FRP.Helm.Window as Window
import FRP.Elerea.Simple hiding (Signal)
import Bewp.Game
import Bewp.Guy

render :: GameState -> (Int, Int) -> Element
render game (w, h) = collage w h [guyForm (guy game) (w, h)]

main :: IO ()
main = let config = defaultConfig {windowTitle = "Bewp"}
           dimensions = windowDimensions config in do
              run config $ render <~ makeGame dimensions
                                  ~~ Window.dimensions
