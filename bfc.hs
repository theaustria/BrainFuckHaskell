module Main where

import BFcompiler
import System.Environment(getArgs)

main = do
     args <- getArgs
     source <- readFile (args !! 0)
     let compiled = compile source
     --writeFile (args !! 1) (show compiled)
     putStrLn (show compiled)