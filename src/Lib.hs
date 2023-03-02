module Lib
    ( someFunc
    ) where
{-
-- EPITECH PROJECT, 2023
-- rush 1
-- File description:
-- it's gonna be sorted
-}

import System.Environment
import System.Exit
import Data.Char


someFunc :: IO ()
someFunc = putStrLn "someFunc"


data Conf = Conf {
    rule    :: Int,
    start   :: Int, -- devault 0
    lines   :: Int, -- devault never stop
    window  :: Int, -- devault 80
    move    :: Int -- if positive, move to the right, if negative, move to the left
}

-- defaultConf :: Conf
-- defaultConf = Conf {
--     rule = 0,
--     start = 0,
--     lines = 0,
--     window = 80,
--     move = 0
-- }

getOpts :: Conf -> [ String ] -> Maybe Conf
getOpts conf [] = Just conf

