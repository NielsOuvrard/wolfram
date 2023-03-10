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

-- checkConf :: Conf -> IO ()
-- checkConf (Conf rule start thelines window move) = if rule < 1 then exitWith (ExitFailure 84) else return ()
-- checkConf (Conf rule start thelines window move) = if rule > 255 then exitWith (ExitFailure 84) else return ()
-- checkConf (Conf rule start thelines window move) = if start < 0 then exitWith (ExitFailure 84) else return ()
-- checkConf (Conf rule start thelines window move) = if thelines < (-1) then exitWith (ExitFailure 84) else return ()
-- checkConf (Conf rule start thelines window move) = if window < 1 then exitWith (ExitFailure 84) else return ()

checkConf :: Conf -> IO ()
checkConf (Conf rule start thelines window move)
  | rule < 1 || rule > 255 || start < 0 || thelines < (-1) || window < 1 =
    exitWith (ExitFailure 84)
  | otherwise = return ()

fromJust :: Maybe Conf -> Conf
fromJust Nothing = defaultConf
fromJust (Just conf) = conf

-- conf
    -- rule     :: Int,
    -- start    :: Int,
    -- thelines :: Int,
    -- window   :: Int,
    -- move     :: Int

checkConfNotNull :: Maybe Conf -> IO ()
checkConfNotNull Nothing = exitWith (ExitFailure 84)
checkConfNotNull (Just conf) = return ()

-- checkConf :: Conf -> IO ()
-- checkConf (Conf (rule < 1) start thelines window move) = exitWith (ExitFailure 84)
-- checkConf _ = return ()
    --      if rule < 1 then exitWith (ExitFailure 84)
    -- else if rule > 255 then exitWith (ExitFailure 84)
    -- else if start < 0 then exitWith (ExitFailure 84)
    -- else if thelines < (-1) then exitWith (ExitFailure 84)
    -- else if window < 1 then exitWith (ExitFailure 84)
    -- else return ()
decimalToBinary :: Int -> [ Int ]
decimalToBinary 0 = [ 0 ]
decimalToBinary 1 = [ 1 ]
decimalToBinary x = decimalToBinary (x `div` 2) ++ [ x `mod` 2 ]

decimalToByte :: Int -> [ Int ]
decimalToByte x = replicate (8 - length (decimalToBinary x))
    0 ++ decimalToBinary x


createData :: Conf -> Data
createData conf = Data {
    binaryRule = decimalToByte (rule conf),
    conf = conf,
    line = createStringBeginning (window conf),
    nextLine = replicate (window conf + 4) ' ',
    idx = 0,
    generation = 0
}

createStringBeginningEven :: Int -> String
createStringBeginningEven x = replicate ((x `div` 2) - 1) ' ' ++
    replicate 1 '*' ++ replicate ((x `div` 2) - 1) ' '

createStringBeginningOdd :: Int -> String
createStringBeginningOdd x = replicate (x `div` 2) ' ' ++ replicate 1
    '*' ++ replicate ((x `div` 2) - 1) ' '

createStringBeginning :: Int -> String
createStringBeginning x =
    if x `mod` 2 == 0 then createStringBeginningEven x
    else createStringBeginningOdd x


stringTostringPlus2 :: String -> String
stringTostringPlus2 x = "  " ++ x ++ "  "

createNextChar :: String -> String -> Int -> [Int] -> String
createNextChar line nextLine idx rule = nextLine ++
    [checkThis3Chars (take 3 (drop idx line)) rule]

checkThis3Chars :: String -> [ Int ] -> Char
checkThis3Chars "   " rule = if rule !! 7 == 1 then '*' else ' '
checkThis3Chars "  *" rule = if rule !! 6 == 1 then '*' else ' '
checkThis3Chars " * " rule = if rule !! 5 == 1 then '*' else ' '
checkThis3Chars " **" rule = if rule !! 4 == 1 then '*' else ' '
checkThis3Chars "*  " rule = if rule !! 3 == 1 then '*' else ' '
checkThis3Chars "* *" rule = if rule !! 2 == 1 then '*' else ' '
checkThis3Chars "** " rule = if rule !! 1 == 1 then '*' else ' '
checkThis3Chars "***" rule = if rule !! 0 == 1 then '*' else ' '
checkThis3Chars _ _ = ' '

createNextLine :: String -> String -> Int -> [ Int ] -> String
createNextLine line nextLine idx binaryRule =
    if idx == length line - 2 then stringTostringPlus2 nextLine
    else createNextLine line (createNextChar line nextLine idx binaryRule)
    (idx + 1) binaryRule

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
putCenterStr x size y =
    if (length x) - (2 * size) == y then putChar '\n' >> return ()
    else putChar (x !! (size + y)) >> putCenterStr x size (y + 1)


wolframe :: Data -> IO ()
wolframe (Data binaryRule conf line nextLine idx generation) =
    if generation == thelines conf then
        exitWith (ExitSuccess)
    else putCenterStr line generation 0 >>
        wolframe (Data binaryRule conf
        (createNextLine line "" 0 binaryRule) "" 0 (generation + 1))

main :: IO ()
main = do
    y <- getArgs
    conf <- fromArgsToConf y Nothing
    checkConfNotNull conf
    checkConf (fromJust conf)
    wolframe (createData (fromJust conf))
