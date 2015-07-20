module Bewp.Guy (GuyState, guyPos, guySignal, guyForm) where

import FRP.Helm
import FRP.Helm.Color
import FRP.Helm.Keyboard
import FRP.Helm.Time
import Bewp.World

data GuyState = GuyState {
              gx :: Double,
              gy :: Double,
              speedy :: Double }

moveSpeed :: Double
moveSpeed = 3

jumpSpeed :: Double
jumpSpeed = 15

gravity :: Double
gravity = 0.8

initialState :: (Int, Int) -> GuyState
initialState (w, h) = GuyState { gx = 0,
                                 gy = 0,
                                 speedy = 0 }

guyPos :: GuyState -> (Double, Double)
guyPos guy = (gx guy, gy guy)

onFloor :: GuyState -> Bool
onFloor state = gy state <= 0

updateGuy :: World -> GuyState -> GuyState
updateGuy (World (ax, ay) _) state = state { gx = gx',
                                             gy = gy',
                                             speedy = speedy' }
   where gx' = gx state + (realToFrac ax * moveSpeed)
         jump = ay == -1 && onFloor state
         speedy' = if jump
                       then jumpSpeed
                       else speedy state - gravity
         gy' = if jump || not (onFloor state)
                  then gy state + speedy'
                  else 0

guySignal :: (Int, Int) -> Signal GuyState
guySignal win = foldp updateGuy (initialState win) world

guySize :: (Double, Double)
guySize = (64, 64)

guyForm :: GuyState -> (Int, Int) -> Form
guyForm guy (w, h) =
      let (x, y) = guyPos guy
          realx = x
          realh = realToFrac h - y - ((/2) . fst $ guySize) in
             move (realx, realh) $ filled red $ square 64

