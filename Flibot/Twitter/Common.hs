{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleContexts #-}
module Flibot.Twitter.Common
       ( runTwitter
       , module Web.Twitter.Conduit
       ) where

import Web.Twitter.Conduit
import Web.Twitter.Types

import Web.Authenticate.OAuth as OA
import Control.Monad.IO.Class
import Control.Monad.Logger
import Control.Monad.Trans.Control
import Control.Monad.Trans.Resource

import qualified Config

getOAuthTokens :: (OAuth, Credential)
getOAuthTokens =
  let oauth = twitterOAuth { oauthConsumerKey = Config.oauthConsumerKey
                           , oauthConsumerSecret = Config.oauthConsumerSecret
                           }
      cred = Credential
             [("oauth_token", Config.accessToken)
             ,("oauth_token_secret", Config.accessTokenSecret)
             ]
  in (oauth, cred)

runTwitter :: (MonadIO m, MonadBaseControl IO m) => TW (ResourceT (NoLoggingT m)) a -> m a
runTwitter task = runNoLoggingT $ runTW env task
  where (oa, cred) = getOAuthTokens
        env = (setCredential oa cred def)
