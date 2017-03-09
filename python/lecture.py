

# try-except block

# try:
# 	assert 1 != 1
# 	if False:
# 		raise BaseException
# except AssertionError:
	# print("ERROR")
# finally:
	# print("some")	

for i in range(10):
	try:
		if 10 / i == 2.0:
			break
	except ZeroDivisionError:
		print(1)
	else:
		print(2)


def function(named_arg, *args):
	print(args[0])


def function(x, y, food = "spam"): # default value
	print(food)


def my_func(x, y=7, *args, **kwargs): # kwargs is a dictionary
   print(kwargs)


my_func(2, 3, 4, 5, 6, a=7, b=8) # >>> {'a': 7, 'b': 8}


numbers = (1, 2, 3) # feature with tuple

a, b, c = numbers # a = 1, b = 2, c = 3

a, b, *c, d = [1, 2, 3, 4, 5, 6, 7, 8, 9] # a = 1 b = 2 c = [3, 4, 5, 6, 7, 8] d = 9

a, b = b, a # feature swap

b = 1 if a >= 5 else 42 # ternary operator

for i in range(10): #else invoke if not invoked break (it worked not only in loop but in the try block) 
   if i == 999:
      break
else:
   print("Unbroken 1")


if __name__=="__main__": #ask about name of module
   print("This is a script") 


# classes
class Point:
	_weaklyPrivate = 4
	__strongPrivate = 5


	# methods with a double underscopes have a name - magic methods
	def __init__(self, x, y): # it is just constructor 
		self.x = x
		self.y = y


	def __add__(self, other): # operator +
	 	return Point(self.x + other.x, self.y + other.y)


c = Point(1,2)
# print(c.x)
# print(c._weaklyPrivate) # >>> 4
# print(c.__strongPrivate) # >>> AttributeError: 'Point' object has no attribute '__strongPrivate'
# print(c._Point__strongPrivate) # >>> 5 becouse it is Pythooon

# other magic methods
# __sub__ for -
# __mul__ for *
# __truediv__ for /
# __floordiv__ for //
# __mod__ for %
# __pow__ for **
# __and__ for &
# __xor__ for ^
# __or__ for |
# __lt__ for <
# __le__ for <=
# __eq__ for ==
# __ne__ for !=
# __gt__ for >
# __ge__ for >=
# __len__ for len()
# __getitem__ for indexing
# __setitem__ for assigning to indexed values
# __delitem__ for deleting indexed values
# __iter__ for iteration over objects (e.g., in for loops)
# __contains__ for in4

# __init__ constructor
# __del__ for destructor class

# inheritance

class MegaPoint(Point):
	def __init__(self, x, y, z):
		super().__init__(x,y)
		self.z = z
m = MegaPoint(1, 2, 3)
print(m.x) # >>> 1

# static Methods
class Rectangle:

  def __init__(self, width, height):
    self.width = width
    self.height = height

  @classmethod	# methods for class 
  def new_square(cls, side_length):
    return cls(side_length, side_length)


  @staticmethod	# like a static
  def thatPrint(message):
  	print(message)


  @property # read-only status
  def readonly(self):
  	return self.width
  def just(self):
  	return self.width
# square.just = 2
# print(square.just, square.width) # >>> 2 5 wtf???


square = Rectangle.new_square(5);
# print(square.width)
Rectangle.thatPrint("Hi");
# square.readonly = 2 >>> AttributeError: can't set attribute

class Pizza:

  def __init__(self, toppings):
    self.toppings = toppings
    self._pineapple_allowed = False


  @property
  def pineapple_allowed(self):
    return self._pineapple_allowed


  @pineapple_allowed.setter
  def pineapple_allowed(self, value):
    if value:
      password = input("Enter the password: ")
      if password == "Sw0rdf1sh!":
        self._pineapple_allowed = value
      else:
        raise ValueError("Alert! Intruder!")

# Regex
import re
pattern = r"span"
def some(str):
	return "span{0}{0}".format(str)
# if re.match(pattern,some("asd")):
	# print("YES")
# else:
 	# print("NO")
# print(re.match(pattern,"spansp"))

# if re.match(pattern, "eggspamsausagespam"):
   # print("Match")
# else:
   # print("No match")

match = re.search(pattern, "spansausagespan")
# if match:
#    print(match.group())
#    print(match.start())
#    print(match.end())
#    print(match.span())
# else:
# 	print("No match")
   

str = "My name is David. Hi David."
pattern2 = r"David"
newstr = re.sub(pattern, "Amy", str)
# print(newstr) str =
str = r"I am \r\a\w!"
print(str)

# a lot of Metacharactres
pattern3 = r"gr.y" # one simbol


pattern4 = r"^gr.y$" # start and end of the line


pattern5 = r"[aeiou]" # have this characters


pattern6 = r"[A-Z][A-Z][0-9]" # obv


pattern7 = r"[^A-Z]"# Place a ^ at the start of a character class to invert it. Such as addition


pattern8 = r"egg(spam)*" # Short Kleene


pattern9 = r"egg(spam)+" # Short Kleene more then zero


pattern10 = r"egg(spam)?" # Short Kleene "zero or one repetitions".


pattern10 = r"egg(spam){1,3}" # repetitions 1-3 times.


pattern11 = r"gr(a|e)y" # only gray or grey.


pattern = r"a(bc)(de)(f(g)h)i"

match = re.match(pattern, "abcdefghijklmnop")
# if match:
   # print(match.group())
   # print(match.group(0))
   # print(match.group(1)) # >>> ab
   # print(match.group(2)) # >>> de
   # print(match.groups()) # >>> ('bc', 'de', 'fgh', 'g')

pattern12 = r"(.*)(.+) \2"
# \d, \s, and \w. -- These match digits, whitespace, and word characters
# \D, \S, and \W - mean the opposite to the lower-case versions


# Additional special sequences are \A, \Z, and \b.
# The sequences \A and \Z match the beginning and end of a string, respectively.
# The sequence \b matches the empty string between \w and \W characters, or \w characters and the beginning or end of the string. Informally, it represents the boundary between words.
# The sequence \B matches the empty string anywhere else. 
match = re.match(pattern12, "hie hi  hi ")
if match:
	print("asd")

# as about input, we use a = input()

