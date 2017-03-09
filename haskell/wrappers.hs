module Wrappers where
	-- синонимы
	-- ключевое слово type типа typedef
	-- type String = [Char]
	-- бывают и параметризованные типы
type AssocList k v = [(k,v)]

-- обертки типов
newtype IntList = IList [Int] deriving Show

data IntList' = IList' [Int] deriving Show

example = IList [1, 2]

-- чем отличется от data?
-- 1 у обертки есть только 1 контруктор, таки оптимизация
-- 2 нет сопоставления с образцом и можно кидать им undifined

-- метки - тип произведения 
data Person = Person {firstName :: String, lastName :: String, age :: Int}
	deriving (Show, Eq)

john = Person "John" "Smith" 33

-- забавно, но если написать " john" то будет ошибка

unknowBill = Person {firstName = "Bill"}

-- кидает только Warning, но можно с ним работать, а если обратиться к недоступным полям, будет плохо
-- модификация полей
updataAge :: Int -> Person -> Person

updataAge newAge person = person {age = newAge}

-- ЭТО НЕ ИЗМЕНЕНИЕ ПОЛЕЙ! 
-- Нельзя тут менять поля, нам создали новую персону
name :: Person -> String
name (Person{lastName = ln, firstName = fn}) = ln ++ " " ++ fn