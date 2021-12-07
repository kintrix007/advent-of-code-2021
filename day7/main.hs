import GHC.IO.IOMode (IOMode(ReadMode))
import GHC.IO.FD (openFile)
import Data.List

main :: IO ()
main = do
    cont <- readFile "input"
    let list = map (read :: String -> Int) . wordsBy (==',') $ cont
    let len = length list
    let medianInt = sort list !! (len `div` 2)
    print $ sum . map (abs . subtract medianInt) $ list

wordsBy :: (Char -> Bool) -> String -> [String]
wordsBy p s = case dropWhile p s of
  [] -> []
  s' -> w:wordsBy p s''
        where (w, s'') = break p s'
