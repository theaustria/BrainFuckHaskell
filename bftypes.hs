module BFtypes (
    BFinstruction(..),
    BFprogram,
    BFinput,
    BFoutput,
    BFmachine(..),
    BFcell,
    BFpointer,
    BFstring
    ) where

data BFinstruction = IncPointer | DecPointer | IncCell | DecCell | ReadChar | WriteChar | Brackets [BFinstruction] deriving (Show)
type BFprogram = [BFinstruction]
type BFinput = String
type BFoutput = String
data BFmachine = BFmachine [BFcell] BFpointer deriving (Show)
type BFcell = Int
type BFpointer = Int
type BFstring = String