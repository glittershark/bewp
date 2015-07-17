module Bewp.Game (GameState, makeGame, guy) where

import FRP.Helm
import Bewp.Guy

data GameState = GameState { guy :: GuyState }

makeGame :: (Int, Int) -> Signal GameState
makeGame win = GameState <~ guySignal win
