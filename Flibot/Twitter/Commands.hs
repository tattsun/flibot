{-# LANGUAGE NoMonomorphismRestriction #-}
module Flibot.Twitter.Command where

import Flibot.Twitter.Common

import Web.Twitter.Types as Types

import qualified Data.Text as T
import Control.Monad.IO.Class

post :: String -> IO Types.Status
post mes  = runTwitter $ do
  res <- call $ update $ T.pack mes
  return res
