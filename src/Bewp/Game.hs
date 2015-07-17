module Bewp.Game (GameState, makeGame, guy) where

import FRP.Helm
import qualified FRP.Helm.Keyboard as Keyboard
import FRP.Helm.Time
import Bewp.Guy

data GameState = GameState { guy :: GuyState }

data World = World
           {
           arrows :: (Int, Int),
           time :: Time
           }

makeGame :: (Int, Int) -> Signal GameState
makeGame win = GameState <~ guySignal win

world :: Signal World
world = lift2 World Keyboard.arrows $ fps 60
