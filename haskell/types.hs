module Demo where

data Pers = You | Me deriving (Show, Eq, Read, Enum)
-- необходимо писать тип и конструкторы с большой объектов
-- у нас нет написание для You и Me каких-то методов, 
-- надо бы наследоваться от Show
alwaysMe :: Int -> Pers
alwaysMe n = Me

falses :: Bool
falses = Me == You

not' :: Pers -> Pers
not' You = Me
-- хреновая реализация, типа если кидать Me, это будет эксепшн, 
-- не знаю почему ничего GHCi не говорит, наверное стоит врубить ворнинги
-- Кстати, это называется сопоставление с образцом

data Color = Red | Green | Blue deriving Eq

shoow :: Color -> String
shoow x | x == Red = "Red"
	   | x == Green = "Green"
	   | otherwise = "Blue" 
-- Ну я просто решил напомнить как писать охранные выражение (otherwise не обязательно писать)
-- Забавно, нельзя было писать просто show, но GHCi модуль подгрузил все равно
-- Он странный
instance Show Color where
    show Red = "Red"
    show Blue = "Blue"
    show _ = "Green"
-- Вот метод, как нормально добавить к нашим Color метод show
-- _ - символ Джокер

-- Def частичная функция, это та функция, которая определена на некоторых значениях

-- Семантика сопоставления с образцом: идем с лево направо и если не зашло на данном этапе, идем дальше
-- MB у нас есть важность порядка параметров  
foo 1 2 = 3
foo 2 _ = 5

-- сопоставление с образцом справа с помощью case of 

data LogLevel = Error | Warning | Info deriving Eq

cmp :: LogLevel -> LogLevel -> Ordering

cmp x y = if (x == y) 
			then EQ 
			else case (x,y) of
					(Error, _) -> GT
					(Info, _) -> LT
					(_, Error) -> LT
					(_, Info) -> GT

-- или реализация если у нас нет deriving Eq

cmp2 :: LogLevel -> LogLevel -> Ordering
cmp2 x y = if (lg x > lg y) 
            then GT
            else 
                if (lg x == lg y)
                   then EQ
                   else LT 
        where
        lg Error = 2
        lg Warning = 1
        lg Info = 0
-- Типы - произведения (ну как декартово)
data Point = Point Double Double deriving Show
-- Наш Pt - конструктор имеет тип Double -> Double -> Point

origin :: Point
origin = Point 0.0 0.0

distanceToOrigin :: Point -> Double
distanceToOrigin (Point x y) = sqrt (x ^ 2 + y ^ 2)

distance :: Point -> Point -> Double
distance (Point x1 y1) (Point x2 y2) = sqrt ((x1 - x2) ^ 2 + (y1 - y2) ^ 2)

-- разные конструкторы 
data Shape = Circle Double | Rectangle Double Double

area :: Shape -> Double
area (Circle x) = pi * x ^ 2
area (Rectangle x y) = x * y

-- еее длиннка

data Bit = Zero | One
data Sign = Minus | Plus
data Z = Z Sign [Bit]

add :: Z -> Z -> Z
add (Z sig bits)

mul :: Z -> Z -> Z
mul = undefined	