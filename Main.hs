{-# LANGUAGE OverloadedStrings #-}
module Main where

import Debug.Trace

--import Web.Twitter.Types as Types
import Web.Twitter.Types.Lens
import Web.Twitter.Conduit.Types

import qualified Data.Text as T
import qualified Data.Text.IO as T

import Control.Lens
import Control.Lens.Action
import Control.Applicative

import Flibot.ParseTool
import Flibot.Twitter.Common hiding (map)
import Flibot.Twitter.Commands
import Flibot.Log

import Control.Concurrent
import Control.Exception

main :: IO ()
main = do
  putStrLn "server start"
  forkIO $ (listenWith listener) `onException` main
  return ()



response :: T.Text -> Status -> Maybe T.Text
response t s
  | t `isBeginWith` "hello" = Just $ T.append "Hello, " (s ^. user . userScreenName)
  | t `isBeginWith` "echo" = Just $ T.strip $ t `withOut` "echo"
  | otherwise = Nothing

listener :: StreamingAPI -> IO ()
listener (SStatus s) = do
  botName <- botScreenName
  putLog s
  case (screenName == botName) of
    True -> return ()
    False -> do case res of
                     Just r -> do post $ T.unpack $ T.concat ["@", screenName, " ", r]
                                  return ()
                     Nothing -> return ()
                  where res = response (tweet botName) s
  where screenName = s ^. user . userScreenName
        tweet botname = removeUsername (s ^. text) botname
listener s = print s

removeUsername :: T.Text -> T.Text -> T.Text
removeUsername tweet name = T.replace useridentifier "" tweet
  where useridentifier = T.concat ["@", name, " "]
