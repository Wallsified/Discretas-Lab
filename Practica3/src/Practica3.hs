{-
Estructuras Discretas 2023-1
Alumno: Robledo Ramírez Isaac
Número de cuenta: 320140655
Oyente: Paredes Zamudio Luis Daniel
Número de Cuenta: 318159926
-}

type EList a = [(a,a)]

pruebaElist = [(1,2),(3,4),(5,6)]
pruebaElist2 =  [(11,22),(33,44),(55,66),(77,88)]
pruebaElist3 = [('h','o'),('l','a'),('M','u'),('n','d'),('o','!')]
pruebaElist4 = [('h','0'),('l','4'),('M','u'),('n','d'),('0','!')]

myMod :: Int -> Int -> Int --Auxiliar
myMod n m = if (n < m) then n else myMod (n-m) m

{-
Nota: Como estamos hablando de listas de parejas (o duplas), entonces tenemos que considerar que pueden haber casos donde sea
necesario devolver 0,1,2 o n elementos, donde n<= 2, ya que son "duplas". Esta idea nos sirve para entender los casos de varias
de nuestras funciones.
A su vez, sabemos que x:xs es una lista, y si x = (a,b), entonces (a,b):xs es una lista también.
Nota #2: Como estamos usando listas de parejas de 'a', y en cierta forma un string es una lista de chars, pues podemos cambiar
letras de una palabra por ejemplo. Por eso pruebaElist3. Pero al mismo tiempo podemos tener duplas de caracteres-numeros y hacemos
la misma lista de 'a'
 -}

-- Dada una EList obtiene su número de elementos.
longP :: EList a -> Int
longP []            = 0
longP ((a, b) : xs) = 2 + longP xs

-- Dado elemento e y una Elist l, verifica si e pertenece a l.
elemP :: Eq a => a -> EList a -> Bool -- Hacemos Eq de a para poder compararlo con las demás cosas.
elemP n []            = False
elemP n ((a, b) : xs) = n == a || n == b || elemP n xs

--Dados dos elementos y una EList, los agrega al principio de la Elist.
consP :: (a,a) -> EList a -> EList a
consP (a,b) []            = [(a,b)] 
consP (a,b) ((x, y) : xs) = (a,b) : consP (x,y) xs

-- Función que realiza la concatenación de dos EList
appendP :: EList a -> EList a -> EList a
appendP [] x            = x
appendP ((a, b) : xs) x = (a, b) : appendP xs x

-- Función que agrega dos elementos al final de una EList.
snocP :: (a, a) -> EList a -> EList a
snocP (a,b) []             = [(a, b)]
snocP (a, b) ((x, y) : xs) = (x, y) : snocP (a, b) xs

-- Dada una EList l y un entero n, regresa el n-ésimo elemento de l.
atP :: EList a -> Int -> a
atP [] n            = error "El número de elemento excede el numero de elementos en lista"
atP ((a, b) : xs) (0) = error "Ingrese número de elemento válido"
atP ((a, b) : xs) 1 = a
atP ((a, b) : xs) 2 = b
atP ((a, b) : xs) n = if (n > 0 && n <= longP ((a, b) : xs)) then atP xs (n-2) else error "Ingrese número de elemento válido" 

-- Dada una EList l, un número n y un elemento e, cambia el n-ésimo elemento de l por e.
updateP :: EList a -> Int -> a -> EList a
updateP [] n x            = []
updateP ((a, b) : xs) 0 x = ((a, b) : xs)
updateP ((a, b) : xs) 1 x = (x,b):xs
updateP ((a, b) : xs) 2 x = (a,x):xs
updateP ((a, b) : xs) n x = if (n > 0 && n <= longP ((a, b) : xs)) then (a,b): updateP xs (n-2) x else error "Ingrese número de elemento válido"

{-
Función que recibe una EList l y regresa la misma pero aplanada, es decir, todos los elementos de l
separados en una lista común.
-}
aplanaP :: EList a -> [a]
aplanaP []           = []
aplanaP ((a,b) : xs) = a : b : aplanaP xs

{- Función que convierte una lista común en una EList, si la lista común es de longitud impar, no se
agregará el último elemento. -}
toEL :: [a] -> EList a
toEL []  = []
toEL [x] = []
toEL (a : b : xs) = (a, b) : toEL xs

--Dado un entero n y una EList l, borra los n primeros elementos de l, donde n es par.
dropP :: Int -> EList a -> EList a
dropP n [] = []
dropP 0 ((a, b) : xs) = ((a, b) : xs)
dropP n ((a, b) : xs) = if (n > 0 && n <= longP ((a, b) : xs)) then (if (myMod n 2 == 0) then drop (n-2) xs else error "El valor ingresado no es par. Usa dropN" ) else error "Ingrese número de elemento válido"

{-
Al igual que el inciso anterior, borra los n primeros elementos de l, pero n puede ser par o impar, pues
se regresará una lista común.
 -}
dropN :: Int -> EList a -> [a]
dropN n []            = []
dropN 0 (x:xs)        = []
dropN 1 ((a, b) : xs) = b:aplanaP xs
dropN n ((a, b) : xs) =  if (n > 0 && n <= longP ((a, b) : xs)) then dropN (n-2) xs else error "Ingrese número de elemento válido"

--Dado un entero n y una EList l, toma los n primeros elementos l, n debe ser par.
takeP :: Int -> EList a -> EList a
takeP n [] = []
takeP 0 ((a, b) : xs) = ((a, b) : xs)
takeP n ((a, b) : xs) = if (n > 0 && n <= longP ((a, b) : xs)) then ( if (myMod n 2 == 0) then (a,b) : takeP (n - 2) xs else error "El valor ingresado no es par. Usa takeN" ) else error "Ingrese número de elemento válido"

{- Al igual que el inciso anterior, toma los primeros n elementos de una EList, pero n puede ser par o impar,
pues los elementos se regresarán en una lista común. -}
takeN :: Int -> EList a -> [a]
takeN n []            = []
takeN 0 (x:xs)        = []
takeN 1 ((a,b):xs)    = [a]
takeN n ((a, b) : xs) = if (n > 0 && n <= longP ((a, b) : xs)) then ( a : b : takeN (n-2) xs ) else error "Ingrese número de elemento válido"

-- Elabora una función que haga la reversa de una EList.
reversaP :: EList a -> EList a
reversaP []            = []
reversaP ((a, b) : xs) = snocP (b, a) (reversaP xs)

{-
Función extra, mapP para EList's. 
La idea detrás de la función es, recibimos una función (alguien dijo recursión?) y una Elist a la cual aplicarla, 
despues devolvemos está nueva EList. 
Si es una lista vacía o es una lista de elementos nulos, entonces la devolvemos vacía. Si no, la aplicamos al elemento a y b
de la primera pareja de la lista y posteriormente a su cola. 
-}

mapP :: (a -> b) -> [(a, a)] -> [(b, b)]
mapP f [] = []
mapP f ((a, b) : xs) = if null ((a, b) : xs) then [] else ((f a, f b) : (mapP f xs))

{-
Fun fact, esta asi si nos da pero duplas. La dejo por que puede ser útil luego
takeP :: Int -> EList a -> EList a
takeP n [] = []
takeP n ((x, y) : xs) = if (mod n 2 == 0) then [(x,y)] else []
-}
