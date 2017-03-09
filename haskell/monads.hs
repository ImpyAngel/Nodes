module Monads where
-- интерфейс Functor (класс типов)

--import Prelude hiding (Functor, fmap)

import Data.Functor
class Functor' f where
	fmap' :: (a -> b) -> f a -> f b

instance Functor' [] where
	fmap' = map

instance Functor' Maybe where
 	fmap' _ Nothing = Nothing
 	fmap' f (Just a) = Just (f a)

data Point3D a = Point3D a a a deriving Show

instance Functor Point3D where
 	fmap f (Point3D x y z) = Point3D (f x) (f y) (f z)   

-- существует прикольный оператор <$> который аналогичен `fmap`
-- infixl 4 <$>
-- есть еще оператор <$
-- он просто берет и затирает все значения новым значением
-- главная суть - не изменять контейнер 

-- почему-то ругается на <$>
-- понятно почему, нужно импортить Data.Functor

data Tree a = Leaf (Maybe a) | Branch (Tree a) (Maybe a) (Tree a) 
	deriving Show
instance Functor Tree where
	fmap f (Leaf a) = Leaf (f <$> a)
	fmap f (Branch a b c) =  Branch (f <$> a) (f <$> b) (f <$> c)

-- для несколько параметрических данных, нам стоит забить на все кроме одного параметра и все хорошо
-- для пары вот так реализовано:

instance Functor' ((,) s) where
 	fmap' g (x, y) = (x, g y)

-- почему в haskell все не так как у людей? Почему тут работаем со вторым значением, а не с первым?
-- потому что
-- Either работает точно так же

-- А почему бы не написать функтор для функциональной стрелки?

instance Functor' ((->) e) where
	fmap' =  (.)
-- (a -> b) -> (e -> a) -> (e -> b) Это же просто композиция

-- Итак законы для Functor:
-- (1) fmap id == id
-- (2) fmap (f . g) == fmap f . fmap g

-- Монады

-- Стрелка Клейсли (вычисление с эффектами) 
-- f :: a -> m a

-- функции с логированием
-- они все еще чистые, но с логированием, круто, да?

data Log a = Log [String] a deriving Show

toLogger :: (a -> b) -> String -> (a -> Log b)
toLogger f msg dat = Log [msg] (f dat)   

add1Log = toLogger (+1) "added one"

-- деалает вот такое
-- *Monads> add1Log 3
-- Log ["added one"] 4

execLoggers :: a -> (a -> Log b) -> (b -> Log c) -> Log c
execLoggers x f g = 
	let (Log st1 x2) = f x;
		(Log st2 x3) = g x2 
	in (Log (st1 ++ st2) x3)
mul2Log = toLogger (* 2) "multiplied by 2"

-- *Monads> execLoggers 3 add1Log mult2Log
-- Log ["added one","multiplied by 2"] 8
-- оно работает, лол

-- класс типов монад
class Monad' m where
	return' :: a -> m a -- тривиально упаковывает в контейнер m
--	(>>=) :: m a -> (a -> m b) -> m b -- произносится bind

toKleisli :: Monad m => (a -> b) -> a -> m b
toKleisli f = \x -> return (f x)

kleisliCos = toKleisli cos 0 :: [Double] 

-- выводит [1.0]

-- что такое bind?
-- оператор & имеет такой же тип без монад
-- он так же называется оператором монодического связывания
-- монады, в отличии от Functor умеют менять структуру контейнера

-- return для Log
returnLog :: a -> Log a
returnLog a = (Log [] a)

-- bind для Log
bindLog :: Log a -> (a -> Log b) -> Log b
bindLog (Log st0 x) f = 
	let (Log st1 x2) = f x;
	in (Log (st0 ++ st1) x2)

-- *Monads> Log ["nothing done yet"] 3 `bindLog` add1Log `bindLog` mul2Log 
-- Log ["nothing done yet","added one","multiplied by 2"] 8

-- еее я сделяль свою монаду
instance Monad Log where
    return = returnLog
    (>>=) = bindLog 

execLoggersList :: a -> [a -> Log a] -> Log a
execLoggersList x [] = return x
execLoggersList x dat = (execLoggersList x hs) >>= h where
	hs = init dat;
	h = last dat

-- на самом деле все очень просто: у нас есть уже какие-то данные в контейнере 
-- и мы берем их из контейнера
-- прилюбодействуем
-- и засовываем обратно

-- но это не все наши функции в классе
-- вот полный список
--class Monad' m where
--	return' :: a -> m a -- тривиально упаковывает в контейнер m
--	(>>=) :: m a -> (a -> m b) -> m b -- произносится bind

--	(>>) :: m a -> m b -> m b 
--	x >> y = x >>= \_ -> y

--	fail :: String -> m a
--	fail s = error s
-- И есть еще другие операторы у монад
(=<<) :: Monad m => (a -> m b) -> m a -> m b
(=<<) = flip (>>=)

-- рыбка оператор композиции двух стрелок Клейсли 
(<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
(<=<) f g x = g x >>= f

-- фигачим представителей класса Монады

newtype Identity a = Identity {runIdentity :: a}
	deriving (Eq, Show)

instance Monad Identity where
	return x = Identity x
	Identity x >>= k = k x 

-- Прикольное задание - у нас есть представитель класса Монад, 
-- надо его сделать функтором

--instance Functor SomeType where
--    fmap f x = x >>= (return . f)


-- Законы монад
-- 1 закон монад:
-- return a >>= k == k a
-- где k - стрелка Клейсли

-- 2 закон (return ничего плохого не делает):
-- m >>= return == m

-- 3 закон (почти ассоциативность):

-- (m >>= k) >>= k' == m >>= (\x -> k x >>= k')
-- можно тут было убрать скобки

-- У нас, на самом деле тут накладываются серьезные ограничения
-- Нельзя строить return чтобы там была инициализация каким-то значением (в случае с log)

wrap'n'succ ::Integer -> Identity Integer
wrap'n'succ x = Identity (succ x)

goWrap2 =
	wrap'n'succ 3 >>= (\x -> -- x := 3 + 1;
	wrap'n'succ x >>= (\y -> -- y := x + 1;
	wrap'n'succ y >>= (\z -> -- z := y + 1;
	return (x,y,z))))		 -- return (x,y,z)
-- что сейчас произошло? Да не что иное как то, что оперотор монодического связывание
-- сделал нам императивный язык программирование, где >>= для нашей монады Identity 
-- есть некоторый аналог оператора ; 
-- "Хаскель - хороший императивный язык"

-- Do - нотация
-- слишком громозко писать всякие такие вещи, нужен сахар
-- do {e1 ; e2} == e1 >> e2
-- do {p <- e1; e2} == e1 >>= \p -> e2
-- do {let v = e1; e2} == let v = e1 in do e2

goWrap3 =
	let i = 3 in
	wrap'n'succ i >>= \x ->
	wrap'n'succ x >>= \y ->
	wrap'n'succ y >>
	return (i, x+y)

-- а теперь с do - нотацией
goWrap4 = do
	let i = 3
	x <- wrap'n'succ i
	y <- wrap'n'succ x
	wrap'n'succ y
	return(i, x+y)
-- очень похоже на императивные языки, да?
