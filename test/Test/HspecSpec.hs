module Test.HspecSpec where

import qualified Test.Hspec as Hspec
import Test.Syd
import Test.Syd.Hspec (fromHspec)

spec :: Spec
spec =
  describe "hspec spec" $ do
    -- This results in the following failure:
    --
    --     test/Test/HspecSpec.hs:11
    --   ✗ 1 Test.HspecSpec.hspec spec.sydtest
    --       Retries: 3 (does not look flaky)
    --       Expected these values to be equal:
    --       Actual:   8
    --       Expected: 7
    it "sydtest" $
      3 + 5 `shouldBe` (7 :: Int)

    -- This results in the followig failure:
    --
    --     src/Test/Syd/Hspec.hs:68
    --   ✗ 2 Test.HspecSpec.hspec spec.hspec
    --       Retries: 3 (does not look flaky)
    --       Contextual "NotEqualButShouldHaveBeenEqual \"8\" \"7\"" "test/Test/HspecSpec.hs:14:13"
    fromHspec $
      Hspec.it "hspec" $
        3 + 5 `Hspec.shouldBe` (7 :: Int)
