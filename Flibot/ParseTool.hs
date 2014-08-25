{-# LANGUAGE OverloadedStrings #-}
module Flibot.ParseTool where

import qualified Data.Text as T
import qualified Data.Text.IO as T

isBeginWith :: T.Text -> T.Text -> Bool
isBeginWith tweet text = if cp == T.toLower text
                         then True
                         else False
  where cp = T.toLower $ T.take (T.length text) tweet

withOut :: T.Text -> T.Text -> T.Text
a `withOut` b = T.replace b "" a
