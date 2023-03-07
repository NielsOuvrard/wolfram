{-
-- EPITECH PROJECT, 2023
-- rush 1
-- File description:
-- it's gonna be sorted
-}
module Main (main) where

import Lib()

import System.Environment
import System.Exit
import Data.Char( isDigit )

-- print :: Show a => a -> IO ()
-- print x = putStrLn (show x)

data Conf = Conf {
    rule    :: Int, --
    start   :: Int, -- devault 0
    -- lines   :: Int, -- devault never stop
    window  :: Int, -- devault 80
    move    :: Int -- if positive, move to the right, if negative, move to the left
}

defaultConf :: Conf
defaultConf = Conf {
    rule = 0,
    start = 0,
    -- lines = 0,
    window = 80,
    move = 0
}

getOpts :: Conf -> [ String ] -> Maybe Conf
getOpts conf [] = Just conf
getOpts conf (x:xs) = case x of
    "-rule" -> getOpts (conf { rule = read (head xs) }) (tail xs)
    "-start" -> getOpts (conf { start = read (head xs) }) (tail xs)
    -- "-lines" -> getOpts (conf { lines = read (head xs) }) (tail xs)
    "-window" -> getOpts (conf { window = read (head xs) }) (tail xs)
    "-move" -> getOpts (conf { move = read (head xs) }) (tail xs)
    _ -> Nothing

showConf :: Conf -> IO ()
showConf conf = do
    print (rule conf)
    print (start conf)
    -- print (lines conf)
    print (window conf)
    print (move conf)


fromArgsToCompute :: [ String ] -> IO ()
fromArgsToCompute [] = putStrLn "OK" >> exitWith (ExitSuccess)
fromArgsToCompute (x:xs) = case x of
    "-rule" -> putStrLn "OK" >> exitWith (ExitSuccess)
    "-start" -> putStrLn "OK" >> exitWith (ExitSuccess)
    -- "-lines" -> putStrLn "OK" >> exitWith (ExitSuccess)
    "-window" -> putStrLn "OK" >> exitWith (ExitSuccess)
    "-move" -> putStrLn "OK" >> exitWith (ExitSuccess)
    _ -> putStrLn "OK" >> exitWith (ExitSuccess)

main :: IO ()
main = do
    y <- getArgs
    fromArgsToCompute y
    -- showConf Just (getOpts defaultConf y)
    -- main = someFunc
    -- print y
    putStrLn "OK" >> exitWith (ExitSuccess)

-- B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/app/Main.hs:1: MAJOR:H-G1 # B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/app/Main.hs has a badly formatted Epitech header
-- B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/src/Lib.hs:1: MAJOR:H-G1 # B-FUN-400-MAR-4-1-wolfram-niels.ouvrard/src/Lib.hs has a badly formatted Epitech header