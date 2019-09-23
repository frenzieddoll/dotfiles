(setq-default newsticker-url-list '(("GIGAZIN" "http://gigazine.net/news/rss_2.0/")
                                    ("CNN" "http://feeds.cnn.co.jp/cnn/rss")
                                    ("痛いニュース" "http://blog.livedoor.jp/dqnplus/index.rdf")
                                    ("ねとらぼ" "https://rss.itmedia.co.jp/rss/2.0/netlab.xml")
                                    ("カオスちゃんねる" "http://chaos2ch.com/index.rdf")
                                    ("不思議.net" "http://world-fusigi.net/index.rdf")
                                    ))

(setq-default newsticker-url-list-defaults
              '(("オレ的ゲーム速報JIN" "http://jin115.com/index.rdf")))
(setq-default newsticker-retrieval-interval 0)
(setq newsticker-html-renderer #'shr-render-region)

(define-key newsticker-treeview-mode-map (kbd "b") 'newsticker-treeview-prev-feed)
