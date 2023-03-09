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
    thelines = -1,
    window = 80,
    move = 0
}

data Data = Data {
    binaryRule :: [ Int ],
    conf       :: Conf,
    line       :: String,
    nextLine   :: String,
    idx        :: Int,
    generation :: Int
}

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
checkConf (Just conf) =
    if rule conf > 255 then exitWith (ExitFailure 84) else return ()
checkConf (Just conf) =
    if start conf < 0 then exitWith (ExitFailure 84) else return ()
checkConf (Just conf) =
    if thelines conf < (-1) then exitWith (ExitFailure 84) else return ()
checkConf (Just conf) =
    if window conf < 1 then exitWith (ExitFailure 84) else return ()

fromJust :: Maybe Conf -> Conf
fromJust Nothing = defaultConf
fromJust (Just conf) = conf

decimalToBinary :: Int -> [ Int ]
decimalToBinary 0 = [ 0 ]
decimalToBinary 1 = [ 1 ]
decimalToBinary x = decimalToBinary (x `div` 2) ++ [ x `mod` 2 ]

decimalToByte :: Int -> [ Int ]
decimalToByte x = replicate (8 - length (decimalToBinary x)) 0 ++ decimalToBinary x


createData :: Conf -> Data
createData conf = Data {
    binaryRule = decimalToByte (rule conf),
    conf = conf,
    line = stringTostringPlus2 (createStringBeginning (window conf)),
    nextLine = replicate (window conf + 4) ' ',
    idx = 0,
    generation = 0
}

createStringBeginningEven :: Int -> String
createStringBeginningEven x = replicate ((x `div` 2) - 1) ' ' ++ replicate 1 '*' ++ replicate ((x `div` 2) - 1) ' '

createStringBeginningOdd :: Int -> String
createStringBeginningOdd x = replicate (x `div` 2) ' ' ++ replicate 1 '*' ++ replicate ((x `div` 2) - 1) ' '

createStringBeginning :: Int -> String
createStringBeginning x = if x `mod` 2 == 0 then createStringBeginningEven x else createStringBeginningOdd x


stringTostringPlus2 :: String -> String
stringTostringPlus2 x = "  " ++ x ++ "  "

createNextChar :: String -> String -> Int -> [ Int ] -> String
createNextChar line nextLine idx rule = (nextLine ++ [
         if (line !! idx == ' ' && line !! (idx + 1) == ' ' && line !! (idx + 2) == ' ') then if (rule !! 7 == 1) then '*' else ' '
    else if (line !! idx == ' ' && line !! (idx + 1) == ' ' && line !! (idx + 2) == '*') then if (rule !! 6 == 1) then '*' else ' '
    else if (line !! idx == ' ' && line !! (idx + 1) == '*' && line !! (idx + 2) == ' ') then if (rule !! 5 == 1) then '*' else ' '
    else if (line !! idx == ' ' && line !! (idx + 1) == '*' && line !! (idx + 2) == '*') then if (rule !! 4 == 1) then '*' else ' '
    else if (line !! idx == '*' && line !! (idx + 1) == ' ' && line !! (idx + 2) == ' ') then if (rule !! 3 == 1) then '*' else ' '
    else if (line !! idx == '*' && line !! (idx + 1) == ' ' && line !! (idx + 2) == '*') then if (rule !! 2 == 1) then '*' else ' '
    else if (line !! idx == '*' && line !! (idx + 1) == '*' && line !! (idx + 2) == ' ') then if (rule !! 1 == 1) then '*' else ' '
    else if (line !! idx == '*' && line !! (idx + 1) == '*' && line !! (idx + 2) == '*') then if (rule !! 0 == 1) then '*' else ' '
    else ' '
    ])

createNextLine :: String -> String -> Int -> [ Int ] -> String
createNextLine line nextLine idx binaryRule =
    if idx == length line - 2 then stringTostringPlus2 nextLine
    else createNextLine line (createNextChar line nextLine idx binaryRule) (idx + 1) binaryRule

-- conf
    -- rule     :: Int,
    -- start    :: Int,
    -- thelines :: Int,
    -- window   :: Int,
    -- move     :: Int

-- data
    -- binaryRule :: [ Int ],
    -- conf       :: Conf,
    -- line       :: String,
    -- nextLine   :: String,
    -- idx        :: Int,
    -- generation :: Int

putCenterStr :: String -> Int -> Int -> IO ()
putCenterStr x size y = if (length x) - (2 * size) == y then putChar '\n' >> return ()
    else putChar (x !! (size + y)) >> putCenterStr x size (y + 1)


wolframe :: Data -> IO ()
wolframe (Data binaryRule conf line nextLine idx generation) =
    if generation == thelines conf then
        exitWith (ExitSuccess)
    else
        do
        putCenterStr line generation 0
        wolframe (Data binaryRule conf (createNextLine line "" 0 binaryRule) "" 0 (generation + 1))

main :: IO ()
main = do
    y <- getArgs
    conf <- fromArgsToConf y Nothing
    checkConf conf
    wolframe (createData (fromJust conf))
