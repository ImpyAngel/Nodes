module Demo where
-- есть всякие filter
import Data.Char 
import Data.List
-- takeWhile берет пока работает предикат

-- dropWhile выкидывает пока работает предикат
readDigits :: String -> (String, String)
readDigits s = (takeWhile isDigit s, dropWhile isDigit s)

filterDisj :: (a -> Bool) -> (a -> Bool) -> [a] -> [a]
filterDisj f1 f2 =  filter (\x -> f1 x || f2 x)

-- еее qsort
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort(filter (< x) xs) ++ filter (== x) xs ++ [x] ++ qsort(filter (> x) xs) 

-- map не имеет ничего необычного кроме того, что у нас может измениться тип 
-- map f (x:xs) = f x : map f xs
-- concat - просто ++ списка списков
--squares'n'cubes :: Num a => [a] -> [a]
--squares'n'cubes = concatMap (\x -> [x ^ 2, x ^ 3])

perms :: [a] -> [[a]]
perms (h:hs) = func [h] hs where
	func :: [a1] -> [a1] -> [[a1]] 
	func e [] = [e]
	func e (h:hs) = (e ++ [h] ++ hs) : (func ([h] ++ e) hs)   
