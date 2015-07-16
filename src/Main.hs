module Main where

import FRP.Helm
import FRP.Helm.Signal (constant)
import FRP.Helm.Keyboard
import FRP.Helm.Color
import qualified FRP.Helm.Window as Window
import FRP.Elerea.Simple hiding (Signal)

data GuyState = GuyState {gx :: Int, gy :: Int}

guyPos :: GuyState -> (Double, Double)
guyPos guy =
      (realToFrac . gx $ guy, realToFrac . gy $ guy)

guySignal :: Signal GuyState
guySignal = foldp newState initialState wasd
   where initialState = GuyState {gx = 0, gy = 0}
         newState :: (Int, Int) -> GuyState -> GuyState
         newState (x, y) state = state {gx = gx', gy = gy'}
            where gx' = gx state + x
                  gy' = gy state + y

render :: GuyState -> (Int, Int) -> Element
render guy (w, h) =
      collage w h [move (guyPos guy) $ filled red $ square 64]

main :: IO ()
main =
      let config = defaultConfig {windowTitle = "Bewp"}
          dimensions = windowDimensions config in do
             run config $ render <~ guySignal ~~ constant dimensions
