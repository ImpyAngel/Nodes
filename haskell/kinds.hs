omodule Kinds where
-- все базовые типы имеют kind * (Char, Int, [Int] , Either Int Char)
-- параметризованные типы имеют * -> * (Maybe, [], Either)
-- пары * -> * -> * как и стрелочки (->)

-- пусть будет:
eitherToMaybe :: Either a b -> Maybe a
eitherToMaybe (Left a) = Just a
eitherToMaybe (Right _) = Nothing

-- Параметризованные типы
data Coord a = Coord a a
-- одновременно и Сoord Int Int и Coord Double Double

-- Рекурсивные типы
data List a = Nil | Cons a (List a) deriving Show

yz = Cons 1 (Cons 2 Nil)

fromList :: List a -> [a]
fromList Nil = []
fromList (Cons a b) = a:(fromList b)

toList :: [a] -> List a
toList [] = Nil
toList (x:xs) = Cons x (toList xs)

-- натуральные числа
data Nat = Zero | Suc Nat deriving Show

fromNat :: Nat -> Integer
fromNat Zero = 0
fromNat (Suc n) = fromNat n + 1

myFromInteger :: Integer -> Nat
myFromInteger 0 = Zero
myFromInteger n = Suc (myFromInteger (n - 1))


operations :: (Integer -> Integer -> Integer) -> Nat -> Nat -> Nat
operations f a b = myFromInteger (f (fromNat a) (fromNat  b))

add :: Nat -> Nat -> Nat
add = operations (+)

mul :: Nat -> Nat -> Nat
mul = operations (*)

fac :: Nat -> Nat
fac Zero = Suc Zero
fac (Suc t) = (Suc t) `mul` (fac t)   

-- бинарные деревья почему-то только со значениями в листьях

data Tree a = Leaf a | Node (Tree a) (Tree a)

tree = Node (Leaf 1) (Node (Leaf 1) (Leaf 1))

height :: Tree a -> Int
height (Leaf a) = 0
height (Node a b) = max (height a) (height b) + 1

size :: Tree a -> Int
size (Leaf a) = 1
size (Node a b) = (size a) + (size b) + 1

avg :: Tree Int -> Int
avg t =
    let (c,s) = go t
    in s `div` c
  where
    go :: Tree Int -> (Int,Int)
    go (Leaf a) = (,) 1 a
    go (Node a b) =  plus (go a) (go b) where
    	plus:: (Int, Int) -> (Int, Int) -> (Int, Int)
    	plus (a1, b1) (a2, b2) = (a1 + a2, b1 + b2)
-- хочется применить функцию (+) к нашей паре, но пока я не знаю как

-- лол, в haskell можно делать бесконечные выражения 
-- еее вычисление значений

infixl 6 :+:
infixl 7 :*:
data Expr = Val Int | Expr :+: Expr | Expr :*: Expr
    deriving (Show, Eq)

eval :: Expr -> Int
eval (Val a) = a
eval (a :*: b) =  eval a * eval b
eval (a :+: b) =  eval a + eval b

-- надо додумать
expand :: Expr -> Expr

expand ((e1 :+: e2) :*: e) = expand e1 :*: expand e :+: expand e2 :*: expand e
expand (e :*: (e1 :+: e2)) = expand e1 :*: expand e :+: expand e2 :*: expand e
expand (e1 :+: e2) = expand e1 :+: expand e2
expand (e1 :*: e2) = expand e1 :*: expand e2
expand e = e