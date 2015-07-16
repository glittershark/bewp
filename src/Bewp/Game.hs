module Bewp.Game (GameState, makeGame, guy) where

import FRP.Helm
import Bewp.Guy

data GameState = GameState {guy :: GuyState}

makeGame :: Signal GameState
makeGame = GameState <~ guySignal
