local g = vim.g
local opt = vim.opt -- Vimのオプションを操作するための変数を設定

-- 表示関連
opt.number = true -- 行番号を表示する
opt.relativenumber = false -- 相対行番号を非表示にする
opt.list = true -- 不可視文字を表示する
opt.showmode = false -- モード表示を非表示にする
opt.showtabline = 0 -- タブラインを非表示にする
vim.o.signcolumn = "yes" -- サインカラムを常に表示する
opt.cmdheight = 0 -- コマンドラインの高さを最小限に設定する
opt.laststatus = 3 -- ステータスラインを常に表示する

-- 検索関連
opt.smartcase = true -- 検索時に大文字と小文字の使い分けを自動的に判断
opt.hlsearch = true -- 検索結果をハイライト表示
opt.ignorecase = true -- 検索時に大文字小文字を区別しない
opt.incsearch = true -- 入力中に検索を行い、一致箇所をリアルタイムに表示

-- インデント関連
opt.autoindent = true -- 自動で適切なインデントを設定
opt.smartindent = false -- スマートインデントを無効化する
opt.expandtab = true -- タブをスペースで展開する
opt.smarttab = false -- スマートタブを無効化する
opt.shiftwidth = 2 -- インデントの幅を2に設定
opt.tabstop = 2 -- タブの表示幅を2に設定

-- 見た目関連
opt.termguicolors = true -- ターミナルで24ビットカラーを有効化
opt.wrap = false -- 長い行を折り返さないようにする
opt.fillchars = { eob = " " } -- ファイルの末尾をスペースで表示する
opt.scrolloff = 10 -- スクロール時のオフセットを10行分設定する
opt.sidescrolloff = 10 -- 横スクロール時のオフセットを10列分設定する
opt.conceallevel = 3 -- 隠し文字の表示レベルを設定する

-- ファイル関連
opt.swapfile = false -- スワップファイルを無効化する
opt.undofile = true -- アンドゥ情報をファイルに保存する
opt.lazyredraw = true -- 操作中の再描画を遅延させる
opt.autowrite = true -- 変更されたバッファを自動で保存する
opt.splitkeep = "screen" -- スクリーン内でスプリットしたウィンドウを保持する

-- タイムアウト関連
opt.timeout = true -- タイムアウトを有効化する
opt.timeoutlen = 500 -- タイムアウトまでの時間を500msに設定する

-- その他の設定
opt.splitbelow = true -- 新しいウィンドウを現在のウィンドウの下に開く
opt.mouse = "a" -- マウスの利用を有効化する
opt.foldenable = false -- 折りたたみを無効化する
opt.grepprg = "rg --vimgrep" -- グローバル検索を実行するためのコマンドを設定する
opt.grepformat = "%f:%l:%c:%m" -- グローバル検索の結果のフォーマットを設定する
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- エラーメッセージの表示を制御する
opt.confirm = true -- 操作に対する確認を有効化する
opt.completeopt = "menu,menuone,noselect,noinsert" -- 補完オプションを設定する

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1
g.loaded_logipat = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_fzf = 1
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.matchup_matchparen_offscreen = { method = "status_manual " }
