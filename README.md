# flibot - customizable twitter bot written in Haskell
## dependency
- [twitter-conduit](https://github.com/himura/twitter-conduit)

## install
Create ```Config.hs``` in the root dir of this project.

```Config.hs
{-# LANGUAGE OverloadedStrings #-}
module Config where

import qualified Data.ByteString as B

oauthConsumerKey :: B.ByteString
oauthConsumerKey = YOURCONSUMERKEY

oauthConsumerSecret :: B.ByteString
oauthConsumerSecret = YOURCONSUMERSECRET

accessToken :: B.ByteString
accessToken = YOURACCESSTOKEN

accessTokenSecret :: B.ByteString
accessTokenSecret = YOURACCESSTOKENSECRET
```
