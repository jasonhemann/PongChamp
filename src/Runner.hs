module Runner where

import Parser
import Interpreter
import WellFormedness
import Control.Monad

swallow :: Show err => Either err a -> a
swallow = \case
    Left err -> errorWithoutStackTrace (show err)
    Right a -> a

swallows :: Either String p -> p
swallows = \case
    Left err -> errorWithoutStackTrace err
    Right a -> a

runString :: String -> String -> IO ()
runString name src = do
    let parsed = swallows (parseProgram name src)
        errs = checkProgram parsed
    case errs of
        [] -> void $ swallow <$> interpretProgram parsed
        _ -> mapM_ print errs
    

runFile :: String -> IO () 
runFile file = do
    src <- readFile file
    runString file src
