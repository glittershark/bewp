module Bewp.Guy (GuyState, guyPos, guySignal, guyForm) where

import FRP.Helm
import FRP.Helm.Color
import FRP.Helm.Keyboard

data GuyState = GuyState {gx :: Int, gy :: Int}

guyPos :: GuyState -> (Double, Double)
guyPos guy =
      (realToFrac . gx $ guy, realToFrac . gy $ guy)

guySignal :: Signal GuyState
guySignal = foldp newState initialState arrows
   where initialState = GuyState {gx = 0, gy = 0}
         newState :: (Int, Int) -> GuyState -> GuyState
         newState (x, y) state = state {gx = gx', gy = gy'}
            where gx' = gx state + x
                  gy' = gy state + y

guyForm :: GuyState -> Form
guyForm guy = move (guyPos guy) $ filled red $ square 64

