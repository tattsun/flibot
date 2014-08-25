{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverloadedStrings #-}
module Flibot.Log (putLog) where

import qualified Data.Text as T
import qualified Data.Text.IO as T

import Control.Lens
import Control.Lens.Action
import Web.Twitter.Types.Lens

class Loggable a where
  putLog :: a -> IO ()

instance Loggable String where
  putLog = putStrLn

instance Loggable T.Text where
  putLog = T.putStrLn

instance Loggable Status where
  putLog s = putLog $ T.concat [(s ^. user . userScreenName)
                               ,": "

                               ,(s ^. text)]
