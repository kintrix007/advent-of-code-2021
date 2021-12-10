import GHC.IO.FD (openFile)
import Data.List

main :: IO ()
main = do
    cont <- readFile "input"
    let xs = map (read :: String -> Int) . wordsBy (==',') $ cont
    print $ part1 xs
    print $ part1' xs
    print $ part2 xs

part1 :: [Int] -> Int
part1 xs =
    sum . map (abs . subtract medianInt) $ xs
    where medianInt = sort xs !! (length xs `div` 2)

-- part1, but bruteforce, cuz why not
part1' :: [Int] -> Int
part1' xs =
    idealValue
    where list = [(target, sum . map (\x -> abs $ x - target) $ xs) | target <- [1 .. maximum xs]]
          (idealTarget, idealValue) = minimumBy (\(_, a) (_, b) -> if a < b then LT else GT) list

part2 :: [Int] -> Int
part2 xs =
    idealValue
    where list = [(target, sum . map (\x -> sumLin 1 (abs $ x - target)) $ xs) | target <- [1 .. maximum xs]]
          (idealTarget, idealValue) = minimumBy (\(_, a) (_, b) -> if a < b then LT else GT) list


-- sum of arithmetic/linear sequence
sumLin :: Int -> Int -> Int
sumLin a' b' =
    round $ (a + b) * ((b - a + 1) / 2)
    where a = fromIntegral a'
          b = fromIntegral b'

wordsBy :: (Char -> Bool) -> String -> [String]
wordsBy p s = case dropWhile p s of
  [] -> []
  s' -> w:wordsBy p s''
        where (w, s'') = break p s'
