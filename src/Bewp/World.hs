module Bewp.World (
                  World(World),
                  world
                  ) where

import FRP.Helm
import qualified FRP.Helm.Keyboard as Keyboard
import FRP.Helm.Time

data World = World {
           arrows :: (Int, Int),
           time :: Time,
           lshift :: Bool
           }

world :: Signal World
world = lift3 World Keyboard.arrows $ fps 60
                                    $ Keyboard.isDown Keyboard.LeftShiftKey
