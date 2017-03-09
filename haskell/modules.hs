module Modules where

import Data.Char (toUpper, toLower) 
-- берутся только эти функции
--import Data.Char hiding (toLower)
--вот так берется все кроме одной функции
import Data.List

import qualified Data.Set as Set

--  теперь надо писать Set.union (без Set пришлось бы писать Data.Set)

--*Modules> :t Set.union
--Set.union :: Ord a => Set.Set a -> Set.Set a -> Set.Set a

-- есть и обратная задача - какие модули мы хотим предоставить для импортирования
-- инкапсуляция! 

module Test (sumIt) where ...

sumIt = undifined	
sumOther = undifined
-- конец файла
-- при импорте модуля Test будет доступна только sumIt 

-- немного о компиляции
-- 1 - синтаксический разбор
-- 2 - проверка типов
-- 3 - рассахаровние в язык Core
-- 4 - оптимизация много всего
-- 5 - код генерация Core в язык машины STG
-- 	 - язык машины STG в С-- - достатчно низкоуровневый 
-- http://aosabook.org/en/ghc.htmlы