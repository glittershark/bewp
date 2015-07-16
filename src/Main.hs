module Main where

import FRP.Helm
import qualified FRP.Helm.Window as Window

newtype Point = (Int, Int)
                deriving (Eq, Ord, Read, Show)

render :: Point -> Element
render (w, h) = collage w h [move (100, 100) $ filled red $ square 64]

main :: IO ()
main = do
        engine <- startup defaultConfig
        run engine $ render <~ Window.dimensions engine
