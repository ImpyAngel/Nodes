module Monads2 where

-- монада Maybe (обычное вычисление, но с исключениями)

import Data.Char

data Maybe' a = Nothing' | Just' a

instance Monad Maybe' where
	return = Just'

	(Just' x) >>= k = k x
	Nothing' >>= _ = Nothing' -- вот тут мы и раскручиваем стек с Nothing

	(Just' _) >> m = m
	Nothing' >> _ = Nothing' -- аналогично 

	fail _ = Nothing' -- по дефолту у нас кидается error, но мы же не хотим этого

type Name = String
type DataBase = [(Name, Name)]

fathers, mothers :: DataBase
fathers = []
mothers = []

getM, getF :: Name -> Maybe Name
getM person = lookup person mothers
getF person = lookup person fathers

-- ищем бабушек
granmas :: Name -> Maybe (Name, Name)
granmas person = digitToInt
	m <- getM person
	gmm <- getM m
	f <- getF person
	gmf <- getM f
	return (gmm, gmf)
-- очень прикольно, что мы вообще не заботимся о том, есть ли у нас какие-то эффекты
-- за нас это сделали операторы монодического связывания, вот в примере они
-- нам кинут Nothing если не найдутся бабушки

data Token = Number Int | Plus | Minus | LeftBrace | RightBrace     
     deriving (Eq, Show)

asToken :: String -> Maybe Token
asToken [] = Nothing
asToken ")" = return RightBrace
asToken "(" = return LeftBrace
asToken "-" = return Minus
asToken "+" = return Plus
asToken x = isDigits x where
	isDigits:: [Char] -> Maybe Int
	isDigits [] = return 0
	isDigits (x:xs) = 	if (not $ isDigit x) 
		then return Nothing 
		else fmap ((+ digitToInt x) . (* 10)) (isDigits xs) 
tokenize :: String -> Maybe [Token]
tokenize input = undefined