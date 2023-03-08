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
-- import Data.Char

data Conf = Conf {
    rule     :: Int, --
    start    :: Int, -- devault 0
    thelines :: Int, -- devault never stop
    window   :: Int, -- devault 80
    move     :: Int -- if positive, move to the right, if negative, move to the left
}

defaultConf :: Conf
defaultConf = Conf {
    rule = (-1),
    start = 0,
    thelines = 0,
    window = 80,
    move = 0
}

showConf :: Maybe Conf -> IO ()
showConf (Just conf) =
    print (rule conf) >>
    print (start conf) >>
    print (thelines conf) >>
    print (window conf) >>
    print (move conf)

modifyConf :: Maybe Conf -> String -> Int -> Maybe Conf
modifyConf Nothing x y = modifyConf (Just defaultConf) x y
modifyConf (Just conf) "--rule" x = Just conf { rule = x }
modifyConf (Just conf) "--start" x = Just conf { start = x }
modifyConf (Just conf) "--lines" x = Just conf { thelines = x }
modifyConf (Just conf) "--window" x = Just conf { window = x }
modifyConf (Just conf) "--move" x = Just conf { move = x }
modifyConf _ _ _ = Nothing

fromArgsToConf :: [ String ] -> Maybe Conf -> IO (Maybe Conf)
fromArgsToConf [] Nothing = exitWith (ExitFailure 84)
fromArgsToConf x Nothing = fromArgsToConf x (Just defaultConf)
fromArgsToConf [] (Just conf) = return (Just conf)
fromArgsToConf (x:(y:ys)) (Just conf) =
    fromArgsToConf ys (modifyConf (Just conf) x (read y))
fromArgsToConf _ _ = exitWith (ExitFailure 84)

checkConf :: Maybe Conf -> IO ()
checkConf Nothing = exitWith (ExitFailure 84)
checkConf (Just conf) =
    if rule conf < 1 then exitWith (ExitFailure 84) else return ()


main :: IO ()
main = do
    y <- getArgs
    conf <- fromArgsToConf y Nothing
    checkConf conf
    showConf conf



-- fromArgsToConf ("-rule":xs) (Just conf) = case xs of
--     [] -> exitWith (ExitFailure 84)
--     (x:_) -> if isNumber (head x) then fromArgsToConf (tail xs) (Just (conf { rule = read x })) else exitWith (ExitFailure 84)
-- fromArgsToConf ("-start":xs) (Just conf) = case xs of
--     [] -> exitWith (ExitFailure 84)
--     (x:_) -> if isNumber (head x) then fromArgsToConf (tail xs) (Just (conf { start = read x })) else exitWith (ExitFailure 84)