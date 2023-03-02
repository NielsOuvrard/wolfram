module Main (main) where

import Lib

import System.Environment
import System.Exit
import Data.Char

-- print :: Show a => a -> IO ()
-- print x = putStrLn (show x)

main :: IO ()
main = do
    -- x <- getLine
    y <- getArgs
    -- main = someFunc
    print y
    putStrLn "OK" >> exitWith (ExitSuccess)
