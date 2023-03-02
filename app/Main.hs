{-
-- EPITECH PROJECT, 2023
-- rush 1
-- File description:
-- it's gonna be sorted
-}
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

-- B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/app/Main.hs:1: MAJOR:H-G1 # B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/app/Main.hs has a badly formatted Epitech header
-- B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/src/Lib.hs:1: MAJOR:H-G1 # B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/src/Lib.hs has a badly formatted Epitech header