import Data.List.Split
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
stringToInt :: String -> (Int,Bool)
stringToInt s = do
  let mbs = readMaybe s
  case mbs of
    Just value -> (value, True)
    Nothing    -> (0, False)

calc_line :: [Int] -> [Int] -> Int -> Int
calc_line wins [] acc = acc
calc_line wins cards acc = do
  let win = foldr (\x y -> (x==(head cards)) || y) False wins
  let new_acc = case (acc,win) of
                    (_,False) -> acc
                    (0,True) -> 1
                    (acc,True) -> acc*2
  calc_line wins (tail cards) new_acc
   
  
proc_line :: String -> Int
proc_line line = do 
  let line_split = splitOn " " line
  let nums = map (\n -> stringToInt n) line_split
  let filt_nums = filter (\(n,m) -> m) nums
  let int_nums = map (\(n,m) -> n) filt_nums
  let win_nums = take 10 int_nums
  let card_nums = drop 10 int_nums
  calc_line win_nums card_nums 0

proc_lines :: [String] -> Int -> Int
proc_lines [] acc = acc
proc_lines x acc = do
  let hd = head x
  let tl = tail x
  let line_result = proc_line hd
  proc_lines tl (acc + line_result)

main :: IO ()
main = do
  contents <- readFile "input"
  let cont_lines = lines contents
  let winnings = proc_lines cont_lines 0 
  print (show winnings)
