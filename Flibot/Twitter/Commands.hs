{-# LANGUAGE NoMonomorphismRestriction #-}
module Flibot.Twitter.Commands where

import Flibot.Twitter.Common

import Web.Twitter.Types as Types

import qualified Data.Text as T
import Control.Monad.IO.Class

post :: String -> IO Types.Status
post mes  = runTwitter $ do
  res <- call $ update $ T.pack mes
  return res

botScreenName :: IO T.Text
botScreenName = runTwitter $ do
           res <- call $ accountVerifyCredentials
           return $ userScreenName res
