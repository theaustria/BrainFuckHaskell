module BFcompiler (
    compile
    ) where

import BFtypes

compile :: String -> BFprogram
compile = toBFprogram . clean

alphabet :: [Char]
alphabet = ['<','>','+','-','.',',','[',']']

clean :: String -> BFstring
clean = filter (`elem` alphabet)

toBFinstruction :: Char -> BFinstruction
toBFinstruction '<' = DecPointer
toBFinstruction '>' = IncPointer
toBFinstruction ',' = ReadChar
toBFinstruction '.' = WriteChar
toBFinstruction '+' = IncCell
toBFinstruction '-' = DecCell

toBFprogram :: BFstring -> BFprogram
toBFprogram ('[':xs) = let (match, remaining) = splitAtMatchingClosingBracket xs
                   in Brackets (toBFprogram match) : toBFprogram remaining
toBFprogram (x:xs) = toBFinstruction x : toBFprogram xs
toBFprogram "" = []

splitAtMatchingClosingBracket :: String -> (String,String)
splitAtMatchingClosingBracket = matchBracket 0
                                where matchBracket 0 (']':xs) = ("",xs)
                                      matchBracket level ('[':xs) = let (first,second) = matchBracket (level+1) xs
                                                                    in ('[' : first, second)
                                      matchBracket level (']':xs) = let (first,second) = matchBracket (level-1) xs
                                                                    in (']' : first, second)
                                      matchBracket level (x:xs) = let (first,second) = matchBracket level xs
                                                                  in (x : first , second)
                                      matchBracket _ "" = ("","")