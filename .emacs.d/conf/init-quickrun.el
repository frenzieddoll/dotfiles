(with-eval-after-load 'quickrun
  (quickrun-add-command "haskell"
    '((:command . "stack runghc")
      (:description . "Run Haskell file with Stack runghc(GHC)"))
    :override t))
