{-# LANGUAGE OverloadedStrings #-}
module Main where

import Debug.Trace

--import Web.Twitter.Types as Types
import Web.Twitter.Types.Lens

import qualified Data.Text as T
import qualified Data.Text.IO as T

import Control.Lens
import Control.Lens.Action
import Control.Applicative

import Flibot.Twitter.Common
import Flibot.Twitter.Commands

main :: IO ()
main = listenWith listener

listener :: StreamingAPI -> IO ()
listener (SStatus s) = do
  botName <- botScreenName
  T.putStrLn $ T.concat [(s ^. user . userScreenName)
                        ,": "
                        ,(s ^. text)]
  case (screenName == botName) of
    True -> return ()
    False -> do post $ T.unpack $ T.concat ["@", screenName, " ", tweet botName]
                return ()
  where screenName = s ^. user . userScreenName
        tweet botname = removeUsername (s ^. text) botname
listener s = print s

removeUsername :: T.Text -> T.Text -> T.Text
removeUsername tweet name = T.replace useridentifier "" tweet
  where useridentifier = T.concat ["@", name, " "]
