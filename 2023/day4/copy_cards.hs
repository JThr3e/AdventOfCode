import Data.List.Split
import Text.Read (readMaybe)
import Data.Maybe (fromMaybe)
import Debug.Trace

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
                    (acc,True) -> acc+1
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

gen_next_card_lines :: [String] -> [[String]] -> Int -> [[String]]
gen_next_card_lines cards next_cards_acc 0 = next_cards_acc
gen_next_card_lines cards next_cards_acc idx = do
  let next_card_list = trace ("drop " ++ show idx) (drop idx cards)
  let new_acc = trace ("next_card_list len: " ++ show (length next_card_list)) ((:) next_card_list next_cards_acc)
  let new_acc_t = trace ("new_acc len: " ++ show (length new_acc)) new_acc
  gen_next_card_lines cards new_acc_t (idx-1)

proc_lines_rec :: [String] -> Int -> Int -> Int
proc_lines_rec [] acc depth = acc
proc_lines_rec x acc depth = do
  let hd = trace ("proc_lines_rec invoked: LEN x = " ++ show (length x) ++ ", acc = " ++ show acc ++ ", depth = " ++ show depth) (head x)
  let tl = trace ("len tail: " ++ show (length (tail x))) tail x
  let line_result = proc_line hd
  let next_cards = (take line_result tl)
  let next_card_lists = gen_next_card_lines x [] line_result
  let num_cards_won = trace ("len next cards: " ++ show(length next_cards) ++ ", len next card list: " ++ show (length next_card_lists)) length next_cards
  let num_next_cards_won_lst = map (\card_list -> (proc_lines_rec (trace ("LEN CARD LIST: " ++ show (length card_list)) card_list) 0 (depth+1))) next_card_lists
  let num_next_cards_won = (sum num_next_cards_won_lst) + num_cards_won
  let new_acc = trace ("acc = " ++ show (length tl)) (acc + num_next_cards_won)
  new_acc

proc_lines :: [String] -> Int -> Int
proc_lines [] acc = acc
proc_lines x acc = do
  let hd = trace ("proc_lines invoked") (head x)
  let tl = tail x
  let line_result = proc_line hd
  let next_cards = take line_result tl
  let next_card_lists = gen_next_card_lines x [] line_result
  let num_cards_won = length next_cards
  let num_next_cards_won = foldr (\card_list next_acc -> (proc_lines_rec card_list 0 0) + next_acc) num_cards_won next_card_lists
  let new_acc = trace ("acc = " ++ show (length tl)) (acc + num_next_cards_won + 1) 
  proc_lines tl new_acc


  --num_cards_won + num_next_cards_won

main :: IO ()
main = do
  contents <- readFile "input"
  let cont_lines = lines contents
  let winnings = proc_lines cont_lines 0 
  print (show winnings)
